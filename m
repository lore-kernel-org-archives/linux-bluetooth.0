Return-Path: <Steven.Singer@csr.com>
Message-ID: <404749F3.9090006@csr.com>
Date: Thu, 04 Mar 2004 15:23:31 +0000
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] First HCI command sent to a device
References: <1078411850.5347.43.camel@pegasus>
In-Reply-To: <1078411850.5347.43.camel@pegasus>
Content-Type: text/plain; charset="us-ascii"
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
>                                        Will adding a HCI_Reset break any
> other Bluetooth adapter?

Sending an HCI_Reset to a CSR device running firmware earlier than 12.0
will cause the device to perform a full system reset. This means that
the host transport will be reset (USB devices will drop off the bus and
reattach, BCSP devices will need to perform link establishment) and it
means that settings will be reloaded from persistent store (so the baud
rate will reset).

Firmware version 12.0 and later are better behaved and will reset all
the LM and LC settings (drop all links etc.) but leave the host
transport up and running.

[For the reasons behind this, see my posting to bluez-devel on 9th
October 2003 in the thread "hciconfig":

  http://sourceforge.net/mailarchive/message.php?msg_id=6262255
]

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
