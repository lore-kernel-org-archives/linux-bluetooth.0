Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE07E21577A
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734702934; cv=none; b=BI/SEgbshUZJBmHVjpPmj9AIvi1WyKiwrX8RlWVQgO/PbJc0sMEtbZ2sUBmqswzlQdeYnrOKnwbJygLrFNSsoDsIiYHDt1+7pfB5fF6aa2KLeLbi66Ay1HIg9o58xiyDK7idZPunI1DLtgSCgs9E2cVD/FDL/u36/RLI6jL+Kjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734702934; c=relaxed/simple;
	bh=rvg6b6JxnCs2sS+zcF2zNhzNxw2ir/OJE6UWSClCTCo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SHSiKXDnRnyzgBfhj+kFU078E3DuqvrWHE5ojJZQD0WsYvbQpoHhlD3xhT6+IxqcT6GwKhJjH+SykfzDq6SWzlgMyeqXxZU1TMWjjtfBzv6jCB9ovQ/MGntmqn0NJIrt5Lmiwr255PRdfhK99KIiZwc4uuHFIqwj8wtX12Yuu3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JMRt2Uwa; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMRt2Uwa"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f43da61ba9so1528141a91.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 05:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734702932; x=1735307732; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vMVsRAzJ7m4Zh8Ue5QJPoFG7N2/zoeyMfVV5LEUmn28=;
        b=JMRt2UwaA9/pD4tCgTnJ3bhi34IrXlqD8pGjZce/jMDRqdOwi/6tIIax9jN1jEFPUu
         u4yjO2dNT8BMh/e1PmjVvIX9eSyTx/W0WtA02/PZKZL4su3/zZk/csVVt4Z8dXBlinFW
         RaSH6roD6hW46AC/C+qYdCleAZ0God7f3DG/091WcMWMz4mothTue4HF2vX80m6s0yTF
         z65u7563twwjMtESwHHP22FDgZugVRunxImWeiPUe7Qa2UOvmIyeiKIRs8Wbh66ahCIr
         H7shHXIEfKtaNgxzslQfpLI7iX2uiHYFGyVqbSkDnRFKWjxLmE9DweMFp8bT6OKjvsrR
         fAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734702932; x=1735307732;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vMVsRAzJ7m4Zh8Ue5QJPoFG7N2/zoeyMfVV5LEUmn28=;
        b=s3FHQTJJggoF6w2phIBd/NW5E8ooWdqzJxGq7UrwL0hRZ8z4Ddoq3KvWEJLdbTqh0J
         5ng/eIJ42K9Nf/x8Nywhw3kCK5TRBZhuWfn0Grq2C/IW0lf9Eobt9PC04IjfZYDZQeDT
         6EIHHyc7UAYaZISOC6qOQV3iPC33NXw5Pzdq7FMfclKt3NwLRKbOrrKTXDZsKtmJW/eY
         IAB+Y255WRbsgE9BewIXAwRipuSnnwJbKjkMKAnzZI1CTdKnoppWB5rFGVi65ud3hzQf
         E4HCswNd+17hGe7ju7ml/5WnJP/aQShUhJ09yYw7UNFKrSdJRpE89QaUuU3ZU+08bjzL
         2T7g==
X-Gm-Message-State: AOJu0YxvZqvUh8aR5lYkbHjj1K0D0WLzRBWV/cZWIEpUez51VsU7mArZ
	tjqFykWX3bkqhD1W6m2GK/Ocru0YWadBG6xzM+RXHJh0SodNqTni24HV9A==
X-Gm-Gg: ASbGnctkD08ZJabSflmJjyty2Y55tFI0UqDxyjp9pb1ws2cV0ETLUCYGNHQptZs+QvW
	tWCYuTdgcZmT9HCL+NRrEjjedZrjReWAthr21uIxUDx8LL7IR2AiqxaSb/2i6wdlisuReKdlcgE
	o/IrjgA6hy9zp/Mo/CoytwPuGlfBtli6/H5NkcbvdThftPvLFd5Y5PWTuQiuuzMzvhXGQtcTKq6
	LJdMc7V6kZL9aAY+5Mekkly/HQwcWjGMPqCBCODzeXiO/aFpeE44hh6QxgTgw==
X-Google-Smtp-Source: AGHT+IGH3sqb1K3VtnFN2MpDDN8SwQ0jCV20+EglUiOctGyg8DFd/hY9xanfxnkFgpEAGuqW0OMgkQ==
X-Received: by 2002:a17:90b:1346:b0:2ee:ba0c:1726 with SMTP id 98e67ed59e1d1-2f452eeb5c8mr4153436a91.34.1734702931588;
        Fri, 20 Dec 2024 05:55:31 -0800 (PST)
Received: from [172.17.0.2] ([13.88.99.141])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed52d27esm5279842a91.10.2024.12.20.05.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 05:55:30 -0800 (PST)
Message-ID: <67657752.170a0220.36c6b7.ef1a@mx.google.com>
Date: Fri, 20 Dec 2024 05:55:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4539780758095752310=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v1] obex: Implement support for message listing format version 1.1 for MCE
In-Reply-To: <20241220125812.84592-1-quic_amisjain@quicinc.com>
References: <20241220125812.84592-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4539780758095752310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=919889

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      20.37 seconds
BluezMake                     PASS      1588.78 seconds
MakeCheck                     PASS      13.59 seconds
MakeDistcheck                 PASS      158.66 seconds
CheckValgrind                 PASS      216.52 seconds
CheckSmatch                   PASS      276.62 seconds
bluezmakeextell               PASS      100.63 seconds
IncrementalBuild              PENDING   0.36 seconds
ScanBuild                     PASS      865.97 seconds

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


--===============4539780758095752310==--
