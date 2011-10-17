Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v2 0/5] Request/Abort Continuing and some minor things
Date: Mon, 17 Oct 2011 18:34:26 -0200
Message-Id: <1318883671-10932-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes from previous version:

 - 2/5: fix minor coding style issue
 - 3/5: allow 0 to be a valid duration value
 - 5/5: fill attribute header in player_fill_media_attribute() in order to
   simplify implementation


Lucas De Marchi (5):
  AVRCP: Use track's UID in event notification
  AVRCP: implement TRACK-REACHED-START event
  AVRCP: respond with UINT32_MAX if duration is not available
  AVRCP: Implement AbortContinuingResponse PDU
  AVRCP: Implement RequestContinuingResponse PDU

 audio/avrcp.c |  307 +++++++++++++++++++++++++++++++++++++++++----------------
 audio/avrcp.h |    3 +
 audio/media.c |   22 ++++-
 3 files changed, 246 insertions(+), 86 deletions(-)

-- 
1.7.7

