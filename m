Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: vinicius.gomes@openbossa.org, claudio.takahasi@openbossa.org,
	luiz.von.dentz@intel.com,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 00/11] AVRCP Absolute Volume Control support
Date: Fri, 11 Jan 2013 17:25:23 -0300
Message-Id: <1357935934-20033-1-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This series implements support for the Absolute Volume Control feature for the
CT role of AVRCP version 1.5.

João Paulo Rechi Vita (11):
  transport: Initialize the "Volume" property with 50%
  transport: Store the value set through the 'Volume' property
  avrcp: Add EVENT_VOLUME_CHANGED to CT capabilities
  transport: Get volume from transport
  transport: Keep a list o all existent transports
  transport: Get volume passing only audio_device
  avrcp: Handle RegisterNotification for volume
  avrcp: Notify remote of volume changes
  transport: Update volume passing only audio_device
  avrcp: Handle SetAbsoluteVolume command
  audio: Bump AVRCP CT version to 1.5

 profiles/audio/avrcp.c     | 76 +++++++++++++++++++++++++++++++++++++++++-----
 profiles/audio/transport.c | 55 ++++++++++++++++++++++++++++++++-
 profiles/audio/transport.h |  6 ++++
 3 files changed, 128 insertions(+), 9 deletions(-)

-- 
1.7.11.7

