Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419D31C3C04
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752077171; cv=none; b=KlP+jXp9TuH1Wg4HlFMM+zUvV5s5f5b0yStSo1XO6tFFZduhCCosWw5S8mn4F3CzYccW5+W7onEsWTZiyBLHL0V1TRlgQ+nrWB8hWhyFfee6Z3uoouWtnRxn9uY6QqrWiivw6zHeceVrkNKKD0/kc952i6WWCcuuJCehi2AHP6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752077171; c=relaxed/simple;
	bh=ff8UhDk0VxBql/W9CW9J8+dN+DfuhzTV1vu6kkIqFwA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hawbSM9pJx9OrBcXV9FejxkaIsbBCcmtAZG6kGarmBYiVbKlNJwT7Qja+FvCdK7tHJp5/2QKb0HmVb0JEzGnC0r0SdE+XnBFnjxbdzHiguBr9f963bT6Q/EaY0VWutVyrLH4BLSSFmnN8ND9ORvmqzl3EoEv3d5BZ9cnTrB83OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHybsmEF; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHybsmEF"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6fadd3ad18eso597456d6.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Jul 2025 09:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752077169; x=1752681969; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Nc9004GUbbaZUoVQcGwVlTAdn1D4gSZ0As52nQdQKfI=;
        b=iHybsmEFyOcv1G13GY6cbTIgHFi7fegjJadjnEuvi7OandEsLO/w4jafyIkRS7hYQU
         xqBB3d7q3/+NlhKAo2ESe25s9YVuPNJ7qTzv7YPVqJa3ukLQbKVEpI/zSJ1TV6657Rfc
         2s7uul/fc5ztG7rkXKvu2Nl3SwbxXceKkopQ4rvL7F9PWVPRMwvfo02Rn+KtRKtkadB4
         htHHG/xCIOuzMfh9gqChlae7abqz9PASmJ6H1ph4tZmq/DdEk6w3x1JLWFgCtHCUvz4l
         l9tOpYu2ORTg+SY0JywzLa3eG2R3Y9q19jlKVTfTkHp3nvyVlHLvcSF2Sd41MY1E0qgs
         lfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752077169; x=1752681969;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nc9004GUbbaZUoVQcGwVlTAdn1D4gSZ0As52nQdQKfI=;
        b=lxiyaJc7Qq8jHoyZzJB0vr+3XTnyCH0vo6ssw1P8kAPgSiLsjC7eHvscfhWQceyKW5
         P+iT1aQ6WPO1q2SgQf+CHTrlGFtCCfKjjqJ1CFhQ03VyFDNKWI58T1XPNFc9rO5E/SYD
         6nO/rZ0TP3NzlcVq6DsNoYuPmey084SidFxY1DgQYCF1NT6DAKqEPf2seAQRlBVNLmQw
         Gx6Y4p8gkZssOtzEgReUrFOo7EpHK5bJJ2heFzU9wi4/ClxT+Knhz3Us635TTS+BqkAS
         fG5updClPdsXj/38UW1VvsRo0AotV1GzQ7g0mAnKKA1JmuCQTo7Ho1NDlsF13ZrlOHUQ
         +IWg==
X-Gm-Message-State: AOJu0YzQKo4Ff0ktVArdc34t6Tn/qnMtjnhcfd1vsWQj789jkK+uX/vf
	XvPa7ZtqYtOGFn4sk7erxbQbefUax8vVpoN8FmVENwHWkNrUZpouz9A2FnBKJx0l
X-Gm-Gg: ASbGncttsnLa/Fbl3ExzD25v+aQpKOd5TfzRAhf5jWT8mHl/amgkWQcD8MR+tNIP9sV
	d8GAFURd+j78c/bPUZyPlyJwBuRRybRVvGaKi4Ov6osJsxaIZriwMQMNVTZBcCGkxMvFt/TxQZJ
	VNYezflw5Yl0X/bjzXlSYa6mnqmBBrG3xuHzNLEQUX60bc3rXYSpbCetqYm9NZ1xHFv8F2D0h3Z
	xmaAlCqB4nhSo2hsWyEpgUqQFD/++EY7x1L3jbhxsuHlHv+ZmhseENINkHo9crya2lDWUTU3Jp2
	6mOpGbP+BiUMZfiCNgcZVAUYsTouS0DPox0m5v334pP2Kjeac0iBE1gyXC8L7yQipZihSozj/7n
	GCZCW
X-Google-Smtp-Source: AGHT+IGNyOmBqjEI3dOiXpvoCu9aL1KfOA7mJKukCq/d6ofVhegSMheInYcyvvlnU0mP8NCjnzLFFw==
X-Received: by 2002:a05:6214:2465:b0:6ff:1548:6f0b with SMTP id 6a1803df08f44-7048b9504a9mr44778026d6.44.1752077168700;
        Wed, 09 Jul 2025 09:06:08 -0700 (PDT)
Received: from [172.17.0.2] ([172.203.161.57])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbec037dsm956925485a.113.2025.07.09.09.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 09:06:08 -0700 (PDT)
Message-ID: <686e9370.050a0220.239c1.5a14@mx.google.com>
Date: Wed, 09 Jul 2025 09:06:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5797150892253409457=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ] obexd: Remove --enable-threads option
In-Reply-To: <20250709143612.2115659-1-hadess@hadess.net>
References: <20250709143612.2115659-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5797150892253409457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=980566

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.31 seconds
BuildEll                      PASS      20.21 seconds
BluezMake                     PASS      2633.10 seconds
MakeCheck                     PASS      20.14 seconds
MakeDistcheck                 PASS      184.17 seconds
CheckValgrind                 PASS      235.34 seconds
CheckSmatch                   PASS      303.97 seconds
bluezmakeextell               PASS      127.80 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      911.53 seconds

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


--===============5797150892253409457==--
