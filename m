Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1703A7D73
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 22:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787955375; cv=none; b=A+Nmm13kyFOlo/jkShA7EZZnjD08rVSQjrNMw+Ossohqc7hS8LNhRXLJmIBF12Q+PZU/iVcpPQDWc4G/h6UQa46yk6zpu4Wq+UBCXGcYxcfUS1t7Hr3g9Flfz6baG3iMashE8dl6KPjHb8QUAMwt1ACxlZrp3aBNd5gGA4ENUAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787955375; c=relaxed/simple;
	bh=DtQzcALQHAaBv9lKdv+EJJbgEcvYYsg2RmGUo1HpROo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gDlz9Wtpp0bwzhRDL6UTkc5ipCoPEcYL2gQZ0JHMWl2pXaMsU9CQldjzUKACf3VpSSfCtmr1tZoXWCMZvqGLP3duLH+Kjz5xx9ny18lR+2V8C3h1SPLeFHlVvFe6OMveAjtzzRvyc6bGTA3yPmd3YJiw3C6ccYCQIRe9KofH0s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rlqbtbZP; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rlqbtbZP"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so1263291a91.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Aug 2026 15:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787955373; x=1788560173; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7UyiqNQHpgcgxMXhJurjw1p15fV7x5Nc4JL2vc+d9uo=;
        b=rlqbtbZPBifHdrauPi3CpdUeHm9aedP41sGbFil8Fdoyb85w0PbtY3M1h0a2SS4avU
         iVz6qXIAU/V5wxyJLnuNru30hTii59hXcMB8u0dtrAJKpyzZFqAni3bGxnZm2wMgy459
         2SGJ05Ssw+upC6wDhWNjnnrtp5RO16HfSX2ri3EV/sDRGa03EQlATLKYck+3wEt5/Yj2
         cHopfbDkGLBTVz/bbOvTVis9gTsf77xPdbfxFrI7TteMVSkyTkxs/kec9/LxrEgNyA+f
         JytV6Rh7j4l3Gjv9o23Eoio9UAxsOhNRIMb69tkzwlYiwvvNEKXCGAqoSzqzN9JFSlK5
         //VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787955373; x=1788560173;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7UyiqNQHpgcgxMXhJurjw1p15fV7x5Nc4JL2vc+d9uo=;
        b=XMxvTvquLZznUwK2YnNmBASFwZOfCECB2u4YO8wgb0vdGcisBXMB/YP5Q/DQVZkKdz
         xQ7dpbAHomQvSj5RSRKGc3eRbJyWCNY4X3ALomd6SaPICT3p6Bt/7GZ2pB8KUzV+MMka
         WwpFsqHr4NRCOvhsm4hssKHtpuiQGh8QejFzshcUFf7DqPGW0hsZ0P5V33eDjW1RgclQ
         mMUgNmcjCC++J8dapJVh+atoOYuYwq2ZIMZUa/ti1H83DQ65j3a6Ok2ySq+fOdFxvh9l
         wjAJMy32U1sPFe4u3Y+myq4HuPlQHyG5TKtISLS+Co/6fujP9Kq+vq8kbM4mM1eOYQ+A
         9UsA==
X-Gm-Message-State: AFuF++kuOQQOzlz3EmJ3PAVW+BYSmgvngO+tPiA9vXuEJ+zT0JciYv9/
	l8MES/nORi2AJ54N/Y+9LCZcd5zjLLRMoGmv/QpqCxLb4fZILMnLteoYgunDCqp3
X-Gm-Gg: AYBFou0uwjyozIC3sUpQbCjWRxEUr3FSUZGsYxpSvgV/eCLwR/gQoNFNz8SCvsn6XjD
	P6Gmku5P4pFruGy0OG053QIJ1ELm77+vNSV5HNT5CxsPYK+bcUW7Odqa/iVNtc+MqP+AmcNRiBQ
	cgTefhEWVxV2tbjlwq1zcJ+gWCYif9oFmOi8z1z84fwkrYzMvjbPKI75+nbIb8ckhcaJ5eeKGHw
	T34gfUCMxETJftg+vWtcyGo74wNPnAuCKCDJEDOswH+eXaKJmE/UwpHJFOjR0c9OQ4dYZW8JyUO
	iI0PzxjP30+MwHUcEPAJfGOA1UypNVUep7lw1dcqrT+uAWmE6pul3EY4hqkYtjLGecYVdGDrhTi
	1dqFOfHq6jvJIDX9zdpWIaCKi2mytJqqFYaU6bCRdEOEYan8827d7RTtOW/XEOUsZgSUXCWyu9d
	JmVCWEeyFNs0MDEfcgPZJ2z0cLBgd1OG6jXd5CYianXKn6Q3amMoh322GUs61rIyusr4Q=
X-Received: by 2002:a17:90b:1a8e:b0:396:4c63:7193 with SMTP id 98e67ed59e1d1-396d0fe45damr19255606a91.11.1787955372788;
        Fri, 28 Aug 2026 15:16:12 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.128.89])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-142e0d2e465sm14319370c88.4.2026.08.28.15.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 15:16:12 -0700 (PDT)
Message-ID: <6a9208ac.2915925c.3065f.784e@mx.google.com>
Date: Fri, 28 Aug 2026 15:16:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3171193324084033696=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, agenttimblog@gmail.com
Subject: RE: [BlueZ] client: Handle system bus setup failure
In-Reply-To: <20260828-master-v1-1-4810753bb693@gmail.com>
References: <20260828-master-v1-1-4810753bb693@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3171193324084033696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1153435

---Test result---

Test Summary:
CheckPatch                    PASS      0.31 seconds
GitLint                       FAIL      0.22 seconds
BuildEll                      PASS      20.71 seconds
BluezMake                     PASS      616.75 seconds
CheckSmatch                   PASS      319.17 seconds
bluezmakeextell               PASS      104.25 seconds
IncrementalBuild              PASS      608.04 seconds
ScanBuild                     PASS      1007.90 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ] client: Handle system bus setup failure

25: B2 Line has trailing whitespace: "--  "


https://github.com/bluez/bluez/pull/2449

---
Regards,
Linux Bluetooth


--===============3171193324084033696==--
