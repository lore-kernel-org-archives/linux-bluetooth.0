Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5118C30146C
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789467756; cv=none; b=NdUsihABPykh4BJRXFjeA3SGIUrSFdiZY9VpaLBAHOBfTRCX2K6/HE6XK5BAzqQQPnWs7aVV1AY7nadDzs+UVRsLk2xBszdCDUUur3YGjaGhSmH2Dvg0RWQT0Qfvbw39zVilG2fvxWUQfI9t5wvHRxI0JqqtBZYAKshhspKthWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789467756; c=relaxed/simple;
	bh=eRFLCI3CcWBajlypDLmHILJpS32FKhnvdTKAO/OH/E4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YIybMGoYAkotOYNIfKAIv0m7MivW0VqVZ3h1hHg6H7VzL5fA5q4Fs2fJNpcH2xUxg2x13qJFt/wa696cNccux3IwxbRT1aUT6U1Z1Vtc723YClytjQFDs57ca2BTvXXLQACsCdAlH7Qt5tA5A3NJC7bNSwz7xnp2wcKtPEFJIR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NToLF98z; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NToLF98z"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fbef5018so855025ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 03:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789467755; x=1790072555; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=t4hcXrn2w56ZwZs39EF/Zn5iyhdSK0o7IqCZwGw+8dU=;
        b=NToLF98zSxrGAKS4kd7d7J8EgMRyvFQnKopyEb+SWBbOhHzLFsTGq/syPg5kbQxfSS
         bDktnqasCZ6C99mjIDXTOEHWY+MLWl3QTiSCuiVRWca9yrj+mHEHdYHdxTpIuorn9dlW
         LGZH8Mkf4h31RHE5N6U7h2p574wIL35vnvUk6TDuoxaXcjn8ohyMFRD5s3uKwzVP7d3y
         9ugPCNl9YF3W3iuYSADEQcCQQj9QuA5b4T7vvbQqgJoa12n/iCavFOZvaYyrzhmWGFtQ
         L98JT7CGr6HcT8GvWwKsc2OmPviC5C52L3+9qzRKMdCn2Fti/EgvMHVO4+JCTJp5wW8I
         N8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789467755; x=1790072555;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t4hcXrn2w56ZwZs39EF/Zn5iyhdSK0o7IqCZwGw+8dU=;
        b=InlVqvSkq8kEP5PVYICyJJB4Bg6VRgFOF5VU894tbtMmzbCviw0WjVVGRM1twMO1Vi
         TRsLlFuoM7JVJv8hlru6TSmUTxIVc0sz1OOItD37FRmAelv+zbO+qqY0nkf8PYzOM5P6
         1ARFrhsxC2cJWKhbieiEH67uDFQRQgIM8N0kCTYXjZkGuf/rnpZkwspsVQOU9EXhUUn2
         yr8ADMeHTxulfcwjAs5yXHa6+cP1juEo7XmYUQU3wMrx+icGITpWyeRSMkcLStTzho0P
         1p34nXOZG9OWIEFAGcCg73e62xSDSbIr4j9th3qlcp9exH3uKT5OY/EGypemsGvK+eBc
         YQsw==
X-Gm-Message-State: AFuF++lubQNWztOLjd55kAnj7Lm8wW1g9yKpeb3Ee8NbyxJvvdXbabCX
	G9CmDQrx/fqni6HoAr9DspCcBgEI5SmkUsoSi6plGk2NiP5jIvN9Mp3UfdYTWSsp
X-Gm-Gg: AYBFou3l1macm8TbnP20tzVDxsE2vO2VtW/L8ggyrbg+yNbUqdTljstxGMuuHl8kzBP
	H99vjplfMLWaXWrju3Qw1YOgUi1H9Zil4QPFARMjlaCIJHteFhaBnqwcNz9e++pIQTjcphYkN7V
	8awQy+GWD25gs8byaeqthqMm0ZnfxtqhV9DCSHap+8SDt/aPg7bk/XUf0w1Y2Xh/38cvd3tlWb0
	Fz9CDP56U+o1fL3yhQWtSf6MrcOzfi7q5swOCGqEPQfMB7zBEMLN2MY0OYyodOOwsS9zgi7rZrK
	i17YNs4dylp08RaKN202RazytuC0VsiR2vjGUOSUIluh0u1ou+YMJ/uqE0XiTIW/h7WqSwS+uH0
	fhwj3WtO6jSteztmHOD8AlDBbWEGwBU5PBjbcYD/DKii0vD1uBa8hxtKoLT9uPCnaYbNcfjyqxx
	r3GKvmifOM9TdMdgekUALiAnvZYWO2wuRLPBn75ZYtAbSpE7/Dh3S1PTu1jblHMS/nCZDMVT+BE
	Fs=
X-Received: by 2002:a17:902:e74b:b0:2db:210f:c111 with SMTP id d9443c01a7336-2dd837b0f5amr6956955ad.2.1789467754618;
        Tue, 15 Sep 2026 03:22:34 -0700 (PDT)
Received: from [172.17.0.2] ([4.242.29.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2d0006d6sm63216245ad.82.2026.09.15.03.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 03:22:33 -0700 (PDT)
Message-ID: <6aa91c69.c04a1874.2ac2be.a81e@mx.google.com>
Date: Tue, 15 Sep 2026 03:22:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7837571326759159877=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: BlueZ: Support vendor HCI packets
In-Reply-To: <20260830-vendor_hci-v2-1-9903760957ab@oss.qualcomm.com>
References: <20260830-vendor_hci-v2-1-9903760957ab@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7837571326759159877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       BlueZ: Support vendor HCI packets
   Pull Request: https://github.com/bluez/bluez/pull/2459
   Created:      2026-08-31 07:12:11+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============7837571326759159877==--
