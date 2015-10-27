Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHmfHqQjBKrW+HhjDLaNQPcvYwnzYtm=2WJUhAgKUyyAS-AW7A@mail.gmail.com>
References: <CAHmfHqTrHGpwyxaP6rsBNk5FamFxJMFBy547UY21vQLdLSDc4Q@mail.gmail.com>
	<CABBYNZLjPt_vCcW5JswbK+utJvVm8SbEAus7dw0jt+fW3Q8Fug@mail.gmail.com>
	<CAHmfHqQjBKrW+HhjDLaNQPcvYwnzYtm=2WJUhAgKUyyAS-AW7A@mail.gmail.com>
Date: Tue, 27 Oct 2015 16:47:09 +0200
Message-ID: <CABBYNZJbZzuFQNYSmMmXNv3zWPBsvtFSTvFKroCyyQndDPrw7Q@mail.gmail.com>
Subject: Re: Cannot write to BLE thermal printer
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Leon Nicholls <lnicholls@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Leon,

On Tue, Oct 27, 2015 at 4:22 PM, Leon Nicholls <lnicholls@google.com> wrote:
> Still seeing the same issue:
> ChromeOS version: 48.0.2546.0 canary (64 bit)
> Bluetooth monitor ver 5.35
> I'm using the Web Bluetooth Polymer element:
> https://elements.polymer-project.org/elements/platinum-bluetooth

No top-posting in this list please.

The problem seems similar, there is a Read Blob Request but after that
it just disconnect:

< ACL Data TX: Handle 32 flags 0x00 dlen 9
      ATT: Read Blob Request (0x0c) len 4
        Handle: 0x0003
        Offset: 0x0000

But in the meantime this happens:

< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
        Type: Active (0x01)
        Interval: 11.250 msec (0x0012)
        Window: 11.250 msec (0x0012)
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)

This looks like you manage to start a full duty cycle scan? You
probably have changed this since at least upstream we use 50% duty
cycle:

 < HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
        Type: Active (0x01)
        Interval: 22.500 msec (0x0024)
        Window: 11.250 msec (0x0012)
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)

Anyway this probably means the controller have no time to receive
anything else since it is busy with the scan, so at this point nothing
else will happen at ATT and the Write command is probably stuck in the
queue waiting for the response to Read Blob Request.

Btw, why you want to scan if you are already connected?

-- 
Luiz Augusto von Dentz
