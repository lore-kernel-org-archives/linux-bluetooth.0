Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Edward Rosten <ed@edwardrosten.com>
Date: Tue, 10 Jan 2017 17:09:46 +0000
Message-ID: <CAM4OqtDier-LrdJymk5npiGvZcvj7rsaGsrJwv+tz1o+kCoFcw@mail.gmail.com>
Subject: Adding EAGAIN on 0x3e (Connection faile to be established) in net/bluetooth/lib.c/bt_to_errno()?
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

I've been doing some bluetooth LE work on an RPi 3. I've been getting
occasional ENOSYS replies from connect()---actually from retreiving
the error code via getsockopt since it's an async call. I'm apparently
not the only person, though it seems to be very rare (link below).
Drilling down, the relevant part of the HCI log (parsed by btmon) is
this:


> HCI Event: LE Meta Event (0x3e) plen 12                                                                                                                                                   [hci0] 461.313621
      LE Read Remote Used Features (0x04)
        Status: Connection Failed to be Established (0x3e)
        Handle: 64
        Features: 0x1f 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          LE Encryption
          Connection Parameter Request Procedure
          Extended Reject Indication
          Slave-initiated Features Exchange
          LE Ping

You can see the error code is 0x3e (coincidently the same as the LE
Meta Event code!). According to the Core v4.0 spec (Volume 2, Part B,
Section 1.3, Table 1.1) the code 0x3e which according to the spec is:

2.59 CONNECTION FAILED TO BE ESTABLISHED (0X3E)
The Connection Failed to be Established error code indicates that the LL initi-
ated a connection but the connection has failed to be established.

In other words, it appears to be an error along the lines of
"something wrong happened". On my machine it's very intermittent and
I've found some other people reporting the same
(https://www.raspberrypi.org/forums/viewtopic.php?f=63&t=145144&p=962612).
I modified my code to retry 3 times (with a 500ms pause) on one of
these errors and so far it's never failed on the second attempt.

In net/bluetooth/lib.c, there's a function, bt_to_errno(), which maps
HCI codes to errno numbers, there's no entry for 0x3e.

I was going to submit a 2 line patch to return a sensible error code,
but I've come here to ask what the best choice would be:

I currently think EAGAIN (Try Again---since trying again is usually
the appropriate choice), but this is the same number as EWOULDBLOCK. I
think it ought to be possible to distinguish all cases
EAGAIN/EWOULDBLOCK on a blocking socket is this kind of error. Getting
it on a non blocking socket would only ever mean "operation in
progress". Getting EAGAIN/EWOULDBLOCK from getsockopt(fd, SOL_SOCKET,
SO_ERROR, ...) would also only mean "try again".

Does any one have any input on this? There's not a huge choice when it
comes to error codes, and so I think this is the best one, but I'm not
really sure.

Regards,

-Ed
