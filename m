Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5793A1B6
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 Aug 2025 08:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754815903; cv=none; b=UuOO6DLnMCcvRgBMopVCeUr8X9PodrgWoIwaz1VNB4VGJhgqjQ6d5VQSKFSaeIs19Egj1q65IgQxf+axvCZuh2s4ZMT/or2yBVO5k2Zgj2roVQd5gJCDHEQPR4P/y7mkptx9817YM1d4jnwBZzANJ9dcfwVq9xJa0yd1GoFO4L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754815903; c=relaxed/simple;
	bh=InWcV3TsP4SOqlPtAG1Wd3VQ6lEyBSDEkiPOxgduYlM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mr20/AIdWANoWrQJzcbw+yioaWE+J6GXy7USjeKEeUZVHjWoLxhrDkNhZUfque08drmLLbxSUPr1nab1+vSFI6Vv3i+6d8sNtmRgahhzhfSzg5cw1uFQ8L0LDSu+6r625OkJyvRjgnuXeYLK5G5DTROb9WbKAMIYdqpytzqQhO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnZq0oQP; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnZq0oQP"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b08a0b63c6so40967321cf.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 10 Aug 2025 01:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754815901; x=1755420701; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2kbHa+fsc5toGBM598bu9Z89geIm1ylBue+LcShLK/I=;
        b=fnZq0oQP3uPtoo9lGEbRo2/BJETXuRLJACKXIzI9EkA2UMt1qGJBckWJ2/zzr40qEA
         rMpZKfjCysTtBKVdBGB1qM8WogAGvYdcD0XM70GIlLkm5KpcvUGD/Nbsg9Az980jbjTK
         3/62uYyRVjvs7c5fd4ExctvhzFVJly80Lq/gupkSP5qMPrlxxZvKUQKpuhVLnSzkAcwm
         VD0UWLgDzYE7Gbok76jfY1NTz6ElN5GopIKz0dhOlU1LejuosZgnUYJCicECYuXb965c
         heDPWylScWg4SrIghHQgIoeLVeHPrDCsoyN33zfEeqx2tufX6fxapAWQLiV5CjoIsQzL
         TF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754815901; x=1755420701;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2kbHa+fsc5toGBM598bu9Z89geIm1ylBue+LcShLK/I=;
        b=mBH/IcHuvbIxCVRLemH+soO2C44RXLRvHN/E7fs+JEvTO3GeV6r2MRm0s5dHOFH2vd
         xQxa84Xnptii7am++6zvwi06kVShyEJaTPSxWrp3LBw/X8gJeEnLirFDDjA+DwrFjxjr
         l73ycHlKgjBGP54/E3IOQMBMs3WruYJF15iGibUo2wgyc6L/vj9J0gmw7GQouSZSABDe
         rKJ8NeFPPfsBvC9Bk90gWFoB+i69SC6kq6tF4w9WlK3qvh7dgQHVx+xtfVZdm0gnB7ii
         NJm1ZLQnWitna8IZiYlhG6PiZwh/JemLV3bJt5QSoomTSfTwv+4hWpbRSuki137pg2Pd
         8qoQ==
X-Gm-Message-State: AOJu0YwcMLGSZYQ0uG4+34wMwtAARr+7ajuCqtR5LuTkdNiCjM4esMiX
	sRgVNF+uiasOphGtk7XcUh4kBQVZDEu40ffUuodWGWyOvgG3TMXsrYaQgVNTzA==
X-Gm-Gg: ASbGncvzDmMJItvkVX2NYqRlbGN9u1CykFC6z/df0eMkZLirLlpRLeqGfITxCY2Lnrz
	MOAdyUOgp0DIGsml6+VtxAufwEkfPedpZJEet3I1T9MeMV1rJOponEcoR3ugt+WRpjgnqvy7jA6
	s3J2B4YZIb1sjcynDoq280j27Gcv9OFvXxOm6LThzXVmsZ9LQ0N+b3oPr8ZMjFrNIX0ju57lTSW
	+QuR/8sYlgjpgBu2da2H8r+iM1BEJBUyVTMOi3U6anwRyo1wAH1fKaBwTq6EDDziI0RyZRTEBFX
	eopF7BGCOGu05VchOgSwQFYJmb46HAQc1tUPUw6oZM3pQbZxOOMDwpvoKM7SXg5c8Wbj2h8BQpW
	CL/+ALkfVgS+7yfXGzfMTveCfExI=
X-Google-Smtp-Source: AGHT+IGUqmo4c99cl8/nFwRfjrGV96Cwg15UZxfIyCR4F+KEd0m/zfzN1Uye/4FWFftGZ0jQqa3t8Q==
X-Received: by 2002:a05:622a:11d4:b0:4b0:70d2:5dae with SMTP id d75a77b69052e-4b0aedd7c6cmr129108791cf.32.1754815900999;
        Sun, 10 Aug 2025 01:51:40 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.206.80])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7097382fd5bsm70558826d6.46.2025.08.10.01.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 01:51:40 -0700 (PDT)
Message-ID: <68985d9c.050a0220.2c19e1.e5d9@mx.google.com>
Date: Sun, 10 Aug 2025 01:51:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4699847266563514625=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ochang@google.com
Subject: RE: Fix buffer overflow in sdp_xml_parse_uuid128
In-Reply-To: <20250810073008.1824799-3-ochang@google.com>
References: <20250810073008.1824799-3-ochang@google.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4699847266563514625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=989676

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      20.05 seconds
BluezMake                     PASS      2604.83 seconds
MakeCheck                     PASS      19.93 seconds
MakeDistcheck                 PASS      183.97 seconds
CheckValgrind                 PASS      236.11 seconds
CheckSmatch                   PASS      304.70 seconds
bluezmakeextell               PASS      128.03 seconds
IncrementalBuild              PENDING   0.23 seconds
ScanBuild                     PASS      907.12 seconds

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


--===============4699847266563514625==--
