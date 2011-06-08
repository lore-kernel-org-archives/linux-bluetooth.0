Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Johan Hedberg <johan.hedberg@gmail.com>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH 2/2] Request secure pincode from agent when necessary
Date: Wed, 8 Jun 2011 16:05:20 +0200
Message-ID: <1307541920-3776-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <1307541920-3776-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1307541920-3776-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/agent.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/agent.c b/src/agent.c
index 7bba849..d1494de 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -428,11 +428,9 @@ static int pincode_request_new(struct agent_request *req, const char *device_pat
 {
 	struct agent *agent = req->agent;
 
-	/* TODO: Add a new method or a new param to Agent interface to request
-		secure pin. */
-
 	req->msg = dbus_message_new_method_call(agent->name, agent->path,
-					"org.bluez.Agent", "RequestPinCode");
+				"org.bluez.Agent", secure ?
+				"RequestSecurePinCode" : "RequestPinCode");
 	if (req->msg == NULL) {
 		error("Couldn't allocate D-Bus message");
 		return -ENOMEM;
-- 
1.7.4.1

