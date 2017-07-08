Return-Path: <ian@mnementh.co.uk>
From: Ian Molton <ian@mnementh.co.uk>
To: linux-bluetooth@vger.kernel.org
Cc: sebastian.reichel@collabora.co.uk,
	marcel@holtmann.org,
	ohad@bencohen.org
Subject: Further _remove() cleanup for hci_uart drivers
Date: Sat,  8 Jul 2017 15:29:46 +0100
Message-Id: <20170708142949.13496-1-ian@mnementh.co.uk>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Here are three untested patches. They introduce a common function
hci_uart_unregister_device().

This cleans up hci_nokia.c further, and fixes a cut-n-paste error that
introduced the same race condition to hci_ll.c (or perhaps the other
way around).

HTH,

-Ian
