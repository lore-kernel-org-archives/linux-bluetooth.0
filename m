Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DE92C187
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Mar 2026 23:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772408219; cv=none; b=Rlvp+VNgXscyLlBn1kKKM86RdYoRT8aEf3kx2iz38DfTSZlvh038TBVOunga7ITYDMQizfIbc8rffr5UuzfKOx/EbjXSQ6ZjEXdyUfb3O82JrCqV8eHrjotBtgMI76oz3cS7ajzphq63b7GScgsCjSvrGr3ibydpsG/HVb7tbto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772408219; c=relaxed/simple;
	bh=NshiGiZ5GVrgOAWLDqfY+DVUIZuKELEuHHqYpXcRF/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzs5Tzqm21lYEt+Rchh9031UX98SQguonkuluhrLOlYW8ipnitPlnu5cr08Z49HFvjMnH5KQzUXo83f/8FfiamfNA1GTgwK6W4Sma14CBYtZ841B2kXgfN1i3MZFjG35zV9woM6OeBzPPAxuYDsR4obcHcNR62RsmIVx6psnhlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNIAXuzZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNIAXuzZ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-480706554beso45093505e9.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Mar 2026 15:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772408217; x=1773013017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NshiGiZ5GVrgOAWLDqfY+DVUIZuKELEuHHqYpXcRF/4=;
        b=dNIAXuzZz2uORMnPgFKXvs2M6EHdq/Byv4oaUKchsEkViTJlJxrtPdX+g+9TSPbeaB
         LhvovojhWUAxW98rNp24l1h056RdsytnL7mazHAUNyoeblPB8DHiHy+XLcSg/9isbDwo
         lJsuodJjTRhvee1hUcDIjklVr0dVLECorjU1KjiO6XmTN6T2AaIN0Oj1zxfHaTFS11TA
         CZTT91B/e2/LGZP5ZLrfrLxALZIs4lRL4tahh1b+5kthZNlXrI6prRPlvqCFmAt6idZa
         T3TEd0wv1pY9Sgxaynqp+8/jmPo0gmJ7p/pGjGqU22kpKKgs6ftSZSR1EhiOBxDiKB9h
         hMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772408217; x=1773013017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NshiGiZ5GVrgOAWLDqfY+DVUIZuKELEuHHqYpXcRF/4=;
        b=qIQT/dNO9DMbMJtplMGTjnBzIWOK67/m8z1LFkAUuma3uSabmI3IpjD/wDDg/mYIfv
         ZapBgUhhZW0144OK/0Zu3hZauxeMiur4OS9Lk4KXgBu7FfpKmkLah0vneQ3l11rxtl0D
         ILtqAL66Qd/6jiz7v1KmfQiYbPnWH1jYwYei3nhnxCSyHT6VWX31iTMGra7Jjiw6cgaW
         11wIpVHCJmRwnxitDM2FkycIi/GL87VfQYskLsrtitG2wAoPstcCoQ3APCpKKwmgMAX+
         2+ljWq7lcs0Yy7xIDYV6zlQqv7cTYjytI54lsbxq4mdlkQfkRL6lCvW65x9IUAkDxVeO
         aFig==
X-Gm-Message-State: AOJu0YzjitUyZ3A70XE3pY/nxdjrYZOWE+jo+eDkf4Jkl6pMNeS1LttX
	2VsC1oVAzNcLTP0yZWixjOtn6xNmSavy6Oyd5uWgY+OAzJmg88q72MOxG4cXKg==
X-Gm-Gg: ATEYQzxKu/nNXV2En4Q1nmEM/1e/KP2UOwHuj/AwS9zLQCJ6szXeNyQ2dWxw4TzvHvr
	BeljR6Ih/OIoEanimyGrhEzsqk7M/8HUm9vkoUKB3FBnHVshsvFC+wIlgywp9OeG01i+I+Sss9q
	l497V7J1Wu1L/+5+BVp2u+cl4uZQqTfdS8weMj1UPRT3bcVj5/6rOvtea7QVRD6aCOGfnap2ETT
	d/URKzYx2biAz09dfPjK9EUF3z4tPhma4oCQVk+lpeebSi9T4letWStqqgsqNqFjEHATrhSRv/C
	xLccewjmCCNAj3WX3BK+oz+0OOA8i1Dul7zwrY9KBGHShL7nib6kb0H7FQlO6XeC4zrgpwmlnR1
	tw7dMg6SRjhgTxYI/XH/3DGWYommrEVkFUZx3G/+P4g5plUUJ2+sOV1hVbTSes7M32jlaLSt2j0
	rtqVjZ6B87//xUHWbaPpVx75TNiRPDASaZwhoufr3N5rx/9v7RDDbxrXYRd+mZth3/lVmcW2Spj
	ptPbcxz2ppjjA==
X-Received: by 2002:a05:600c:3b18:b0:483:7432:a761 with SMTP id 5b1f17b1804b1-483c9bc558bmr171850295e9.24.1772408216430;
        Sun, 01 Mar 2026 15:36:56 -0800 (PST)
Received: from localhost.localdomain (184.red-83-46-156.dynamicip.rima-tde.net. [83.46.156.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb776dfsm212531855e9.1.2026.03.01.15.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 15:36:56 -0800 (PST)
From: =?UTF-8?q?Joan=20Bruguera=20Mic=C3=B3?= <joanbrugueram@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com
Subject: Re: [PATCH v3] Bluetooth: L2CAP: Fix not tracking outstanding TX ident
Date: Sun,  1 Mar 2026 23:36:18 +0000
Message-ID: <20260301233619.1807980-1-joanbrugueram@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260126175340.3576865-1-luiz.dentz@gmail.com>
References: <20260126175340.3576865-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I had trouble connecting my Bluetooth headphones on Linux 7.0-rc1,
and a bisect landed me on this commit 6c3ea155e5ee. A revert fixes it.

The symptom is that when connecting the headphones via bluetoothctl,
it either hangs or appears (in pavucontrol) as if it's using the AAC
codec, but there's no output. Sometimes after some time, it disconnects
and then re-connects successfully but using the MSBC/CVSD codecs.

I haven't had time to troubleshoot this further so far, mainly posting
if it can save someone a bisect.

Bluetooth chip: Intel Corp. AX210 Bluetooth (ThinkPad T14 Gen 2)
Device: Bose QuietComfort Ultra (bluetooth:v009Ep4066d0167)
Bluez 5.86-4 (Arch Linux)
Kconfig: That of the linux-mainline AUR package, plus UBSAN
