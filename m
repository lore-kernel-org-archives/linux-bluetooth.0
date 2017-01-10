Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: Adding EAGAIN on 0x3e (Connection faile to be established) in
 net/bluetooth/lib.c/bt_to_errno()?
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAM4OqtDb6cm18Eqs=+rJrt7a-h0N=j+s-jPEUc1c4rHwGDbYqQ@mail.gmail.com>
Date: Tue, 10 Jan 2017 20:22:43 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <49A36183-9C83-43B4-B462-3838E28E21C9@holtmann.org>
References: <CAM4OqtDier-LrdJymk5npiGvZcvj7rsaGsrJwv+tz1o+kCoFcw@mail.gmail.com>
 <1BE3F300-B719-44E3-971F-5015C5F65A78@holtmann.org>
 <CAM4OqtDb6cm18Eqs=+rJrt7a-h0N=j+s-jPEUc1c4rHwGDbYqQ@mail.gmail.com>
To: Edward Rosten <ed@edwardrosten.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Edward,

>> I bet that if you take a sniffer and look at the raw air packets, then this means that CONNECT_REQ has been sent. The initiator then moves into connection state, but reality is that only after receiving the first data packet, the connection is fully established. Between the CONNECT_REQ and the first packet, things can actually go wrong.
> 
> I don't have a hardware sniffer: all I've got are tools to parse the HCI dump.
> 
>> Can you send the whole trace for it? I wonder if we get a disconnect event as well, or just an indication that the request for the remote used features did not complete. And at a later LL connection event, the connection would successfully establish.
> 
> Here's the complete HCI log, from Create Connection onwards:
> 
> < HCI Command: LE Create Connection (0x08|0x000d) plen 25
> 
>                                              [hci0] 460.552896
>        Scan interval: 60.000 msec (0x0060)
>        Scan window: 60.000 msec (0x0060)
>        Filter policy: White list is not used (0x00)
>        Peer address type: Public (0x00)
>        Peer address: 00:07:80:CF:3E:94 (Bluegiga Technologies OY)
>        Own address type: Public (0x00)
>        Min connection interval: 50.00 msec (0x0028)
>        Max connection interval: 70.00 msec (0x0038)
>        Connection latency: 0x0000
>        Supervision timeout: 420 msec (0x002a)
>        Min connection length: 0.000 msec (0x0000)
>        Max connection length: 0.000 msec (0x0000)
>> HCI Event: Command Status (0x0f) plen 4                                                                                                                                                   [hci0] 460.553725
>      LE Create Connection (0x08|0x000d) ncmd 1
>        Status: Success (0x00)
>> HCI Event: LE Meta Event (0x3e) plen 19                                                                                                                                                   [hci0] 460.882366
>      LE Connection Complete (0x01)
>        Status: Success (0x00)
>        Handle: 64
>        Role: Master (0x00)
>        Peer address type: Public (0x00)
>        Peer address: 00:07:80:CF:3E:94 (Bluegiga Technologies OY)
>        Connection interval: 67.50 msec (0x0036)
>        Connection latency: 0.00 msec (0x0000)
>        Supervision timeout: 420 msec (0x002a)
>        Master clock accuracy: 0x00
> < HCI Command: LE Read Remote Used Features (0x08|0x0016) plen 2
> 
>                                              [hci0] 460.882691
>        Handle: 64
> @ Device Connected: 00:07:80:CF:3E:94 (1) flags 0x0000
>        02 01 06 11 06 64 97 81 d1 ed ba 6b ac 11 4c 9d  .....d.....k..L.
>        34 3e 20 09 73                                   4> .s
>> HCI Event: Command Status (0x0f) plen 4                                                                                                                                                   [hci0] 460.883763
>      LE Read Remote Used Features (0x08|0x0016) ncmd 1
>        Status: Success (0x00)
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
>> HCI Event: Disconnect Complete (0x05) plen 4                                                                                                                                              [hci0] 461.314141
>        Status: Success (0x00)
>        Handle: 64
>        Reason: Connection Failed to be Established (0x3e)
> @ Device Disconnected: 00:07:80:CF:3E:94 (1) reason 0

never mind then. So we actually get disconnected here. Which means the connection never fully established. That can actually happen even after a successful LE Connection Complete. Mainly through interference etc.

I am fine treating the error 0x3e special, but we need to figure out what is the best socket error code to map it to. I am reluctant to use EAGAIN since that is kinda dedicated meaning for non-blocking operation. Keep in mind that EAGAIN and EWOULDBLOCK are the same number.

This needs some research on how normal network sockets would handle this. If they do it at all. However things like ECANCELED or ECONNABORTED might be a good choice.

>> If that is the case, then I have to say that it is a bit sad if this leaks through via HCI. I would have expected that the controllers hides this from the host. In case you have an Intel or Broadcom dongle, can you enable LL traces via /sys/kernel/debug/bluetooth/hci0/vendor_diag (just echo 1 > into it). That way we also see the LL traces going over the air and can analyse this.
> 
> I'm afraid not: it's the BCM43438 chip build into the RPi 3 and
> doesn't provide that option.

It does support it, but if you use Rasparian or similar, then they use the old hciattach hacked up code for getting the chip recognised. The newly btattach tool and kernel drivers for Broadcom chips will enable that. It is pretty useful.

Do you want to work on using hci_bcm.c on the RPi3? Would be useful to have it natively integrated. I tried Fedora 25, but the SD card controller the card sits on wasn’t upstream yet.

>> However my bet is that on this specific error, we should just send the LE Read Remote Used Features command at least one more time before we give up on the connection. If that would work, I do not want to send an EAGIN to the userspace socket. We want to at least hide that part in the kernel if can handle it.
> 
> What should be the error message on failure? It seems to be a very
> sporadic error. Also, I'm 99% sure it's not the remote hardware, since
> I've tested it a lot on Linux with a Broadcom dongle and never
> received an error.

As I said, I am pretty sure that is some interference or scheduling issue locally and the controller missing the LL connection event that confirm the connection is really alive and active. We know that occasionally that can happen. A newer firmware from Broadcom might also make this more robust. Nevertheless, reporting this better to userspace is a good fix. Just need to figure out the best error code.

Regards

Marcel

