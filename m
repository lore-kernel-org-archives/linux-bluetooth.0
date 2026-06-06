Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F6E1D5CFB
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Jun 2026 06:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780725855; cv=none; b=i0wfMoe1pVvCJlYtArfTh3SdW9P5cqXW7jBZuuYbm5XPzwELLoW1aHFKWlO75O5K0RmH/NrONcbzX3qaQHNAu8W0qkB3e+Pi7ALb5xWJpFqEAIa5RmaE80fuMKNFhzSWnCCn1vlY0QCYCPH25qpYXB1oesOxeSB2hrePDfzU8+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780725855; c=relaxed/simple;
	bh=otxTA/ib4jpepPJJGUqc49LenV1G1XD8O0oQd8oDtWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFBzPZ1KSfi7hlpt4MkpRPoAK8Mg6bpCAFlgSD5l3GbUH8LWjcVAXRwwv7YOdneDo93fJ5gNnbuKhOrBn8OPMIXhbJAmAWFxX2OHEnNZ5JWMrU1AaUH9wEsGYt7KnOmEF2UW0gpmrcwcsGkIYRYMM7IODgpotn5pBa46IvmQx8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=NZARHK/l; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="NZARHK/l"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-68d23396ed3so4641371a12.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jun 2026 23:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1780725852; x=1781330652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGXvh7aaJz7lngW44NM6XiohVSkHrDLp0xw6qLnnQBU=;
        b=NZARHK/lFPFSJykpAcupZvwg1vqZHK44ZvUlQWZjU3tYpfYH9+e8ezpt2pRubqHUta
         Xw0UqAa9fS/rvSkmTfysQnw/7mdlS6nvnV4t34JvuJ2PNMoOD7lUNnyVJ3Xkp9n6VyJp
         I92xi4Rxhb5XF0y549P+NlDsf13FINZAnDYdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780725852; x=1781330652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SGXvh7aaJz7lngW44NM6XiohVSkHrDLp0xw6qLnnQBU=;
        b=bTGMIE8ctW8Bv22bRQFZ79qQrcSEPArpBcrbYjF2xlK4r7VdCF1vuRLLKpbB+ImB2+
         DoaVkEqiRQOeYsWEEi8UTheHjfbEtS5jFxNMhK5GHcdjW7vh8IpVkOi3Ay4ON/Nqc8ve
         MO+aEGl4OfhV+06LUDzyVPstrpeaKbL7K+XhpkUKIEhTiX+OSo15nEGm6QEogyhcyMdJ
         zVM48wqXZlO0WMlVQN3k9NsIsrN00J5Z+58QgNgH/GxRzzV17cgupsLHqX2Dcs0KIpL7
         aAedh4iIdDZLYFAnpCoQPKjK4JoO/yVRlFivbteTzil+y7eTwHV4eMYn/JDjklMtRWm8
         pFGg==
X-Gm-Message-State: AOJu0YyupvM3VeMkNIR51EZodAk78cVNubh85swAuNtIEi9Mey/pvHkM
	Rk/F05NMAgkQXM6PXyowobZvkgMSK0/bxBwCLmr19RE4Tqz1nfO2i3zTwfj7RGOB7Ss7xRCldH9
	+d9k=
X-Gm-Gg: Acq92OGUtBM1DtUU5iKHmQGoujyG0cYl0O8P2ZZlZNW10MXw1s0k8XUeyagySc+6DdI
	EcygHPTcTZn4uTP9U+bqob/EJRGCKolhPHKmA1+trhbJB04956/XrxH2VJqjgxR7AODo3Yb7wf5
	ypPEKggEVI9dDj3SdgyQgwf6ZwW1S4GUED1nfQnjj1UmDdK00sQuQW8gg8xS4bN3lnAQCDQBjfl
	epxJ/W65N/KNNaG93w/3NY6Sj7OXXbsBP92EW/w0WpxQKfmEokjqfcXVnhHEq0YZ67CHJoccStM
	8TZJreZ3HXdy14yqzr7zoKGX01xoV6qv4wy/M67J70HMzy4itXnPjatF3NwLSekVEEau7fe9Wj3
	+peS3DeU53jouCQE2U93p83JjIuMNbQcvuIOHwQ2oaRQbt8+ojyhw1VfA8efxQTwjUIhuUSbeRm
	QuhbSQpdB1RNL2ZFfMt1dVIVQYZTK+AqRuaWVaF7s2lY/srCRQ15EVs7n/G8d4Tnonf7Fc8zKgs
	CmdK8RnaO2o39yktOWk9VA2qPwoQg==
X-Received: by 2002:a05:6402:1f4a:b0:687:50d3:d9e0 with SMTP id 4fb4d7f45d1cf-68fa514bd51mr3112843a12.20.1780725852233;
        Fri, 05 Jun 2026 23:04:12 -0700 (PDT)
Received: from great-eastern2.home (public-gprs207019.centertel.pl. [46.134.147.236])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64e2c810sm4593197a12.9.2026.06.05.23.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 23:04:12 -0700 (PDT)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ 2/2] bap: log errors in BIG sync
Date: Sat,  6 Jun 2026 08:03:48 +0200
Message-ID: <20260606060348.2240980-3-michal.dzik@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260606060348.2240980-1-michal.dzik@streamunlimited.com>
References: <20260606060348.2240980-1-michal.dzik@streamunlimited.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 profiles/audio/bap.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index b35542488..dd4b3c8ff 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1474,7 +1474,10 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 	int fd;
 	struct bap_data *bap_data = setup->data;
 
-	DBG("BIG Sync completed");
+	if (err)
+		error("BIG Sync failed: %s", err->message);
+	else
+		DBG("BIG Sync completed");
 
 	/* The order of the BIS fds notified from kernel corresponds
 	 * to the order of the BISes that were enqueued before
-- 
2.43.0

