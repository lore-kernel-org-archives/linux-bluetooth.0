Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D451B78F3
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 00:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792023457; cv=none; b=pNBGcr0RSim/1bYJHnI5bfRt9Lj1PRCvoLANyoWBskUvNg2JpGtozeCNWr+T7736jcIzbplfI4009Cy4RgHhaqQCCjWr/VAUXocvyfuTFXMWvaOaEpVX5aXUxXtcyidxdyAZ+wH8/tJEiIovsbKE2Na7iwQ6GLWWSrZPSkXpxME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792023457; c=relaxed/simple;
	bh=VO8mOYTwTaCZJAv73JCflb3eZv5BKNxm29MMxxE5dvc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mu6UezLyXkGmxcaIm+bHiodrEvogsdpL5WinIfU0WXvEzit22Wo3wLpWK8iqEtfj08fLQ9mbtcM9p2UKmayxxT4ykVL9J+UvTCDByaAl69g1w3eV4RMJY61/taScOdNTg1uamAAEw6J+pXVGTqSGQN4rYic1YPyLqbDev4SReU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jh8b4T13; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jh8b4T13"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-917d595138fso6138886d6.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 17:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792023455; x=1792628255; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8Y5fTNhZxvDbFuq1GKsAQQBTZNpzS055boeLKvE1plw=;
        b=Jh8b4T13jWJm0MsUt7dc2RnT0x2rbOG10ZmkD1D++y7UFYkrKysHzD/Kh6eA7//Eee
         g0lIS+hLjO+ODwKGypVTbngUK+lpvM1ORdK+quPckdxHT9KmhOIWDN81k+0pkfo4ab18
         iH0lvlKTpev3G3yF0LsyBR0Lman7Msk44AmUt36W6F+xgC3S1xOMEmktNLKL56Xnqe68
         pI/6qtbx9SrEDIIxZ8wcint6YY2gPT1RHZEdooB/M0WUpPTmsUcJiyhmF6o1Xjj6pvPx
         QLuEqeIuTHFb+mgtGgfB70Wm/Z5E91lMm8evVe3UPVmxLzN6ZnxoZqCdp43d4JBZtkJD
         Ibag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792023455; x=1792628255;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8Y5fTNhZxvDbFuq1GKsAQQBTZNpzS055boeLKvE1plw=;
        b=HU3N9pfXa68evpaK8T2Uo9MAwO1BRV/3x1saBZkkE9H3pWEL2yE6PG8rUF+DWajpuS
         7bbCNLhivq6XM/jTtsZQDQI1RgFCoicJltn8+6vfv935JOF+OHvLjvlf+Svepewyyc5C
         RYRubcq5koxfjVn8Uyxbl5wB7TDP5ISn2gdQLpgHXfhxWaLXBWQt6ze2y3SMsPqrguxP
         0XqFXqmtJ8SicZSOJcWWlYVPlCkgadKwj6YwedErVYOQSEt16krP914CqeY2CpZ41AhO
         /Jiw/k54piHKqzbHPLJMnF0ozpVDppIBshTtnKWOfSDd55oeavRVLPLIgT3mVq/PoAk3
         R3mw==
X-Gm-Message-State: AFq9FYIn/Ta4+cIGdPSM8Jfrs0CJAkVX4Lbas9NJaWvOR5x/XxqKdEx6
	AXmzSxNl5J44b4Dd/1yUDZXGblzX8dDsDe5/J2wXbbISVk5b4Z65SVT+0P9jhg==
X-Gm-Gg: AYBFou06hteBJ3tZkGYbz/GQBaf0QyOBF/laxYIk11r3TFL7sGW57JqO5kfgtTKM39w
	vMKs0SKN+33GHNn07syLWbj0txlrRuqJznaygtdNu/hD88PDz3DX0pvnTh9n0ROehC25ummxJZc
	rTCYYyi4r/ELeDM8c7ESbxFETyG5nHJpaim94YBdrJdlYRnOTOTSTjAMncUAXi9Ny0P3Tzts6hI
	uu3Cv+BcgwlzensP93nLKWGr6AtXKyC2GQDKFawfevSVdvFQLUzudUBLfOS2YOVZgl3MbMfVxDc
	sQJC4XXJr9cppTTs3LC+JEKr6pvCxzy+snEUjQWgrMk1tzeS+Bwj5DyH31qzFeSgswSGRArpgEg
	KItXLkbFewDcq9YnEolprbRF2b5ZC8xSJSeJUpbb3ZrzZlYnpI6QaUJwFjz45F4f3jmDpvv5N5e
	jdaN77CCVFEH7DsC30zY2efJpHYGFgVRdJ/idtIr/5sqJLN0hO9AD2wtOeOgN0uQQ+Co29OuKaq
	QtTTBI=
X-Received: by 2002:a05:6214:c89:b0:917:a304:e059 with SMTP id 6a1803df08f44-91b5553e763mr302456946d6.25.1792023455236;
        Wed, 14 Oct 2026 17:17:35 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.93.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97bce15csm66963816d6.35.2026.10.14.17.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 17:17:34 -0700 (PDT)
Message-ID: <6ad01b9e.8db45b81.16fb1b.4c12@mx.google.com>
Date: Wed, 14 Oct 2026 17:17:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5639927055398754599=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kevin@simpleble.org
Subject: RE: Bluetooth: hci_event: Clear explicit connect state on LE connection
In-Reply-To: <20261014224145.10801-1-kevin@simpleble.org>
References: <20261014224145.10801-1-kevin@simpleble.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5639927055398754599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1185966/

---Test result---

Test Summary:
CheckPatch                    PASS      1.47 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      29.66 seconds
CheckAllWarning               PASS      34.33 seconds
CheckSparse                   WARNING   46.77 seconds
BuildKernel32                 PASS      30.31 seconds
CheckKernelLLVM               PASS      34.30 seconds
TestRunnerSetup               PASS      723.49 seconds
TestRunner_l2cap-tester       PASS      12.87 seconds
TestRunner_iso-tester         PASS      10.86 seconds
TestRunner_bnep-tester        PASS      3.11 seconds
TestRunner_mgmt-tester        PASS      87.91 seconds
TestRunner_rfcomm-tester      PASS      4.48 seconds
TestRunner_sco-tester         PASS      6.17 seconds
TestRunner_ioctl-tester       PASS      4.64 seconds
TestRunner_mesh-tester        PASS      5.51 seconds
TestRunner_smp-tester         PASS      4.36 seconds
TestRunner_userchan-tester    PASS      3.21 seconds
TestRunner_6lowpan-tester     PASS      4.92 seconds
IncrementalBuild              PASS      28.32 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


https://github.com/bluez/bluetooth-next/pull/939

---
Regards,
Linux Bluetooth


--===============5639927055398754599==--
