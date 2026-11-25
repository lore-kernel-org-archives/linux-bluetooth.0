Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795650818;
	b=n/0JJjR7OyCt+b48qvPiUnCKdpZhhewUqF203qDgd5pRa+f4mAo4WG8yWo7IPm4MAvOj
	 CZiqWd+wiVXcgyXtKE3YwZ0zzEXe/fMZelecDJkFG4IT5fzs1Mc8wntqdNq3IVcNBpSmT
	 y433Efs/h3q7K5tXJhLB/zQ7Zjz3jophoCbRUrT1KVOKWuwG6uBMds07q2WTEg2+CeNaQ
	 UZpD7bw6rHzxwre+lKRaV/i3zgyl0fD8okd9dCUIjsxDP7/NFT4C+fDAVTgTDODfgwNwZ
	 a4i6Mjn7GazeMGDMxC5kDrN2+q9+vFC4JztihKS69TrjZKP2JeoRXmTYf9IrqAPz1zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795650818;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=eSb1hsAZ7B02SxcKicb+w0Tqahcu7ufrOcym0dA2MZs=;
	b=bfpn5zjFk8v10yMWLR21xCtwdSVhxYdr3LGEvD3OY2VC0vg1Kf+nlOH5cTMjJ3rf8tYx
	 tKsD9N/APNeaclHy+HfqgFRMHJ7JkYdzxW41rLf9szO5Rbj/IX/teMjTHJiebuxWd7uOM
	 WsFzT8fgUmDoN85xQSU+X5mmRc696N1jq9B8ki7DIyeCTxGd0CXx3BwFK/tfWvMvxz3X4
	 kDOKKH9d/UR/V38cCBxurmNHNQHIyya+BOtyypqzunU2FJ6AFPWWgjmkdeDz+onL5lx39
	 mjp5Jk5fGwFbN5AQOK03hRnZN9cDSjiU3HAJP+tynQaTQUyFd9iMaKxx+GlgV0lVEUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q9ZDRSn2;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC40606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 23:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CC40606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q9ZDRSn2
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-38644aedba1so9664268eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 15:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795650817; x=1796255617; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eSb1hsAZ7B02SxcKicb+w0Tqahcu7ufrOcym0dA2MZs=;
        b=q9ZDRSn2iO9WAWAcENEkIcTj2+AUDpSXoMD+fWdZwwvfdP+p+JG1xR8UI+fd4SIO8d
         RunsYtw8cpqNsb5xB4uhZROOLUktPoNmdp6hZzXneWMM7xzcLe4FBDX72ju0PBM4aLjm
         Is9QzrspAQjQPM7Vp9T5ijhbyzkuUXohZB08amf3cXcACQm9WQMkcrCaEJZrX+SF3292
         Hlgvd3tjYvPIBx6AYvFneGi0mgSwQeDcd5j6QLZsoellTf2EkDxS+fIR8Pb/PqEove+s
         MFKjJO/iyesJ3oQKcWfwc2hX0w1a/7lXn/2Tl0E+LGv08aXbVVd41tNqZ2dRb/h4sz1q
         6deg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795650817; x=1796255617;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eSb1hsAZ7B02SxcKicb+w0Tqahcu7ufrOcym0dA2MZs=;
        b=C9rtI7spIyTI/3wH1BoTeG84Q48M4JDlBMdZU0FFRB3lUYvAjtXJot/S+rZ4EUJHnB
         IGiNyyDxBSAvVoT8+HEucq4ngJ1y6FgQSwSGD9JWUiR+xHDRhhH9xTeUXFJ2gVKqlqvV
         apbsHxMLLFmA1iIn+SQoDKbYVytJovPwE1h8r2X/djk2Ta1LearnFs2NHceO/lNHMP+N
         E3RWrKwmI1hqDaN1lfbd9gqZZO1FWCLd1jP+OObIPojo2LVFSyJK70/MUTPamk9cLZ6l
         G9ojt8lTDTJcI39Nma/bus3REY1V9zlhTr9g5f424dX9/T1Tks7O5LlodfVGzEUpfE3C
         KsMg==
X-Gm-Message-State: APuU4Z8yXhyDsE4sTSOMth1Vi2SWi/n8YE3LMuf/ZcVFlwiukmgl6l8H
	8ALnbmySDsHxP2t2CF8RS9seUdRW9pX+M7JO7uc+qAd/DEeSMaZ2aoyhvyBl5A==
X-Gm-Gg: AZFdTZcnbUJenrZZtlentOEuCbaQs1/l6Z1sotWCMcQWWgYdlYLYeklphrFUHgLubRy
	M2s0ARkyh3Y1yYIodi0HunBsSLIj77aYv+vTDDy2FmKRUxK1E2Au7x93ECaEMw6Po+cQ4jF5LCx
	SfZesDdUlE6geCqsiDHi/ZR/6rDlo30cvfqD6DBKXG/PX9qF7+G/H6MzyFRyc9dSrifNspsh708
	/tz8kMFpnBinIHvi6ijIASbBeHMaxdZtVCevhHDF7eKFwYBkeB2iAR3JJ2J0rFaY+mbd6WzNjuc
	PXzZIq7+Xunv+n4sWQRuOEKlziwdqCP9Vgx2P2Xi2O9E1z0XDY9JXSoMwn7JinzvEgDjCCG/RoO
	bTs1DhyAo2r0QCW32CdOxe3vLllbIJEsttFs9Mxw8BujnXYdb3dqfgC6G+K3afzT6PD+BnFx3Gy
	qstncqF637Cqj2QAM/ZFu0Rcwxay7QtPwvqzmoXN9vE6KPYGF5c4JyrL/xOfTmK30cQqcQsfHMw
	zDOSY0rjLTMQLsw8k3JJ8lOuhdwIvlqlNYwrGnTd82o4dk8TYAZltIzcxqthj8IOwcSXI9O2iUT
	867zUnQ=
X-Received: by 2002:a05:7301:e0c9:b0:382:e67:9d4b with SMTP id 5a478bee46e88-3856f850902mr17531564eec.15.1795650817295;
        Wed, 25 Nov 2026 15:53:37 -0800 (PST)
Received: from [172.17.0.2] ([52.148.0.50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567daaf70sm59133732eec.28.2026.11.25.15.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 15:53:36 -0800 (PST)
Message-ID: <6b077500.f6a0bafc.eb5f9.7bb7@mx.google.com>
Date: Wed, 25 Nov 2026 15:53:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1823907014408459899=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ,v2,1/2] avrcp: Defer init until service discovery completes
In-Reply-To: <20261125170243.1649146-1-simon.mikuda@streamunlimited.com>
References: <20261125170243.1649146-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1823907014408459899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1222369/

---Test result---

Test Summary:
CheckPatch                    PASS      0.78 seconds
GitLint                       PASS      0.49 seconds
BuildEll                      PASS      20.42 seconds
BluezMake                     PASS      313.65 seconds
MakeCheck                     PASS      3.45 seconds
MakeDistcheck                 PASS      149.30 seconds
CheckValgrind                 PASS      161.76 seconds
CheckSmatch                   PASS      322.06 seconds
bluezmakeextell               PASS      102.12 seconds
TestFunctional                PASS      1242.70 seconds
IncrementalBuild              PASS      322.06 seconds
ScanBuild                     PASS      1209.76 seconds



https://github.com/bluez/bluez/pull/2927

---
Regards,
Linux Bluetooth


--===============1823907014408459899==--
