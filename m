Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B161230566F
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 09:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784541079; cv=none; b=VrfyD8jwJR+HrZD1Nv5UAS7xCju7kffBarrvS6Y5cnhMX6L50qTaLz4fLfN4wV/kObGDMC5GwCHNpE1nDdC4amz9JFZbAeyDjq2bFhmD27AFuFwtmsmMDRhsMMlgY5lWJ4hUgi+aoq25dCSsyRXHVm78A2WbNd2MsXIWaSYHCDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784541079; c=relaxed/simple;
	bh=wcDxpxF3RjGyub+Kqd9fjk2xEnPpkgNzZJARdvb5sRA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=llsJfVRxqITpZSwWp1TuI5tV0vHJP2riHKxlzbbBaMhWTTum433y0kWfd3HxF3EITT6hXnTZd7RhNkQCs0lgK8KdI6hB/AIUzFdJ+1g7lRTFHOer4VLQDlqYjlYC3DU2isARp0qYaOcpLVRcqnAiruI2eoDN/PU+uYRQy/1w7WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpPM8Oe9; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpPM8Oe9"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so4220739a12.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 02:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784541078; x=1785145878; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wcDxpxF3RjGyub+Kqd9fjk2xEnPpkgNzZJARdvb5sRA=;
        b=fpPM8Oe9aMIRlDV4ZzjmCrL4xUbG5TIKntP4xJdGn7a/AVJz0pDrEekSpeppe+ib52
         ABFMtrQixxMDOM1cSCu35RSwo7O5MmGBMGjtqLzMJbW00PsUwyEETxhWTNbUcw0Q92VH
         9zjNYsocA+Y636tYZPqiWHNnAxmfXd1r9bz2TG6rlyhkPJrmL4IxnVjbY1j+HCZtr65J
         7MBW6JVf4OeZqvkGJOztE46Mk7DZAlePBczVrg6Hmqfr7ouzZErSV7rJ0n7eYkxE/JiL
         vcBHTJyIwvEDT7xjLCvZWF7Ipqak2/IMiUrzmBoUN2UiZOX0XhQm5vao09+RciFPbbuh
         5uyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784541078; x=1785145878;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wcDxpxF3RjGyub+Kqd9fjk2xEnPpkgNzZJARdvb5sRA=;
        b=XLPKWSAELodbF1jB+jKYCy4W1EWU3nNeSgPLLE9hIT1u3RzM6+Jw6zoofZfkAlJaXh
         uWoHSU8PNuJJN0BH71f4DCJlaVuxf1W/paQ3N+4Q3OznppH/mlF0K3lx8j6qaI5yvNw4
         kyN4b/drVtFZcTekBWOKrg6t/aNxUfN1AZI5tSB4b9bkc2CB1G1BDlTXsIRS1BREVPXK
         kO3qzgBDg+RqRELb2K20bur5khG5pPiOo6lMN41IsWFixl6fcOHh5nw3G61Eenz7banf
         cwK8zji4F/OTMiNdD+3VCge1gRCWz58DUiAJv6ZWWByvCIVwPlg/v5h5asyiCssCLYe1
         XOGw==
X-Gm-Message-State: AOJu0YwMdDGUXZgZ1u79dZqaOz0T0gItfmNkMDQDHOzZdmoDDtSpGQsB
	O4eVlfxJNFcsDyVhptlu6/ZFyIsf2N5FCl6hMvrKDVxcsUTbr72alVDUW5Bc8w==
X-Gm-Gg: AfdE7ckhQDVtfhuiycAg0Hnj0Vb0mpckg/QA2/rPA+QVke9eETNJ/CPJvacwUZ3eOYI
	VFvRj8NoxWw4W0yZd+2Q8j3UNK8Pt2tLjDwCTsPCgoRjMcYl9b1JcHDu4EfRh/zXEVdutJutt/f
	qgCjMHyCFs/z7Fiut6ZAmNdV3CJPGVvJq+w6AJCv4cDlbi7+QIcvvdT6wE8M0Fzp8jO1N100oyu
	GpXZR5VttE68JUpn7KFE2PHydxe/ida/nGHo2SiynHFAr7j8l2Xfx/gu3kmzUfCwcaqKScdithn
	gQqXw6RGs9ipO0NRqKuYHebJlp0D3+NnA0yZee82soWVBMvCZQ0CWWih6k91FWm2XLCpUfdgB8R
	jiuo2hNSBncZDQJM12wuVbkVRZtKpKHfODi5V7QzXaRZfY10hO3mjAzQm810igaQKgM4KaPhjX8
	nLcDEscU1uOMs=
X-Received: by 2002:a05:6300:95:b0:3bf:e2f1:1b08 with SMTP id adf61e73a8af0-3c3ad9717d4mr14159397637.40.1784541078009;
        Mon, 20 Jul 2026 02:51:18 -0700 (PDT)
Received: from [172.17.0.2] ([172.215.216.192])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a02b7f2sm34337175eec.13.2026.07.20.02.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:51:17 -0700 (PDT)
Message-ID: <6a5def95.6c5720b3.2da3b9.d724@mx.google.com>
Date: Mon, 20 Jul 2026 02:51:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1657238816991117432=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, loic.poulain@oss.qualcomm.com
Subject: RE: arm64: dts: monaco-arduino-monza: Add support for LGA WiFi/BT module
In-Reply-To: <20260720-monza-wireless-v5-1-69ec6743543c@oss.qualcomm.com>
References: <20260720-monza-wireless-v5-1-69ec6743543c@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1657238816991117432==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/power/sequencing/core.c:991
error: drivers/power/sequencing/core.c: patch does not apply
error: patch failed: include/linux/pwrseq/consumer.h:25
error: include/linux/pwrseq/consumer.h: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1657238816991117432==--
