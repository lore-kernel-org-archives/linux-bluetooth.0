Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 0/2] AVRCP: Add support for Vol Up/Down operations on TG
Date: Tue, 22 Jan 2013 15:18:21 -0300
Message-Id: <1358878703-8100-1-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This series creates a new quirk called QUIRK_IGNORE to be able to accept and
ignore certain keys. Then it uses this infrastructure to accept and ignore
Volume Up/Down operations, instead of replying with "Not Implemented".

Suport for Volume Up/Down is mandatory on TG side if we claim to support
Category 2 (Monitor / Amplifier). It's also tested by PTS on test
TC_TG_PTT_BV_02_I.

João Paulo Rechi Vita (2):
  avctp: Create ignore quirk
  avctp: Receive and silent ignore Vol Up/Down operations

 profiles/audio/avctp.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

-- 
1.7.11.7

