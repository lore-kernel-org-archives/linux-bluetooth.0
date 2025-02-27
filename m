Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5301B3957
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673908; cv=none; b=jHzUe727hNTbYg5DSEdKUJqQzh/lcK8AgZCDqEOIWVfe9Dzfan2Rx1UrKk2F41t54u+KMvczJ6LOn6BsIICd3vPttT8/5p0lra3CaqCfkxwVJGj840XeYuUYI1iIcK89rc4aCNVtUZ22HVvTQCuHMyDB98d6UiBP05t/0FUk5BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673908; c=relaxed/simple;
	bh=Ya0QaLgVrUXVj25C0FXqWJlqDP3fHy0ZpYKmS5ukAow=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZW19YNznWl7oNQANRSMfUdHDdCGgDzwqUGA9gGCYXfcs12ac42jdNJe4R9Edlet1yZqRlzDOffWBp339OnvqqlvB3Qes3NTp1a30kQe1Zn460R+XckLXVRzjPUkrpDgzKwdnQ44aRnwXSm/Aov94ZCA7xZzyhx3OEVsn+cCjUcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgIOhdrA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgIOhdrA"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2232b12cd36so17360315ad.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 08:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740673906; x=1741278706; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yTGTWvC6YLiOhEOoIMYZvJKAktOHATrzd+P3Bsz9FZc=;
        b=NgIOhdrAW3dd9Q3/EK9g/8vzVqN2gr6JykZ37AlR8+8A2Q2F4Nufex4WRrufhr0VY5
         srAoNG3KLr/Hi7zDKke83JmsXqFpcnX8dSyPLh1Ym2/Vm0cku+AIO1wqTHtr1ziNBe8B
         H+i/atUUcxMHngJwhZjEXE5UiJnE7dzv819BOUUM15BRcWCaDiNxbm19Y/+mD1QlgNgS
         2sg8wJiZp6XH20spvAMNZtnoLsKASUhCc05PGGVH8mo2eeKHrZKh7AJ+PoYCGHQ6p1iS
         Zx4SwUVgHn4sk4f6fKKLSMw+ZxOEoEW1/sThVl4OqbC7VpU0zioel6NsIiKDrmrgrqnM
         gPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740673906; x=1741278706;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yTGTWvC6YLiOhEOoIMYZvJKAktOHATrzd+P3Bsz9FZc=;
        b=Lg2oFjjFkGnwBDw015655ue0dGEtMiisFHfCUKOUpvvsKX+oOZNCKDa0/YVrtCw1Go
         /sjltzhc8+Rh1sk/lqxq3Qo00o4Qh4/pTNDnrH0kwQGVILdEq7latFZRaNr0bNyt5Eej
         sWMb9WYjeZ5QNNE/ot6oPv9hxrYTtyXRuIqkz10J+s0GueoNRiGanFWl3pBPoHfjP95Z
         3WaLhPPxkqt8PyeOIdR52Zz9VaR2TIWdBR5QmIsLCt4zJ+ttl8w3MwZMpYdZDCNK6jGz
         vDqAf0j9JFpHD72A278HjvASThM4gsxMofWl0Dr0QrGveM1v0Z5r/1mrsLM0JQYTkYec
         hHOA==
X-Gm-Message-State: AOJu0Yxs1hcLXWC43BI4LJ0gNxCVCUfCgsiSIdCFneCyY4w45cXMTiBf
	u97Wa0ZsDW5X31XIbbVhtCEgEJet0zik1Ye/K4vA4zPZk0g2Pj3mnK8WXw==
X-Gm-Gg: ASbGnct0RNhW0g/uxCaeEKWTaHKa+SD9IATd68YxrGRZw1R2GRanzU6km0OIWJGAc1F
	vmNoFOXTLkON648FGfwrJjueLwUS0f0VtN23xQmUWVg2JOR/NfuHL0xHoezyiK80b9Eu47oWXGj
	Gv8eAMAhm5kDITospOaR2v8UNHrqAFJjXOCb/JxMpDL6Mivg3O11TXVlXiM+kqloSvjMbjmX7LN
	JW/2KRSBtKwn8fwIT9TRF742fCTjXju6xP28lUmqiXuCHSBIea5MXRS2QgMNa4wScKC5YRNEoPI
	tzTR8/n2e0WQOiuL3QVb7rzfuXB1r0s=
X-Google-Smtp-Source: AGHT+IE53zlmijOFsyAxp5oz+pF9+xk7PhcNeIEW2ESTP+ue1WrUbKOOlXVG80gECrRt44rMLXMGLA==
X-Received: by 2002:a17:902:f706:b0:220:d6be:5bba with SMTP id d9443c01a7336-22320208667mr152292005ad.33.1740673906142;
        Thu, 27 Feb 2025 08:31:46 -0800 (PST)
Received: from [172.17.0.2] ([20.169.14.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235052beaasm16831645ad.233.2025.02.27.08.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:31:45 -0800 (PST)
Message-ID: <67c09371.170a0220.2e1f8b.ff5c@mx.google.com>
Date: Thu, 27 Feb 2025 08:31:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0238916780692254503=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: bass: Register bis probe/remove callbacks
In-Reply-To: <20250227151756.33772-2-iulia.tanasescu@nxp.com>
References: <20250227151756.33772-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0238916780692254503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=938583

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      20.50 seconds
BluezMake                     PASS      1466.21 seconds
MakeCheck                     PASS      13.22 seconds
MakeDistcheck                 PASS      161.59 seconds
CheckValgrind                 PASS      215.91 seconds
CheckSmatch                   WARNING   284.21 seconds
bluezmakeextell               PASS      97.36 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      854.38 seconds

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
src/shared/bap.c:305:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:305:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:305:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============0238916780692254503==--
