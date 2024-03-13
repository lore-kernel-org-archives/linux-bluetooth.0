Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B358246426
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 19:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710359056; cv=none; b=Mf+iKZcqIMUP/0/DzSFk8LX5nBktMJqf9BUAOo+2N99fBnScXcC9dNky94IGvmchtdYGtcMAdtfx/5cHUuhkqmn+YJuL1w8NTLBRjiGXQ8lWz7QyX90jvJt/7VKv1YRXnlHWAAAuGLlcFqRVErDDjxdWE2kc12y3bKa6NtyOEfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710359056; c=relaxed/simple;
	bh=PXp1Zb1Khcx0KWI5SNDwipwCmZytXIDt+kHpshxKR7E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHr1q9VVQXOI9bNLCOfL/elTpUXo2J1jvhzGwxisjqFEPCfRrlHE3spKOZVMfFGUYvLi6i0GuLjqJe5GGPczwjFan5Ts+k7Ostn3fAypDhmke/igY9tDi/Z8TD9uvouzDPvu9xMiEPnlBzdezUz+zjbfszlizKLYrZoOiuEC7fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VuD0f18S; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuD0f18S"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-47348b64b56so38677137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 12:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710359053; x=1710963853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VGuMbCSblXuMbRdp+cVXJVrBpElJQ+MdlDXtWzUF73w=;
        b=VuD0f18SMkRqocxNSqql0MWc5s+Qz76RY4X8A03gagCr7zdEuy5OnDWI6whzZ1BTLY
         Ch51WTq3uNiX03GM1nR/IA1VCY63cME/SehgCIczkSBV1ruPKLrRIwz56E3u55dHa2y4
         KUmWPACDPUZWTeCNdJg4vNtW1pZkQsCUbn9CCRZt1QArV/g6l4PrC6o6GTPLIVCUf/YT
         pvsC87IY0nayuOt2Lf+ggWeH+CgfvoQkf8BPU49yxT3FEEkhAlvAZdNh2uynWu4GcB71
         k8KbGphMapYp7ZzjysEsAZmU8mUlxrPaw2jwdLChXZnU01kQjR3u8aBI9eOhYlVovK3C
         TzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710359053; x=1710963853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGuMbCSblXuMbRdp+cVXJVrBpElJQ+MdlDXtWzUF73w=;
        b=hlJGuyrK8uwdJPXY+ZFUqL3WJBhuSMTA/nm2zhYZeQFuxY86rl5NG8WFdl/KlrRS2F
         14hmbU+uIZJxi3dXN8HE9C9x3TImpL36z6oNKYJFV3+2FZUnpESqCHw4nVPe0J6oqidz
         gEUb0OXRWPfo5bJUNAWz1VMCz2MDIWjB35hvwSGuKVVIj1maoz+t3iWCJ8UeI80co7nc
         EKMk4BLeamcqBqoghtIylU1IbW0TiukCU9f7Fr+4HHhjpt/ZEHgXkVnsExSJMLNCtWcT
         hdOqUp1o5x/uPUZ7G82hgETYqAa20ywRrv/gK0qydBAdt2iHJxaDQGjk75pVw6geGhQQ
         +d5g==
X-Gm-Message-State: AOJu0YyOO8nmKRy8B4bHvJAxMsWl/2+9Uhor0/wsyktS6aV3Q1Mqps5z
	j8e+yZqb/Ms0oYyEJHLmK3bxkwphBYpOVAMzmkRyzFynSHoZgo3c9HpyDJgg
X-Google-Smtp-Source: AGHT+IGE130eQXNzR3G85kEkU+BEd5gq4xX/LTiFZ/5+5DqZn5EU7F9Lxr7zf3lXcINy7cPThi/AMg==
X-Received: by 2002:a67:f3d5:0:b0:473:c49:283d with SMTP id j21-20020a67f3d5000000b004730c49283dmr1023485vsn.2.1710359053130;
        Wed, 13 Mar 2024 12:44:13 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id gd6-20020a056102624600b004730db4e873sm1800259vsb.10.2024.03.13.12.44.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 12:44:11 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 6/6] bap: Add proper default for broadcast setup
Date: Wed, 13 Mar 2024 15:44:00 -0400
Message-ID: <20240313194400.1397477-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313194400.1397477-1-luiz.dentz@gmail.com>
References: <20240313194400.1397477-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds proper default for broadcast setup so it doesn't fail to
create the socket due to users not setting them.
---
 profiles/audio/bap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 1034202cb8a0..964ba9c212e8 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -841,6 +841,9 @@ static struct bap_setup *setup_new(struct bap_ep *ep)
 		/* Mark BIG and BIS to be auto assigned */
 		setup->qos.bcast.big = BT_ISO_QOS_BIG_UNSET;
 		setup->qos.bcast.bis = BT_ISO_QOS_BIS_UNSET;
+		setup->qos.bcast.sync_factor = 0x01;
+		setup->qos.bcast.sync_timeout = BT_ISO_SYNC_TIMEOUT;
+		setup->qos.bcast.timeout = BT_ISO_SYNC_TIMEOUT;
 		setup->qos_parser = setup_parse_bcast_qos;
 		setup->destroy = setup_bcast_destroy;
 	} else {
-- 
2.43.0

