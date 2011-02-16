Return-Path: <cyrus@holtmann.org>
From: Alan Ott <alan@signal11.us>
To: Randy Dunlap <rdunlap@xenotime.net>, Alan Ott <alan@signal11.us>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	jkosina@suse.cz, ospite@studenti.unina.it,
	linux-input@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	bgood@velocity.net
Cc: Alan Ott <alan@signal11.us>
Subject: [PATCH v4 2/2] HID: Move hiddev.txt to the new Documentation/HID directory
Date: Tue, 15 Feb 2011 23:06:49 -0500
Message-Id: <1297829209-10511-3-git-send-email-alan@signal11.us>
In-Reply-To: <1297829209-10511-1-git-send-email-alan@signal11.us>
References: <1297829209-10511-1-git-send-email-alan@signal11.us>
Sender: linux-input-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With the new Documentation/hid directory, it makes sense to have
hiddev.txt here as well.

Signed-off-by: Alan Ott <alan@signal11.us>
---
 Documentation/{usb => hid}/hiddev.txt |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/{usb => hid}/hiddev.txt (100%)

diff --git a/Documentation/usb/hiddev.txt b/Documentation/hid/hiddev.txt
similarity index 100%
rename from Documentation/usb/hiddev.txt
rename to Documentation/hid/hiddev.txt
-- 
1.7.0.4


