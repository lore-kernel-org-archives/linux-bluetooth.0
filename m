Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 00/11] shared/hfp: Add support for HFP HF
Date: Fri, 10 Oct 2014 01:50:00 +0200
Message-Id: <1412898611-12199-1-git-send-email-lukasz.rymanowski@tieto.com>
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

v3:
* Fix some memory leaks found on self review

v4:
* Fallback to approach from v1 in context of response callback for AT command.
Bassically, if AT+X has +X and OK response, response callback contains only OK or
ERROR code (including CME which will be added in following patches). To get +X
response, user need to use hfp_hf_register() API. It is done mostly to keep hfp.c
simple. With this approach we do not have to cache all +X in hfp.c before calling
response callback.

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

 src/shared/hfp.c | 624 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/hfp.h |  30 +++
 unit/test-hfp.c  | 285 +++++++++++++++++++++++--
 3 files changed, 920 insertions(+), 19 deletions(-)

-- 
1.8.4

