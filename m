Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793351117;
	b=KodvecEvyCEqPMl3p9zJs7rJFL+0/kLi2x1TTXgwH1PK6JPanKp31/VPZyqewrWOA+fj
	 oGn32i0ODfkbxvJxmvVpBgZc82RW682lri7IJ8JxNxv6VEzR5xxQvgvxjvkpyX4MgMmOC
	 EyqpLTyd6JGaOoqgV/KPCBmtELA4ZXu6qjrHGcytxN5suFnnUv6nii6YyYJy1LQ9KbA9I
	 Scz5Yz6X+MHuR4EVFvqdCrsFE3EmU39R7+Z3PkH489x51rQDV5QxrVwQ83FWaoHqeeSr9
	 HAt7MSnVZhsGSJE5ERQ42hqgO0LNuUWJzucLMzfkuwCTHb7KYRSz2irQSDa5grnPxew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793351117;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=iLLJ7VSWkfT6blOLGIaUD9z0kVz6HbaoViZTdSH2puA=;
	b=ujI3oRobLujtAIvIStgjDnEl+ICThnD+80fk7y62u+Hz8opasjzgy54y/Dc4jUxI3m0t
	 F4mWr8rzDQLEZ0dg5Ki6dpBu4Sv4KaxNk8Qx8ehU+2AYeesKC35/4zEu5Xa2jF/Spic3E
	 LsKBsS6sDnbuvFAFFS9OpNFQmmCVXYVS8VcKP6eaXrnlNaw8DXtoxERwToT6raAJxlt13
	 SpnHJNjf3hmC3VeFyhLEiuhMdYqUtDVdL3Crtwo8hz3RVv2D/HC1ziqHtOSk3QULGshgT
	 go5p84N4Q3HjgsBkqvaRnQMBshcE/6krenf4AG5rMaOrwAyADDwL2Q0OEvjOYEkWTQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=teenage.engineering;
	spf=pass smtp.mailfrom=teenage.engineering;
	dkim=pass header.d=teenage.engineering header.i=@teenage.engineering header.a=rsa-sha256 header.s=google header.b=VqXIuuj2;
	arc=none smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454A1606A31C
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 09:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 454A1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=teenage.engineering
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=teenage.engineering
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=teenage.engineering header.i=@teenage.engineering header.a=rsa-sha256 header.s=google header.b=VqXIuuj2
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso875741a12.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 02:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teenage.engineering; s=google; t=1793351116; x=1793955916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iLLJ7VSWkfT6blOLGIaUD9z0kVz6HbaoViZTdSH2puA=;
        b=VqXIuuj2P0mHXmynp602Gc/vtl4EJ9aY5JUC3/sOTrXpkRQoDjz4R+ObcwvTB6Urea
         K9lKRG4elFjG8Qmj5+ttsy9lT6KvKpDAa4OALgZpe0xfCs1Hsob/2e2yIlvVk9Orh4vX
         qlvf8thRqMLC/fkFyxzksA0vWQopWfv9HSr50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793351116; x=1793955916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iLLJ7VSWkfT6blOLGIaUD9z0kVz6HbaoViZTdSH2puA=;
        b=nUt+amaP0eyvBBFczom/yLXJfA2lmK4wZuTwbqNKz9e2Ku+XFoSOlGcV5pBlukaxN5
         TxjfQEHEFO5c/9G80fTefLTq96fFOU8ELnzTb6p3htI8UbynsW2YYOOASGGaJznT5xCL
         zX3oi7oGBcct1YqvUUxIUh3kSnyxMNW3gJWK2Nh74DEsH9dpQ60NC9MQVJuj1wUCqLE8
         TdI7qy6qrSIABeChf+do+RGpZ5/BhkQ5CwvU+UJxQP3vuCAS7OquqHd+I6G/fk8/XvQi
         enalcycaLH+4ngQihoXEcl3MHMXDR9EQ9NrEi5Rj1jxKeuajDzhSTjoaSnQwoKksihvw
         i8ow==
X-Gm-Message-State: AFq9FYKhdLVdaTM1sTk3bnUSG6dYlklgpKMvUp0B5k0xfngPEe+Z3b7B
	ukg8C7zyY9W1Ql0lRwa7/SvaMadeUPPYIew83UYkls5W6P+HvMsjcz5mqRWSCYvBbiIeIcXFOow
	A0iQNmg==
X-Gm-Gg: AYBFou02zJ4GMl3De36vUSGnEWlw3eMvP56EK8QQfzD/JlP+R94bQcqWNNj+tyPdeGr
	lDU7lbf+hd4UWeNfv9Himv1js8YL9QFnZPZapWenMVpEsztGDoHMxU6jg7OTrd/tSx7Arv/ipsG
	/KO+4q10QXkeY7OU1Ufp9vDo1zli0aoyc/SyIvbeMvpBmWyYt0VLzSUFWRk8XsQTBymLsM0Rqo3
	gZLG9qh3Dr3wi8PSs3vvecT/3sO5A621H4k9TcwrS/v4E7yPa/d4tenfAp9FggrQz+2Q1Zwe+Ba
	QbZ3pGIKlBKpopSUgY2DBIZ2c93fv11eyrZbVY1HK3cJope/jLOwsjO0Hlp/v3S8wFTQw4SU4bo
	pHU4OM0lxK0jPMW8Zb7mIU3mQVuwPIrwbnJzq/4WkCTubhJ5mNlxASp1FfEwztk76jafZgJsXM+
	TLVGLk8UP6R2lx8D7YYImj+dDEmLthXdpl/YdrurFiBIPa6iL5NQn28BzQXTJfdxTOcebu5BE7u
	iK0y5wsyjdfVkxO8qlanmiUklhOWSb0+U5wJX0Dlks5Tc7r1jx+YulCpnR+TYsnb2y80dV7suRE
	dly33P/3QteHqOAXl8VGV7dm06sV0tm/Yl1RsamA3sGtxkqF5L2w4V3uoHaQVF/tQGAYADDzp8b
	m2GcCxxLg0oXKFJBkn9qxBfyHXV+xqG8eJf1Rh+8=
X-Received: by 2002:a05:6402:789:b0:6b1:8316:ba32 with SMTP id 4fb4d7f45d1cf-6b4d46754a6mr800229a12.17.1793351115745;
        Fri, 30 Oct 2026 02:05:15 -0700 (PDT)
Received: from jacob.localdomain (c90-143-204-146.bredband.tele2.se. [90.143.204.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b4d7a4eac5sm393459a12.5.2026.10.30.02.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 02:05:14 -0700 (PDT)
From: Jacob Siverskog <jacob@teenage.engineering>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>,
	Jacob Siverskog <jacob@teenage.engineering>
Subject: [PATCH BlueZ] audio/media: Fix build with --disable-hfp
Date: Fri, 30 Oct 2026 10:05:10 +0100
Message-ID: <20261030090510.88867-1-jacob@teenage.engineering>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HFP MediaEndpoint support calls into hfp-hf.c, which is only built
when HFP is enabled, so linking bluetoothd fails with --disable-hfp:

  profiles/audio/media.c:242: undefined reference to `hfp_hf_sco_remove'
  profiles/audio/media.c:1467: undefined reference to `hfp_hf_get_device'

Guard the HFP code with HAVE_HFP, as is already done for the endpoint
table entry and in transport.c.

Fixes: 89b91a4806fb ("audio/hfp-hf: Add MediaEndpoint for HFP codecs")
Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/media.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 34ff251c7..abd3cb992 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -238,10 +238,12 @@ static void media_endpoint_destroy(struct media_endpoint *endpoint)
 		endpoint->pac = NULL;
 	}
 
+#ifdef HAVE_HFP
 	if (endpoint->sco) {
 		hfp_hf_sco_remove(endpoint->adapter->btd_adapter, endpoint);
 		endpoint->sco = false;
 	}
+#endif
 
 	g_dbus_remove_watch(btd_get_dbus_connection(), endpoint->watch);
 	g_free(endpoint->capabilities);
@@ -1457,6 +1459,7 @@ static bool endpoint_init_asha(struct media_endpoint *endpoint,
 	return true;
 }
 
+#ifdef HAVE_HFP
 gboolean hfp_hf_set_configuration(struct media_endpoint *endpoint,
 					const char *ep_path,
 					media_endpoint_cb_t cb,
@@ -1514,6 +1517,7 @@ static bool endpoint_init_sco(struct media_endpoint *endpoint,
 
 	return hfp_hf_sco_listen(endpoint->adapter->btd_adapter, endpoint);
 }
+#endif /* HAVE_HFP */
 
 static bool endpoint_properties_exists(const char *uuid,
 						struct btd_device *dev,
-- 
2.53.0

