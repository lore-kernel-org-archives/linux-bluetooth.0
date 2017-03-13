Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Mon, 13 Mar 2017 11:31:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: linux-bluetooth@vger.kernel.org
Subject: Fw: [Bug 113171] realtek bluetooth rtl8723bs (SDIO) not supported
Message-ID: <20170313113144.1f8e8990@xeon-e3>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I receive all bugzilla networking bugs, this looks like bluetooth

Begin forwarded message:

Date: Mon, 13 Mar 2017 18:17:55 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: stephen@networkplumber.org
Subject: [Bug 113171] realtek bluetooth rtl8723bs (SDIO) not supported


https://bugzilla.kernel.org/show_bug.cgi?id=113171

--- Comment #2 from dan.g.tob@gmail.com ---
Created attachment 255219
  --> https://bugzilla.kernel.org/attachment.cgi?id=255219&action=edit  
unblock device

With this patch I was able to see and get the bluetooth device to pair with my
phone. Trying to copy anything instantly disconnected and I got no further.

I'm using the rtk_hciattach from the above git tree (it uploads the firmware to
the device from userspace.) It seems kindof similar to the in kernel driver at
/drivers/bluetooth/btrtl.c

-- 
You are receiving this mail because:
You are the assignee for the bug.
