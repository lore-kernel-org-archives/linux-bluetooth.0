Return-Path: <cyrus@holtmann.org>
From: "Gregory M. Turner" <gmt@be-evil.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2(sorta)] Unexpected-continuation-frame-printk flood avoidance
Date: Mon, 23 Feb 2015 22:25:39 -0800
Message-Id: <1424759141-17889-1-git-send-email-gmt@be-evil.net>
List-ID: <linux-bluetooth.vger.kernel.org>

Mitigation for those with floods of:

  Bluetooth: Unexpected Continuation Frame (len 0)

in their logs.  The underlying cause of this is still far from crystal clear
(at least, not to me), but, anyhow, I'm sold on Marcel's advice to solve this
by placing my dongle in the garbage.

Previously I suggested dropping the printk entirely but ratelimiting is
better, since the printk is not wrong (or, if it were wrong, this would
at least be indicative of a problem elsewhere).
