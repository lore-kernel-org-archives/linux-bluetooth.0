Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B852B1EDA31
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Mar 2025 09:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741943884; cv=none; b=KTAC6vADLjdF8KsktOu+p/bVjHzGTl6xiT7behcwd894ldGQ8vVqrrUVtV3exLBaYSHY/RQx1NGodVCWJirRH2kcxNBiMBFZM7oPQMqqFFXi2mrCOascErZFwFULD7PAHTtQOrguw50tVWuyS25tqPyEcoNJkcp0h867wOu41fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741943884; c=relaxed/simple;
	bh=39geyQaXwGD54roFC3SEcqmqTbLEwKAEjp5F90AjWDw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FPxXjBQb0sdmg17QNrURjdnHWra/a3MjrbRh98UN0wJ8auauQ06Umw7eVtNAWEAksZ7IQGhabYikvIHywpZzdxrnGlXpaTqGjsLIalQbQOmGWE5c4OBRi9Y+7D7+HotPzn8ibhfaUfnfwX/yctB5MTbVhgKNswDtlbgQsVZbPK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvRVTn1d; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvRVTn1d"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c07cd527e4so157532085a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Mar 2025 02:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741943881; x=1742548681; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=39geyQaXwGD54roFC3SEcqmqTbLEwKAEjp5F90AjWDw=;
        b=PvRVTn1dc2fb31PdfCq3fu/iPqMPMu2E5OCd1MzyFzKvejdKXY+aghyaWhxiGG14xc
         Sz+1FjhsWyMFFuWUG00L1VvXeDK+yB9hvAAMAg3ATXFTYQpl/EkNBCxaI16oq0awkB8f
         YlKeN/4SgC1OXa3F41k75y5qvzwmwRrGYNnHcuH6GhO1uVerQAg4pBPAsXPrgrSh3kHc
         no5EOg1GGjBY2Gx1EGP8f8+OLD5YtkSXc0a8w8hEa/GYN8Q+OvfdITDaILelHOgvQ0Cj
         HiYPt4Q8WGNB44ayeNBvjwi526ukGEicKuh0ntx8JqGRaZONAc8XWVdcJjCKEVCHpZ1l
         ArbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741943881; x=1742548681;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39geyQaXwGD54roFC3SEcqmqTbLEwKAEjp5F90AjWDw=;
        b=vWMMPNcL3Jwd6zHEl8lvX7k+QloyU3rwJyUNxGvlFvm+6yrC7dHyG7Zem8m6154UVC
         k3u/vo2O3ims8n09LK00KJmxxwaSrGL/sGGxDjDQU4+KfLzaXcxk2EqDz3KyIgGegHJd
         IMjSzDyFc5LFpxMuXnMZcpqTgifK9CZK3lvZCMYff8ga8ozDtuMbW1BQcKXmOsD4vFRA
         ho0/XgT+ToQmaio/mHRZcgUW/eQ1Mk87H6mT3/IKGlpm1VpPSGNZcyZu58bwNISb7sIH
         z4LvlbG6hHEg5Cdf9UYVqRCf0hNnEqNCBau1F1oPA+04bruh3oRjjmPVK10hoJ/PDh8e
         TBAw==
X-Gm-Message-State: AOJu0YwquC4JFTApLek743r6cCJ9dzRgEbXeCUvHKPDC6Paifo1qG8QQ
	zyKPUqREpzqVk4DTXJqTvXL30soxve/YOSLOIPJvWQpNU00QLWEvmvo7VA==
X-Gm-Gg: ASbGncuo6CQRBAZlvJt8QGeZChQMbfTAlJ/77eSaRK64ten40OFt4wG9d0i17Y25ePU
	d0B2H1Q/0/JyDtU6ajoJSyxu3++GlaxtdDg5X33JIkQyBRZC9Mz5VEdYgPeYYIGKKMSyyTjEQls
	+pmF2iHa9qa0DQMniLUSC4tDEf7nM7kFniyVrcjMX4Bh0qzULWBbyP92OaEGopnk1dfz29AetAm
	46Xox5Wp4gToMH/Czgf6By4lE6jVrEwWLajvtfAWFE/TlcOt5LnVfxog7uYZ9HRbNZJiSu22Qas
	o+QS3Yh9MbcU8N5CmYmDEHtKwdgJ/o4VR0cRTDcemvcFlax6jAeQ0pNAHLQ=
X-Google-Smtp-Source: AGHT+IFn3G1wWjNPKLjeg3o4gT7OkRcctSUMXGS1boWuUnkhDXtnW/T2qZt9B7LJBpXu9EY6WY2H3Q==
X-Received: by 2002:a05:620a:4712:b0:7c5:46e4:47f5 with SMTP id af79cd13be357-7c57c7d6d4amr159057785a.20.1741943881364;
        Fri, 14 Mar 2025 02:18:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.79.66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573da455dsm220524385a.115.2025.03.14.02.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 02:18:00 -0700 (PDT)
Message-ID: <67d3f448.050a0220.8d57c.73b6@mx.google.com>
Date: Fri, 14 Mar 2025 02:18:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0366865381738036214=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oosaprogrammer@gmail.com
Subject: RE: [QCA9377-3] How to Enable Bluetooth HFP on BlueZ 5.56?
In-Reply-To: <CALYKT1guG+x7v6ojLvS+AZ-u_EO0uxycBLsUi9FnfAETdpQ6aA@mail.gmail.com>
References: <CALYKT1guG+x7v6ojLvS+AZ-u_EO0uxycBLsUi9FnfAETdpQ6aA@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0366865381738036214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: ambalink/buildroot/package/bluez5_utils/bluez5_utils.mk: does not exist in index
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0366865381738036214==--
