Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5F32E041E
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984486; cv=none; b=EAQpQcAaUxRWtDHKOsiHU5mxKJwLXjXGE5dw4pjKG2LNo4KARjSBrPsMiBZJrcwfUpJUZVPmwnZEGKjfgiVb1uRdqVzeRMvgYXvjdd2uPZuobT7xCUfQjcMMuengqbE2xNy09r0SZXaunuGukFr4SnyJWHMyysQxKYyrVizhyX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984486; c=relaxed/simple;
	bh=UGbsk2AKnpRyZ3udeIO4+vTkMWW7A6wYla7EXNjVFOQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qAAH6S8TbCnBjOI0ekt5Jc8RLYB4hvxgqwwxVEW4Pjwq0X9byV0Ubr7lnBfWV67MteuM3FfoA51uhdSprH39Wo0htMI1/NPq0tBPO6naDQEbVA/YEb3Pa2xwfctGyCPueVZWdh5wAE0ZztdRB6i8kdWfLiYIFBWGlRqq1Rp7+Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhXHpQGT; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhXHpQGT"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2350fc2591dso42090015ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Jul 2025 07:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751984484; x=1752589284; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MitjmFCeU0q0GG6p3Bkk0OJsNSTByx7GwB48Jc2MA4M=;
        b=NhXHpQGTfCasSp+2kBmXe9/0EeJsPlIMhrmhjN/7ysypQaRkboHUZ3awGhd8YpcxcP
         vmLflZjZjy/IjAwhpjUERLPbjU47yEF4YftotNCZwXvObTArL8E2FVcDiqxwRmWcFsUq
         nJ4AOFNSWfIcyXYVwu8wHAsyh26iDS4eS12Syq6DxS3Fq2BOrTiSZse0V1gsaeUk0N90
         QfmunezmrdhSZrB7PMWHzi07wZErhuOckA0CV7ft6ziEzlvfykXpPudNm/Juj6aXovQV
         /Vw8MZ+TN7+66b8EImM5+DmFvdwfLX8M5tQr6Fi3qCXEg60EA7I/fVIbN3I7OwJj1gZk
         SCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751984484; x=1752589284;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MitjmFCeU0q0GG6p3Bkk0OJsNSTByx7GwB48Jc2MA4M=;
        b=dFAlRcAPiKXpbjQR3xNXx6EQJKMAPxXdAtjRu8Www1inNbb36Ey/IkEnr8hBZ8rtr7
         jG5MOBzvWCZiu2/qUb07SaGP/1HC4j/h1BUeKQlIm2xx8LP3iF4ruImmlAOi/+wjUBqE
         FECHndCZ4UAroAcnix13ZHOU6SxWAhh8zr6hBEBxD1GPRuZ7jg2AFQycHXNxLov6uHxN
         Qv1AuJ8VRyeJtECWIKIC8pv50y8v3G1KqLonxFny5W03mWKnSI18aKUXHM+S9YlaPxtp
         z/njw7cLAejEldp3Dp7137R7sqSyWVhy/EApXo519ExMB3W8EAw/9/VNZV49uP97BgoT
         ppbg==
X-Gm-Message-State: AOJu0YwdLFH9nI5Ln8VH5txOpO9kzGCmHhlyQe6LEAFEi9NOddQGsFuk
	zJaW1LKKaDM1KcIEfDi5Daps9P67DuLFPoilxEEhQr3mnAbMgrkDpiVKpFz8Dw==
X-Gm-Gg: ASbGncuHwPPaU7eQTJ0jwPLVdJ6phDEDaZDxWZ1SuKhLV1gbESHJ1Aeeu3B5j9MIlL5
	tBoOXgKVYQMyrIN2xXtyUiIA4bLanCaNv+HGEXXnNCdyCWx1GRTeJGlpZzedbyQhFe50kW/GOmZ
	neEZZ254P1RTdg7B4MCsD96QtBdfWSW20fN0I9KaNavx1yS++7UM32BHQBGQvVIuzhtFTLCTvBR
	/TI4j1ZrHZOChSaytkisGNvjA9aws1tyw+Bi+6MU1dAvGgSWQ6W8KAq9KX0Lm+BTtJ97nwH+RYe
	9BinUsL7GBpaHO8QDGi2g7ybnLbLZf38P19sTK28RsCjTU0tX50g+D0IWn0mMJGQpA==
X-Google-Smtp-Source: AGHT+IGoRuxtETcUHsxuaqsxgJg2/TYysHc8hRVxumIjAzohyyvhzMoLTF/BN3BJOrXLNds5qR8Okw==
X-Received: by 2002:a17:903:2a8f:b0:236:4d78:d528 with SMTP id d9443c01a7336-23dd1cdf6f8mr34977155ad.6.1751984483590;
        Tue, 08 Jul 2025 07:21:23 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.2.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c84350266sm114829115ad.84.2025.07.08.07.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 07:21:23 -0700 (PDT)
Message-ID: <686d2963.170a0220.1a83c4.1b2b@mx.google.com>
Date: Tue, 08 Jul 2025 07:21:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5701239218822217365=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ceggers@arri.de
Subject: RE: [BlueZ,01/15] mesh: crypto: remove dead function declaration
In-Reply-To: <20250708125947.11988-1-ceggers@arri.de>
References: <20250708125947.11988-1-ceggers@arri.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5701239218822217365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=980052

---Test result---

Test Summary:
CheckPatch                    PENDING   0.46 seconds
GitLint                       PENDING   0.37 seconds
BuildEll                      PASS      20.75 seconds
BluezMake                     PASS      2714.98 seconds
MakeCheck                     PASS      20.33 seconds
MakeDistcheck                 PASS      186.42 seconds
CheckValgrind                 PASS      236.01 seconds
CheckSmatch                   WARNING   307.45 seconds
bluezmakeextell               PASS      128.36 seconds
IncrementalBuild              PENDING   0.45 seconds
ScanBuild                     PASS      922.86 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
mesh/mesh-io-mgmt.c:525:67: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5701239218822217365==--
