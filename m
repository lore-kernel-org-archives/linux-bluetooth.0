Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99B2227B87
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747060464; cv=none; b=n5FM2UD7KgVCvIN6tBhhh8PjF4VVvq58gPMDzApB17/vKzG3vgpo8CVzsnSucEtlV4zdUPLy22uFabtshiceTVjk7PVwF8ej/7AmQb66aMt2VsUpDVuyjbpAq8clYWI+r/duTqEIC5SNhZCENn4wwtdd5+CYjwWiP6K6sTtpi54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747060464; c=relaxed/simple;
	bh=WcN2D6UtskJWPMq+oleGhEj38XGgAxyAAptyMMI4kmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mheJXr1A0iNcr29SboiEbm74NtSTElDzXVkEK8FWTKCTlxqNQ4pg0p1qoscm/dTpVg3BDLcprX1XmKAcPPjHWAiju2OaFYz0RTc8P1En2PdBLmGFZjuyBIBTsN5oCy1Pelxhq83M/7VBhbokmEuVp0W0GpCGASjvt6MDTHw0KZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=jC2nEo7f; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="jC2nEo7f"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7399838db7fso4316362b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 07:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1747060462; x=1747665262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5JPEvtrfWchVOQ4/kHbwugCmbnBLL/r/dlkKhZ1kxc=;
        b=jC2nEo7feuMUyARMbnzzAKSNnnDsy1wAbc2rqeaMugq5WILIkMqG+4abhSTpObl+55
         ArFndyZ3tYiMxiryUW9CX9/D3BSJSnP0mxd5irfFIw4tRQGrMTXZzQSSBjBGR34bsnkA
         Ib/1ElTXfs1h3GmI1oOFsUKC98uYbO/cw9iWmUP4R2w0HL6BcVntRLeQWmOQ3pcbIg3n
         dShCQMEymE87nv+Rbr3INAL3XBhKM8Z8PanPtmZGMi1R5SCe+q06DEzmhdomTtw6gD/x
         UX2ADlazAtnhdtMROAN15R5Ety7brDmCBDU+rYHl1GjqNY/nPlBGLC9f6bNowg3sr13B
         bPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747060462; x=1747665262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K5JPEvtrfWchVOQ4/kHbwugCmbnBLL/r/dlkKhZ1kxc=;
        b=gzKqw4Q55HqGZbiu8+coDIxgdmrHHJwYO4AYXO1wsei4exov4mLD5/5CDMPI+lUFm6
         4iSB0AkOBMMQ/Tn0BO0ZgOwcfdpi19kRpI9PSOqxZsYzFrZQAGXdkAr8T13i4sS0iHr4
         i/7aadkMwUtFwqCPG0tNIkAKwmtKMubbvNb206WJdNypNF1AQQQECzywA3dhay2pZybz
         uZhSe1cbZWdn3GGieEiFSB2apKiCM55vvsxmfdKNlvyOD99v2NDhnggh901lY2BNv4vf
         WHJPJ8bIT3miPhMekZ2CuMu5tz5VGQ6hA1L96J61FMiQlxmI1iaDnDDx+oAPK/AD+b8S
         nBgg==
X-Gm-Message-State: AOJu0YxaI3Sd/tMrn9QnWubXj9p1U7syxgJb4NCNtDl6EbLxlG8kbc3F
	IvkpEokdMT7+I9uD+urHoJkw8d0vOlKt/PRm2+FNMTL+0mc90tzPDL89PFP4A5d+2c2wEkqP0nc
	k
X-Gm-Gg: ASbGncsorC2ZqOTre5TpYnev3lAIag4fm7WWcwSLRiwT3+n6+W7KKXY6fVt5BM1ahI0
	J89Jr0Uh3lDickquAvW/3c1cvSLVTSZqzt13yU4iWLE7uFTGXgIxkH1Ie4+6dnR6Q9cvl3eSOC0
	qUG6t8Q2j6z1r8lfBsarPWx0l9JVsLVHo6J+FheXYdF1kTp1TemkGHHvVOktob+CT1nlsdCwb+8
	0uhNxVtkeSmQXKQcnM3KtkOmu4X4xdELpnRVfgSlyy8S2SB25cqyvgflmQxySIA+mNHTEMJoBE5
	0RZRhRr0Y/2f7vhvHl0rhFWWhlxnX//5b5916G6uRBAKhCib73t0MfYvGEGALoYrM0M=
X-Google-Smtp-Source: AGHT+IG65VFOYSSxWZ81VMiML7+/ctiBk7TE17TJFGC6obbQuDq5M+FBWKrqFrxx+3xnYQTEbbr8hw==
X-Received: by 2002:a05:6a00:138a:b0:73c:3f2e:5df5 with SMTP id d2e1a72fcca58-7423c06f4b4mr18281542b3a.9.1747060461886;
        Mon, 12 May 2025 07:34:21 -0700 (PDT)
Received: from localhost ([2401:4900:1cb9:9be3:2edb:7ff:fe58:f2f5])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74237a1088csm6046107b3a.113.2025.05.12.07.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 07:34:21 -0700 (PDT)
From: Sanchayan Maity <sanchayan@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>,
	Sanchayan Maity <sanchayan@asymptotic.io>
Subject: [PATCH BlueZ v2 2/2] transport: Fix the use of callback in transport_asha_suspend
Date: Mon, 12 May 2025 20:04:08 +0530
Message-ID: <20250512143408.283938-3-sanchayan@asymptotic.io>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512143408.283938-1-sanchayan@asymptotic.io>
References: <20250512143408.283938-1-sanchayan@asymptotic.io>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some devices do not send a response to the stop command, so
audio status notification might not be received after stop.

Instead, as with the Android implementation, we just immediately
acknowledge the client's stop request after sending it to the device.
---
 profiles/audio/transport.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index c5ae3a71b..153515191 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -2295,42 +2295,49 @@ static void asha_transport_state_cb(int status, void *user_data)
 			media_request_reply(owner->pending, 0);
 			media_owner_remove(owner);
 		}
 
 		media_transport_remove_owner(transport);
 	}
 
 	asha_transport_sync_state(transport, asha_dev);
 }
 
+static gboolean asha_transport_suspend_cb(void *user_data)
+{
+	asha_transport_state_cb(-1, user_data);
+
+	return FALSE;
+}
+
 static guint transport_asha_resume(struct media_transport *transport,
 						struct media_owner *owner)
 {
 	struct bt_asha_device *asha_dev = transport->data;
 	guint ret;
 
 	ret = bt_asha_device_start(asha_dev, asha_transport_state_cb, owner);
 	asha_transport_sync_state(transport, asha_dev);
 
 	return ret > 0 ? ret : 0;
 }
 
 static guint transport_asha_suspend(struct media_transport *transport,
 						struct media_owner *owner)
 {
 	struct bt_asha_device *asha_dev = transport->data;
 	guint ret = 0;
 
 	if (owner) {
 		ret = bt_asha_device_stop(asha_dev);
 		asha_transport_sync_state(transport, asha_dev);
-		asha_transport_state_cb(-1, owner);
+		g_idle_add(asha_transport_suspend_cb, owner);
 	} else {
 		ret = bt_asha_device_stop(asha_dev);
 		/* We won't have a callback to set the final state */
 		transport_set_state(transport, TRANSPORT_STATE_IDLE);
 	}
 
 	return ret;
 }
 
 static void transport_asha_cancel(struct media_transport *transport, guint id)
-- 
2.49.0

