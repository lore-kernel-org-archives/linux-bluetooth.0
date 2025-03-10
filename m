Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27117227B9F
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Mar 2025 12:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741608278; cv=none; b=lpgYtMIkUlGp88vJoZAoD+RkxGKyuJd/NwhHlO/4SOvFHmeMzQRiA9XqWudXY2keh3XFHan06Y1XkCSt1Pae4ti+bFwaf2AbB8KulRm5G7pkvDFEtc/UrMspno3WUfBelvNabokP+/R/JjHFZE9Zkn+1XbWPlYiRjiXcGAlY+TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741608278; c=relaxed/simple;
	bh=R82OEd3lyQba0n3zXWXCoNs2XZOMHzx013RXgxuA8X4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jwaGE/sN3ZwFpMvd1pCF6FdLgTIN2h6xp+OvdkOAFWz53XfqbG4ScQHrHAGGJB1HNFMzhVYbnwQIAsEzIIy5yHYoDdKw5IM2Dmv+1CdgSsQLUixH/kOXLXPIFeMF/g4OvWQrQ0PWIyAsLPJWNkclb1IKhnmI4dNt1eSs9SAn+iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YH6Isvgw; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YH6Isvgw"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2241053582dso61364245ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Mar 2025 05:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741608266; x=1742213066; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IhEvTXOUC75Wdlpjq0KCkYyZELjohDfXdOUrnGWQ8MQ=;
        b=YH6Isvgw09oPEFyJMjSBmYZ10qu0W5asrcu5bwZPCuhLmHX8BgM4EKOz8apdxsqQ4k
         reHMzvBrfue2ppU89iNGutRNgFwKxFeG3Va3XJRf58bCBOub0aKz5QJd5CupC0+CRcru
         SoXQpC+syPZjOX/tREZ/3ahiRFx0u6eIIC5Kc34irjc4T5zJXIrG5caDxYgB7691wm4h
         lVEpEGwdKapwKDMrk5fnCRlf1/rHpIYa9mb0j5UDnpZYuW17M4LMbaSfooC4MvsF3d88
         nLw2gsUgEPMLwhNpha1FXizwSZSyYlazz23a7/OIrc3CF9yvv0AJUty0CkAsWJo0z1Lb
         ZXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741608266; x=1742213066;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IhEvTXOUC75Wdlpjq0KCkYyZELjohDfXdOUrnGWQ8MQ=;
        b=ucc9tspomqiyWw+3Wk0g4sl/ivKZPdi+x5LzdeBs9VQlLAiA6g6+3i3pGUvCbXCNZL
         wMuOsoebkCtiABnP10ANoo0UogQvUBazKubF6gSFsXqzLk5H9iRnOZ6FgjMQABTnWbla
         X9JFXNO85PZaPbznSlf2ElTNHDKXsJes6hp1wA3oZOrUCZbEghP/RFuE2nCQaiRLt7zL
         kPS6vYa3mQJuQMlJbM1U79g1sXqVSnga/6UBL2vazqk43LgEVUoqRsAY4IMgtlcm68xc
         D9rXrBq7KrsFUjPGcrsHc0os8izUMJD1J91fUeWoU4Pj/PLlTip7z9xv00QYe35+8gHs
         vbug==
X-Gm-Message-State: AOJu0YzL6x0MQzwsyMOtvT6ExWVJgOptz4PMOYJPEALls8Ur4A1bk/j4
	/KgybhAXmvuDm5KLY71hE5TJuW1QPNak2T3C8zD0qMFnvdLPANBYCCi9UA==
X-Gm-Gg: ASbGncvT2wAmJ81nyn9UeRSJoQFbM5JLMzhENp/XzH+Xzf+fJf7Z1QN8UgnOkN9O7F8
	ORr1UUIhffv6Q9iOT0aHm+l/IUl9HG5gTGdXbGJT+V+v8xyomWxea0nQgjpdYtB27pC6s6uspKG
	ImOgnCAuaFeNnP+/ml9MHG1cescTsgIJUYi7TDieOZZP666PQ10lb10LKIiVkJi2yDyd6bC6Cah
	FnqLQLvQV6UK9WvYd/LNBq8lHzHM9osImw2zhbtt5Xy0VC9JINchuaHrWwImBT9F+V/s1NlwdjR
	wHxcn7NclRQmnWUNNbQESfhF/L8X+RZ/49/g0ZEpUfYWLs9g
X-Google-Smtp-Source: AGHT+IFm322uH8+YpYpneNAQfCxehUdi5LhTInkGk5kRLWhCDQH2gzCF5SjhA7XsFD6D1vvGTnMQGw==
X-Received: by 2002:a17:903:2f8a:b0:224:1579:5e91 with SMTP id d9443c01a7336-22428ad58camr160391835ad.47.1741608266071;
        Mon, 10 Mar 2025 05:04:26 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.85.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af53c53d76asm835536a12.50.2025.03.10.05.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 05:04:25 -0700 (PDT)
Message-ID: <67ced549.050a0220.646ce.2402@mx.google.com>
Date: Mon, 10 Mar 2025 05:04:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7591808526085105751=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kernel.org@pileofstuff.org
Subject: RE: [BlueZ] Fix URL for submitting patches
In-Reply-To: <20250310104134.4124489-1-kernel.org@pileofstuff.org>
References: <20250310104134.4124489-1-kernel.org@pileofstuff.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7591808526085105751==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=942185

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      20.81 seconds
BluezMake                     PASS      1425.74 seconds
MakeCheck                     PASS      12.72 seconds
MakeDistcheck                 PASS      157.46 seconds
CheckValgrind                 PASS      214.46 seconds
CheckSmatch                   PASS      283.93 seconds
bluezmakeextell               PASS      97.99 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      859.08 seconds

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


--===============7591808526085105751==--
