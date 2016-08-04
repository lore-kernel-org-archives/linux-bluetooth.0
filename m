Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [RFC 2/5] doc: Add RebondConsent method to agent API
Date: Thu,  4 Aug 2016 15:28:36 +0200
Message-Id: <1470317319-3985-3-git-send-email-szymon.janc@codecoup.pl>
In-Reply-To: <1470317319-3985-1-git-send-email-szymon.janc@codecoup.pl>
References: <1470317319-3985-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This method will be called when bluetoothd requires user consent for
performing re-bond operation.
---
 doc/agent-api.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/agent-api.txt b/doc/agent-api.txt
index 801ccb6..16328d7 100644
--- a/doc/agent-api.txt
+++ b/doc/agent-api.txt
@@ -176,6 +176,14 @@ Methods		void Release()
 			Possible errors: org.bluez.Error.Rejected
 			                 org.bluez.Error.Canceled
 
+		void RebondConsent(object device)
+
+			This method gets called when service daemon needs to
+			authorize rebonding of remote device that lost bond
+			(replied with 'Pin or Key missing' error).
+
+			Possible errors: org.bluez.Error.Rejected
+
 		void Cancel()
 
 			This method gets called to indicate that the agent
-- 
2.7.4

