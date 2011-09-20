Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 0/3] avrcp: fragmentation and volume passthrough
Date: Tue, 20 Sep 2011 15:31:33 -0300
Message-Id: <1316543496-18575-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

First 2 patches are the same as sent previously to the mailing list, but now
rebased on top of the recent code move.

Last patch just adds VOL_UP and VOL_DOWN OPs so we can handle those passthrough
commands.


Lucas De Marchi (3):
  avrcp: limit avrcp packet size to the MTU of AV/C
  avrcp: implement pdu continuation request and abort
  avrcp: handle volume up/down passthroughs as TG

 audio/avctp.c |    4 +-
 audio/avctp.h |    3 +
 audio/avrcp.c |  310 +++++++++++++++++++++++++++++++++++++++++++++------------
 3 files changed, 253 insertions(+), 64 deletions(-)

-- 
1.7.6.1

