Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A0F3DB86
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 19:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705951625; cv=none; b=nZltXVwQIY0cUwppDSdzGiACT9nBZoHGozPXt7JCZfRYSJ8wnDiSa3C3/gcinGeuJeYfFtPrACPQWZZ4EyLtbMvk6aLPsUcj92GxGJnXP8XweRc3/4Vv1gXUkhPqabhoj7ws2iKlnzFJrXYJyAVBTNUM+ZJnDx4Mt1dPrKpFkEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705951625; c=relaxed/simple;
	bh=WMaGkEAxSVkZInKaqeNSJ9dHIsrhHTnrSBQY841rfHA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gcgvT+BFBk3mj32pN95ghqx/D1RjsJ++17DhX2NShaiNp2W4TEziTaYCWUVni1ivjMnJ2AyWrPTRGkzFqGxzmkAjPxuZcSb3uglQbj+Wgb6pfP6IYmM9Ar/WAIammR75/0n+JfIpn/dSsZDDsWxR+dqHe3kvaa/xukPAgbVvxcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cxa3C3ET; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cxa3C3ET"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6da6b0eb2d4so1700275b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jan 2024 11:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705951624; x=1706556424; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hLdBQ7Gh3K/05HtxM0hTA53zG1ZorjV8mj5gGBg6JJo=;
        b=Cxa3C3ET80Cw2T9CHOpvDyJw9CJAhle6flsH8lg58dOfzFL3pFaMgzYCHBoa/GPx54
         g/QcHplKzmuIdUmpw8xcgMlnNiFJjiY3iugk41OCwOOnttbsqVrdkYhyiBJzm4z8/Vct
         VacLke5fcZu6yAIMvpuITTt8MMdU3ex990viyGD0iroMYyUly50PclDjaTGl75c4JInI
         G6L4x37SvAX7xk++hqg2zqI9a+SxxlLCvJWlc4BRjEnrHJkNfqgwC22WEfVwz2EB7iQB
         +GIPIkotfVs3yN1Om2RsjzVSEsnMSYBkM1VUiWextGLiT0M7+B2/EwyNXwkowhqpIcsn
         PYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705951624; x=1706556424;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLdBQ7Gh3K/05HtxM0hTA53zG1ZorjV8mj5gGBg6JJo=;
        b=WlNXJ4RMu+gI12vbhtNzn2Uwlt0CoabEAs32J5/kXSw92hfNrJSU6u95cCw8K3qtam
         GCVtpk/ueO52PkeBVvh9Rl5W3uma0/h0IKDNx5yUUly03zNFUzK1dPBWthlw62z/50Km
         yeyTKh1CAJ/2vb5+4ycrreCjdqnObxFvVCjNgk6byp+zlqMWYnBGKUn3gQ4jm2ZvsDu6
         rYxb/H85CBDlIwwjM2vYvuq6A87d3xmxZF+Xd3zqoSS2BXtGkv5ccEBx3JTI9nXCycsO
         iZlFTq12MncYYDSaqjRupJQ1hk++Cnm92LqHhVbEv3WvY5SZxMDrJSrvbmBw8TN79OuV
         /hRw==
X-Gm-Message-State: AOJu0Yx+q422WRRpzrcMKuyJNOaNWozzBxhDItCTYX/rF7CtqGis7AfV
	e162JUc3HmJ1FBDaYujK7Nr4bF8ot6ksqUHMS0/7aARiFJd8zq4RBrRl6pOV
X-Google-Smtp-Source: AGHT+IFTw6CsdY2tLjzAWXjshylqdBCU4+V1MeNnAs6oA8JAdF5kf3LQdBCNBL1gwHYgweT54q8HDQ==
X-Received: by 2002:aa7:88c2:0:b0:6da:3437:f6fd with SMTP id k2-20020aa788c2000000b006da3437f6fdmr2497741pff.47.1705951623650;
        Mon, 22 Jan 2024 11:27:03 -0800 (PST)
Received: from [172.17.0.2] ([52.157.3.104])
        by smtp.gmail.com with ESMTPSA id w26-20020aa7859a000000b006dad993d91csm9970280pfn.129.2024.01.22.11.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 11:27:03 -0800 (PST)
Message-ID: <65aec187.a70a0220.63784.47fc@mx.google.com>
Date: Mon, 22 Jan 2024 11:27:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7851391165354154980=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: Enhance GATT to pass PTS tests
In-Reply-To: <20240122165000.279381-2-frederic.danis@collabora.com>
References: <20240122165000.279381-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7851391165354154980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=818707

---Test result---

Test Summary:
CheckPatch                    PASS      251.88 seconds
GitLint                       PASS      153.53 seconds
BuildEll                      PASS      42.15 seconds
BluezMake                     PASS      730.75 seconds
MakeCheck                     PASS      11.23 seconds
MakeDistcheck                 PASS      160.09 seconds
CheckValgrind                 PASS      224.46 seconds
CheckSmatch                   PASS      421.96 seconds
bluezmakeextell               PASS      106.00 seconds
IncrementalBuild              PASS      3388.99 seconds
ScanBuild                     WARNING   945.24 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
tools/btgatt-client.c:1571:15: warning: Null pointer passed to 1st parameter expecting 'nonnull'
        end_handle = strtol(argv[1], &endptr, 0);
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
tools/btgatt-client.c:1893:2: warning: Value stored to 'argv' is never read
        argv += optind;
        ^       ~~~~~~
2 warnings generated.



---
Regards,
Linux Bluetooth


--===============7851391165354154980==--
