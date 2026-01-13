Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE73389448
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jan 2026 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296359; cv=none; b=fKuCVUXzVHkGTIXUkDALyho6HESz7fn+Qu/HAM7xgEBL42HxQ+eGpBdmwZcSkopm94X1HBZK9O3/Wu2rhlWYI6BNXSBNFDEch0cellSS0RUA5nuNgxtHgcG0D+d8o040/goC2paHR+L166QKp0Y0VggQpT3J5NvDGF/W3J5msE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296359; c=relaxed/simple;
	bh=h9cQ1eKI1rtLZbTbLy0j5bHxCReomMPGGPHxe4xOsI0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pGnGMZwP7tUjKcvdDWHal24PWdMqZbFI1jDy4eVzYwYR/nMb4zc+EVD6t/pakZll53STHslKo6wv+L5+Zo/o2W8lvCpAbLTHyIkxfTlLepQACwQiIXqjCzwV3na1cHzdFWQl+8omOwy/FW2NXwKMkcSAi9WdfhqcZD4yTUFlHPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxTOUopz; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxTOUopz"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2b19939070fso7579627eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jan 2026 01:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768296348; x=1768901148; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h9cQ1eKI1rtLZbTbLy0j5bHxCReomMPGGPHxe4xOsI0=;
        b=HxTOUopzrCWBVPXAcl02nB9eZ04q1IGSs6zGalTxbU6YIpX/46pCRKyF7zr5y1HQ9p
         88uIUB5Cd3nBVnw+/buLUEJvAulpW7FxlJricORKNOthXfme/oYdBTFE9oEgE/b6KwTg
         wqo/0Z4lXnOcg0Kbt6wGs3Of27/bvBzaFdX3EtE+AI2U23EIZcht44g/qaOJn6xY115+
         PZ8DBWIc+0rtmGc+tMnhhowubHs467wEhV7yr0NvGLYKpncW+CvnBHPpW4QAKvI5P1+J
         2OTJuvksp+Go6Rd5nfjlIAC4YTPI3woaAIQD6VpStoDH7H38CU+POQqdg6G7OWSleFhh
         xNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768296348; x=1768901148;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9cQ1eKI1rtLZbTbLy0j5bHxCReomMPGGPHxe4xOsI0=;
        b=ICqlthm6EPGG0TafLiobR1aNNy7D1UplL8Z2t1GiwqDvOEfiyVQZIobK35RoJmBCDX
         AVpNWsVHhqS4TUef70bWY7TnIoW4ZttP7zw4THR8U5IUh2wt4+mzAs1735Q8tZ7KXTzh
         8JZvXLcNNOorCaz66kjtzhX4nCsJWuoPwfVW4p4FtrLEa+GWDXN68zDOfU1bkoTC0Xdw
         44CX2shJiU3rASaUV2ygD55r+wVdGgNrsMtCq0kbAFp4ffprCI76NYIbjw8a1/7enP7Q
         XlYdBQWHzOQ8RcFYQCOEP+7ZUDKpo8Z2iEk4q2UQNOqctATNak+tr/qq5zM/zp5LmX/+
         PtMw==
X-Gm-Message-State: AOJu0YzOBtJBN+fNa+my6q/JtN9ktyfdr5SUrewbQ2Nmbwl8XRQFNO3a
	Iofka9IHU/31e2Gs7P2b1Gjx5HxlFtZzWQ04DFIBFJBzkaE8GVXc0QvhR9qyKozY
X-Gm-Gg: AY/fxX5WiPvwhw3cCkHHYAmgPSWranHZoXyOct+cgEQTBB1MpohS3H3hALMGmXZxjNP
	FjSe0x2dNrskw49cjUwyEpq5k6t3KzRPQ9RGuo02HQGQB2Qg5CTuqTJTzTHmF4w4WlkT4paZdhc
	cUwud4EFIbRkW7CiLoJUqC7ldNBaW3iFXO3OudWLEx21DiH8fStkkLCgvvke7VMmv4DnDz5zMt7
	3haO119d49iW3i1AnZ0NOCSOb+C/3foFIh5dduMY6bEwUbagLzMNHciftW6bYsJMxitCpyYTdN1
	gswsO0J5R5FXvmQFD6Numgys5gK8d7+9XCWEkOmO6jtXIdHs4gaXcquz6PkoPx6Y44eTHtJXq9i
	v9Yad+STUhSqvsg2V3oSQ/BZTIImUaFstWiQ1TJ8v5Hro3vMUna2Ii4NQLTG4JiEio1Up3MoiGP
	9zTIqzZ7RnzYlGF8hL
X-Google-Smtp-Source: AGHT+IGRM16KUDFkkhPCBJ0NgTpErWoaRqsqlv56f3ZI65xDmF18YT+WdPBB0pysDsSNDoDAzQG+cA==
X-Received: by 2002:a05:693c:2110:b0:2a4:3593:9692 with SMTP id 5a478bee46e88-2b17d2230a9mr14405375eec.15.1768296348262;
        Tue, 13 Jan 2026 01:25:48 -0800 (PST)
Received: from [172.17.0.2] ([68.220.59.229])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b170673271sm17222113eec.3.2026.01.13.01.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 01:25:47 -0800 (PST)
Message-ID: <69660f9b.050a0220.322a52.0b5b@mx.google.com>
Date: Tue, 13 Jan 2026 01:25:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0266308823703237237=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [v2] Bluetooth: btusb: Use pm_ptr instead of #ifdef CONFIG_PM
In-Reply-To: <20260113090128.244709-1-hadess@hadess.net>
References: <20260113090128.244709-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0266308823703237237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:4633
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0266308823703237237==--
