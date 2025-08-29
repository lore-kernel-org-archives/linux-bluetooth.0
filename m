Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E41630CDB9
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Aug 2025 06:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756449254; cv=none; b=N0hCS+LfWU1sfJmqAaCLZsRu/12HjUh/8lFVFSjWRj+CkpW1XfXg+96hkszwuBR19pt4JQEoweAm4aGINmvwgYpOsbmAjD2JQ/iKsUtEVF0KTR0zhnQ8iF9wrFiFumKe1T1uCtbbf7zUDtQ86gjUGCciP4WdEmPY/O+Wv4ekyAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756449254; c=relaxed/simple;
	bh=lymtCwMD2paZBTWXKOVVCDlk+4owU/aG5USgIt7KANc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=szJe3MW4ycmo0S7oXQjkMlsFAMJji1j3eNAZTcLhK+14nqro7C/x9lheVzZFrTQ91hszAHeoX1ICDqCdBGmJZTlI7rfvh3s5iyABUMuyE6SnCCtgOW/xYySfDKipQ1NZJkYCOF+s+JQP49OSjP4bBysJPOLeQC7FgY+twZLeH94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=MNWTHqEE; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="MNWTHqEE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1756449244;
	bh=HG7TVZCtg7WlXc5dashuNRBjKBGoKIFWgzWB5slr1KI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=MNWTHqEEPxv6hvtOWCZzrHWhL0B9fDG3ugGz5wDx9a84P+smlGbnohqHt+swLenjU
	 kBvL1/su3rxyo9if49TZQpft8HH70iQYOWp/khQBkQGcg1x5tqZ+WCmfljgQy696kH
	 q97QtqZcaqazYu+Nuodj4I7qB8whixX0j8RLDr1A=
X-QQ-mid: zesmtpip3t1756449230t22c781b8
X-QQ-Originating-IP: dpykmWJtJQNv/J5iX/BsdX3MPWumKPRaL4DwDDBr4PM=
Received: from uos-PC ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 29 Aug 2025 14:33:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6719484331011562171
EX-QQ-RecipientCnt: 2
From: fuleyi <fuleyi@uniontech.com>
To: linux-bluetooth@vger.kernel.org
Cc: fuleyi <fuleyi@uniontech.com>
Subject: [PATCH] obexd: Refine error handling for agent authorization reply
Date: Fri, 29 Aug 2025 14:33:42 +0800
Message-ID: <5242DC7C99E5FE0F+20250829063342.421365-1-fuleyi@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-0
X-QQ-XMAILINFO: OK7DM3eVak3cOPAiYVYovwlvb4fDQxDMM5nKFk0ACmaf7cTN031835J9
	DT+cDnHAuMLE81msZaad29QXI002ewayTLmvfNNw6MjZBtbrCXTC8yaF351gSCV3jiW28tu
	AFaKPNbDOW4nuZlA20WS6n5Nx/1ws/fgL+vAU8ZX+cqh2LXao7OH9vhGzo3fTZ7cKfGolxs
	922K527M9lBM9SfLhIx1Ue/D0jTam5cVcLosR1YXilbh6nCq2L49fzUlBQIfBFOFv0ReSyS
	Za4xishZoXJAT83vaUwZMziZxlUE4P3K5R8fAAwM86eQ4A585ILU3F4gSa7sSOFbW9R4WH+
	j0guK4IsTmMtg0cUf0fF0G7+vLqwttbj+alrJmmbPYRdDzD5oKURLmOYy7degdhEDTs5LHU
	eOcCTOOjOVnsZHdajxdt7qUM3hmcaCKEAXPbKc+04X06zsGsjr9HlISzEKqXntfsrJPOT6j
	96rd5CP+v8HtcF4A0LrjkFaTNz/HmFyujQk4KASkg4uZ9wjFtQiRNQ2/e/c1tx/XMqkSgX/
	wBpdIhzfgF+yWcdeI/bYJWtWc1Hzbs1Nv9lBVffUfzpkTLb38IWkxHRI/r1dRXp5nFvvFCh
	WKc7Xk+c2d9pvImEGQsQcDiCuuRjB/TX8pFqgLr1aCl/rxD/FQD17M3XKXG6R0hksEpyYRg
	2Z0m9b70WssE+6JOPiasv8qt4E6rYy0GRElj+LpdLFBf5GqXmcps4eIY/+CO3uUIeZv8yNO
	/tYTKZ8TEpgOyccnevr9PR7gqabKo3c7o536DQjQqzh534ZnuODjGt7TSruKO+2mDjDL+1E
	r4Yor78KgNzRLfR9oIwYZAfKDAjpe1od3qAAVwkc7uZWxQjNZF0d4snuSFYWv1iOD5ehEry
	KzieLqI6KdwNr96Mj8qhuwvkuHYoI/KHynWZpZw7I/3fAz8vA3H+MCrsN0u+hFafqXbZx4w
	4PMG1yrtrIWX+KC3y+LmLHEpKlt0cvc9ORYPLZKF409xBYtfUpL3GsxpLtegDIk3lCa4Ook
	8VtJ02AnPKt0EUJ9VqSAJDEhjv2ER4lt/ns9JQSFPRziYAWKyGHzxM0OsOvKUPXNPYIenSX
	2DtyYRnG6Drn0J+uXSd6MAAdZzJcojMRJhDzxctE5Ho
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Handle DBus error types in agent_reply() with specific errno values:
- Use -ETIMEDOUT for DBUS_ERROR_NO_REPLY (timeout)
- Use -EPERM for OBEX_ERROR_REJECT (permission denied)
- Use -EBADR for other errors

This improves the accuracy of error reporting and makes the authorization logic more robust.
---
 obexd/src/manager.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index 683dd4ca0..73273dff9 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -46,7 +46,7 @@ struct agent {
 	char *bus_name;
 	char *path;
 	gboolean auth_pending;
-	gboolean auth_reject;
+	int auth_reply;
 	char *new_name;
 	char *new_folder;
 	unsigned int watch_id;
@@ -632,11 +632,14 @@ static void agent_reply(DBusPendingCall *call, void *user_data)
 		error("Agent replied with an error: %s, %s",
 				derr.name, derr.message);
 
-		if (dbus_error_has_name(&derr, DBUS_ERROR_NO_REPLY))
-			agent_cancel();
+		if (dbus_error_has_name(&derr, DBUS_ERROR_NO_REPLY)) 
+			agent->auth_reply = -ETIMEDOUT;
 		else if (dbus_error_has_name(&derr, OBEX_ERROR_REJECT))
-			agent->auth_reject = TRUE;
-
+			agent->auth_reply = -EPERM;
+		else
+			agent->auth_reply = -EBADR;
+		
+		agent_cancel();	
 		dbus_error_free(&derr);
 		dbus_message_unref(reply);
 		return;
@@ -703,7 +706,7 @@ int manager_request_authorization(struct obex_transfer *transfer,
 	dbus_message_unref(msg);
 
 	agent->auth_pending = TRUE;
-	agent->auth_reject  = FALSE;
+	agent->auth_reply  = 0;
 	got_reply = FALSE;
 
 	/* Catches errors before authorization response comes */
@@ -726,8 +729,8 @@ int manager_request_authorization(struct obex_transfer *transfer,
 
 	dbus_pending_call_unref(call);
 
-	if (!agent || agent->auth_reject)
-		return -EPERM;
+	if (!agent || agent->auth_reply != 0)
+		return agent->auth_reply;
 
 	*new_folder = agent->new_folder;
 	*new_name = agent->new_name;
-- 
2.50.1

