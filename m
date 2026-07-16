Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310E241DEC2
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784203359; cv=none; b=LNi5/CyPXd1XPg+FDXmwm+EJkLevoxdgnRRYFNo3M/5h0gRrkm+KC2e1T5LUG2lz1XU1PJA/n90lnqxinwJcNlrTXlFPK7o2jCrMpmcMnW6wuMuI5vG1ywsI/mj7VrQlxOzaI2ZTTo3pw7BP4z+jXKGdLrreLtxiP67yb+r7GOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784203359; c=relaxed/simple;
	bh=KwBo4NwrIsdLFKnZ2Tl9UUnrV0f6wBPohS/cLcEPWzo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ulyA/YlXNZ24AfuzfquLNZQbl4TBCaAmmaJ6O59LiveqgSMRtTow+gfOKVNwnonwdtoTWsroTmkSX1+ksOb4jCzFA7MszNBzQVPWMktNl9NX5Ck31EyTfwx2B4EBqCL+VJh0Qt/sCKHAbL6EG9/8pElh6qhx2gtt5+iJHGx8Upk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZ+YqtOV; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZ+YqtOV"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-80bb41f7f3cso31447717b3.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jul 2026 05:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784203356; x=1784808156; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KwBo4NwrIsdLFKnZ2Tl9UUnrV0f6wBPohS/cLcEPWzo=;
        b=SZ+YqtOVszNdWE8ze7Nds8gA02+R3Q/C+s7j0x/IfIVWysnXDPZOOKRAyif+GYDz1N
         pT3LITf6xF1OkYA8Hc42u3BnY1FWWFu0fZ3VjUiaBDtyiWRvhaA0YOskKSQocuQQT+YF
         8TR1sMckXyPZkZNUHRsuGA6vJ0mdKZl4vv+dkfQPeDypy/mcTSuhIDpIjH0kh3lARwP3
         rKYX6y4OXNeOdB1ecWLuVK3MP3BZYwM2JY/vUBxX+IIszett3crnhu0PLRDOTN6YYbT4
         kkJKr5z2lP/vMNxXv48QyzfjNCrjFZwwFlq5pzYWGuc5Ib9Ha+vRiaNSSsM10ez8FuRM
         24Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784203356; x=1784808156;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KwBo4NwrIsdLFKnZ2Tl9UUnrV0f6wBPohS/cLcEPWzo=;
        b=oj99ss/BXBWZN2ELqvp9DpNXqIAM7uUQXjMt3bibdM17tYBtCgW9A+4JBgmNBn7Ds3
         PgX9yk7demIUUL9hRV4YuXDm/eP+VALV/9MsNoYecEheJzdu8bgv9R1ped1FckTEQ43T
         rVJC/2o8wwv0NPAtQdw1BXaH+v1VxLwCi3oJAfZFV4fMpaHizfzla6xSaMcsQCx82WmM
         6FrMeyDXr+lI02XAXSv71W+kHn/0D7RF9f6r9/TtHAzYqxqknMLrR4gY3FyJVasZfTWv
         9qEhDNgzm27KXy+v2cSUpnvG0tGCTa7pxxCgqU4Ck71CelRJC0343fIFxA3z4k0q6sKe
         5/PQ==
X-Gm-Message-State: AOJu0Yx2IuTgCtEmzGAXVDonK1urHQWaBQ+bi1mqacksVS6FVbGznAsd
	dYGdg0O7LPp1PloNJiilbrRRqqTOrCn1ha/lXsvpiCbf8djX0IUg28fJvDqCuw==
X-Gm-Gg: AfdE7clSAOsoOJbNp1dCyAKU3o2boQ787SnP2Nl6KNzxGzOcQkiNCXjUrHYnQxubtnr
	MZLSqmWt6Qumn5oByinaaGIp2GQLJfMEVcGvAj5cSRNwbWHXHTr5Igram4VVTWmszFaXgEJX2s7
	njyfNJpB1IYC+7kIftbgbD06Qb/jTRmLVg2VOCf3oyhUV5QVI6MZgS0nx7AIWXNs3CkuHccaZXk
	KklMELoiZ086U9YmQqsXa0OzuUIrHx7K+nz5PZfmBmJRIkjLJmeP+Pb9QOfflneUIWY5DPIwPNJ
	Sul9mRZTRKR0ujSTDIkIkBZFP1xLuVTiDqJ00tUg9IHhlXMtarH5Yl57iDXOCX+tXQPoNPLxTB4
	JNXmhXO7uVbixqUj6ZTrNZ0uZOGq1kgODsKqHgNi9sb1QIFYJuyHffdGELBuG7nVmIzyijCU1BU
	bcUdyllTbXNA==
X-Received: by 2002:a05:690c:9a87:b0:812:be92:6ea6 with SMTP id 00721157ae682-81e90042907mr161169077b3.28.1784203355753;
        Thu, 16 Jul 2026 05:02:35 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.133.102])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b4b38dsm2131068985a.10.2026.07.16.05.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 05:02:35 -0700 (PDT)
Message-ID: <6a58c85b.63ad6957.165fbc.65b1@mx.google.com>
Date: Thu, 16 Jul 2026 05:02:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3304082866243220719=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: Bluetooth: btmtk: Add MT7928 support
In-Reply-To: <20260716112353.2192865-2-chris.lu@mediatek.com>
References: <20260716112353.2192865-2-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3304082866243220719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: corrupt patch at line 84
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3304082866243220719==--
