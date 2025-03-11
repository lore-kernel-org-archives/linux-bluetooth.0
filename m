Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF3D1C6FFD
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 21:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741727499; cv=none; b=q5ASyKONbKswzuc7TTatnCFle6wPtI2ElRCMyZoI0gMaW+59XQo7mefPtWUudFKcp+XjJgVywDKyalD7v3HfhrOVyKhIYbcVvPfZaXlSugtcwgbmEegvtftNU1oPRBPXGYl76kTfQYXIK7bWsD5OZc0bVBj9fsQxmHXlZTyAAc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741727499; c=relaxed/simple;
	bh=Bt5gtp/1Ym5Kz1By0c9Cq8d0EnHw/B+qetGo00qtJTk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Gox2sex3KhhcwtvFL4ZhO23szOQXnaz4hjjr1fIH4/84kwI3PmYzdGmv+p79Ob3Zp5ME3Vjj5LFyIeGrNR8gCkJ3HfxCQVzgELSbg491Eqrgn7804qWM0NaPMb1trsV6xSCqAYS2JajDSdOuLbgsgXbXVdY1royYYUDZy5nJ1bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Im96lXC7; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Im96lXC7"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c08f9d0ef3so358528885a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 14:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741727497; x=1742332297; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MLznIaCtCxqVZ94Tnl1sDYGk9aeJQjUB4wb2v33eQL0=;
        b=Im96lXC7D2EWt05avH/0JzlR9T2zJoneP3FjRfisEBeAi1lSsTL9FdbCMp/I2J17WG
         dAOAJBrMYdLeTWoM6utdl8//QVfHAtjAm75/scNK/6rbI1KSAnlYiGlTPabJaYtJdcci
         kAoAoqnYocTD3LLYan5UFT/S+DFKz64bFgz0dpBMM3V4Ounh0e+WmBJScIm6wpkQ/5ah
         zkSYcNlr8ywUsjPqmhAu3uiUYbQNX+vWgcZnzuNXlIWZ9CPr5s9Z+iWtik+DT69WB52b
         6ZSB9l/gVHW9Cg5wVw2p8gi8ucAetc8dP57Vg3sFyVjwHp/1oHlH4j4g0msdwoQwwUEV
         MBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741727497; x=1742332297;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLznIaCtCxqVZ94Tnl1sDYGk9aeJQjUB4wb2v33eQL0=;
        b=mOaaJOJeLwiUAREpSToDIrBSKAWTGKmVg96MRCE7DWJgFqvRBYEaGvbRwcOLG8RRxG
         aWNgplbZbu5rmsb8vduuSteEIA+C4cDOsh3Vxnw1uApAFSumfbKmRypuiwOAgwNkB786
         OpLQi9Mo/F8ZqzJrAfpYiAzSCHl1n9SXgvf3TYBla84oJ5DqWo3nX+/rOA+zWRW01jqw
         EVgT4D79hkDW9z1T8XL1kTFW+jFPAs+svUthRwAAxOboU+kvfSONxkWgo8jORwcm6CDd
         L8DhUDGdRdohiVWO83NsVURUj6gaUnHnXYMmLFv2dwMiXTyPfDL93iHzfI+NrocUj8WA
         YNsg==
X-Gm-Message-State: AOJu0Yzjm5FWIvhRv3XoyiZKSX7R0x62ow3ALtS/OC9m6w8IbfNKMGA6
	zNiiEmT++wL49BWnWnuo61L4tS2N4CAaNKTx8CBuHdjXsBTecNAIPltw8w==
X-Gm-Gg: ASbGnctJCIxJL/GcqGqWcQkWzv+NBm4fVf3zjMMW+/9LYMUpQAHIjYh0YoL2mt3HK/i
	N92gTd74k0gzu4KBP7qW1lWDS9vRj6vJwmVDJB5h94MXOfiM+oxRcj0wUxjPEnB/hqRvnSB1eM6
	S2sbpLI+5xDD22gpPczRjuMFosImRXOliT84M6vaPPTYF7nKj0vbJ1c3tXbreIac021u8C14e9h
	H+1YcjoQAtMtgG8aONYKnZVh9wY2zko0OiiGVMdJQd1oWQmGiuGoVnNTsyxkq9TkYBqGd4tqZH/
	RV6WVxg63OuSZMRDRHmhOsi5XQqYgCNqC4VZZJ8e0PVAf6Vt4sZ/
X-Google-Smtp-Source: AGHT+IFclf8juoQoTMoATYBf3qSrewoSNdKS5wgemPlgxXFyBbrr9eSi0yPSG3AB4tTx+mOFn9QbWw==
X-Received: by 2002:a05:6214:d6d:b0:6e8:98c0:e546 with SMTP id 6a1803df08f44-6e9006c8309mr270022936d6.29.1741727496571;
        Tue, 11 Mar 2025 14:11:36 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.199.139])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f707c267sm76203096d6.17.2025.03.11.14.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 14:11:36 -0700 (PDT)
Message-ID: <67d0a708.050a0220.1cfb48.ad7d@mx.google.com>
Date: Tue, 11 Mar 2025 14:11:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1130151783302213353=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] sco-tester: Fix closing the socket
In-Reply-To: <20250311194226.15109-1-luiz.dentz@gmail.com>
References: <20250311194226.15109-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1130151783302213353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=942846

---Test result---

Test Summary:
CheckPatch                    PENDING   0.18 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      20.37 seconds
BluezMake                     PASS      1467.50 seconds
MakeCheck                     PASS      13.22 seconds
MakeDistcheck                 PASS      157.13 seconds
CheckValgrind                 PASS      214.41 seconds
CheckSmatch                   WARNING   284.15 seconds
bluezmakeextell               PASS      97.80 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      867.64 seconds

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
tools/sco-tester.c: note: in included file:./lib/bluetooth.h:232:15: warning: array of flexible structures./lib/bluetooth.h:237:31: warning: array of flexible structuresemulator/btdev.c:451:29: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1130151783302213353==--
