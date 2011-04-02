Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: hadess@hadess.net,
	marcel@holtmann.org,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 0/3] Support binary pin codes 
Date: Sat,  2 Apr 2011 21:51:00 +0200
Message-Id: <1301773863-16297-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch series allows passing binary bluetooth PINs to the hci handlers
by adding a pin_len argument. This is required to support devices which
require binary PINs like the Nintendo Wii Remote.

This patch series also adds Nintendo Wii Remote pairing support by hardcoding
the PIN. This was discussed earlier in:
http://thread.gmane.org/gmane.linux.bluez.kernel/3961

Marcel suggested automatic pairing inside the daemon by VID/PID detection
and this patch implements this approach. See:
http://thread.gmane.org/gmane.linux.bluez.kernel/3964


Regards
David
