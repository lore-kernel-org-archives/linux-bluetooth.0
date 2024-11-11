Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6940155A34
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731335717; cv=none; b=MnSFFRZRNa7z2PxwmjRuVduk3l1U5TQCRxdbCPbUoiXSOQCEN1ConGgVV8/CbkLhL1hEAVZ5puYmS7PYUFgsqbR0c9diJUvFZINGacPUBljcxP5d8XNjpa9f1HeptoR6iGJlCW0qx6Y4V0Iix2ZXsjjfmMfqCMBnjc5oaPyw1Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731335717; c=relaxed/simple;
	bh=2w+U+7OCOnkRQJkVuCf+70StlTs6GwUtdusw4Vg4TB4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nEGMNzFm+WYMmQpWvkmyFZmLE2bZTMqnyLvuURFpysKscGaMfOnEshGyy5mFGt4azLH/dE53Vi75LJnb3491RcR1oty88XQQJmZuySX4cl3Ey0VyBcYZVcgan7w5v7yTcDu6yuQxCiHL931SudjOgfqZ9xTl2g6j/6ql2DDhHro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SXPYweN+; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXPYweN+"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b1539faa0bso296341485a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 06:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731335714; x=1731940514; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=smAkrdVypE5eLUU1Jhn37Rn0L9RRaFaqUbxrHeyugVQ=;
        b=SXPYweN+c/2wtjSbnMokPjjhjCakWiH37atPmKerHGidwtqb0IKSK/KlbX/wVlCgzI
         /vhD9hikrnMskWmulmfypQEE5xdB8z0OaIz4aNGVLKq7svGPlpHnO3QTFp4P9tv68xlp
         oqsEPbBJPRuelhvXG9Jow32O35r5CO5l6GEWguI5bwjF7xESdjOhUm0KzfoKZiZdQ0hT
         DXwVk9wbpz+Vc9UadVNzYXXi6UgSLjKWFpgBXXblFFuUB3U4KPAtNaVelLV/SeInvL5V
         h4wXP8eU728AYfmKUfySQLJzSjCeJTLloEHL6DhZqD85qsNEEyGeeX4AGhnueBTRMVjy
         f/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731335714; x=1731940514;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=smAkrdVypE5eLUU1Jhn37Rn0L9RRaFaqUbxrHeyugVQ=;
        b=FTqNvriS7Ngz+79S8gFRoewgNkvwJWVB4JSqLW69mWw3fqFJB28UtYHiKcisjHk4sG
         RNddV6owUXgC6r7FX1i8U9cIfe77qmJ/DGsfztT4xgegsHhUZIyBbOsQWQKJbpnGLf5/
         /bSAyLvwZbsppaZM4amlX2aFYDdfal0+PW9/bzBvrQRND4Iu77DB0zuIBhIs5AVf/8YV
         894pJDD3sEliTAdSru65xn6fQydlZ3OlQ1DRCo8ofXdcHClKkXj48EGIUn5SctVt0xqP
         eUrLGgxeLTzTXfNenQuxF27WzJX5f0QRuW8Q2cxE0rxXWUqWrcJ0Cocqauu5nSKZHs5+
         Mx5Q==
X-Gm-Message-State: AOJu0YxhP08zgYD8P0yA2JpCAvlIAm57XEy7mEhj+OPY3i/+SY2A1ks3
	1z14ep+YhHs9LQMN5iEUvbI6UcJOYcnhkQCRL4oXiECuTP0YL1XcYYRbkw==
X-Google-Smtp-Source: AGHT+IGWkPjFLTaXEjwphr2+0h4UPHf5MVWyZsCGIMxXUz4V8nvQPwc7JyLciKRDqDii+f1WmyZNPw==
X-Received: by 2002:a05:620a:1aa0:b0:7b1:11ac:627a with SMTP id af79cd13be357-7b331d8c831mr1874513485a.25.1731335714543;
        Mon, 11 Nov 2024 06:35:14 -0800 (PST)
Received: from [172.17.0.2] ([20.55.15.35])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac44082sm499033185a.38.2024.11.11.06.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 06:35:14 -0800 (PST)
Message-ID: <67321622.050a0220.176322.cb81@mx.google.com>
Date: Mon, 11 Nov 2024 06:35:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5351318749074414447=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_amisjain@quicinc.com
Subject: RE: [v1] obex: Check for supported features bit value for legacy server
In-Reply-To: <20241111123125.2034898-1-quic_amisjain@quicinc.com>
References: <20241111123125.2034898-1-quic_amisjain@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5351318749074414447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=908391

---Test result---

Test Summary:
CheckPatch                    PASS      0.44 seconds
GitLint                       PASS      0.41 seconds
BuildEll                      PASS      24.74 seconds
BluezMake                     PASS      1800.88 seconds
MakeCheck                     PASS      13.58 seconds
MakeDistcheck                 PASS      188.59 seconds
CheckValgrind                 PASS      262.96 seconds
CheckSmatch                   PASS      371.16 seconds
bluezmakeextell               PASS      125.55 seconds
IncrementalBuild              PASS      1695.02 seconds
ScanBuild                     PASS      1078.32 seconds



---
Regards,
Linux Bluetooth


--===============5351318749074414447==--
