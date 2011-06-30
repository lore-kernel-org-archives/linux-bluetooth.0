Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 0/3] Fixes for AVRCP 1.0 and preparation for AVRCP 1.3
Date: Thu, 30 Jun 2011 15:50:32 -0300
Message-Id: <1309459835-11434-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These are simple fixes for AVRCP 1.0 and a preparation for the upcoming 1.3.
I'm working on the task of implementing AVRCP 1.3 now, based when possible on
previous patches sent to this list.

Lucas De Marchi (3):
  avrcp: Check that AVCTP packet is of type COMMAND
  avrcp: Factor out function to handle vendordep pdu
  avrcp: return NOT_IMPLEMENTED on request for vendor dep command

 audio/control.c |   31 +++++++++++++++----------------
 1 files changed, 15 insertions(+), 16 deletions(-)

-- 
1.7.6

