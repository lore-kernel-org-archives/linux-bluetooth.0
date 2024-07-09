Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DA2156862
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2024 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720521629; cv=none; b=MaYFFwJYQUOev+N0URyHdM1w5ndGnEBUmrYy6a2y0kZN12eSkfcC84TRFMPPWBpIr44UsHfjCXk7EfFFmdiiT7sZDp2ffcuj8avlGrfjpE2iDBznPOcwG1PVnVIQEkbBR+eAHNhBqNO3zr+unuTWNfInx58hNGoDfrmw5lotGms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720521629; c=relaxed/simple;
	bh=fCI6ePD9sQPufl1o97nqyGvUnqEDrUncZdVqh//H+8M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=f0Xs3lh5hWUb3TSyMKJ8u6Yva1QNZob5sUbcsjuzfWeZQ2g58LikftPcS6h8463ZCZwTWSlA9R/C1um9rYkk5DYHmzP/Fw5R2kO65/XkRGMSI6Fup+/Fr5JvbzZ9CSHY0IPWHjte9HnT6icrfcb1vcdouGm75Y7Gute3N90GA90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEfUhxNM; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEfUhxNM"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b5e0d881a1so45421806d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jul 2024 03:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720521627; x=1721126427; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=95T8hD93/yTe3wxJ+aRDnUxIj4Bib/x6IT7cFCQeetw=;
        b=lEfUhxNMrE8e/hkIMbtZepwx1cf4J/R2S1CoqAtgFPVbyfvDwPcQUM5qjMT4OBDXa3
         2jqTO+sUnxFf7xVf4vwPgzrO16ouYbvnOcfe/eNyQnABVByv3Bn1bZbMnySaQHru725R
         zvjUyJEwYoYj5nSi+ixvynX0zRm5tbpLP1KnZgZRfLW+oWSijARqqjWCylNwmyuV06WD
         ZxfJqGzRGsHnQI0wToEvGfWeXYCvpdXjys9jFyDgtnKr/UQxyGiujs97UKzeEZVUswYI
         LfBUwcYjv3nr7Vvtq/Obw0VFv+KjjovGb5Rp+HWXvdVmgnczfVG3GvAF7VMzwd5riIuM
         FTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720521627; x=1721126427;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=95T8hD93/yTe3wxJ+aRDnUxIj4Bib/x6IT7cFCQeetw=;
        b=ANZwNAWJzeaHnSlOkktQQNfGUVuBe5sRlrOnq0TNXYlDDJZ4ShPr6fhUz2xG5iKEuQ
         7yZEyA6RyzlD+dlwWlaHcoDAgxThYQil7YNPw5PHXmN2+Cr+9mJO8PeMH/dCcbtroy9a
         re18aX2fF2Z8JkGZGnCg8VgrTsP5XjJMfpO9cdXGriiXRADcMEBISZvsQoGEm6HOzI5s
         tB8A8lVAz2x8hCZ7DAl3/fPiSXVXU3QywXNDNz5SU/JyKLfqZgm2Yc0jev8lTnzvKKfE
         mIgkWxqzFCw9tDB/MwyeTPfy/YLqmhG9k4Gc1rMDJ4l+LbGhYJklZgpm+tM9lIKtzd6g
         aQ3A==
X-Gm-Message-State: AOJu0YyWIhHFYIKOAWVgb/OWWgHO9J5ZRpjlb+B5YyKYFXHiZuNGXcfH
	MtathGUeD/UK51QGwKyxLsq5L3ex5de1WugAHWbfbelJaGfDJWsXhIG6hw==
X-Google-Smtp-Source: AGHT+IFUdmsfdphp3zHvrBQTS2oHPD6oYjDzas90M5A/G1fGlT5bd+u5ZTmDqJZs+Xo8mtIiqwHmEg==
X-Received: by 2002:a05:6214:19c1:b0:6b5:80de:987f with SMTP id 6a1803df08f44-6b61d7a6e6emr29942586d6.3.1720521626734;
        Tue, 09 Jul 2024 03:40:26 -0700 (PDT)
Received: from [172.17.0.2] ([74.249.14.166])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61b9d9ec5sm7523646d6.30.2024.07.09.03.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 03:40:26 -0700 (PDT)
Message-ID: <668d139a.050a0220.c2ad2.2ae8@mx.google.com>
Date: Tue, 09 Jul 2024 03:40:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5083919303591008497=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: bap: Wait for BIG Info report event before creating streams
In-Reply-To: <20240709085903.125001-2-vlad.pruteanu@nxp.com>
References: <20240709085903.125001-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5083919303591008497==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=869563

---Test result---

Test Summary:
CheckPatch                    PASS      0.50 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      24.49 seconds
BluezMake                     PASS      1679.28 seconds
MakeCheck                     PASS      12.94 seconds
MakeDistcheck                 PASS      176.35 seconds
CheckValgrind                 PASS      250.71 seconds
CheckSmatch                   PASS      351.87 seconds
bluezmakeextell               PASS      119.10 seconds
IncrementalBuild              PASS      1444.30 seconds
ScanBuild                     PASS      998.47 seconds



---
Regards,
Linux Bluetooth


--===============5083919303591008497==--
