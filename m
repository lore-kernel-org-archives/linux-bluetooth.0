Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2FE2749DB
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 13:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.2.141.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354027; cv=none; b=GsOHpgdODFkqGAlqdhxKATrTTfDm9vbHdzKOk+ihb8Sz/W0vowex1yQKaz/IZIpR/HWvssuBZCx7huproKNSLdasHLZsntvqpDfoFk/5pGGBDpfDsRQdx0UJdiUEcM/EbqTPn4sor4uZYbwFRRfM56klLSEGjFqveEOHnJzag08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354027; c=relaxed/simple;
	bh=F2arN47b4bB5mmRnBlyQhUoqXVcPR8q3XjoP1Tlu8l8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a9t87e1BvlDAhYlmpZzXl8+fifjDHiZAoEJd8IL8SldTOVv8sJPQxIPh19bH5oRZu7qSSDs9/QEM/VFGMWGlvQmY71Xpmh44UqLYO8AjVEnrwocV/hX0cYoaQfjb89gU5F+SmVfOOO3NElORs+9ZrCNAEyKg0bP/sdiGe3cXDMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=fail (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b=q9/bk2xL reason="unknown key version"; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=gEB0YFaZ; arc=none smtp.client-ip=103.2.141.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="unknown key version" (0-bit key) header.d=smtpservice.net header.i=@smtpservice.net header.b="q9/bk2xL";
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="gEB0YFaZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1748354924; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=2QLsocQqIIE1PjUWYoJN/0gG6O/8Y+rlS3W//d5Z25k=; b=q9/bk2xLDfweXMk1amfBhyUDtc
	a2Lr37f40G9WWptwuvTMOMPHTH2kcqcxb2Jts4MedDlXjqTKSdIT7WTXLHHhjTsL0o3i7pFq8FzH0
	IW0UWTQ/P2lQJjipa9jHpbLtfB+7r7VW/McxSV4lDRJmQY8fqiBZCGTjtwfgHyh3hbnNzBmW90Dbe
	EcuAnCGXGrxeJ4VsQZCMxINimAH14q6mK6o7+ZWgbwK8aeC1dehKMRtuZn9eTQbsQvIJ2x6N+Kw6/
	YlO2aYPKZF4B62pJonPu8+Vkzq6oTzNmBrahJ6yGFVgf0sLweYw06e2lDN1o2VSG1eH4Tx/OxWqYX
	8Pw0J0AQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1748354024; h=from : subject
 : to : message-id : date;
 bh=2QLsocQqIIE1PjUWYoJN/0gG6O/8Y+rlS3W//d5Z25k=;
 b=gEB0YFaZvEOBB7NpnW2jNEkllpx+qrkYhs14X0rej/QBEdXsKLJw24BGKBFQuWa1USEbh
 jYjjmRcVxwfdaz63Pz2PzXNAUHGwRQHYQopkzgkp0y4hSVsyvyAE9C4xqrgkz17vOTGEQ8x
 vZ+3GII11wI/iPupgJRj3+JjggUdp/yqXtCyn0IwD2lWDjV3lwvpeyy+H0oErigW6dksfod
 173zy0DXvRnZi7N6ybOm0gDsVj4xJZFMWzqAaWSrXmIC6xs+kNMX0RWKLrjNM1s2wn1KcfS
 qQfaRt39z9eBYJk9mgiC9YN/LW4V6mkUp7S8z4dGv5pzCX8q3KllDHJAwsow==
Received: from [10.139.162.187] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uJukP-TRk3NG-7n; Tue, 27 May 2025 13:53:41 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1uJukO-4o5NDgrlFa2-oELH; Tue, 27 May 2025 13:53:41 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: linux-bluetooth@vger.kernel.org
Cc: Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH BlueZ v2] policy: Fix service retry counters reset
Date: Tue, 27 May 2025 15:45:21 +0200
Message-Id: <20250527134521.4942-1-repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: L8cbotX3tUDC.nMtce4RkEwxW.5Tl-0QZ0PpA
Feedback-ID: 510616m:510616apGKSTK:510616sM14PTLsSF
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>

Control and Target retries counter were reset when service state
goes from CONNECTED to DISCONNECTED, but usually an extra DISCONNECTING
state is reached before going to DISCONNECTED. This causes retry counter
to not being reset in this case, leading to service not being able to
initialize on next connection. Source, sink and HS retry counter were
only reset when limit was reached, moreover HS timer was not removed on
CONNECTED state.

Reset all service retry counter as soon as CONNECTED state is reached to
avoid that. Also remove hs timer to match other services.
---
Changes since v1:
  - Reset all service retry counter on CONNECTED
  - Remove hs_timer on CONNECTED
---
 plugins/policy.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/plugins/policy.c b/plugins/policy.c
index 0e533ba1f..561e3c089 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -311,6 +311,7 @@ static void sink_cb(struct btd_service *service, btd_service_state_t old_state,
 			timeout_remove(data->sink_timer);
 			data->sink_timer = 0;
 		}
+		data->sink_retries = 0;
 
 		/* Try connecting HSP/HFP if it is not connected */
 		hs = btd_device_get_service(dev, HFP_HS_UUID);
@@ -375,6 +376,11 @@ static void hs_cb(struct btd_service *service, btd_service_state_t old_state,
 	case BTD_SERVICE_STATE_CONNECTING:
 		break;
 	case BTD_SERVICE_STATE_CONNECTED:
+		if (data->hs_timer > 0) {
+			timeout_remove(data->hs_timer);
+			data->hs_timer = 0;
+		}
+		data->hs_retries = 0;
 		/* Check if service initiate the connection then proceed
 		 * immediately otherwise set timer
 		 */
@@ -489,6 +495,7 @@ static void source_cb(struct btd_service *service,
 			timeout_remove(data->source_timer);
 			data->source_timer = 0;
 		}
+		data->source_retries = 0;
 
 		/* Check if service initiate the connection then proceed
 		 * immediatelly otherwise set timer
@@ -537,8 +544,6 @@ static void controller_cb(struct btd_service *service,
 				timeout_remove(data->ct_timer);
 				data->ct_timer = 0;
 			}
-		} else if (old_state == BTD_SERVICE_STATE_CONNECTED) {
-			data->ct_retries = 0;
 		}
 		break;
 	case BTD_SERVICE_STATE_CONNECTING:
@@ -548,6 +553,7 @@ static void controller_cb(struct btd_service *service,
 			timeout_remove(data->ct_timer);
 			data->ct_timer = 0;
 		}
+		data->ct_retries = 0;
 		break;
 	case BTD_SERVICE_STATE_DISCONNECTING:
 		break;
@@ -587,8 +593,6 @@ static void target_cb(struct btd_service *service,
 				timeout_remove(data->tg_timer);
 				data->tg_timer = 0;
 			}
-		} else if (old_state == BTD_SERVICE_STATE_CONNECTED) {
-			data->tg_retries = 0;
 		}
 		break;
 	case BTD_SERVICE_STATE_CONNECTING:
@@ -598,6 +602,7 @@ static void target_cb(struct btd_service *service,
 			timeout_remove(data->tg_timer);
 			data->tg_timer = 0;
 		}
+		data->tg_retries = 0;
 		break;
 	case BTD_SERVICE_STATE_DISCONNECTING:
 		break;
-- 
2.40.0

