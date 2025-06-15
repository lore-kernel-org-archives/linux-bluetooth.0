Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3CE29A2
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Jun 2025 00:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749947184; cv=none; b=r8IqZVo3v6OAVzwwzd7TAFdXW+GimVH0N77oh/hkbjmbYuUAmil7eExWRM5EtUctJj8OaNwCxAV3tmS8sGX8YG97enM1bYZqI2qTLNLT2O54crJB2pkDPfczopU9FT66uclgzShweD2If0AcjC4nDiJB3t3QG9vIvCUoxM1Z6Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749947184; c=relaxed/simple;
	bh=ESObMxVftrHieXyfCKj3rJ/7gE5Lk6g4EsY6SjMlfdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtllIwGuBfWePCwlAnzkDlFV5iyXXbmU86uILDkHNA3hlS2Zs0RK4l7SwrGWSMJfqY0+y2D4bIUBaSCzZajG/hGpQP7iZt3trD2cJ5+P431m032+py9u6T3HmlcT4emgTKggNzrAvKC2C9Hc8s5xLM7pLedw7SwnbjpuNa4Bf7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LK/IDGo0; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LK/IDGo0"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b2fc93728b2so2687672a12.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Jun 2025 17:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749947183; x=1750551983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNbZafM6+TPbhOW2ly9rnLgXwZbFmo2u0bYi6CSGCcM=;
        b=LK/IDGo09jZ9uuAQsnAB/9TbhphlLg/faaaRrBSoZ+3B4mn+qSFVXq9FyRHXeTtdzx
         /PAKbnBz6YPGXQgf81JaZ0WuWtw2LcY0R5DV4ibvZdvyeFvwzIJiEKL9YSozJ7wHBabw
         z1DrEBMUefVHroCxEyFquuwwKyF9mVRSCzVRfC1qxdRE0icpUbocivYMOjTmtlX0T7Yp
         5vcfwVmdVM49eHDyPnFfEm/Exo/xPm3HCOUpEq4f4JwtsBsWMlYCNctgLn0ieFr4RdX1
         VGD6vprvcKR400eNvtrL6Qc8HedIVDRp+YPa3Ml4nSgOCbNfTqzd4zVTUxLb8eE5Ekoh
         6knA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749947183; x=1750551983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNbZafM6+TPbhOW2ly9rnLgXwZbFmo2u0bYi6CSGCcM=;
        b=LbDj55HIGVUqEwNlQGI+/JVbxERopfQ9NcbjR3HluojscG+sLEz2FiqWd4xThftGJb
         c9WejJZanvwYwIlCx5KRuNdNUCI9cRpy3xql4NiCYoIVAmcDNgtAvUAOjlksp1/06OA5
         2p7rasVM/WMmkElD41TeglsLOQxbB1B8Yd7xjG1gZKaDKYAH7192kPsN+90CJxFRH8Bd
         AAcDy3MNqHgM1wbctG4Ldm5IRqdFPXqcwmKfIABj2L/oyD49MoKBesWa2TfFwNOtKUfV
         ZB7CSMnT2ptV6aJX/Z3KzPSFtij9KZq/esqFGmjp4+gHRCtB0i1WgVcr7iiox9wl38jR
         uNOw==
X-Forwarded-Encrypted: i=1; AJvYcCXql14jYBp885/V2cJ3eKIKDAJdsMxs2E3YJvarH5mQXX1bwpplRWYjcgmJDO/nXhDNLbnnVOLJAJBD7NDNgO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdsPyqSciunsCoDGfCdvb3xds6r5qksR3UBDaGEXj0+VtSnpQt
	Vcc6DY+aq52Mb+YqGiNd9GmBd5mgbVYzXpUHp9rWvnsAotfAh/43oHv5/EPjR3xzSHt9
X-Gm-Gg: ASbGnctwglzmZ2W6nwoqEZiJGl/PoLDrNvK79hEc4xtp//FQsfsqKfkWoPafRpSInjL
	h/upSB+zkHkFHpcQ87csm3Cnwn1NjvejdFLb9uJjZ0WXt7MnTDD2zbOsrHko6oadM7oHfsWHfCC
	0f8CbqlCeIbjE/gabMIXCqsT9ZG9fSClhR9I/x+D6VECfPbWkJ37iy5OMq5urF9caVSOwD9hNP6
	y4JFb9kv3rm6wqJmzXkzRPVtDXATnsrP1EVGJyCVPhvip3+Rm2NxIyfdH1M8CeO7/+J1grDHVFR
	5OdtPp29UbUh7kn/fbPz/60UFbPBjN3zbTufEhY=
X-Google-Smtp-Source: AGHT+IGzmEbBFJRMpBPSEkfdIg4idVD5a+7AwJe5xam1f97w3YO99O73I0bzOtYqTtD3yDMIonXI1Q==
X-Received: by 2002:a17:90b:3b4e:b0:312:e618:bd53 with SMTP id 98e67ed59e1d1-313f1ce2b77mr5589509a91.26.1749947182573;
        Sat, 14 Jun 2025 17:26:22 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de7839dsm35790255ad.127.2025.06.14.17.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 17:26:22 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: pav@iki.fi
Cc: bluez.test.bot@gmail.com,
	kuni1840@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: Re: [v1] bluetooth: hci_core: Fix use-after-free in vhci_flush().
Date: Sat, 14 Jun 2025 17:26:01 -0700
Message-ID: <20250615002620.2343407-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <6d9fd112f73fd56511318a0bc8f9681f7348de27.camel@iki.fi>
References: <6d9fd112f73fd56511318a0bc8f9681f7348de27.camel@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pauli Virtanen <pav@iki.fi>
Date: Sat, 14 Jun 2025 14:30:18 +0300
> pe, 2025-06-13 kello 19:20 -0700, Kuniyuki Iwashima kirjoitti:
> 
> [clip]
> > > ##############################
> > > Test: TestRunner_mesh-tester - FAIL
> > > Desc: Run mesh-tester with test-runner
> > > Output:
> > > BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76b/0x7d0
> > > WARNING: CPU: 0 PID: 68 at kernel/workqueue.c:2257 __queue_work+0x93e/0xba0
> > > Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0
> > 
> > It seems the same splat can be seen on other patches.
> > https://lore.kernel.org/linux-bluetooth/?q=KASAN+run_timer_softirq
> > 
> > Is this a known issue, or are we all making the same mistake ?
> > If latter, can I get the full splat 
> 
> https://github.com/BluezTestBot/bluetooth-next/pull/2887/checks
> 
> But probably it's an existing issue.

I agree this is a separate issue.

To me, disable_work_sync(&hdev->rx_work) in hci_unregister_dev()
is doing the proper synchronisation between the work, so it might
be a problem in the workqueue code.


> 
> > and some guidance to run
> > the same test locally (if it's easy to set up) ?
> 
> Please see
> https://github.com/bluez/bluez/blob/master/doc/test-runner.rst#examples
> 
> I does not reproduce locally for me however.

Thanks!
