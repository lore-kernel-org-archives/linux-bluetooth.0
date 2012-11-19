Return-Path: <cyrus@holtmann.org>
From: Bart Westgeest <bart@elbrys.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bart Westgeest <bart@elbrys.com>
Subject: [PATCH 0/3] Fix corrupted SDP response for sequence size > 256
Date: Mon, 19 Nov 2012 14:04:29 -0500
Message-Id: <1353351872-10628-1-git-send-email-bart@elbrys.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset includes minor refactoring and a bug fix. The bug
is exposed when a data sequence grows beyond 256 bytes, in this case the
complete sequence data is written, but the size is truncated to one
byte, resulting in a corrupted SDP response.

RE: Feedback on potential fix for issue while advertising Feature List

Bart Westgeest (3):
  sdp: Inlined single use of function sdp_set_data_type
  sdp: Limit side effects of sdp_get_data_type and sdp_get_data_size
  sdp: Upgrade datatype SEQ8 to SEQ16 when data size is greater than
    256

 lib/sdp.c |   56 +++++++++++++++++++++++---------------------------------
 1 file changed, 23 insertions(+), 33 deletions(-)

-- 
1.7.10.4

