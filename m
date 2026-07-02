Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C718E420E60
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jul 2026 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782995359; cv=none; b=fz1OfaTUHbgY0QYKlhujvw+WxLwBnfeMZue1p4M54TzF3ht6CB93t/qLkQa4AS/2zbCIXCofSKsGwVrtVuarIzUtB6ssvFZrs4oIt8l7DQi+w1Sn/e7yTrU0uU9T6vD7SswRSHyb0AaNpL7bBJrx8281QwQO//XrxqwJ+z7Ml7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782995359; c=relaxed/simple;
	bh=ACFjqwcHSP7kvzVMTnEI69DxR1s1NQeSMrCJZEC6Dwc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=NEiwPidrBlomHewW/KJ+Dk7KALjLtlLdShq4nctRiMxIQ621uJgHmBGdQTLhK/G6XOYSaqB8QSlU9Z3N9BEToO+MNbUWLUcfwVh1sw37N9jURlg14mOWZstPym7S60w2Y4Q24V0hzO4O9UVovh/Ftnp4KhEbuX7HEcFdPK7gY1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tLR2+6OA; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tLR2+6OA"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8ef1dc934d1so4621866d6.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jul 2026 05:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782995358; x=1783600158; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ACFjqwcHSP7kvzVMTnEI69DxR1s1NQeSMrCJZEC6Dwc=;
        b=tLR2+6OArtsig30vxAeJBih8nH5eJjKgRDLEKKP3mpTjNAUZkMh44ONRLtXVnvYDjM
         T5vTH03+ZVgijSYNmq8SJ0SJyiIgKssC/eeGr+IC+986DEq5tS+WRd6lJjZAgqrFAhzW
         +h04zvyKbseItaC4UxWdx01sB4MsQhD797fhuGffP82asbO9GrMvI5XCswnijN3G0hf8
         PfFyQ1ak552+JQ54CNrVZSwv9dVI0qgYG4bgi5yDXTAXq5mPxVlDFTK1E0p7wWdauwK2
         0na2N45Xo1uSV74LTmtm6bWTiV+Aio8jJRBF0OnlM/EqCV33VBpAgqLEZ7j/NxkGSZne
         aaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782995358; x=1783600158;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACFjqwcHSP7kvzVMTnEI69DxR1s1NQeSMrCJZEC6Dwc=;
        b=FpurD3+kwj8ycREQauwcjpyzvOYriV4S7Koak4r6knAyFin4atoEtDobHQxdTDPABy
         qNiC4+jhV3yrd77NQ+HN/e+HoCKo5OEz0vBGIWnSXWwwhhRyEl4uB91oa95rGnTupc9A
         Rg3aughHgUzf4uZukMM1nFJ7ikO+M6kNidmdpSZdrJK984F3KOm/Xb/xtMrSigqjiVQg
         NAW23OIkUjjpGjVgkhu9knfEI3uLL3gZyCP8agghhLAcScuGblCxVzt5WYP61MqdIRLR
         CilD58woc9tV3+hiKTgKRe+k47CzaPAVAETsFuNdPkXMxjwRDeK2oypPGA9IpT2mT5Wv
         oDFw==
X-Gm-Message-State: AOJu0YwZ9Xl+nI86nWdkMLD9nNit0yxWd2J+U/itxDcjb6hW8d74MSze
	ZBXzc+/lwQddjs9sG5SkRTnTM7blu2xsuTnIQBwygfPR6qENJoQYnyegmdf01w==
X-Gm-Gg: AfdE7cnC9ZdpafCzwpxkx5B2ttD0w9g+y4kSXRVk1yDspUuWud9muRdp0yM204KqiKI
	+l4O/GiilEz/wqnApcuAGm7W5A2IASRnbP/jmnzJZC4a63yzRv94t2cj28CYTR6V6xeyW3SMjbZ
	cKewFivTjTF6DHC1h+y6WwrusMbTTUJKy+W6UOebqo71QQPWiRF1WM7evOO+pQJwbhb1fALZdZH
	ECF/Y5TUzTaitILtBRL99eHvO71oaX7Mi8XiPtWoFl1TgEuiznvhUhErUH12kiwE0QGsErNDy9B
	O32AAzgUpw2P9VHamFIq3oGGjmFuHqoew4EY1XVdYEUoT9OUb7arn5FhlIVttu6b7tEjN7YYGal
	aEnmpdqw5xXBmW0SWLn9Tr7E+kgY2CrfnYIwswhXEnUnApFBIHUTq7uQgzVTT3IJGfLk4QwGZrh
	4ZfStxnIZUduVACY52o8A=
X-Received: by 2002:a05:6214:4891:b0:8e9:f45f:107b with SMTP id 6a1803df08f44-8f25548943emr136474776d6.34.1782995357790;
        Thu, 02 Jul 2026 05:29:17 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.102.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f471de93a1sm24658196d6.34.2026.07.02.05.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 05:29:17 -0700 (PDT)
Message-ID: <6a46599d.d0999061.39a55a.a91c@mx.google.com>
Date: Thu, 02 Jul 2026 05:29:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8900158777810853232=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, loic.poulain@oss.qualcomm.com
Subject: RE: arm64: dts: monaco-arduino-monza: Add support for LGA WiFi/BT module
In-Reply-To: <20260702-monza-wireless-v2-1-7b56e2a6a6d4@oss.qualcomm.com>
References: <20260702-monza-wireless-v2-1-7b56e2a6a6d4@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8900158777810853232==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/power/sequencing/pwrseq-pcie-m2.c:190
error: drivers/power/sequencing/pwrseq-pcie-m2.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8900158777810853232==--
