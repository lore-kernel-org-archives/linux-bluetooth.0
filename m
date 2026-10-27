Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793110209;
	b=PUAJTz0FHPdnm3H0bBBNBTAKtmlrta3uqknRwUmrEj2cD0d+1MEVhgFoQJpqdgvqzNEs
	 6H6S6gE+0wyu/YvXMVEesqtAWV7jU4FTxEBSQiDwerX8vmeTwxVjWYVoxwE5iL0lPe1GD
	 mcNwDvtktmNfGszhWDyOHsUtqkx5KGYQhd/pRWUoDXx6DrgC2mpC4cFySuIFHIulCNkae
	 b7um2GgB9NdCD1DZOl98omJXZR8NCPOkOcW2tEJ+Sc0LTpHzYalMdAMIvdR+B4pLHEtoY
	 ia6ViB6lHM+r38n3/5I0YgrL6hV7HxTgyu/9tHCfuFiOBwOXqWsLLdCvfPk33oFGpbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793110209;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0T898B1wyJhlG3noalOwL94aVx4N49jD+j0Akx8FUdU=;
	b=dl+P21BvQi2GRSfOqshl9mim9PvCJ/mRGIu0zhRvm/PgnCHY4YwuKNHTTsEtzgZ0cysF
	 z0jJXZou0IP6+gNTa9+9PzZgo55StbY0OPiUKrI1t0gwNacEFJjF9vZEVJ7mD9ARSqqd8
	 WWiOL0jL+3dfRUEDKG7lwiDkyVirC9e9H68o7LtO9Az/6tKcdl2H9Sr3qqfvZFcjel6VJ
	 qZ6StvDJ0T/CpvHmeej+BjZyQHUjFetvTYRfI0oAWw4zbJU/5roqzNU7FCqSLmA57n4FY
	 7PZWLjPcYVmr/tp1WPWURr5XG7HkUk8L4S8VjOGLxEQ4WLZIAPc8GKNHZtHH1BlqHQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NDw8XHxZ;
	arc=none smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF121606A320
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 14:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF121606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NDw8XHxZ
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5e9528732b4so3358988e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 07:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793110208; x=1793715008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0T898B1wyJhlG3noalOwL94aVx4N49jD+j0Akx8FUdU=;
        b=NDw8XHxZE1N8nFGD2nUUPSfQVAthQpbvq1CV/XXOXfq2qGH87M5kR67T8SWHLL7mS0
         wo26/oLWEa1augx9uemsS//lboC/MlC1Ytktjv9vvLoHk/LDuanURpUKvR+GHGCGz7QO
         T57VTXYQn5DQM05IB6LhwBTOb7brADD+Rq1yBVMJIzQ/fmH489NhGUi1g0s5QKHhfAOe
         l/C4UW6H7jAWxPoifRzbXV5ni3ly5ALhu5ly4NwAB0Z9pd3weGzXg3wuDbAo73sTrA78
         KPK9gZr6O57o1Uw6EpAfFpytovYVXdXRgUgOfMYL/JnI9SYttT2bQmyQTMm/NXxvi+Fz
         Yoqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793110208; x=1793715008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0T898B1wyJhlG3noalOwL94aVx4N49jD+j0Akx8FUdU=;
        b=Na2cQI+Op6UdjflqRR3ksIlNW8NvFxBQG84fmtUsZli/mGzjfUYApKlgRD43KfbMXn
         ax73uI/2EoC/Fnvts6ARk8m4tb1gzmn5oPH0EQD6BVbYigFxdqmjZcADJz+nFW2bUQMX
         K1iNfK/mwTTpuLGfFDBd8rD15alXByITddUIZCCoW61aw64/mvDhrrTSwYci52a3I1Eh
         tNcAR5pKAljfwfVJjxfK1rmp79pjUkwnSSzDbmnPmkBvaZYQB3hl95VC3WEBZpj7FMAY
         73iHqfd8YOTXLj1tC0NvcLNcVHf2Go6kfxRFRXXR07tMjUcdRhCn+1bFfmAofm6BJzEy
         GkCw==
X-Gm-Message-State: AFq9FYImymeaA6WloAzR5TyNv7y1kn1LY/NwaQjk7oA9dJeEsfN8wvPA
	qrpiE/iggNWDkdeXi1VKfZKuSJI4hdSfxOTSRjO+bGeZIe8fDk5Z1bZkiPCRig==
X-Gm-Gg: AYBFou2xarCoZX9jeYv8fdwwnxtSpqpiS+aqUG8l+ug2/xYJzgjk9cn4IS4nYgGmSCj
	oqcerxZugcDXlqGhq+jk0Hj/UfBSIDKI7E515RQ2C3WKU0pjY5TWx9h+hIJLHmqqRngwGZ9kSuK
	E/VEFz8lKggSjsxuVp2zvj4GcNYnXsyAWQ/SQ5OMfAp+587HKjhLQSPBqRk7ENby9haSDAokqfW
	4+5Oj5YY1Hjaj/ei0lwp5RsKCnvPGuoVaf4eP5uV90MHeJ851CRYE1tVOUFbYK/bnyo156hLbiN
	ajOq5T4jFOsp1Jwg/guQTujQq95LVPmglDWZ9eYDpUaguNMpi3KYbrpdCNUa6KXOad2lo31bkg6
	t/6/5hfvZ5dojwRed25YNNZjyXLCcvCKc0+1w/ZWQyrCbdipXKjqr6YOlwFlVW0NHEFvx4G3Vn5
	B7lfAN0Mdw+nfb5H0+raVuGaQUaxSgxqcHR7W/5YlT/FkrCw1kdEDrq/Gzdev0mWFLrUXgS1DY1
	8ihR8vfuCyW2H5pD9L/6NOzb6vpvRzPTmKY30XZJuPBzhmOfYQKCtzS3jCSocqeL/OBkOivHUsi
	zsnSP9iu8BisA+xblCYzK6G74l8bWcQgKa1XaZrppDV2IWU=
X-Received: by 2002:a05:6122:c8c:b0:5c9:a60b:e5a2 with SMTP id 71dfb90a1353d-5ec232ab84dmr4025016e0c.13.1793110208007;
        Tue, 27 Oct 2026 07:10:08 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec23427e92sm11837223e0c.9.2026.10.27.07.10.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 07:10:07 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] ranging: Fail CS Config Complete on role mismatch
Date: Tue, 27 Oct 2026 10:09:53 -0400
Message-ID: <20261027140953.1854740-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027140953.1854740-1-luiz.dentz@gmail.com>
References: <20261027140953.1854740-1-luiz.dentz@gmail.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When the role reported in CS Config Complete is not allowed by the
Role_Enable set with CS Set Default Settings, the state machine carried
on with the reported role. A Reflector-only Peripheral receiving a config
reporting Initiator ended up in CS_STATE_HOLD from the security path, so
every following Subevent Result was dropped with "Received Subevent when
CS Procedure is inactive!".

Move to CS_STATE_HOLD at Config Complete and report the mismatch instead.

Fixes: 20cc88874d57 ("profiles: ranging: Add CS Initiator cmd and evt handling")
Assisted-by: OpenCode:claude-opus-5.5
---
 profiles/ranging/rap_hci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index fee769e9b438..62760b5c092e 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -964,6 +964,15 @@ static void rap_cs_config_cmplt_evt(const void *data, uint8_t size,
 	 * (CS_INITIATOR=0x00, CS_REFLECTOR=0x01)
 	 * which is different from the role_enable value sent in HCI command
 	 */
+	if ((is_initiator_role(sm) && rap_ev.role != CS_INITIATOR) ||
+	    (!is_initiator_role(sm) && !is_both_role(sm) &&
+	     rap_ev.role != CS_REFLECTOR)) {
+		error("CS Config role 0x%02X doesn't match role enable 0x%02X",
+			rap_ev.role, sm->role_enable);
+		cs_set_state(sm, CS_STATE_HOLD);
+		return;
+	}
+
 	sm->cs_opt.role = rap_ev.role;
 	sm->cs_opt.rtt_type = rap_ev.rtt_type;
 
-- 
2.56.0

