Return-Path: <Steven.Singer@csr.com>
Message-ID: <3FE0C1B9.5090504@csr.com>
Date: Wed, 17 Dec 2003 20:51:05 +0000
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: ag@new-media-artists.de
CC: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ Mailing List
    <bluez-devel@lists.sourceforge.net>
Subject: Re: AW: [Bluez-devel] Device Busy during "hcitool info" or
    "sdptoolsearch"
References: <FJENILNPNAGPJMMDOKDCKEKBDJAA.ag@new-media-artists.de>
In-Reply-To: <FJENILNPNAGPJMMDOKDCKEKBDJAA.ag@new-media-artists.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Andreas Gaufer wrote:
> Not wokring inq:
> < HCI Command: Inquiry(0x01|0x0001) plen 5
>   33 8B 9E 08 0A
> 
> >HCI Event: Command Status(0x0f) plen 4
>   0C 01 01 04

CSR firmware will issue this error code if you try to start an inquiry
while an inquiry or a create_connection is already in progress.

The inquiry-inquiry restriction is there to protect against hosts who
have lost control of what they're doing. If we accepted the second
inquiry, how many inquiry_complete events should we issue?

The create_connection-inquiry restriction is there because both
procedures need to get as much radio bandwidth as possible to work. In
particular, taking bandwidth away from paging can cause spurious failed
connections. In this case, create_connection wins. If you issue a
create_connection while an inquiry is in progress, we will terminate
the inquiry with an inquiry_complete event and start paging
immediately.

Once paging has finished and the baseband connection is complete then we
will allow the host to inquire again.

Since a Bluetooth chip is connected to one host and since the chip is
an embedded device with limited resources, we expect the host to handle
the multiplexing of requests. We expect the host's state to be
synchronised to ours - if it isn't, we're in trouble.

It is unreasonable to expect that multiple applications can issue
arbitrary HCI commands and expect the to complete as if they had sole
access to the device (consider what would happen with ACL flow control
tokens).

SDP searching and similar activities will take over the radio to inquire
and make connections. It is therefore expected that other simultaneous
actions will fail.

In your case, the correct response to having your inquiry rejected is
to back off for a few seconds and try again - either that, or find some
way of sharing access to the device.

	- Steven
-- 



**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************
