Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7152748A
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 15:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711379042; cv=none; b=Zj4HUHeDrLxRTPgMPSsCsnBI8+fmHjjHtMMlsATI/UCxw5U4THHoLEah1llEkZqdaWeyxJeTlGOzFQAg8tZkE9NfaF6fahmB37iW6yru97r/W6cPqLHNJWOS9OxCKrATEtvykDlz17qrsE+oxXKruQ65TyvSVt7Jrb++6odyRnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711379042; c=relaxed/simple;
	bh=JTLi8FtnHfb6IUFVWdUO/7xfXI/tie4HZuqxjtioN0Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QD6+tyomzyBCE+amJiaUvt3Z5BwafREUE/UigD2G+Xcju4OOQzWLKTBfoBAk8qGw/aAub1gRuyFOIbfZGfauDlNuPQes49mlq6gMM/u8u9/ii4IULCIOgwKxWQ6y0rEE1U3E8hn5GEIeYTsCb7p4QBodkhEOn/65la376TJFesk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NjGJ1l3R; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjGJ1l3R"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e709e0c123so3338970b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 08:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711379040; x=1711983840; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kXKdAznPglX9s4RD0HwK7PDlff6QaxVvnScV0dnxTI0=;
        b=NjGJ1l3Reb+9q4/F0LlAGHK9UALXjMzxT8vFF5LGjupBAVnyRB9nuNE3nFciX48RAt
         w3iydgDsxK4wdscI6kmjqcZUuWVzkRGRvgrzd2B9OeJODxEjMqED/TfcuTrboKTXD27K
         laP2B+zuvqnSm+87h+xap0NvMqC/thnsFVMjsYRUzIN8an9ELZJGQhRxMBLTb3RgpLVf
         Eetkl+Qsc8BuM0i4ae+BKvN++WwtE68SVpqMa6MYbKrOW8uldBoyeanpUJVKWlZ8ditj
         GkkLSOsv+/gr10lPshmrJvBZh2dT/o0F3dDtHEW0n906glxGN9284O5S3RYwJdj5x9yJ
         Hw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711379040; x=1711983840;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kXKdAznPglX9s4RD0HwK7PDlff6QaxVvnScV0dnxTI0=;
        b=FFVyC0IfwT6RLtuEl5x0764SI3+HE48QsNovn3J+H/px5JSmeMe1B2MR8qef3jpY/O
         HiAHtjPilYjE9F4wy3Mk/+hyFRnSaEYTnkE9sv9WxNFUQ9an1eMH45y9CeXUxdbL2RHI
         kWwo1FctTxfMrxrbQKOJM9UkBLV9U2AW8ANpf/sT9L923iDYIuAxIE6HaD/V2H4e14Qx
         GTvGk/qTiHHnVrML6hklepNrL3sMj0EjtcLhWlgksDrCUMZBJJ2z0udVHVFe3jG0lzOr
         yhdxUccAr6MQ50leSbA7eTEWtYnmWS3yVxNqzu5v9vev7SdapBMbFvIrWXcUoUyFzUrk
         nIWA==
X-Gm-Message-State: AOJu0Yz0SDAMwC+zNWPfxiHtVp4hRqPMxDwwoSJ8ZBDLZbrJ5++omF9P
	/ewwyimpKbCSlf78KuxMma2KLFwJdpI6IRYMesMs1zTGWJ/2tH8BHRBCJPkG
X-Google-Smtp-Source: AGHT+IEHqqRMcYKD6SvFO2iFRX3KKcn91HV2iPS3GRf1HN7MHSJ3IzRjJIpQlyElVNGccJiP4mggAw==
X-Received: by 2002:a05:6a00:6604:b0:6ea:aaf5:e0d8 with SMTP id he4-20020a056a00660400b006eaaaf5e0d8mr2489556pfb.2.1711379038627;
        Mon, 25 Mar 2024 08:03:58 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.115.128])
        by smtp.gmail.com with ESMTPSA id it13-20020a056a00458d00b006e5597994c8sm4187100pfb.5.2024.03.25.08.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 08:03:58 -0700 (PDT)
Message-ID: <6601925e.050a0220.24fd.a257@mx.google.com>
Date: Mon, 25 Mar 2024 08:03:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4250492973101975060=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: bap: Fix setting adapter address type for unicast
In-Reply-To: <20240325131910.324811-2-vlad.pruteanu@nxp.com>
References: <20240325131910.324811-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4250492973101975060==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=837881

---Test result---

Test Summary:
CheckPatch                    PASS      0.30 seconds
GitLint                       PASS      0.22 seconds
BuildEll                      PASS      24.44 seconds
BluezMake                     PASS      1734.50 seconds
MakeCheck                     PASS      13.28 seconds
MakeDistcheck                 PASS      174.87 seconds
CheckValgrind                 PASS      244.47 seconds
CheckSmatch                   PASS      350.29 seconds
bluezmakeextell               PASS      120.25 seconds
IncrementalBuild              PASS      1517.35 seconds
ScanBuild                     PASS      1005.29 seconds



---
Regards,
Linux Bluetooth


--===============4250492973101975060==--
