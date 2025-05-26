Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD22B3C465
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 May 2025 19:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748289123; cv=none; b=kJlUooFOBNgw23/Lxg1yoOxFZ2hyVWdt55ex6MtUoOUEWIrr99FR0RSufJoaFk9Gf06OC5A5Ow3AfSOnuYXc04X1Pb04u32Uz9q3vjXNJR+36WD3tfJQUYNiax+jg9YF4eW35nXA8Chxp4cbbw/CIUPn1bOK19SQCwPAXmFfOuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748289123; c=relaxed/simple;
	bh=D00RHDlNrTVIa7DyjZChMl8PaTVB9iTiGbaKs9HxIQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U4qJfQNc+RJqsZBYj6HuzDqVe3lwxmRo34o+nu+YurzQ2I2oTgF564KimB8ht0ka/TMjpnyxts2GsOX27dyZNRGIRlyrNkW8y5Ktcr092CYhVFGubHs2hdwWWZ20vigRZUq2l4f2r2iKXQJIs4rhxZQxsabfvjFbrV98o4167Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=GiS+DkiJ reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=CIC7p9Mo; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="GiS+DkiJ";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="CIC7p9Mo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1748290020; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=XPNHOD4qOBhSlprrx0fS+dkW80t98f7p2v/qxbkcPHc=; b=GiS+DkiJPzj1ZdJkEO6H2yjh67
	YnsnghXhNQEMgEW+rDYp2uxktm8JEY9JfcxgzxVvAHJx9eqN2NF4HsytaA62q3lpoBTECUPgY839X
	uEQAGErWdoHCy1Fm3+z2alrAKJnF/eS1p25thi1BuWOEDe9BKcDGFGosP0DdiDCDGYIwAL9Np4aH9
	nMpZ/YPcrsm2ynI3TGjnLGpQ2EzQHW85Bq6FkiE1b9zc7eXkN+sLEOF9irtOsYtHJHKWMc1onvT3C
	u3zvq8Cj5vCrhrZxy0MbbjxgHW97w2c+ofPXfd2GtgK9FPqwPVStwJBGrDErsIL6DPJ4JsRTwlx6n
	4nddwb8A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1748289120; h=from : subject
 : to : message-id : date;
 bh=XPNHOD4qOBhSlprrx0fS+dkW80t98f7p2v/qxbkcPHc=;
 b=CIC7p9MoqVEgrqYxzxFUWCZGfMv32aHTdWmtSclbhkXAtuWjYALOLdA0zrbSRqTj6dLe/
 BxGBuQJiAn/JzMo6w3K5ZR7LkhxIpQjOFte5WjVX3c8YM5zNHYycJ/LO2NPYqRJIE4NtpDS
 vTSgPdccA1oS53ohVw8HV40F37kghUwAZhF0A33V1DLTJge+IoTucbMqtuaFXJXLJaxcKNE
 tbw68CQSsQqaDZzF8yP5k+ZzGDVecL+6kJ2p8hcEli5snSYQlqnZ7gvAYTprdsew/tJol5A
 jKeW8PX7IIFucFMFJ4HYTq2CJo4xwvgXvpGY9LzCAYf5yoJIAfPMlz9qkD/g==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uJdrY-TRk4cP-GK; Mon, 26 May 2025 19:51:56 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uJdrY-AIkwcC8mNqC-HZWi; Mon, 26 May 2025 19:51:56 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: linux-bluetooth@vger.kernel.org
Cc: Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH BlueZ] policy: Fix reset Control/Target/HS retry counters
Date: Mon, 26 May 2025 21:43:28 +0200
Message-Id: <20250526194328.15875-1-repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: kHNM3QcIv54n.s059qfr0OLkM.xT4_RgnM9Kr
Feedback-ID: 510616m:510616apGKSTK:510616sd9kuJY7Mo
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Control and Target retries counter were reset when service state
goes from CONNECTED to DISCONNECTED, but usually an extra DISCONNECTING
state is reach before going to DISCONNECTED. This causes retry counter
to not being reset in this case, leading to service not being able to
initialize on next connection. HS retry counter was only reset when
limit is reached.

Reset the counter as soon as CONNECTED state is reached to avoid that.
---
 plugins/policy.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/plugins/policy.c b/plugins/policy.c
index 0e533ba1f..02ce16f67 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -383,6 +383,7 @@ static void hs_cb(struct btd_service *service, btd_service_state_t old_state,
 		else if (btd_service_get_state(sink) !=
 						BTD_SERVICE_STATE_CONNECTED)
 			policy_set_sink_timer(data);
+		data->hs_retries = 0;
 		break;
 	case BTD_SERVICE_STATE_DISCONNECTING:
 		break;
@@ -537,8 +538,6 @@ static void controller_cb(struct btd_service *service,
 				timeout_remove(data->ct_timer);
 				data->ct_timer = 0;
 			}
-		} else if (old_state == BTD_SERVICE_STATE_CONNECTED) {
-			data->ct_retries = 0;
 		}
 		break;
 	case BTD_SERVICE_STATE_CONNECTING:
@@ -548,6 +547,7 @@ static void controller_cb(struct btd_service *service,
 			timeout_remove(data->ct_timer);
 			data->ct_timer = 0;
 		}
+		data->ct_retries = 0;
 		break;
 	case BTD_SERVICE_STATE_DISCONNECTING:
 		break;
@@ -587,8 +587,6 @@ static void target_cb(struct btd_service *service,
 				timeout_remove(data->tg_timer);
 				data->tg_timer = 0;
 			}
-		} else if (old_state == BTD_SERVICE_STATE_CONNECTED) {
-			data->tg_retries = 0;
 		}
 		break;
 	case BTD_SERVICE_STATE_CONNECTING:
@@ -598,6 +596,7 @@ static void target_cb(struct btd_service *service,
 			timeout_remove(data->tg_timer);
 			data->tg_timer = 0;
 		}
+		data->tg_retries = 0;
 		break;
 	case BTD_SERVICE_STATE_DISCONNECTING:
 		break;
-- 
2.40.0

