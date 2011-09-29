Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 0/3] track-changed notification
Date: Thu, 29 Sep 2011 14:07:27 -0300
Message-Id: <1317316050-12855-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

While implementing the feature in the last patch, I noticed the track-changed
notification was not working anymore due to recent split of audio/control.c.

First two patches fix the issues and 3rd patch puts an UID in media_info. AVRCP
1.3 allows only two values:
	- 0x0: track playing
	- UINT64_MAX: no track playing/selected.

AVRCP 1.4 properly uses this field though, so I'm already preparing the ground
for it.

Lucas De Marchi (3):
  AVRCP: fix changed notification
  AVRCP: fix missing bytes on notification
  AVRCP: allow track to be un-selected

 audio/avrcp.c |   40 +++++++++++++++++++++-------------------
 1 files changed, 21 insertions(+), 19 deletions(-)

-- 
1.7.6.4

