Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 0/5] avrcp: fixes and pdu-continuation
Date: Thu,  8 Sep 2011 20:14:45 -0300
Message-Id: <1315523690-11195-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Patch 0001 and 0003 are nice small refactor, whereas 0002 fixes the meaning of
one metadata field (spec is not so clear, but this makes much more sense). I
put David Stockwell as the author since he wrote them; I split, rebased and
sent to ML again.

Patch 0004 fixes an issue when metadata fields sum more than ~500 bytes. It
just refuses to write more data to the PDU if this condition happens. The last
patch goes a step further and implements proper pdu-continuation (really
annoying since fields might split in the middle, but essential for passing
AVRCP 1.3 tests).



*** BLURB HERE ***

David Stockwell (3):
  avrcp: use LAST element on media_info_id enum
  avrcp: fix handling of metadata item 0x7
  avrcp: get/set three-byte company-id

Lucas De Marchi (2):
  avrcp: limit avrcp packet size to the MTU of AV/C
  avrcp: implement pdu continuation request and abort

 audio/control.c |  350 ++++++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 269 insertions(+), 81 deletions(-)

-- 
1.7.6.1

