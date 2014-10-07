Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 00/11] shared/hfp: Add support for HFP HF
Date: Tue,  7 Oct 2014 11:22:09 +0200
Message-Id: <1412673740-24336-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Following patches extends hfp API with HFP HF functionality.
HFP HF parser has been added and unit test for it.

To consider: how strict we should be when it comes to parsing
AT responses. For example, at the moment, command +CCLC:<cr><lf>
will be recognized as +CCLC: eventhough correct response format
should be <cr><lf>+CCLC:<cr><lf>

Note: As discussed on IRC I did not try to generalize code.

v2:
* minor self review fixes
* response callback on send command, contains now result (OK/ERROR) and
data from unsolicited response if available.

Lukasz Rymanowski (11):
  shared/hfp: Add support for HFP HF
  shared/hfp: Add set_debug and close_on_unref API for HFP HF
  shared/hfp: Add set disconnect handler and disconnect API to HFP HF
  shared/hfp: Add register/unregister event for HFP HF
  shared/hfp: Add HFP HF parser
  shared/hfp: Add send AT command API for HFP HF
  unit/test-hfp: Provide test_handler function via struct data
  unit/test-hfp: Add init test for HFP HF
  unit/test-hfp: Add send command tests for HFP HF
  unit/test-hfp: Add tests for unsolicited results for HFP HF
  unit/test-hfp: Add some robustness tests for HFP HF

 src/shared/hfp.c | 625 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/hfp.h |  27 +++
 unit/test-hfp.c  | 260 +++++++++++++++++++++--
 3 files changed, 893 insertions(+), 19 deletions(-)

-- 
1.8.4

