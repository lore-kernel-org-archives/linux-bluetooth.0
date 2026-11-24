Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531615;
	b=BNdJ5+EXJ+HQHaQzd8Qu7Uu1eZLhWEHTRHb8ad5BBFYWrcbTyqHQB51G+Rpo7D5enAlh
	 ddM2b3u+bfczTjI7KpXO7Hk67ZePrkuMeKwrSF/eK8jGg3PJVrhHHtbwlUTTo64wcwqlf
	 qp71prgMZU6MhCJfIJo9nStR7upqClDZbYn7IgkfRIjLATf7hx5wjKWD4GBL+9x9OzEPY
	 QFN5VvuSezvpngxR6ahWlyzH2aSp3MezEvmTD8my84MfQD/re7PInkFPfsenkgWgI5vpD
	 GadYV7uwD0uyiJ1YG8FTJC4YQ65vbkEXhAdV+BhKpaSJRMZkmm9nI8YhMzlBLMyrLdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531615;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=k7931+pByh+fm0RROpVCeoCKV9LNxZUw1ZYe/Wt/HJQ=;
	b=iWXizFK57LIsthR9t7Lng80VqwASOEEXX7XVm7srvr/TRBV1CCsDyAIs6d5JDCtuwEju
	 y8xTwUE3fO0wrVaLuSpJf155DJ+tDh3fArVJMtrJ3iR0jxDe1A3vqEAEa3sahhgSntM+p
	 kiZsUr3rCNNXtnuMi0RylD8DFPgm9dQvyCVnAncVzYIgSpV8VUJFQ8v/EXOD2nb1SPqML
	 U6RYSiNvWd4lhIOMVQrcZOeWZ/nK4KuY9HTffI20puLPjsfgNkeeP2Gs1yrxnA5A2uatr
	 J8yRlKgx6VdbEcU7bFnVt5reuveJnDhOOeC3jZYTYRDvOKgdSgWd6AuGpHb8qMTtLPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b="i/c0Zm8j";
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4BB606A32C
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 14:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC4BB606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=i/c0Zm8j
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4a34ffd3e39so2524492f8f.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 06:46:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795531613; x=1796136413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k7931+pByh+fm0RROpVCeoCKV9LNxZUw1ZYe/Wt/HJQ=;
        b=i/c0Zm8jmq8zhOPTTKOW0wIxUoxsSF2Jfg5z7SUr4+FKIE2DZ5DLRXs8xL60R9FmyF
         nsGFqjIgzM3rOJHcRcxMKkurRVS5BRgG4IJ4iCkfTbw9h0l5X5ef+wxTAMWsJR5OBu1P
         V6RfjIpS0K/2GXCTCCdgpm7UhhSiUyYNVWl38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795531613; x=1796136413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k7931+pByh+fm0RROpVCeoCKV9LNxZUw1ZYe/Wt/HJQ=;
        b=ROQ3KiVEza/LY3Ea2Un6J1USLhblJdDmPFQ88UwS2s5PR77NYXP8LTXu+cCk2d87yp
         RSxR+nvRDq4q41Y9PxsUigGps9uC+07A2tJBOhrdDmPX8kcRtFSwxWma4H6peYu7k27C
         8fADHaVKO0uGkFgzovBbtTY022sd84Udf5kVaNddBOFznLOyfiDdxT0TEivCfrWvUCzE
         ouwFOUSxvsgoANSI7LxiEYOAHNKhNvqsqJYdjXsxR8eTgBM/SfzZbCa5RwUf5iSrhwkR
         Pa0wdOhJVRU+54m7FLVv2v/cVmdRNAuWBbuvxut72UhsZjtMH/M+TCU63yB+jhOGXAcP
         HOZg==
X-Gm-Message-State: APuU4Z+zH6UpP4Txew1PiE5XNxfDR9sfdoADNy303MzFq6G6gdF89bJf
	pUNEXRITu3XXwfq4eK7UdKBhyn3TXghq0uoVJwxrYR0OdmfrHBn9aUIK3BoLh4aZDxsogUIBBt2
	rOVdw
X-Gm-Gg: AZFdTZf4XtBSngxdvfeOsEcJhs4ooWUWkhfnv8EXlajOPoenkufgLic2cPda+5SMq2n
	Dl2XBeUeOulCQfI2gvmvhPW1NfjVQJOaoep1Lx7NWK30MQsb/aYdwgexFbcyQTo+5mEJTFTmvH1
	64gPeu0386BwRE5ZzCRyPQLrTVOzWGzO8osAZzjhZq+foCBm23pvM+MKuiJOyDC59VSRFBcgoUy
	XxgAFNJChZJEdvCjpwj23dGHAEEuBDSTIWXw5/uN0htH+YdyZ3nkiqD3dCQctJ/eOAxQJH8rmDY
	EQqhNJRG7DsuheuK2M3tG8Lh19lDpT48hV+CzNN91B+BC/XqUznBbZgmBhh6ybo0pek0Jt//uVf
	1kuTTk2KD9TmOmecriQxp6Jd3fnr4Pg0YOwNrC0X9RbRPsdT9HmZOE+AYJ7uhk23dKYHj2RfcbL
	jPdyaEGXMQ4H1da2DawjFK18j5BSSLWcUOnTgAFStryF3qfUtH7RmYAcVkvIg2wSKIlZyvXSQkK
	CsqB+OFDrbWybH4V7cO/BslSAlnCQBS6bUIvWXzXOG13ERSThMJXBUfC84pO/FCjYFbpol3kmsZ
	UaMoUqehgfl/7HkorsTzAClfV2z2rVLebsRV1secN0S760mC0g==
X-Received: by 2002:a05:6000:1863:b0:48d:b940:af7a with SMTP id ffacd0b85a97d-4abb665167bmr35727796f8f.55.1795531613253;
        Tue, 24 Nov 2026 06:46:53 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf61e8sm29891561f8f.11.2026.11.24.06.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:46:52 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 7/8] device: Don't accept LE profiles over ATT on BR/EDR
Date: Tue, 24 Nov 2026 15:46:41 +0100
Message-ID: <20261124144642.298366-8-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124144642.298366-1-simon.mikuda@streamunlimited.com>
References: <20261124144642.298366-1-simon.mikuda@streamunlimited.com>
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

When ATT runs over BR/EDR, every profile accepts the GATT services found
on it, LE only ones included: BAP reads the PACs, VCP, MCP and BASS
attach, MCP creates a player and RAP a ChannelSounding1 interface for a
device without an LE link.

Skip the profiles of the LE bearer when ATT runs over BR/EDR.

Assisted-by: Claude:claude-opus-5-5
---
 src/device.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/src/device.c b/src/device.c
index 7a85403f0..8508fed81 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4806,6 +4806,19 @@ static bool device_match_profile(struct btd_device *device,
 	return true;
 }
 
+static void device_accept_gatt_service(struct btd_device *device,
+						struct btd_service *service)
+{
+	struct btd_profile *profile = btd_service_get_profile(service);
+
+	/* A profile of the LE bearer doesn't run over ATT on BR/EDR */
+	if (profile->bearer == BTD_PROFILE_BEARER_LE &&
+			bt_att_get_link_type(device->att) == BT_ATT_BREDR)
+		return;
+
+	service_accept(service, btd_device_is_initiator(device));
+}
+
 static void add_gatt_service(struct gatt_db_attribute *attr, void *user_data)
 {
 	struct btd_device *device = user_data;
@@ -4845,7 +4858,7 @@ done:
 	}
 
 	/* Notify driver about the new connection */
-	service_accept(service, btd_device_is_initiator(device));
+	device_accept_gatt_service(device, service);
 }
 
 
@@ -4907,17 +4920,16 @@ static void device_add_gatt_services(struct btd_device *device)
 static void device_accept_gatt_profiles(struct btd_device *device)
 {
 	GSList *l;
-	bool initiator = btd_device_is_initiator(device);
 	GSList *services;
 
-	DBG("initiator %s", initiator ? "true" : "false");
+	DBG("initiator %s", btd_device_is_initiator(device) ? "true" : "false");
 
 	/* Accept in profile priority order */
 	services = g_slist_copy(device->services);
 	services = btd_profile_sort_list(services, get_service_profile, NULL);
 
 	for (l = services; l != NULL; l = g_slist_next(l))
-		service_accept(l->data, initiator);
+		device_accept_gatt_service(device, l->data);
 
 	g_slist_free(services);
 }
-- 
2.43.0

