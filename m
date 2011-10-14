Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 0/5] Request/Abort Continuing and some minor things
Date: Fri, 14 Oct 2011 18:28:27 -0300
Message-Id: <1318627712-9725-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

Patch 1 allows TG to correctly inform CT whether there's a track selected.
Second patch is an easy event to add, track reached start. Third is a fix to
RequestPlayStatus.

Last 2 patches are the ones more important. They cover the Request/abort
continuing responses. In my previous implementation (that doesn't apply
anymore) I was generating all the PDUs in the first GetElementAttributes
request, putting them in a queue and sending them upon receipt of
RequestContinuing. Another approach (requested by Luiz) is to save the list of
attributes we need to send, the position within the last attribute we sent and
the pdu id. Then we can generate new PDUs only if CT asks us to continue.

I implemented the later, hoping it would be simpler than the former. However
it's not, but there are some benefits:
i) We don't allocate "lots" of space to keep pending pdus
ii) The first request to GetElementAttributes is much quicker this way since we
generate only one PDU.

Lucas De Marchi (5):
  AVRCP: Use track's UID in event notification
  AVRCP: implement TRACK-REACHED-START event
  AVRCP: respond with UINT32_MAX if duration is not available
  AVRCP: Implement AbortContinuingResponse PDU
  AVRCP: Implement RequestContinuingResponse PDU

 audio/avrcp.c     |  301 ++++++++++++++++++++++++++++++++++++++++-------------
 audio/avrcp.h     |    3 +
 audio/media.c     |   22 ++++-
 doc/media-api.txt |    4 +-
 4 files changed, 256 insertions(+), 74 deletions(-)

-- 
1.7.7

