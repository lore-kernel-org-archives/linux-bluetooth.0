Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995D6626AD
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Feb 2024 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801916; cv=none; b=HtbnFcmB+s628FSg+jlRC15Ern2uB/nbv6qbys9LwB6HofhuD3falf7wFEsTwFgLZ8pYlPbf+Rz9E8pruiXClAKmcjrJVlqfB0e1+IIDJYDaBKN6If80IyimA+7/+cBdfuSRbmsuGyvTGV4IH1cs7cP1K0Eq3+Hmkrj05RJc+AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801916; c=relaxed/simple;
	bh=gyuyQ/aK4rZwWgwe0gruyYcDUQyzIfPAlXAzVb6Vozg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKv4dtkZQlslVNejYKh7DIvfvTuw5+JL6SQ5iYHr7LVhy7cNisKBr0b7GwYlZ/G8pqI5WEL2r+IlPx3NLIZJ+OTWdAkisTyjsrIk16s+Gu5i6LAmJSwZBX6j9r624Fq07jit0KOmdAqzyOQmh2c2bY7y2q7sh71MoIheNwCzTAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgyx98zJ; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgyx98zJ"
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7d6024b181bso469830241.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Feb 2024 07:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706801913; x=1707406713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NfocMJ4OgAO3HX5ciQuRwEHA66Qb0abBxdrZu7QgJK8=;
        b=fgyx98zJOxDvNAMgT8TKfsyPF06wwf3Hxakq49nL5P4+Zx5zYND85uJ3TS1+gvrEbc
         Orm+GSB4KLXz7di0eJP+R3m1Dcmj8gU9BXQPV3r7h5WEVqr912Tz0zjVS4vNRV8jBBAx
         9C3pdSdDOe/lPFrFklG0btyP4WAIxJsE/azwoGNACTbz8LiYcO40xmaC1E7gHPwT1aVO
         dkoaUgfVaCz3sZAVTxbPO8YrfRKo9guQNDH1aWWaIlyyFYsYf5RBUpgJnqMgd7jP75EG
         PQ4xIJR83G+cGp/6c5r9fCD/TuVj7hde4aidcvD3T4HgAL3s534Aa5ABq59/KmlOzE+W
         iVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706801913; x=1707406713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfocMJ4OgAO3HX5ciQuRwEHA66Qb0abBxdrZu7QgJK8=;
        b=hQAADA/5efLT5Aoe3YHn3aQerl4XizwbUnv8NxoBFqccqdowxckZ3Fw+9iWFz1ShXf
         O1CWLCjb0p6U12KNwr1sQtRByTBqFAUQOvxHRGof5HMSbBx4MlkUMdfgaWIEPqDj/StI
         RxbWjOF3+fChinDzt22AJvXpLNPdjVJWbLE/mDGszdfXirXI7DRtCi1gFcPoY3Sg+K0s
         y5qpqrr5doZOuVHWq61bVDeL0pw9ptTMYU/sBXe3VVzaW4sOHNhbCTFudvKfnzIf85v2
         L7acnKG8yJfUDE5N1mtSIr6J4rsonn1AKFYUHS1dPFoiMJ+cTmsbQ7cQTKlprJRjGzCD
         koRw==
X-Gm-Message-State: AOJu0YxqtgPsssmvaTodG4bKqqmEjam4zNZy2v52G37xZcfCusIWtaZ5
	s/rnUC3++qEfhIAlFr87vXzW+0cyA3Q7P6BIj2H27KVMQxesHRq1w2Dw3lkd
X-Google-Smtp-Source: AGHT+IHoQ+STx0Mtklo+82AQiYzym0FxwtREoYYkvWJJFLvYAR+q0n/qO/TxOD+ql7cJimr41fmKxA==
X-Received: by 2002:a05:6122:17a1:b0:4b7:185a:d8d with SMTP id o33-20020a05612217a100b004b7185a0d8dmr5268349vkf.1.1706801907778;
        Thu, 01 Feb 2024 07:38:27 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id ca5-20020a056122400500b004bd503f054asm1624586vkb.42.2024.02.01.07.38.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:38:26 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 4/5] shared/bap: Allow using bt_bap_attach for broadcast
Date: Thu,  1 Feb 2024 10:38:19 -0500
Message-ID: <20240201153820.1016507-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201153820.1016507-1-luiz.dentz@gmail.com>
References: <20240201153820.1016507-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables use of bt_bap_attach for broadcast by checking if there is
a client or ATT instance.
---
 src/shared/bap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 851d6a5facc3..ce8d35f86af3 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4156,7 +4156,8 @@ bool bt_bap_attach(struct bt_bap *bap, struct bt_gatt_client *client)
 	queue_foreach(bap_cbs, bap_attached, bap);
 
 	if (!client) {
-		bap_attach_att(bap, bap->att);
+		if (bap->att)
+			bap_attach_att(bap, bap->att);
 		return true;
 	}
 
-- 
2.43.0

