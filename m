Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633B43C13EE
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 22:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780439239; cv=none; b=KFHrS2x3dfeL8Rl/AUDB5k6FZFmJrBKwhPHPZxSas9EdHANO1/VWAQfAXamkJSalqv+XE+FxDGmcUuepbKiCXu97l+KYybQ79+eAdyC0zSS2QC6t0zU10w71zDXocEqx9Th4dvDpWg4PQtUYLTH3veUrn1u6xwvHR9t4thP7fz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780439239; c=relaxed/simple;
	bh=BMZx7z/Xega+fBvyoduK6lf/TYmOYDzcfVs3x1hjpwg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eQNthmSTitqBQChGrsGle3kV8nY0lqGc0ACi9v9ruPB/PdHg7zII5/TWrG7nMuyoSm+DIEeWEfb8iVmQAIRrmTYezDSa1x6/7ks0ait6VTfEqhyt7Pp9Od6AgkOCo2vkKRi6tB8MbZAg/C0sWOLZQMJxuNMhWN3VdfiCVnvtqOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K43ZJD23; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K43ZJD23"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-304e6c6464dso1623230eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jun 2026 15:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780439237; x=1781044037; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8lsP68O3hz5AFuTQWfRJxTbtYeSbPfP8JyV3eEZ6oU=;
        b=K43ZJD23CedrRH3wJ8B5E3QJd7TWeQnXkfXvT07TfekqHGeWEE7HL1y9Tcvk8PXBxx
         0dK732ictllhi/1vqC32/hIbDe5X68qU6XRVKggnDFt5xGImFTGH26XJiHlHdhrBojri
         MlGzS/acG5RPXMY5KbRb3izmZYVEqCB9+Efp9a5CT2SVgtMo+by4+5CBDSQdKMzZUu1Z
         mr1Ist6UB4kp/HfAkGGdxeyA/Uc5a0iNkBqZJVGjtM52I3lM9mCRfi0+EKk/j1CtPbBV
         yM4J+HdR++1CxvsVo1RaMALix3/ERyqb6j9ubH29HODHbgGgDZifYDsZNfsQvR8Rfsp3
         XFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780439237; x=1781044037;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8lsP68O3hz5AFuTQWfRJxTbtYeSbPfP8JyV3eEZ6oU=;
        b=DcIoa9jzL2BQ7gF/u9Qu2goZG8uEnX0IAIYjGMwzTaoM9v3l1SfY8Enp+8ugTvpoLZ
         i2MCT3QrzHKVwVGH5atQe/Nnb1GCNVKZGcHt1cUSSlmzmVCN4ugT8dPRZfPbdbkzlEgO
         1KQhWJVSkI0sHg0ZumIDvAlfxI1HMP0agBdvT6wuFUEKYzz5FAxmXhIkH/SG1lOOg64p
         ZGDPLFCWyn+7cBdaNa5/kCuWqT3nHBXRMJY+70ZJT0A7ttNgumsvHoQGaI4QSNI1wg3g
         d1rQTpaaB8X4UEcj5Ir1WH3riWhV3VxaCv9XXhC34MiV1m3DCNCj7lfneM5d8LFQ7VUJ
         c9kw==
X-Gm-Message-State: AOJu0YxUwW3t8VZLhnHuXIkVV7LJzDl6V9lcxBLtwrLcCsxt1DnrnKXV
	/l5KlgzFOm68ucLJ+FscLSu83RC3QNqpBWFvqtGdcb225u/Q1Ugm+C9zCNGmHA==
X-Gm-Gg: Acq92OGsLDozxTcA6OXJlwXvCHQY8Mt5Vxlk8s30t5xFnWJGDje135hZJbwfpRFPXTA
	rdS/ePA+i2KhGdOeMmWnMEgzSK4PV16i7S9hRpcgMdao658D1hV9MA6BPr2e8B0ORsRuEBUYdmo
	hBXSr/b8HA1g/HP0Yiwz/MwDUUP+tT7t82wHk8lOpzTpDhYQ8NQbLzzL2Hag2M90giHzYUjrSqB
	v/zgt4ZszOnCdWrB7QjX5zFacZ/h+/BWXcj7bt2LcK0N9fotPvkXR/DdyigSNXuwLFwMAGU+Q+k
	5uhiifASdcv7yVKHq1EQzw44uAeYktQGpJrzPViHmdTQI1z6/s8ZYj6sSusvApAYUOhElOl17/4
	BnXbTTAN6EH0AT2emP1c7UWxwCShiERzRl8IZOYEb3WWkzOhw6XpeG38km4VhfHGkJykJe9S+s1
	A4QNhu57G3NpKN8NhBL8JaXmnrw1uWSDv7fYneBM5ZcA==
X-Received: by 2002:a05:7300:dc03:b0:2ef:8b91:212 with SMTP id 5a478bee46e88-3074faa0516mr421621eec.14.1780439237351;
        Tue, 02 Jun 2026 15:27:17 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.153.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db528dcsm922298eec.3.2026.06.02.15.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:27:16 -0700 (PDT)
Message-ID: <6a1f58c4.4a342cbc.a61e4.60bf@mx.google.com>
Date: Tue, 02 Jun 2026 15:27:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4305235679094399350=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/4] profiles/audio/bass: Use BASS_Modify_Source when assistant is active
In-Reply-To: <20260602210022.213562-1-luiz.dentz@gmail.com>
References: <20260602210022.213562-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4305235679094399350==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1104856

---Test result---

Test Summary:
CheckPatch                    PASS      1.75 seconds
GitLint                       FAIL      1.01 seconds
BuildEll                      PASS      20.78 seconds
BluezMake                     PASS      686.70 seconds
MakeCheck                     PASS      18.37 seconds
MakeDistcheck                 PASS      252.36 seconds
CheckValgrind                 PASS      298.96 seconds
CheckSmatch                   PASS      352.74 seconds
bluezmakeextell               PASS      185.30 seconds
IncrementalBuild              PASS      687.41 seconds
ScanBuild                     PASS      1066.94 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,1/4] profiles/audio/bass: Use BASS_Modify_Source when assistant is active

1: T1 Title exceeds max length (83>80): "[BlueZ,v1,1/4] profiles/audio/bass: Use BASS_Modify_Source when assistant is active"


https://github.com/bluez/bluez/pull/2168

---
Regards,
Linux Bluetooth


--===============4305235679094399350==--
