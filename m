Return-Path: <cyrus@holtmann.org>
Date: Fri, 29 Jan 2010 15:20:38 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: "Gunn, Brian" <bgunn@solekai.com>,
	Marcel Holtmann <marcel@holtmann.org>, Ping <pinglinux@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: [PATCH 0/3] HID: make raw output callback more flexible
Message-ID: <alpine.LNX.2.00.1001291515560.356@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

this is a followup to the thread

	"Implement Bluetooth Wacom tablet's mode change in the kernel"

First patch alters the raw output API so that it is able to actually 
distinguish between feature and output reports (and modifies low-level 
drivers accordingly), and the two followup patches make use of this for 
in-kernel mode setting of Sony and Wacom bluetooth devices.

Marcel, could you please review the Bluetooth part?

Thanks,

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
