Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795683141;
	b=RmfPYeDSq2mQkUxRkhWF3viWZaGp87SN2kZird6QM2CMTifvqSFYEbCIz8rwv/Zwk6eU
	 Q2rkoxlze10UXFge1akxijfd86mcBTRPOur89ZYGnm3kQJ1BcorNHKFoLRGE8+rXYifnM
	 YQa/gmizQEe3GCbyfYD9sZkJ/RpoKPze2iFNcXTEhFTAZ0LvHpTthqfwyZXM4fdE2mlO4
	 ywh7kKhrcxLHS6PPL7bv9AWyoUg172gBXd3POVRLzNjwrIeIpWjS0pFRNoUtUhlLYr62N
	 kMtfzN/7zAYCjq9uh18PgoaHPqrfdPiwt0Dc0+qVFt5AMjaHdO0WZnlEx9rAKnRmn5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683141;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=eGo/qIdaltdfxfW8RUGbVypWsoUR0hlD7QmKdB/COy0=;
	b=e/MoZfhj+pAhyvSzNDXCcB+R72sucUAHKEOcKzN8cnkmeQnoxIcU+/J8bBLIRW/g0Qyc
	 6Bc6jVyYx/Sg3nvasaAq/3SIW+NUTj9O5059HbRsDIBK4Sec4TATGt8ozWNdF4rQXGPS9
	 zm4CuzF4QjW7IAxVI8R6Ff/rzBfXwhFYgy61FBEA0Q6ixhTtqPdk5GW9DDs0yRtG7dTNY
	 SwEbGsq/HpiY4UWGJ9OwNImt6Tic/AW7vM97RkKdLxiNC6+KSbGCHw/IpmBkj7cVJgUhU
	 oRSGVsPf0eWPTKQFAyyZayCwVoNbxtI8jojBPDeHIslf7P6bVUv/IIUfgpMNQhMl9/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=fGuo1djA;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82F5606A327
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 08:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E82F5606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=fGuo1djA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795683138;
	bh=2/5eUVSo8yhjVO5OzanE8qePEjyUQESKGPd8wgqPQ+0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=fGuo1djAF7/cWdhLjr4BcyRVBhkBV5r6QG5ECZzuhQeFszYT/mktOhxfFlVCchwjP
	 /H+gdvrm8/1e5SOzY+8ta5likLx1ZrOv+xSGccJs+q8kZVh43Q8DO6Wg0m7Ciw9wmB
	 lyfG+gghp+8n4hcqDcSfH5PM3kV1dBOu1yfD9csqAoqhvJQ4lirwOgKb0YHfuFramk
	 v6GkGmbVhmVZntlkg7uu54ITTXsfrFn1Gb4i63pyjk8CV6Np5V6Bluqgi0OFLxooyU
	 ock3rAuOE8i3keZWi1LjDPSUYTfsPoL5liVQv68D6dIpQetv05VFGZ/R8ycnrPKUG0
	 LnT34/j/BTFlA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 243B317E0DCD
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 09:52:18 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 5/5] client/btpclient: Suppress duplicate BTP security-level events
Date: Thu, 26 Nov 2026 09:52:11 +0100
Message-ID: <20261126085211.80204-6-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126085211.80204-1-frederic.danis@collabora.com>
References: <20261126085211.80204-1-frederic.danis@collabora.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

SecurityLevel and EncryptionType can change together for a single
security transition, and btp_gap_device_found_ev() can also replay an
already-reported level on an RSSI update, so the same BTP level could
be sent more than once for a single transition.

Track the last BTP security level reported per device and skip
resending an unchanged value. Reset the cached level on disconnect and
whenever GAP (re-)registers, so a reconnect or a new registration
still gets a fresh replay.

Assisted-by: Claude:claude-sonnet-5
---
v5->v6: New in v6.

 client/btpclient/btpclient.h |  1 +
 client/btpclient/gap.c       | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/client/btpclient/btpclient.h b/client/btpclient/btpclient.h
index 54f44ae9a..4de9775a2 100644
--- a/client/btpclient/btpclient.h
+++ b/client/btpclient/btpclient.h
@@ -30,6 +30,7 @@ struct btp_device {
 	struct l_dbus_proxy *proxy;
 	uint8_t address_type;
 	bdaddr_t address;
+	uint8_t sec_level;
 	struct l_queue *services;
 	struct l_queue *characteristics;
 	struct l_queue *descriptors;
diff --git a/client/btpclient/gap.c b/client/btpclient/gap.c
index 2731329ef..4f14d1064 100644
--- a/client/btpclient/gap.c
+++ b/client/btpclient/gap.c
@@ -1824,6 +1824,12 @@ static void reg_def_req_default_agent_reply(struct l_dbus_proxy *proxy,
 							entry = entry->next) {
 			struct btp_device *device = entry->data;
 
+			/* Force the cached security level to be resent on
+			 * (re-)registration, even if it was already reported
+			 * to a previous GAP registration.
+			 */
+			device->sec_level = 0;
+
 			btp_gap_device_found_ev(device->proxy);
 		}
 	}
@@ -2447,6 +2453,11 @@ static void btp_security_level_changed_ev(struct l_dbus_proxy *proxy)
 		return;
 	}
 
+	if (device->sec_level == ev.sec_level)
+		return;
+
+	device->sec_level = ev.sec_level;
+
 	btp_send(btp, BTP_GAP_SERVICE, BTP_EV_GAP_SEC_LEVEL_CHANGED,
 					adapter->index, sizeof(ev), &ev);
 }
@@ -2614,6 +2625,8 @@ static void btp_gap_device_connection_ev(struct l_dbus_proxy *proxy,
 	} else {
 		struct btp_gap_device_disconnected_ev ev;
 
+		device->sec_level = 0;
+
 		str2ba(str_addr, &ev.address);
 		ev.address_type = address_type;
 
-- 
2.43.0

