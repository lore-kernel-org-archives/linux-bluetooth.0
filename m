Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 13/13] doc/test-coverage: Update test count
Date: Wed, 10 Dec 2014 16:21:11 +0200
Message-Id: <1418221271-7034-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1418221271-7034-1-git-send-email-luiz.dentz@gmail.com>
References: <1418221271-7034-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 doc/test-coverage.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/test-coverage.txt b/doc/test-coverage.txt
index 30271b1..533a8c9 100644
--- a/doc/test-coverage.txt
+++ b/doc/test-coverage.txt
@@ -12,11 +12,11 @@ test-eir		  14	EIR and AD parsing
 test-lib		  14	SDP library functions
 test-sdp		 133	SDP qualification test cases
 test-uuid		  30	UUID conversion handling
-test-mgmt		   2	Management interface handling
+test-mgmt		   9	Management interface handling
 test-crypto		   4	Cryptographic toolbox helpers
 test-textfile		   4	Old textfile storage format
 test-ringbuf		   3	Ring buffer functionality
-test-queue		   3	Queue handling functionality
+test-queue		   6	Queue handling functionality
 test-uhid		   6	Userspace HID functionality
 test-hfp		  29	HFP Audio Gateway functionality
 test-avdtp		  60	AVDTP qualification test cases
-- 
1.9.3

