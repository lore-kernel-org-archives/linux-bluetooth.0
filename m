Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664F72C694
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 Aug 2024 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722767653; cv=none; b=K/BYhB9DwrHwVTXtTaK+A85NypY9xmwpqilRwE6MXhWgWVsUa2spvpQen4CEdrtXtWbDoCZjyAK2CfUS1+gVhz3qejUt0Gy1Jo2DnFVf21RU1oKyJmSJRHZToyouAVegm0rmDURYwUMwyo0XcOu6SVQu4vgqjWlQD8CVCus/CF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722767653; c=relaxed/simple;
	bh=4xnPb5xRkLktK08INjVDMRC0SOyZU3dmwmty5/9UaqQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AGlMqcZCyvnGciZrjvTqoJ/yLAtT58yJ7XifgBcB4q6Gm0uR77yjMjaRk8qrDKbZmg7NfE4F7IRFqdH83Hr7FIh2mfrgWV6yvIcEgIrAqwLR2fJy2e4LjOAS2uCObcIOnc6NxiPw3mzJ6LU6VuhMKAjQ6NSjnBU1LxC9ALSJYEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1Ml0ALB; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1Ml0ALB"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b79c27dd01so53606496d6.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 04 Aug 2024 03:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722767651; x=1723372451; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dmWDreuE3aQei1gnXoN3pmLI5phd1LrBNZAcv1Rk/0A=;
        b=i1Ml0ALBAGMDLqRZ1Cz7SgpAb53/9+RXEoIIo6s/WUl1OHdX9c7t2j+X3AaOFV8NIz
         Y7+1CbPAAdchSe/QyVFM6xPjpL36cuhFyZAHGND4Xn2WdPh/LDIEeuk9FsflO+Zu6ZIp
         lCLlE77YKJ0R+AlhGCgfhqIkA/XrsgvK7gDr+Z+aowKFp/gnNfLUZVz7y1ofKlHSjqx2
         A5HXLAeyPJEu84b0urYTYcPjTL8ANRQTK993hm2nS0xmTlLTEWTaa/n9bd8fYZjok1Er
         oBa/p6swJsdAxZRO7ex/CB4MqX0C4wk8fjCKB3lvs4h25FW6cZqQjcflTlmIUhklmDJ+
         Cl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722767651; x=1723372451;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dmWDreuE3aQei1gnXoN3pmLI5phd1LrBNZAcv1Rk/0A=;
        b=Ul+CC0NCUYsUOHxbONbjVRwqbJ2m+xhSf1vwBERUc+NP4mRECKNwdLNDHVKEZxDbCz
         e+XsQfuhqHOoiYtCLCVXyC9uhe/ZxW+sEonPu+8yxi6cbNxyFlylHPSMPj+sTN6Ldu53
         CL0TiOIvXurz6HdUbIFeiEkK6BIP6leb8vm/tJFA2A7w0yMW1jU59HcQ72sTBjv2m8tS
         GhdQF3fIcj/u1UZMZRnIyH2Ax2XNZF13NEc2mXnB/MuO0EmJJCh2KzIRYXbwdchViN3M
         ItgzLYl3yYbrSNWDy1cQ9chGqwrmOr3c5FP13WLaIGzYZC8IH1QgqcIIUhqTOxZHHwWQ
         CLAA==
X-Gm-Message-State: AOJu0YwbTYBHBjUi5/Sc6q7bw7yi32hAqtokdxGnN8nUbrWmhLtDj+2L
	RUgArpdl/oUNkKq8yuPykFVRwyimFzehMiRNA1nHTrm8ewaN9hwqbbQWcg==
X-Google-Smtp-Source: AGHT+IHOfi4dkBu1Ku/JdDstRJzoux7Y3O3g6ijlKTPOTi2gtDXK31UROInkS8eK9a2olNPpTiEjbw==
X-Received: by 2002:a05:6214:4a02:b0:6b7:9fe3:b2be with SMTP id 6a1803df08f44-6bb984351a0mr123820146d6.53.1722767651166;
        Sun, 04 Aug 2024 03:34:11 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.59.177])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c7977cbsm24719966d6.43.2024.08.04.03.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 03:34:11 -0700 (PDT)
Message-ID: <66af5923.050a0220.aa867.7a1b@mx.google.com>
Date: Sun, 04 Aug 2024 03:34:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7710286984288949316=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kernel-2024-q3@nuclearsunshine.com
Subject: RE: [v2,1/1] Bluetooth: btusb: add 13d3/3608 VID/PID for MT7925
In-Reply-To: <53ccc7377341b64ff3fbdde3df28cbd14f245340.camel@nuclearsunshine.com>
References: <53ccc7377341b64ff3fbdde3df28cbd14f245340.camel@nuclearsunshine.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7710286984288949316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=876499

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
GitLint                       PASS      0.42 seconds
SubjectPrefix                 PASS      0.21 seconds
BuildKernel                   PASS      30.79 seconds
CheckAllWarning               PASS      32.85 seconds
CheckSparse                   PASS      38.28 seconds
CheckSmatch                   PASS      103.35 seconds
BuildKernel32                 PASS      29.16 seconds
TestRunnerSetup               PASS      527.71 seconds
TestRunner_l2cap-tester       PASS      23.63 seconds
TestRunner_iso-tester         PASS      32.55 seconds
TestRunner_bnep-tester        PASS      4.77 seconds
TestRunner_mgmt-tester        PASS      120.77 seconds
TestRunner_rfcomm-tester      PASS      7.32 seconds
TestRunner_sco-tester         PASS      14.95 seconds
TestRunner_ioctl-tester       PASS      8.07 seconds
TestRunner_mesh-tester        PASS      5.88 seconds
TestRunner_smp-tester         PASS      6.85 seconds
TestRunner_userchan-tester    PASS      4.93 seconds
IncrementalBuild              PASS      27.48 seconds



---
Regards,
Linux Bluetooth


--===============7710286984288949316==--
