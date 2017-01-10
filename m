Return-Path: <edward.rosten@gmail.com>
MIME-Version: 1.0
Sender: edward.rosten@gmail.com
In-Reply-To: <1BE3F300-B719-44E3-971F-5015C5F65A78@holtmann.org>
References: <CAM4OqtDier-LrdJymk5npiGvZcvj7rsaGsrJwv+tz1o+kCoFcw@mail.gmail.com>
 <1BE3F300-B719-44E3-971F-5015C5F65A78@holtmann.org>
From: Edward Rosten <ed@edwardrosten.com>
Date: Tue, 10 Jan 2017 19:05:06 +0000
Message-ID: <CAM4OqtDb6cm18Eqs=+rJrt7a-h0N=j+s-jPEUc1c4rHwGDbYqQ@mail.gmail.com>
Subject: Re: Adding EAGAIN on 0x3e (Connection faile to be established) in net/bluetooth/lib.c/bt_to_errno()?
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On 10 January 2017 at 18:49, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Edward,
>
> I bet that if you take a sniffer and look at the raw air packets, then th=
is means that CONNECT_REQ has been sent. The initiator then moves into conn=
ection state, but reality is that only after receiving the first data packe=
t, the connection is fully established. Between the CONNECT_REQ and the fir=
st packet, things can actually go wrong.

I don't have a hardware sniffer: all I've got are tools to parse the HCI du=
mp.

> Can you send the whole trace for it? I wonder if we get a disconnect even=
t as well, or just an indication that the request for the remote used featu=
res did not complete. And at a later LL connection event, the connection wo=
uld successfully establish.

Here's the complete HCI log, from Create Connection onwards:

< HCI Command: LE Create Connection (0x08|0x000d) plen 25

                                              [hci0] 460.552896
        Scan interval: 60.000 msec (0x0060)
        Scan window: 60.000 msec (0x0060)
        Filter policy: White list is not used (0x00)
        Peer address type: Public (0x00)
        Peer address: 00:07:80:CF:3E:94 (Bluegiga Technologies OY)
        Own address type: Public (0x00)
        Min connection interval: 50.00 msec (0x0028)
        Max connection interval: 70.00 msec (0x0038)
        Connection latency: 0x0000
        Supervision timeout: 420 msec (0x002a)
        Min connection length: 0.000 msec (0x0000)
        Max connection length: 0.000 msec (0x0000)
> HCI Event: Command Status (0x0f) plen 4                                  =
                                                                           =
                                      [hci0] 460.553725
      LE Create Connection (0x08|0x000d) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19                                  =
                                                                           =
                                      [hci0] 460.882366
      LE Connection Complete (0x01)
        Status: Success (0x00)
        Handle: 64
        Role: Master (0x00)
        Peer address type: Public (0x00)
        Peer address: 00:07:80:CF:3E:94 (Bluegiga Technologies OY)
        Connection interval: 67.50 msec (0x0036)
        Connection latency: 0.00 msec (0x0000)
        Supervision timeout: 420 msec (0x002a)
        Master clock accuracy: 0x00
< HCI Command: LE Read Remote Used Features (0x08|0x0016) plen 2

                                              [hci0] 460.882691
        Handle: 64
@ Device Connected: 00:07:80:CF:3E:94 (1) flags 0x0000
        02 01 06 11 06 64 97 81 d1 ed ba 6b ac 11 4c 9d  .....d.....k..L.
        34 3e 20 09 73                                   4> .s
> HCI Event: Command Status (0x0f) plen 4                                  =
                                                                           =
                                      [hci0] 460.883763
      LE Read Remote Used Features (0x08|0x0016) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 12                                  =
                                                                           =
                                      [hci0] 461.313621
      LE Read Remote Used Features (0x04)
        Status: Connection Failed to be Established (0x3e)
        Handle: 64
        Features: 0x1f 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          LE Encryption
          Connection Parameter Request Procedure
          Extended Reject Indication
          Slave-initiated Features Exchange
          LE Ping
> HCI Event: Disconnect Complete (0x05) plen 4                             =
                                                                           =
                                      [hci0] 461.314141
        Status: Success (0x00)
        Handle: 64
        Reason: Connection Failed to be Established (0x3e)
@ Device Disconnected: 00:07:80:CF:3E:94 (1) reason 0


>
> If that is the case, then I have to say that it is a bit sad if this leak=
s through via HCI. I would have expected that the controllers hides this fr=
om the host. In case you have an Intel or Broadcom dongle, can you enable L=
L traces via /sys/kernel/debug/bluetooth/hci0/vendor_diag (just echo 1 > in=
to it). That way we also see the LL traces going over the air and can analy=
se this.

I'm afraid not: it's the BCM43438 chip build into the RPi 3 and
doesn't provide that option.

> However my bet is that on this specific error, we should just send the LE=
 Read Remote Used Features command at least one more time before we give up=
 on the connection. If that would work, I do not want to send an EAGIN to t=
he userspace socket. We want to at least hide that part in the kernel if ca=
n handle it.

What should be the error message on failure? It seems to be a very
sporadic error. Also, I'm 99% sure it's not the remote hardware, since
I've tested it a lot on Linux with a Broadcom dongle and never
received an error.

-Ed


>
>> In net/bluetooth/lib.c, there's a function, bt_to_errno(), which maps
>> HCI codes to errno numbers, there's no entry for 0x3e.
>>
>> I was going to submit a 2 line patch to return a sensible error code,
>> but I've come here to ask what the best choice would be:
>>
>> I currently think EAGAIN (Try Again---since trying again is usually
>> the appropriate choice), but this is the same number as EWOULDBLOCK. I
>> think it ought to be possible to distinguish all cases
>> EAGAIN/EWOULDBLOCK on a blocking socket is this kind of error. Getting
>> it on a non blocking socket would only ever mean "operation in
>> progress". Getting EAGAIN/EWOULDBLOCK from getsockopt(fd, SOL_SOCKET,
>> SO_ERROR, ...) would also only mean "try again".
>>
>> Does any one have any input on this? There's not a huge choice when it
>> comes to error codes, and so I think this is the best one, but I'm not
>> really sure.
>
> I need to see the full trace and if possible with LL tracing enabled, the=
n we can see what to do. As said above, if we can just handle it inside the=
 kernel, then lets not bother the socket with it.
>
> Regards
>
> Marcel
>
