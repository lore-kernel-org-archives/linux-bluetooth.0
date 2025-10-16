Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584A12DF3F2
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 21:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648458; cv=none; b=Oq0kFvi9m4nNV0ZGX4B2GO7UWZ2/dEgMnTIIPXKzF+zaGNPEU2sCoKatCknGiKH3sJGezLVdoeqSMJvT9PYIdcVpXsUa/ULu//1zh3ePHmz37B28IzDQ8/misOqS4TMA3f9U08VycJvYgqcOW5tRthtIhrCLbSsMrjjp5EqbfvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648458; c=relaxed/simple;
	bh=pnpqVlgWpLXKkpCovp2yr2M3xCVDrUWGSLn0ih/LQ14=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inwHIbcX92VhNg560cF1PeXVdML2i5BByqiT1wgjYTfCUvCRpdI7LSPDmNmarO+RnneOORyFErrmulHUrfFSCchw14FJGRKkHaJGecygLwPR1DSMCrKpSpg6v9MuDLnxaijp4b8weci6jNavQJ+d+dqn4YuHGC2FXnen10ytqWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ANaiLtNq; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ANaiLtNq"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-54a8514f300so737165e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Oct 2025 14:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760648456; x=1761253256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4S97djthjvOE16v9gtPxDN2MNMKmdQnLF3noNAjA4S4=;
        b=ANaiLtNq8WYtwcxMb3XHs9mn0iB0y3R3xmrpd0X2nqHGkptRf04zQVyaBxZx/lZR3k
         8ae0sKI3Hjgq6aApY3xQrzj3iuS/Xt+R/obBE+3StS3xAYF9euwovsGW9LeqilegkxGF
         65PIqx9q+jXIanf2GvJBt2qa+C2EQyjpdltmuLCUHKnK/Pk4Y18w151yjEPZ0VuiSgxA
         2b2ke7IO87ZkDMbNQZTR5WtTnSX1JdZx6XU7tPJJVSxt+N24h2tt38i/AFyUWwnFJZMM
         GRmi/usHsFg2GSCG1z+nM5Iw8+xfGJdTE5nCHg2TAWNXC+5MazGQ15G2sF44PqGZiY//
         0ucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760648456; x=1761253256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4S97djthjvOE16v9gtPxDN2MNMKmdQnLF3noNAjA4S4=;
        b=N0Din6d49+KhNc0JF7rDgI/UMnPhhVLZBuCUq+yXhqd35f0H4CAX8qme1h6lfTEiz6
         y8SbFYmqLLHvBM8tpLCsanO4R02NNKhws4iF22Zbj76bbl7oBT7rM1MNEUU4Yy3F3UyT
         ZLsdH3Z8XfEetNVIwlrikBi7R7GxTV4W9HZl7ittPsBTAmNGBdIKlg7FWzJ6YBFJFqDo
         4ZuwXBO7wLhw1mdwPEMEl2C60YXq87WWYHpid8gDPnbUbTIEAtWMrrIfLLC65W9o5VRB
         WLcu6K3CltWZhLgSuL/GHWDXiix/z+6Xm0cDi0H0rJyAZoeMlXo4zjs1LCa1LYKaGZIR
         CB3A==
X-Gm-Message-State: AOJu0YwTEkU6v6EkZYLJ3SgSBmOMfy9LSG4WytoL5sohxrdG9/FLvGXb
	BWmOpZbxnElmIyV6xMp4gW+Q6qQm2JMsAVfHFisrLdP0AlBMDKMMloKEC3XdWp21
X-Gm-Gg: ASbGnct2+CswYpOqEEc0SElqgjvkF6IsbiOJllm/I9Z5kxqO9K+hkUDjC1qD1yeup/V
	BA45+MKuB33npfxSGEIQQ1qXkPtQIykMOiji7asQy8wEyKB7M5gVty5Non1UDGIM7UsO1+2Gd4Q
	hb54AAs5ju9tJf8Tu8gyn6UbV9XDcJHSC1IMPK7Rn7KuP9DCkQNUGyS56PpGxDzxEXG/43OmpLf
	fZBM2Yy86GGZ0A9RuRtYYJsyj10OJ71MzbZkna6wn8eOFq3qfhbb5I89HUO0od1T0vqZtdam6Bh
	cawxvTA6TATQnH5kvaFLmKoAEcR3Srek2EUHm2bpSZpucFrJ68JUO7C45uvY/2sjV7eWMerxm3h
	wMUSjOSSNGs3H6s41EVDW2uXeO6lLlK+E0JaviDyedzSa9Da06Dl2jSMN3WB6qUD8HH3RJypES1
	FDsG8=
X-Google-Smtp-Source: AGHT+IHkRKUTrOV5a0ifD4bmyCzAB3c8fOxtDzIr6bCq04PQq3V75GELQUtLqaHrBRr4yA5ISZl4Eg==
X-Received: by 2002:a05:6122:319a:b0:539:44bc:78f1 with SMTP id 71dfb90a1353d-5564ee22d18mr785772e0c.5.1760648455749;
        Thu, 16 Oct 2025 14:00:55 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d80d9bf0sm6590304e0c.18.2025.10.16.14.00.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:00:54 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 12/13] client: Add script that setup a broadcast source with 2 BIS
Date: Thu, 16 Oct 2025 17:00:18 -0400
Message-ID: <20251016210019.191878-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016210019.191878-1-luiz.dentz@gmail.com>
References: <20251016210019.191878-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a testing script which setups 2 BIS Broadcast Source, one
for the left and another for right location.
---
 client/scripts/broadcast-source-2bis.bt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 client/scripts/broadcast-source-2bis.bt

diff --git a/client/scripts/broadcast-source-2bis.bt b/client/scripts/broadcast-source-2bis.bt
new file mode 100644
index 000000000000..35b1846334be
--- /dev/null
+++ b/client/scripts/broadcast-source-2bis.bt
@@ -0,0 +1,19 @@
+power on
+endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
+y
+a
+3
+4
+endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 16_2_1
+1
+a
+a
+1
+0x03 0x02 0x04 0x00
+endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 16_2_1
+1
+a
+a
+2
+0x03 0x02 0x04 0x00
+transport.acquire /org/bluez/hci0/pac_bcast0/fd0 /org/bluez/hci0/pac_bcast0/fd1
-- 
2.51.0

