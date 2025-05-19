Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86F1289354
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747677413; cv=none; b=UjElgJTR97Nh7hCBrrADXrgiEakB+LWeTEKRnNe98eNSIR3H3ox7WwEMXf4RxdverZcmTyF6F6eDMBkPK6/Lrij2d8mtHWVL3lgmLfVmAmkmBc07NWRBqRu9QcCeOTzwDYJAcfwqOwYep8Y3WSQbGRDNpfURjAYKyKIcppgXVTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747677413; c=relaxed/simple;
	bh=32squJ5PEv9c6qmZBFP+NX2KEGpigSIJqTVZEX7zvnw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Y0kO0qW5h1G5R5EQ1KsBXcs1Su9O+9pMzROTj5LGvPTB14P+cpuFAt6Iwl4WfN3KBoPKc72Twmc0VTkke2Vsf1951Bmo12i1U11Pcl4a7GLqfVKhcW6711Kw8dhTQMGDbmnXKnW5WvkWCTwrdIEn7gBB7cJG6lfiuFSpZnCipyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b22Fa13i; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b22Fa13i"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b26df8f44e6so4480073a12.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 May 2025 10:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747677410; x=1748282210; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IQckObPSmCwxfl4Kc9m1L0E+HkUXmushiHmsoNTfHbg=;
        b=b22Fa13iN27WhIRsSFA6SJPZbpK8HgGdA/MGs10aGAlybYefouTty2KybmviMYzQQx
         SQDBx/d6PIwxnYmIbOqlk7N1LfJY2AYj0YBziIrmkhLcMGyLuYFMrbTTN59kcxF+FZnY
         fhFPbn2BWyOjGKF04mKHaAyor+pI0NFk2DPSix/AUXE+uFciQzGVu6riw3ccPmlXVoDf
         5OAv4ReMPZk298iDhDLOTrCymosapBpFwkZ/pgzLtNeBBP+7J+HDHFw6DXfn1syWXGGO
         3IX7S5EkaKb7/2LMlv3+h6YGoKFmK6e08lSq8oU6o++pHXhc+mMgCcor0k50xN4Z5Xim
         ePDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747677410; x=1748282210;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQckObPSmCwxfl4Kc9m1L0E+HkUXmushiHmsoNTfHbg=;
        b=Y05Qi4bLbNBmkJOk1nOi0/wyciPNBNXoKRTFL278c+kyNero/hmp0CfflHPglbrMWb
         Xfn2Zdby5qH1OLS4EMKcxFI8S89tl+vlGtV/Hx1WudV3THkIBmR81kCj0SNRO7ufz08j
         QbMLz9FChw/jX/z0uqJNdmtAHq+FN2QAmTePAQWA+AzuHL/SwdZKYlgyptY1FBe78jf8
         syIHKg48MUqpHAmNqZQ4WSyatFL+hArMkilhsbeR3gQML4J0+TkVyReps+DQwvA22Tw/
         YcojRvFTFMcUDl2hMXIdjunYwD5AWzVmw/fqV7nYzdLyl00C4+LI0t0V2/a4jaN8S9Q1
         bm9w==
X-Gm-Message-State: AOJu0Yxt15dZdB1Ewz51YepZFfKt/XnFbJIQBxdbPZLvHvaoRQup5dW+
	0HDhJ+lKndHQteBxuhGbTr6+TobIDJP08RGG88lOhylp7tkEJ3GiFOVkHNrRPg==
X-Gm-Gg: ASbGncvcC1X1RIYaoOB9xKw+cRn0cUQtVcfGZZ2VHSFlPvbROxdWJwRn+y+0toNzqPy
	oYz72VAxpcBt5VrKhxiWS3UGjhOB4dK7ce5Xe5064rk6e1YQ2usxOoIL6p5L74usSWEV6j4odSV
	VhTR3RwFKSs0pl8I0WtdKmD69MnJrYlhqM66XEEXaVCqn/R3jQl0zVy/BzPxO0zXpKHbx1JFxDc
	OoTlXbJB0hy1tGx/L2b05XAJslzCSg1CyTYbK32X3w4FUskqW0hTrNda2WhhKgpxCHtAIRZ/ki+
	uWN2UWR61sRQcTPK6w/zGMXI0Ep/gr7jY/rZnV/DGdpgnO/dL7U0AXMJ
X-Google-Smtp-Source: AGHT+IEy59fUHHTfCi1c3eZeoKKQ8cNA7C2CV/zPBMqQk6D4dYWuEib+UNXbX9tOHN/gE3TTP45OgQ==
X-Received: by 2002:a17:903:25ca:b0:231:f5a8:173a with SMTP id d9443c01a7336-231f5a81b85mr117002615ad.51.1747677410507;
        Mon, 19 May 2025 10:56:50 -0700 (PDT)
Received: from [172.17.0.2] ([57.154.42.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e988c3sm62947275ad.120.2025.05.19.10.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 10:56:50 -0700 (PDT)
Message-ID: <682b70e2.170a0220.145166.ae5a@mx.google.com>
Date: Mon, 19 May 2025 10:56:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3159307958736334654=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: Propagate disconnection reason
In-Reply-To: <20250519161412.107904-2-frederic.danis@collabora.com>
References: <20250519161412.107904-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3159307958736334654==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=964261

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.33 seconds
BuildEll                      PASS      19.99 seconds
BluezMake                     PASS      2726.44 seconds
MakeCheck                     PASS      20.36 seconds
MakeDistcheck                 PASS      197.77 seconds
CheckValgrind                 PASS      272.16 seconds
CheckSmatch                   PASS      297.58 seconds
bluezmakeextell               PASS      126.66 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      899.13 seconds

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


--===============3159307958736334654==--
