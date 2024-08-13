Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A5B199245
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Aug 2024 15:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723563328; cv=none; b=trGqcX7W3Mws160RkRdNPEqnMl5IKhp+r1oEEkNUD9BCetRpr30TIUncV7gRsaKjPQ3DVhTqnQoaomqSoUAGXrJC+ANdDIUOIDByHOGBUmdnHvPVnj4IF64sfuVlWGDKhmjlO4JN3zPD8NHhjY9p+w8bAlYBJC3EuSBjYNuYopI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723563328; c=relaxed/simple;
	bh=f1Wd8sTXMr5v0VmHSUwyKeMkr767j7H9qWg8p2xIfyw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BRBJoSM0zLi+34mbjpG03KAflc4qbMHtu5NKkiWtOrBTgkmHjMw70LV+c2+eHeniXjGqx9yREXNslWVOUiiitXvkZ1LnEZJE3HziuJrQrMlrIu/hUZJLjErve7Oaw9VpzduvCMO5GMwxg8JU/IvEztY5wvLW/1uNTVGBEETIj+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzWBT9vG; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzWBT9vG"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6bb84ac8facso27671776d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Aug 2024 08:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723563325; x=1724168125; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mluezBKl9OxNHv4WtoIfJsiAnL32H2OHfHNb2TCpD2U=;
        b=fzWBT9vGBoifKvIkeeTkPDtCacfWFQ+25o2NxesmCuJfaBdcC03IP4Ngssncbb6pAp
         cjTLqbhg0bb9pQT+snmnCWOHhXQ6wr7ep4nLBNodsduD6ONb7S/IIQJLkEswmTB3mlh2
         BzR7dT4w+ICyYEcYr32uIjdYbhQ8LpBJYPl27t/oRkDB8bH+s3ZFy1nDXnChGsmGNhHT
         x4ugcOtNqqA0/zTGMxDqlmhUROrRJbin66aL1iNK12JhgO/3VMuXXWtwiYqoLLZdxP0J
         HcFts3eAWranA460iXJ2SvM7mIhVvEnIaJxCAvgvWWUBDCO0uTz0GkyfJZPaJSp1Mi2I
         c5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723563325; x=1724168125;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mluezBKl9OxNHv4WtoIfJsiAnL32H2OHfHNb2TCpD2U=;
        b=ZMc6SEStH+CYGMac+3dJYxI41G7up3Mn9ragbCWPMRmRNL0XoSNwas/TaHzDd/+kWB
         yCB8meSDfYQAmUbU1PSYIW/fY0Z7fhGb2Ze6losoHIqefuoNjb4gy7ibFtUDeD1Y7zYS
         EiqlzuwyhpKjG1sm6H0Wm4HIRGzAoahLmsHqxTrm/RH76HRuQ48PHKlSGRzGXz3ndHWQ
         wdWhkIn7m/rwo42ZVSewsDpp0n0a/hXjB1JQddrceZbYrnloJ8Z342KbB9w8ET+3bQK7
         Xgwx6o8LD2KFJ6XARP3zOhcjNFfrWeoGeXDWgvXX/n+RvnztCkknQsE3Ru6cuou+EPRQ
         lTug==
X-Gm-Message-State: AOJu0YzzYH9Fkl1FtgwjGxiGqxnNH2bMd8A+hblju9k5zkfWcR1p/3Vd
	FOYtpKrmqKJqeHiJtr9foXYykKmbZ6M+IDaHGlHW7VnnM+9QuOHnM1zmPw==
X-Google-Smtp-Source: AGHT+IEgysy+zXFEzPeRf0wLSWXbDuy/gpWyFYvPz63MjwSsxY7Cvb6/nsx/GPkix6va1XPdz/G2WQ==
X-Received: by 2002:a05:6214:2f8e:b0:6bb:9b66:f264 with SMTP id 6a1803df08f44-6bf4f443ecemr60393036d6.0.1723563325296;
        Tue, 13 Aug 2024 08:35:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.60.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82c5f36asm34846786d6.25.2024.08.13.08.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 08:35:25 -0700 (PDT)
Message-ID: <66bb7d3d.d40a0220.4d725.b2db@mx.google.com>
Date: Tue, 13 Aug 2024 08:35:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8281022004294523303=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RESEND,v2] Bluetooth: SMP: Fix assumption of Central always being Initiator
In-Reply-To: <20240813144559.529786-1-luiz.dentz@gmail.com>
References: <20240813144559.529786-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8281022004294523303==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=879268

---Test result---

Test Summary:
CheckPatch                    PASS      0.98 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      30.01 seconds
CheckAllWarning               PASS      32.02 seconds
CheckSparse                   PASS      37.51 seconds
CheckSmatch                   PASS      103.75 seconds
BuildKernel32                 PASS      28.69 seconds
TestRunnerSetup               PASS      528.11 seconds
TestRunner_l2cap-tester       PASS      19.98 seconds
TestRunner_iso-tester         PASS      34.86 seconds
TestRunner_bnep-tester        PASS      4.89 seconds
TestRunner_mgmt-tester        PASS      114.91 seconds
TestRunner_rfcomm-tester      PASS      7.49 seconds
TestRunner_sco-tester         PASS      15.19 seconds
TestRunner_ioctl-tester       PASS      7.91 seconds
TestRunner_mesh-tester        PASS      8.31 seconds
TestRunner_smp-tester         PASS      7.00 seconds
TestRunner_userchan-tester    PASS      5.07 seconds
IncrementalBuild              PASS      27.72 seconds



---
Regards,
Linux Bluetooth


--===============8281022004294523303==--
