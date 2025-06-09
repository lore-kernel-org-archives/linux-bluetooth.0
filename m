Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744EE254B14
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 12:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749470863; cv=none; b=vFIG8OAxZngrjWDyQ0zvtIlkUVy/K35tZ2blBlfHIEv96rGVoItg1X++B9jYygWViLHF3KF1DNpnGIRkZmKBIpfdlQIPYb4eh/QbvMNf1cKbkB8IPCteIs9imwqElJ08A1sLfhUmWYJJgObSHM6GVjZVb5RzRpkS/y9Urus6A9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749470863; c=relaxed/simple;
	bh=rAmYJ1hginVcMroOwAtpkrBbWc2uAFSK5dGbUfvS2xg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EgZS4BeLgt/Zrl1WcWyl87UKAg5Ti0pH0pDTWpla4QpdFhbZVJ9NtQUq0XVf0BThtZz7lDfakNLq5lwz0G64jkOdDR1rFYy08mvTKgqRzJAnuWbtGbS7pYi1LTFVVfRhuBJ2IGfthjaeZ4m9YXfCdwdJCjhqyat6IN0qqEX9ee0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWVK4IC0; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWVK4IC0"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4772f48f516so55768421cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Jun 2025 05:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749470850; x=1750075650; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=17Mbeliygdsg2JfHUvcUk8k1rEkpOXrhnpTK/Kn0l9w=;
        b=OWVK4IC0rbJ8YIvHUDcLIFaADRuU/7MQa4HLJ3dficXbmH+Fs6of5j74Xr8USUPILf
         K8BeVsWd4Skrp7dKZugvE+X33NZMDnYwje/xENIlLdZpF3vGP5aW34dNr98YeycNFQ32
         /2UDCIuhGuN339nBNonLjCpQ/ih9oAje6XxcVJ/fiUMBPKNmgNYu/+KV2wsCrLOOmx6o
         3Rf1LP0gJghXxi80qQ9j7WoUd1o4QBEuIhHduPkLtS7IfAlwUXPOgwL/2Ai0cFTTheLB
         S5z65J8TG0E4IymOLKFM9LSx1B96Oi4w037adF9BvmigkbX7tLVc9h92jhGpCvxHM4+5
         ZafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749470850; x=1750075650;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17Mbeliygdsg2JfHUvcUk8k1rEkpOXrhnpTK/Kn0l9w=;
        b=BdCxCrWRSeoUthpEQ2z8MTp9xycoUwYXadO8cJ5vUumkLCgUnYC1aCVzhGtvcHZbBK
         xvs2q4AZ6y/2oZHc+12txEXaR2MAOOlxVAA2oUVZjt6VhgRL1+RWsXeqqvvYaa1XK7dY
         eKBtKVLOHd5OX0Hic/TLnAwh9pc8nZFVU83fV6OUifgUjH9WTLiJ3suENHA226uFTg6v
         XBL7e5j2C3wOJU4SLtCSjWSbSmRE55HZ2vMsFFWZtS7hXB5mbyljz5HnfoVZQYsrxGQL
         KCwGKANVWeJrOfMUGbRLj/3SHYdQlPdAZgKGGft3dGOz3DIOWKh8oCgRzR5HOTISgDmj
         lpYg==
X-Gm-Message-State: AOJu0YzWrXVnaMhFbF1Sjr6AgKuw8b1h00J/NKWZqj5xat3ZTyZK/D5n
	qB1N350bSaFGbyeG+onyvkK8U24USct2oQCFevYPZ8v8iPLNXyKoU6WZvm5QszEM
X-Gm-Gg: ASbGncvnhfrwxWEkIokw11clEtgUtpxs+pfdR/SFLduERxr+JtNGeQp0k/kJOg7YcfT
	IdhhBJcPJSWfaiN4shhZwTy2pLSifeE2leRfmS6g8mZDM7VXOBY7pJwd9iHVYUahDoQEVaDmpVa
	5K5tHQcZCEFpmpuxOTUB77zbGPGeBo6aGrcPTQDuSlYb9QNjWsVVz0SebMDicxDAM2b0x+2KRF2
	2EH8TwWjpKqFgb4TBsvk8HrBX6TJQ7+BIKG3uG9keU0biJlNP0df7Ex0NtCUaUzFVDDCPWPrA3e
	ZzfFG63an/PnuEy1t8YlIt79S8N63mNJacLBTOB94Nv9eMT6eyEDS3idC9UoEOSc5mlU
X-Google-Smtp-Source: AGHT+IFvfE0aQyVe5OrrN3LLi8bGdSr5bNbeYzqXZmQvlrJ3D7Fblvp4MUwRVabUY+a9VzogT8mSQA==
X-Received: by 2002:a05:622a:8cd:b0:4a6:f801:4db with SMTP id d75a77b69052e-4a6f8010692mr106243131cf.25.1749470850097;
        Mon, 09 Jun 2025 05:07:30 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.34.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a61116be2dsm55501931cf.29.2025.06.09.05.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 05:07:29 -0700 (PDT)
Message-ID: <6846ce81.050a0220.3aff39.8260@mx.google.com>
Date: Mon, 09 Jun 2025 05:07:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8992660091551598970=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, magdalena.kasenberg@codecoup.pl
Subject: RE: monitor: Add support for decoding Channel Sounding
In-Reply-To: <20250609104716.1814089-2-magdalena.kasenberg@codecoup.pl>
References: <20250609104716.1814089-2-magdalena.kasenberg@codecoup.pl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8992660091551598970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=969781

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.22 seconds
BuildEll                      PASS      20.12 seconds
BluezMake                     PASS      2702.15 seconds
MakeCheck                     PASS      20.00 seconds
MakeDistcheck                 PASS      198.66 seconds
CheckValgrind                 PASS      273.05 seconds
CheckSmatch                   WARNING   303.31 seconds
bluezmakeextell               PASS      128.03 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      904.16 seconds

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
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1876:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3822:52: warning: array of flexible structuresmonitor/bt.h:3810:40: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8992660091551598970==--
