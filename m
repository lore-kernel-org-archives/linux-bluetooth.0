Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A098748F
	for <linux-bluetooth@vger.kernel.org>; Sun,  1 Feb 2026 09:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769939171; cv=none; b=usa1zUj8ZY47fT6+4fnuRdXCxecx2tftwLj0NsfwprMm/8AunoxN1r/92z9jpoAUqp0SjutRRXYaG+LCQRmlxrvpUjwBgB4u4HBr7CLzHMipZJeIuLUA3tQOm2hI4p2CaJMrw+XFGiJhFMT0Z7X6Vaq9UHG2L24KaKrtQtlzAsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769939171; c=relaxed/simple;
	bh=mTifnupFhQ4QVsdqLlWsnLVc85y+5ycMLtAwzRzYO6M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ps+9TM8W/Ifh4lPcWNmwNPvyK+u1Q+hYiJYtn8Cq6cBdS956BT1f7h3KasZ7jrh2qz0Hnh+6Ops7K8F2LFsaousueSiVW/34O+nbwLO8RwpYepTNvDYjdG1FbnCsyQHQlmsXiencvRLkTDpsbTu8aLplzOny3K9onC2QASIW/bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0fMQdSR; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0fMQdSR"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-124a635476fso5099976c88.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Feb 2026 01:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769939169; x=1770543969; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AG3Q1IKTz4HeTNYsPvhef7CR83WVl+7+1YFaGzdrvnk=;
        b=O0fMQdSRFLMnDbfvsq5k5StWzmhcZE0r7eG0hMd/GrnEUzGobuuAA/GVIML8hEEIbb
         GotodCLuOyfpg5DDWMbIt3baohdSClUnjZ3I1b0uafivIXEWdVPDFu7hZv3/x6QpfAUS
         2ovxXUcBK2HFVYiYILkDp3+eKGXwSRrKZ5H5XtNvNI4nelgstLEaRa1SKLAHuVsHFD9+
         CaYclUqB3j+FhIJSHl8q6rKXBR9u5PeCwwXT4gxYrZudAn8HUxd8QfcyeDQ1CoHRo+gA
         fytBjaq0iWlfIwT0+zcsNb0dhXWTob6PZNh1x/7l5ZAn6zpmNGSymrmTjcCvSc2bSW5k
         uTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769939169; x=1770543969;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AG3Q1IKTz4HeTNYsPvhef7CR83WVl+7+1YFaGzdrvnk=;
        b=n2o+j03wpti+ENC9yoUuJINpal8+rwzaq6DvyjdV4Tw/W1LpcUkifJt3aSL1UOW2ns
         u36NKFczEDz1b+ACfncrlWh97mAxsVCLoDDtsCgtenqoiibR/LxufyiGuTGPh4Ofw+V5
         wl/n5Hj+5FHUcX+dA8NilUWY2+mqpWDbMzYVTxQyDfAu9RgV9isEBvFzP3TkusqXxrho
         r1dJ8DB5RBha7JzKkbGl8afKdkjrZYrg8CxEbMfufFshmUCMaYqXJ2FpIwwETfvm2wHm
         cEkrKcI03QBYRyPsygrU/neDhHdfpNo9gVkREpevew2nelD2gWSqp1BUPZRoPI+snwr9
         bfZQ==
X-Gm-Message-State: AOJu0YzTxfmEBTxqtT6SpHvDj4+WF7NrWRd7C/fpYxov1qGUQccCKHs6
	gDztRTu45+vuJtuZtg1I4qXNLNKUrCz9gOqMLelthaapd/aM/Njic81fhNK/+39/
X-Gm-Gg: AZuq6aKb47qBoMeQgpFWVf3ZIRhMieVYEvlwfSgx1BVeg4ev/R5jFaemxJ14XgBGJyw
	96QcWFWsuLIwFyr2MEPZgkYdDQqWJpfK+3okYx1xoh1lPvYRPOkx614lahZDTvLRHd1DGiYLhhE
	HacTWdAk1dNe6+sR8CJfdtwpHTq7xlvbw+62lzky3SIyL8Hi3pnedJouMDtyIGJLj5dNjunPYtA
	L2FuPzuuU8MyFkPuGWydcxAggHDRzKwBDFP7/5dXjaiHlKXbS7FZsp1XsXVAGxDsDkumi9cr/7L
	7en20oeb2+Oa1F80Y+dupGyHzhMVti4aamjscRGmdT5CyGclXbIQevgsWrkSvb81mTiWP+DN7oS
	x+EbYXXCc1QKboR5Hd/M4e6s4UIs+UVl7UYgwhg3Y7ltTr0vnyjPk2g+58/kbPTZBHEmIzvBJuR
	P0+XT15L+Y5fH+N2QbWDo=
X-Received: by 2002:a05:7022:6981:b0:11a:fec5:d005 with SMTP id a92af1059eb24-125c0f895bbmr3496330c88.10.1769939169095;
        Sun, 01 Feb 2026 01:46:09 -0800 (PST)
Received: from [172.17.0.2] ([172.215.231.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9df97d0sm16060774c88.13.2026.02.01.01.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 01:46:08 -0800 (PST)
Message-ID: <697f20e0.050a0220.14c0b9.1242@mx.google.com>
Date: Sun, 01 Feb 2026 01:46:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8859382731575208165=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, github.rtron18@gmail.com
Subject: RE: Add Null Pointer Checks
In-Reply-To: <20260201084655.73566-1-github.rtron18@gmail.com>
References: <20260201084655.73566-1-github.rtron18@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8859382731575208165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1049427

---Test result---

Test Summary:
CheckPatch                    PENDING   0.40 seconds
GitLint                       PENDING   0.42 seconds
BuildEll                      PASS      19.88 seconds
BluezMake                     PASS      650.91 seconds
MakeCheck                     PASS      18.51 seconds
MakeDistcheck                 PASS      242.66 seconds
CheckValgrind                 PASS      293.92 seconds
CheckSmatch                   PASS      348.58 seconds
bluezmakeextell               PASS      182.42 seconds
IncrementalBuild              PENDING   0.38 seconds
ScanBuild                     PASS      1000.60 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8859382731575208165==--
