Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: Adding EAGAIN on 0x3e (Connection faile to be established) in
 net/bluetooth/lib.c/bt_to_errno()?
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAM4OqtDier-LrdJymk5npiGvZcvj7rsaGsrJwv+tz1o+kCoFcw@mail.gmail.com>
Date: Tue, 10 Jan 2017 19:49:40 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <1BE3F300-B719-44E3-971F-5015C5F65A78@holtmann.org>
References: <CAM4OqtDier-LrdJymk5npiGvZcvj7rsaGsrJwv+tz1o+kCoFcw@mail.gmail.com>
To: Edward Rosten <ed@edwardrosten.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Edward,

> I've been doing some bluetooth LE work on an RPi 3. I've been getting
> occasional ENOSYS replies from connect()---actually from retreiving
> the error code via getsockopt since it's an async call. I'm apparently
> not the only person, though it seems to be very rare (link below).
> Drilling down, the relevant part of the HCI log (parsed by btmon) is
> this:
> 
> 
>> HCI Event: LE Meta Event (0x3e) plen 12                                                                                                                                                   [hci0] 461.313621
>      LE Read Remote Used Features (0x04)
>        Status: Connection Failed to be Established (0x3e)
>        Handle: 64
>        Features: 0x1f 0x00 0x00 0x00 0x00 0x00 0x00 0x00
>          LE Encryption
>          Connection Parameter Request Procedure
>          Extended Reject Indication
>          Slave-initiated Features Exchange
>          LE Ping
> 
> You can see the error code is 0x3e (coincidently the same as the LE
> Meta Event code!). According to the Core v4.0 spec (Volume 2, Part B,
> Section 1.3, Table 1.1) the code 0x3e which according to the spec is:
> 
> 2.59 CONNECTION FAILED TO BE ESTABLISHED (0X3E)
> The Connection Failed to be Established error code indicates that the LL initi-
> ated a connection but the connection has failed to be established.
> 
> In other words, it appears to be an error along the lines of
> "something wrong happened". On my machine it's very intermittent and
> I've found some other people reporting the same
> (https://www.raspberrypi.org/forums/viewtopic.php?f=63&t=145144&p=962612).
> I modified my code to retry 3 times (with a 500ms pause) on one of
> these errors and so far it's never failed on the second attempt.

I bet that if you take a sniffer and look at the raw air packets, then this means that CONNECT_REQ has been sent. The initiator then moves into connection state, but reality is that only after receiving the first data packet, the connection is fully established. Between the CONNECT_REQ and the first packet, things can actually go wrong.

Can you send the whole trace for it? I wonder if we get a disconnect event as well, or just an indication that the request for the remote used features did not complete. And at a later LL connection event, the connection would successfully establish.

If that is the case, then I have to say that it is a bit sad if this leaks through via HCI. I would have expected that the controllers hides this from the host. In case you have an Intel or Broadcom dongle, can you enable LL traces via /sys/kernel/debug/bluetooth/hci0/vendor_diag (just echo 1 > into it). That way we also see the LL traces going over the air and can analyse this.

However my bet is that on this specific error, we should just send the LE Read Remote Used Features command at least one more time before we give up on the connection. If that would work, I do not want to send an EAGIN to the userspace socket. We want to at least hide that part in the kernel if can handle it.

> In net/bluetooth/lib.c, there's a function, bt_to_errno(), which maps
> HCI codes to errno numbers, there's no entry for 0x3e.
> 
> I was going to submit a 2 line patch to return a sensible error code,
> but I've come here to ask what the best choice would be:
> 
> I currently think EAGAIN (Try Again---since trying again is usually
> the appropriate choice), but this is the same number as EWOULDBLOCK. I
> think it ought to be possible to distinguish all cases
> EAGAIN/EWOULDBLOCK on a blocking socket is this kind of error. Getting
> it on a non blocking socket would only ever mean "operation in
> progress". Getting EAGAIN/EWOULDBLOCK from getsockopt(fd, SOL_SOCKET,
> SO_ERROR, ...) would also only mean "try again".
> 
> Does any one have any input on this? There's not a huge choice when it
> comes to error codes, and so I think this is the best one, but I'm not
> really sure.

I need to see the full trace and if possible with LL tracing enabled, then we can see what to do. As said above, if we can just handle it inside the kernel, then lets not bother the socket with it.

Regards

Marcel

