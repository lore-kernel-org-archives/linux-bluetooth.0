Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80618265623
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788979; cv=none; b=ic7qN0UmabPeW9laeIYVyU759i2M21ikxk8J/mZ+DkgLNkCMNZKZbRWD3DEshvyGKX64jhA4Gqfj/DxNz7FmumUhCq1Rw898lZ+NLXDRYzgYllUlmiDHJdwkpP+ErUcYdkUxnM775clHra6VzICmHUxRs/cOhRNrd+eSjMRIEno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788979; c=relaxed/simple;
	bh=xsRwfh6saGpDm4vql3Bn4h4ZIDD4DWxjLYqSuXZoLLk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mPNEjqY3ilhsFPB4it0L3GYsPMzFI6rgMWQNwdWk/FmSFzrb9x3/V0Tzp0y1oK6kASdyertjzdFuITBUk4doCDIDTbYpwRASZ0+0Dmr8/5r+6QaAduc/ZHOKrHMMJQdbMA9sRzFFrxu9YOQLwOnpU/RqSAU+qoX+1C5FRYK9Hb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUyKKugY; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUyKKugY"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4b109921fe7so13175311cf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Aug 2025 08:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755788976; x=1756393776; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ab5BuStbETRbkDeAZnUXuQ/DgQ8ILKXnSWXLDpSHBxw=;
        b=FUyKKugYaCQOqJPVTskE6o3o6l1jmfWuW1AFv8zt+bSEBf+voMAumyMRuCet968OKj
         VAdYunWqOakOrvcoKH/a7faqZhOk7TSoU2cciJdsZlbKmWuasarmsgNYN0+6QlfuP0vF
         UZc/FudGU+Ss4szqG4qiTGo7OUa2hmd4005xAwSI7noRyGVsPizKgTqOiic+v6Rs11DQ
         EORriSqv+T2+hLV/kGr265kp16nl/ZFryAxnc5pUtwYpEb+HIHdoE0hRaswNaXsqNhrO
         umusN19cwEuTbCtk4DliD8NlxsYD69CwmAArsB+7OoLbZgafELvUj0g0x9yA4MdOXGRY
         wAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755788976; x=1756393776;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ab5BuStbETRbkDeAZnUXuQ/DgQ8ILKXnSWXLDpSHBxw=;
        b=xCmzoj/rI4zUm285/H5PMnqH0ChCCKHelj2zMSyT3qsnztfnIg6vft3W0DpI5TVR9S
         eYIs9D3lc9XOv//S3eZ7wFnl9FFe4vBrte4s7mMDI9S+N86G5RSNBQlI4rD/MAg/vPQu
         uoXflmmAaSy5eXppSzKpPcXBf979J/Jw73fdXB5mM8lsBELKHl30ZJ8sKDRSSCrS6yMw
         JIIHoJU0HOYxWtKvkuzYaXG3yVXzrlY1+1wDmeBVk9oVgwC6xYku2OSenqi0NRFaJKUo
         7WiDTRh+e7ymHGnslHhi8/FLyhR5sjTBeQ62WjvjeUhf7lui4ead3ml/+0EIE51pmOC2
         xo/g==
X-Gm-Message-State: AOJu0Yxucmzeq0rw1SE16f8CeXk5BmdClK9cBSiDQ2L+LUYWV6WnpUy8
	MDDvJGzd4rx43sCvJeaC3iQ4i0r/GdzCUclhc1aYpe0lGRIzgGvBXsCiuO2ZIg==
X-Gm-Gg: ASbGnctpzXNNNIA/Vkx0NIQfI3yQ/PXeAJIJ81ma3gljTvo9yMaXMEk1fKjkK6rZVWx
	n8xYWDfBVLvCbXiGDRDSy6KKHtK8RaOZ8+IJJtbBoWxsmfzsfuIUcpwUGdqfNLxSBRvNlCTflxC
	jQjFVSqI21j50UNO9C5y0jV5kzERUCPMhelayL6/YfLrpTXSM1nwrNnWX5lH4LnhcErUK2vAN8v
	eQ1WrOgDuKn3v9GOWOeZxuiH5wXFc4hECvspSJV/fO6373gp8iV3xOu8pAeq2Bv3P480TGkIXaX
	FJRrp1hOFBWnDuggzFEW0GiNujGsQ/B+qHP2r9chC9G28xq8PDTjdyhUtD1XZJiUYnPrMC7/3Jf
	VaBEdABsyzhpq6Z2NQDcBggxC4iDf
X-Google-Smtp-Source: AGHT+IFvMqfZGbnNPtUB9e6JAnEv2+qUZWxZ6VFUV4ZJvKKDEhZfSf7XPFmuzJqvrZnSwFlxaiIfrQ==
X-Received: by 2002:a05:622a:11:b0:4b0:e1bd:a2bb with SMTP id d75a77b69052e-4b29ff9b22emr32645091cf.50.1755788975432;
        Thu, 21 Aug 2025 08:09:35 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.58.230])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b299beb322sm21120951cf.41.2025.08.21.08.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:09:34 -0700 (PDT)
Message-ID: <68a736ae.c80a0220.e11d6.ae93@mx.google.com>
Date: Thu, 21 Aug 2025 08:09:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5830048786087250039=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2] monitor: Add support for -K/--kernel
In-Reply-To: <20250821135031.2033789-1-luiz.dentz@gmail.com>
References: <20250821135031.2033789-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5830048786087250039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=994059

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.31 seconds
BuildEll                      PASS      19.94 seconds
BluezMake                     PASS      2593.48 seconds
MakeCheck                     PASS      20.22 seconds
MakeDistcheck                 PASS      184.32 seconds
CheckValgrind                 PASS      235.72 seconds
CheckSmatch                   PASS      305.53 seconds
bluezmakeextell               PASS      128.02 seconds
IncrementalBuild              PENDING   0.23 seconds
ScanBuild                     PASS      905.89 seconds

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


--===============5830048786087250039==--
