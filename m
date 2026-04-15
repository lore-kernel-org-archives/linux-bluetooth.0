Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B37D1DE3B7
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 22:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291016; cv=none; b=rdYGA7SaMPPSC+XELz1Yb7eefG1xoQYCHyaJqF7W815OaR9d61k1/hchy/xNODFQ0PPzyRw7nZD5aL/58yLySVgJK4SkBpqLXnIWqThvnOfdDAVYv6ELF4PyzddTruko3frGbjzKsM0ubs4q6B6YY4a4HkF88BmuUSZ9TJC/GAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291016; c=relaxed/simple;
	bh=cnRuGdOY+4zk+wj8WjhdLFQdizAQlKcOa/AZeugb4i0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VAJlA744/cMC+jM3dLsNkcX0A//yQw7bagBLFbSmXjj8iBu+j00MAE3Vjsl7HEbkbDeABRloJubPh8Ki20aQr7SA1SCyQvr4EpFCaohYGhtiu0FRtGIU8DHlSWo694lvj3fmOeP5Luv4GbvgKBVsRIOYJRnuZc4IHKyFZXzthgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2AKPfOb; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2AKPfOb"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8d00cf835b7so885753285a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 15:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291014; x=1776895814; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nBjnbVOdsbMqZy5MNgG9tJH4I9ij6naGXLOfceN8zEc=;
        b=Q2AKPfObs9PhIheFY668YucQxbfL+e7oB4//wH7E4NS/S5DFF63NW8rjCuyjeIyb1F
         DbHRRmZcpl5amSOEUsKvTF2QkPZKoM+SiUcu7/x6nPA2dvB/7ZefQMh+ST7q1ZKHvfwH
         Qwb3QaxeaPdSfj4444NX46+wgltal3DVBU52uPnlCeNpzTab27Qwn9bbG3Bh9W0oEJoy
         A/39uEBzcdUHuWkfe36ozE3CWYs2VnNRnUsXM6m9+fZCWD0+mlNFf52OkMQS7Z2P21Zs
         HPXwlDfcIMLWSqqZDWsO90273KshX0xkKZNHJBSDZmLaW69W70BnfM0nN1efCNCImkMg
         5MFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291014; x=1776895814;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nBjnbVOdsbMqZy5MNgG9tJH4I9ij6naGXLOfceN8zEc=;
        b=hJU+kR2LI373fWWESqdlSK6Susx83Ow96DH47yYgQK31ZgHRPIkGsXTRqntyPUjmw/
         TwaHT91skenQ4Jnycz87UM8wn0RhRsPW+3X0dA+uzDx8QlYwYjh7/JxwubCUyhaZoN/H
         gz5DbXbEejQlQ4ETYIMYHXmwQN5YPGRpc34eAsK0BnLMEv5EG3bx4uVETwgLGwSGYgMK
         XSYCY9hPDSZnq/JbAedGoAIgkLJEszKI7/vhJHBle6zFNe6xZH52jB0J0gKn6NLCUH1v
         IwLHDuuCVWqTfKBL5W/YSKKsnP1N7seLPi9IcvI40n2ON8qJBe1y/+FlKk2EJJd9L36j
         lUgw==
X-Gm-Message-State: AOJu0YzvY7Kn5xwosoJXGZ93hqd+Az1TVcuheqFekhPomzgliLVFw8Yi
	Eq48w1ghudGBdC4XgSNOMPrkVgdqMpuhoiYJNLkpAiSMAU7rMLRxbVxR8SCYaQ==
X-Gm-Gg: AeBDietE1Dq+cVf9wxbfuZ+4r/zNOaXrREhBP3DmfhHZCj2Q+XwU0rnMvE9JUltmYr6
	ua8ROTCqehEmU6PFH4k+/TNUvbMD7RTaeLCL5D95xJEtY/RRTF3T55UHNaVkiDbowXUzlKNPUtO
	AsZWJ785O8G+N9zPgA4CPjKEH1jYAnAi+yi9Uo4q9HjooJRhLxIkx+X+3Ko44vp3bn6uAJhi2Rk
	JlbHOYuNvOf4pHwIvmvmCdrL5u9OXcxEm3a7WzTJr72M/k/0XvkE5ohhYxho7IhE4o8wBam75nd
	Z7tECOUBt9Iuhqj4+yozxjLNRqTOILdtsoY3/uhg2/Wyw5RdDNloN564YTtPMRhKEnz1dSaFNxT
	u8k6R9+FlLXKH3D9yecOtPxzG8GALO1SO41l3d7YEnMk093VAJS0SyLS4iImEzWOpxQoTxgUoEw
	i2POn+Dqq3Y/D8Gm0hMHd9f3JFVcuVqn+jvumTHGHLq78=
X-Received: by 2002:a05:620a:1790:b0:8d7:a2b3:3aa8 with SMTP id af79cd13be357-8ddccb282famr3406495285a.2.1776291014210;
        Wed, 15 Apr 2026 15:10:14 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.133.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4fae74060sm254290585a.4.2026.04.15.15.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:10:13 -0700 (PDT)
Message-ID: <69e00cc5.050a0220.3d0f62.f777@mx.google.com>
Date: Wed, 15 Apr 2026 15:10:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7899861708169316680=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/3] monitor: Add L2CAP channel details to analyze output
In-Reply-To: <20260415205818.594024-1-luiz.dentz@gmail.com>
References: <20260415205818.594024-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7899861708169316680==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1081747

---Test result---

Test Summary:
CheckPatch                    PASS      1.40 seconds
GitLint                       FAIL      1.61 seconds
BuildEll                      PASS      18.08 seconds
BluezMake                     PASS      673.13 seconds
MakeCheck                     PASS      18.27 seconds
MakeDistcheck                 PASS      227.65 seconds
CheckValgrind                 PASS      277.64 seconds
CheckSmatch                   PASS      317.95 seconds
bluezmakeextell               PASS      172.05 seconds
IncrementalBuild              PASS      705.73 seconds
ScanBuild                     PASS      957.94 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,2/3] monitor: Use wall-clock duration for throughput and add min/max speed

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (84>80): "[BlueZ,v1,2/3] monitor: Use wall-clock duration for throughput and add min/max speed"


https://github.com/bluez/bluez/pull/2042

---
Regards,
Linux Bluetooth


--===============7899861708169316680==--
