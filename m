Return-Path: <cyrus@holtmann.org>
Date: Mon, 28 Jul 2008 18:29:51 +0530 (IST)
From: pavan_savoy@indiatimes.com
To: Majordomo@vger.kernel.org, linux-bluetooth@vger.kernel.org
Message-ID: <673335200.654421217249991946.JavaMail.root@mbv7.indiatimes.com>
Subject: Understanding UART bluetooth ..
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I had a question on hciattach / hcid & related to hci-core.c, If I know I have a bluetooth device on ttyS0.. and I do a 
#hciattach ttyS0 <with_relevant_parameters>

will the whole system know [using dbus & hcid, that a new device  has been added, if so who exactly does this ? ]

I mean I could only find hci_open_dev, but no other dbus or hcid functions to notify...

does hci_notify does the same ? which is being called on hci_open_dev?

Thanks..
