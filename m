Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCE9361DA8
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Apr 2026 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775156023; cv=none; b=bvM6sTEdEoGytDV4mdaTsLyFjIbl6C4IaIctj3o5LRyg4iZa780GR6oA2Y1PuYUhclcKhCFQ4oavCtEuQ0fpxFDJDxbAl6iAYMVmZPm7wD9+L4ZOV0SnE4J83WYMhiYC4XjKp+TpPB2UKRumL7EiuF/ZwaL1EMi2YD57vahkICw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775156023; c=relaxed/simple;
	bh=6DSHuW+gs/1A2FmOqUILCYN9Sy+t19j2FifD7IyQ9Ng=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YZUrRZ0h2VQwmd0Ap3ZLPl0caiYdBddvpWP72EQakLvWp6dfKTqlXlQE3Pjn1dqIncgjPrMAHfgMCx88Q1EG4Xir3NwH5b0Mz9wcOkXLgwxf8lWCngGse9Vq8tk1TqeApNIyPeEteuT5HoNGPCJqkCSY8Y2Yg3ukG6pF7lXGZvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWuv7evG; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWuv7evG"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cd8a189f44so119159485a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Apr 2026 11:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775156020; x=1775760820; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+6KnPNFyQ+Ami5PrcBzt4NaOLrU1eHBWbXVA5ph0ghg=;
        b=FWuv7evGxW1am89ub4OkrYirRgHQ0HTlHZhablRclJyEybAdbAafp+bdN5AmyfKXL8
         tFhh0hlJaZgMnxcK9q/xwmEpMCm+DTavX/wLhI02Ff/hUcxt34MWGt3Qo1z7ROCM6kzw
         OfP/zqkCwHYQSLdqfy/butsCfxPQ7vprAWaY9IdmBx8mowrytNozsGc6Unm+N0kN5bM8
         wHh8r6gdZv5ahyCV/VBwoDFO8ctV0kYmShqc5AClkPOeLd0DjEhNOcZSArXr3Cjnp2Y2
         0reVWRe2jK79Kq9zeWGJ9/heIslpbJlhIT8BFv8deDQQMWiAcb2E88hxBXjEhJpnFx86
         jiaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775156020; x=1775760820;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6KnPNFyQ+Ami5PrcBzt4NaOLrU1eHBWbXVA5ph0ghg=;
        b=SlOB+DSr7QRY3bL0+GGNQq0Olv2PnGh9ZMuxb52J6Uzg3A7wdF2lrJbZYQGPqaRGWj
         sG0zJXFxuDo7w/2HXRvIJee8+BNMkW7D8aQwMwpUc/uCfKUtIEsirqLZRjrJ2JNUmsoE
         hmypMvQNdZ62+0c1shzOfpnvQZCBFmM7nOOGQ7M09vWhze7R5hsEmhT6R1pUc9SGQQdW
         ztc5VIniK3MXr8PifA8D0TlyaLmAZ7twz3Dv4x6B3l9MVg+qtsEgFfKBJn3japcudjsm
         AUETjtQzUHFbDkS7k98YDeCqNu88IcNyxcxETxILSmktiFPfhDmQwJNO/7G6MWyoW+U9
         R7tA==
X-Gm-Message-State: AOJu0YyD90bYmr2Lq/WnE3bul8xEhbkub47qOcyUtfIoooSySkXE9RH6
	iWRDiNYyBkY5ojmf7vMhS3V54rPJ5s8VZC+num1lZsIaRWdiBiz6tLpdktrFRw==
X-Gm-Gg: ATEYQzy83dTDZO1/WcYh0/K+QLPVQC15kPqGtvF/FFqtyGBCrioPelONbWMg9urXhtb
	Rr0gTcO54rZCCE45PtiBJTH7uJGDWJbxmiUT9hYAF1bIfV3PZH18OmyZWg2kzinAwBOZC+7A299
	zgpTN3aJrAzuLF0FtkYbpYvixE6RoY1gz1nHwcVQekr6txI2ZhWXHuCL+CSnnRvMAcbAgxo4n8s
	y8EgJWo1TZ80U6oDoXDiGNh+4zzZP4KcZIjdr5oMk1JXj12na6GPE+gsT0YFqEYhnrYD8EIpDIL
	4rMU+01Z8GFT6F+x5psXzBMziCrt/S5dqm/m2+kvwePrAoRs4BlJr5bo+E6Ak+PIt00pjhJpouS
	XgsoL6uUmrW2jzr65EmPD1O1231KvAg8XJpHOpOTg1eiXLg8ymYzLv3fL4xr4MXM8InDgRb6DbI
	/u/s4M6LBAIpdf6wdYINRXT600FeA/GvB4
X-Received: by 2002:a05:620a:f03:b0:8cf:eb1c:57c4 with SMTP id af79cd13be357-8d41db4d3eemr61456585a.45.1775156020222;
        Thu, 02 Apr 2026 11:53:40 -0700 (PDT)
Received: from [172.17.0.2] ([172.203.212.192])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a8648c17sm277931885a.33.2026.04.02.11.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 11:53:39 -0700 (PDT)
Message-ID: <69cebb33.050a0220.9ee57.04fc@mx.google.com>
Date: Thu, 02 Apr 2026 11:53:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7781375751446865317=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC,BlueZ,1/3] doc/btmon: Add Channel Sounding protocol flow documentation
In-Reply-To: <20260402175624.2442647-1-luiz.dentz@gmail.com>
References: <20260402175624.2442647-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7781375751446865317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1076592

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.31 seconds
BuildEll                      PASS      20.15 seconds
BluezMake                     PASS      660.36 seconds
MakeCheck                     PASS      18.26 seconds
MakeDistcheck                 PASS      244.89 seconds
CheckValgrind                 PASS      291.88 seconds
CheckSmatch                   PASS      349.42 seconds
bluezmakeextell               PASS      181.27 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      1021.29 seconds

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



https://github.com/bluez/bluez/pull/2005/checks

---
Regards,
Linux Bluetooth


--===============7781375751446865317==--
