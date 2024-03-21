Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E8E8C0A
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Mar 2024 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711042868; cv=none; b=koFc2iuJr/qlXyBK2BKrR9WRxwBYy55OlDwzuoHJZzjvbrPV9lA7DPlM1v5jsUUmUlQXnZ3jY6Zpk5Vsc4mc1C33Y1pSS0HRgHrXsvAlnl4i1pbVQI5KRIy/mJQIA1dA+Ir06RF79WxV3mbrRfIs7DJLgB4xLsJW/WpwWkOMKqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711042868; c=relaxed/simple;
	bh=GbkKiLKecMqXaef3dwzM5BYmyJt+lU+Fv5mNU/2GbtQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bS3at0kuLyWpYE2elyWP39i7D8jyhQXFdjbU+DUl6uvlsOZ1G687cgZMVewfdx+LL7LxOkJZU/vQHIKrMIxvzTkXi2PubPuYXuul4PK2OTdmGxnIDglWgwsBjSPeEOniQQ6AppKsPFhnF313LGHaWlLo2PUB9wMjl6Bacxsrg4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3ePRu1/; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3ePRu1/"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a43329565cso323446eaf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Mar 2024 10:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711042866; x=1711647666; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XN6y2Lyj9CV21rBwmoeoiwMnwa6y0BT3NWSH9902q+A=;
        b=M3ePRu1/AYWaEZkv5jgSnNXKE2tamHLTXuolAcRkm+o7G8XmZxIo1oMK4+ouUfJw1p
         0UT/0QzQTHX1HsQjKOIP8OZqvmugdtRf/nmns1Ic4ih/ojMCp03qZOQ4ng7r/L70jd9X
         cttF/FBW3LAhfDHi8Rs4ep/kUF7V0vu3P7GlaV4HzSbLs1vXOHUdvOMtbapwbCNU/1Cr
         zczHdRPCNevsVJx0NEcKhCk3ncQT7C4+8DTVIIybuySDT9E/Wp49602YXc4VJ4fR2zsl
         jPS8EwC6WRv4IQn8ZGQtvC2QAmRLIFSAepp+ZhDerTbTA9ua3pSX42LQipskOl2o1kQn
         V8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711042866; x=1711647666;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XN6y2Lyj9CV21rBwmoeoiwMnwa6y0BT3NWSH9902q+A=;
        b=N5qDnkSzDWWcnzNPylM1JCFzvOuqU+ZDlUj1ikppp0Ul+kFdMdKc5L151gYY2Tzltz
         Yfjkb/tbwUpogVbP2x5Bbatp0RVKUx3iRZRUbpb5HeMGZlc9jShPDvsRTS8vs6cPemFC
         au9oVUf7kX6M3BtMzCRIgVItdYWeHV8Lz0IOJw8X2gqC/plXVJUy4bd2bZoO9P1A3ovw
         J44zRiglwQ62IUQWll1iSpz+CX504FLRovp7BZEcJlVwhNBgyrzSyTivWxrj5MONXGgI
         3ygSWSPSrrrQypLG6IGR3MQ+/BRdOqEAQiE+JEfCXH/nCm5jUFuz8Ls0M7PX6uMGgIvS
         ZY/A==
X-Gm-Message-State: AOJu0YyVKe8MJMruLhoHCCIW1aFpiEsgUXJ9oxDgRyv06dd9FfmrLrPL
	NPq27rgCNU1LwcQclgpK7D+zmuYoBLiZnSOBP8co2qn5xilJeMmWx0pWOW5g
X-Google-Smtp-Source: AGHT+IGPHFS8Wsp/hfJrAdgAS+NjJbS6HiCOWpnpuKXZyHUMRIUuAKS6nGrHbCSTBUYjSzQstjbriw==
X-Received: by 2002:a05:6870:658c:b0:221:45a1:b72a with SMTP id fp12-20020a056870658c00b0022145a1b72amr2947456oab.35.1711042866321;
        Thu, 21 Mar 2024 10:41:06 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.122.244])
        by smtp.gmail.com with ESMTPSA id r3-20020a0562140c8300b00690ff31fcd0sm104885qvr.79.2024.03.21.10.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 10:41:05 -0700 (PDT)
Message-ID: <65fc7131.050a0220.8bc3a.1d91@mx.google.com>
Date: Thu, 21 Mar 2024 10:41:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5265382510127126914=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Adjust SDU size based on the number of locations
In-Reply-To: <20240321161255.24892-2-silviu.barbulescu@nxp.com>
References: <20240321161255.24892-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5265382510127126914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=837099

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      23.81 seconds
BluezMake                     PASS      1576.90 seconds
MakeCheck                     PASS      13.59 seconds
MakeDistcheck                 PASS      174.09 seconds
CheckValgrind                 PASS      243.71 seconds
CheckSmatch                   PASS      344.82 seconds
bluezmakeextell               PASS      116.88 seconds
IncrementalBuild              PASS      1478.08 seconds
ScanBuild                     PASS      970.49 seconds



---
Regards,
Linux Bluetooth


--===============5265382510127126914==--
