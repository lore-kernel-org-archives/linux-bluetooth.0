Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB28428A3F3
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jul 2025 05:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753160901; cv=none; b=W0x3kw+rnj/kn+2zPa0rSj/6W7gET8WWAu+Xbt/Nye/Ijs/HJpyZqOuaFOQJ6rI97GbR8eONyojzMNkBAWzWmiFpwCHYec2OrJcE1QbShHxuIL5P+HCHeALw+G0t9Clhf1GC8RYuN2UGA8mg6lEnFdqmdKFPfSrzRk8unsdHkN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753160901; c=relaxed/simple;
	bh=x1Nq+JFhhiQff0Lsd8bL2tXp/IorIK3zd/pTH5qkUSc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=X7Mauo/qC5qsmzqpGd1iy6fsF0gP3SBMcN6y49AusKDxpGkuMcm8ui4joi9WTWcZuhURY1M2GmrPQRcF8YaAXETOQy+mjDHE2HT7tfAEiArCDFwQEWmx2x6faLXNuV7JvhaILgdXoeHKo/HQnDZQ27e6stRGbCvWf+yDpwWHw4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gx28ocQp; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gx28ocQp"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6fb1be9ba89so42383776d6.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 22:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753160898; x=1753765698; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MT21KcwikgaswUpJC1lto5WFRX79cyThdlmAXxWRm1g=;
        b=Gx28ocQpc2iveWgMiO3IV9R9w3NF35ZtA4v1EmDbmYycFb7xawFBvnE7/X82SXn6Ji
         fhkyVPcUH1BrTugbnYzCv8WjVbLQH8mzYM33MX7sUGCsda7bx8J1wgToMfEBPYRcZ05J
         Clc7NRoCsHUlsNXEtkfqrY9tLqqfTrdD9yEyck81ARSw/uSJKHa+ElwLAa0+K6jeqlRP
         S4g+8mYJ62c5XbFDbtjYlLi6rAowOFgoRo8lLmgGuWcLzl3GCVpA75f9qJksI3+ySYXD
         +ixeT+0dHROUs+bm7GIlUSDTZs9cs996MLOfnyA3okA3vzeQtq4aU/J6rnHE8wLFUuaq
         9QfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753160898; x=1753765698;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MT21KcwikgaswUpJC1lto5WFRX79cyThdlmAXxWRm1g=;
        b=VrdtKSpPJdtGoNGT9hWsc1Dsk8rMq2mluuuhO3dzkpddW/6oHMLnecZ6U4H8K8XtT2
         VSQqNeHMS9Yji+svy4XJyulNoXWgoD5lC+ehyoLLjdKz3CM19ZHiYj4ncXxImdmefC+B
         V8fEO7Nt6C5LGwjDiBcq+nXO3NMdhquP029urodf47aWvIPkm2C0npF8jU6bfeu1g9wf
         /0b+pzGN74H7g5aClubbr3d3XqfjwZ/vgl9LkE+kCXVXjRf8VRd9hj0xuuu28bxh1/OQ
         OopuVSSkcRdIKNarE2MXo/7ObWCasHq/IfdRxSuZSwoy542ACNpcdWF9BlOuu7ncMfZN
         5/mw==
X-Gm-Message-State: AOJu0YyqD1WcyAX4X4UGKlNcPPGLRb+TN2p4nqK4j/mf/LXSevkcBFrE
	SSTLRZF0pITJaS7cptYHaF6krWmeTYNAw3iObH2Jfw+SabHdb6XAEq58eTCJz+ZL
X-Gm-Gg: ASbGncu5syAAPj55SU5W6uKZdTynYaTYkttVpLEPUTjwX5BwnTt1FhRzvfnwYex5IKi
	1BZBDX5BfHULAy131+MJv2hYEG//+3/a+QKUfeX6Z/FqephEI6/fvuM8+TmRp7apqIXxf/v5+8u
	1lzdFqio+BZO563eylEJrgMIrGmUjOmbobJ4YB3Il4SbzSWKj6z2s3jkBIfuTNpSQPJsq6e4qKo
	5MxUl6gkN8A4Mdr3mLw3Wk2KM+UqyXfiYq9KuMipIXWxujqQS/ic7lBZ78kRWoPYcKjhApR5LDY
	JSNkNfVRplmRvXUaprib5CuZxeaewFFmINcQ811Ades4Fa6KVvBgL7xhvF4c79u5PquhMOO2nED
	JJJOLVEaN3rWTtCgqU8lxGceCq9yG5g==
X-Google-Smtp-Source: AGHT+IFSLWBxL2z7wLIMvqKb8hxa/RjNkx4+Xba7APl4yVU1uApVp7/IRzkOz5yZCEW8wv+RgE9lGA==
X-Received: by 2002:a05:6214:4108:b0:704:a817:41b2 with SMTP id 6a1803df08f44-704f6b59d96mr305168646d6.42.1753160898366;
        Mon, 21 Jul 2025 22:08:18 -0700 (PDT)
Received: from [172.17.0.2] ([172.172.153.33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051b907ac8sm48251996d6.37.2025.07.21.22.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 22:08:18 -0700 (PDT)
Message-ID: <687f1cc2.050a0220.10ffe0.eb35@mx.google.com>
Date: Mon, 21 Jul 2025 22:08:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7649492287897224904=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: [BlueZ,bluez] bap: Add NULL check for stream in iso_bcast_confirm_cb()
In-Reply-To: <20250722-bap_crash-v1-1-35ae54484d29@amlogic.com>
References: <20250722-bap_crash-v1-1-35ae54484d29@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7649492287897224904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=984529

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      20.32 seconds
BluezMake                     PASS      2678.12 seconds
MakeCheck                     PASS      21.95 seconds
MakeDistcheck                 PASS      185.84 seconds
CheckValgrind                 PASS      236.28 seconds
CheckSmatch                   PASS      311.08 seconds
bluezmakeextell               PASS      128.42 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      920.09 seconds

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


--===============7649492287897224904==--
