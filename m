Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	keybuk@chromium.org,
	Alex Deymo <deymo@chromium.org>
Subject: [PATCH] Powered status stored in BlueZ
Date: Fri, 12 Apr 2013 14:51:32 -0700
Message-Id: <1365803493-6716-1-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,
As far as I understand, moving from BlueZ 4 to BlueZ 5 intentionally
dropped the Powered status management to another system like the
network-manager. It turns out that our NM does not support that right
now, and since we want to make a smooth transition to BlueZ 5 we 
created a patch adding back this functionality. The following patch
also migrates this option from the BlueZ 4 config file and persists
the value across reboots to make the user happy.

I'm sending this patch (already open-sourced in our tree) to share it
with other projects that are also in the same situation and help them
make the BlueZ 5 transition easier. You are also free to consider it
back in BlueZ, but I don't know the details about why was this
dropped.

This is the only patch I had in the chromium tree that wasn't shared
here. Thank you all for the work!
Alex.

Alex Deymo (1):
  Make "Powered" property persistent across reboots.

 src/adapter.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

-- 
1.8.1.3
