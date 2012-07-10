Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 00/13] Rebased remaining HoG patches
Date: Tue, 10 Jul 2012 16:16:52 -0300
Message-Id: <1341947825-14789-1-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Rebasing against upstream after the input directory move.

Additionally there are two patches from Vinicius to improve re-connection time,
only discovering characteristics when probing the HoG device.

Claudio Takahasi (4):
  hog: Use real values for vendor and product IDs
  hog: Add read Report Reference descriptor
  hog: Add HID Information Characteristic read
  hog: Use hardware country code

João Paulo Rechi Vita (6):
  hog: HID I/O driver
  hog: Prepend Report ID to the HID report
  hog: Add support for uHID events
  hog: Handle output reports
  hog: Handle output events
  hog: Handle feature reports

Paulo Alcantara (1):
  hog: Handle HID devices operating in Boot Protocol Mode

Vinicius Costa Gomes (2):
  hog: Fix re-discovering HoG characteristics when reconnecting
  hog: Fix destroying the uhid device when disconnecting

 acinclude.m4                |    9 +-
 configure.ac                |    2 +
 profiles/input/hog_device.c |  416 +++++++++++++++++++++++++++++++++++++++----
 profiles/input/main.c       |    2 +
 profiles/input/manager.c    |    2 +
 5 files changed, 393 insertions(+), 38 deletions(-)

-- 
1.7.10.4

