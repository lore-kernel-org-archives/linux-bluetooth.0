Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7863F8805
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775048175; cv=none; b=tQFT/mQvE4m+BNUqS+HIfNxHh1aVLCs3JRrywHNzFGnznr7iMFQ3UGCDiBIiRGNqCUYX91nxyzEjxdSCpe6b+D5JsAEjrDNdggucRzGvSbvfLTkKoA5yKRMNwsUoxBtS1cmzsJ7qGRdXBybb7z+XnIgl6hSsJAAPduL4ZRntZjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775048175; c=relaxed/simple;
	bh=q1HNnFkA0cHvrPtDx8OnXoiyGTybGCXqFLKZrlQNah8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mzdk95crWwUqk3tmTm7ePzh4qfKelTvp+KcpJQiA1ouXECQgim1A/jsd4IITOmfuO6jQa5TJ1Fk1RjZMX0wYs4x65T5nF1nvWZz2zxyRzXWB6NqgKg6pCLxU5357H+DH5fW68iBt6Twz7CzBBltEyhJVwyPvJ1JadH54WhR1Jic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeRlA+Ll; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeRlA+Ll"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d8b2703f37so6301156a34.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2026 05:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775048173; x=1775652973; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UFiFM9uteJQvhWyvbBCuUZAR4nECdSbn7/pZUAFvEXU=;
        b=GeRlA+LlpMg6S2n6tSLhmXXk8Dm28utl7GPoYEx+Z0f+Js7fx+4f5L5ROlvPP48slO
         LYSWj2zM8fThYmjdKj/U295qO3Rf5bZWZa8hGLkXTyMYXq59G6zJ1TLFSBlF2SZsYSIk
         4gEC05iMG0aIYYd/NZ5Dx111nsKe0hb6+iA4s5mJW/A83SYpoSGsmGFTz+8/YOrViiES
         ewDOGnbDFNCNud8M4an+AAQHEQ4DuXNPrAMaPFnQNhBm6uCJrTroAK1rORsrW3C3DIr1
         TDlnzqWdlpb7SY/lhtQgZQGxk2DGBgLWUudLEOxQm5pbrrKl4hvksuq5TlgFPVju7/sb
         NGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775048173; x=1775652973;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFiFM9uteJQvhWyvbBCuUZAR4nECdSbn7/pZUAFvEXU=;
        b=JtIIj9002sDYTvAzxiBx5jw+pv4Gxi1XUgQzORuxQfvCo5I173l70mfjR+xyr6Cg4i
         uCtw8k8knyv5SDCseVdW5ZmggcmlP2ERtqNtU6I6aVQhm04IntAtltMtztWRkZ2TO1It
         /WhcwvNdgv6TwwM346eVigLUzfG+pt78suiKbE4EiGslahvQRGAfO+DC1CbLvwjBVY95
         PPFjEHV9Oxom2XdJpHvmEh6YG76TsSgXKWmEuSk+/Csr7ewN7rC/F93ktMBXM2+lxWJe
         O4Dhi4bkRO8mQbvq409+056UPbAUyZRQ/51h8Oib48lJXTnIbY2lK1WDfUYgdYYEnRUL
         F7aw==
X-Gm-Message-State: AOJu0YzjQN9glPL02PblQIjKWhItMdzI53/7VqqfgWXy1zwgFribXinE
	6mkcKhhbDtLj592Bp+7zE+WqD8smayMZP/gKROys5cgQ5DRXca1GMgCO243pzg==
X-Gm-Gg: ATEYQzzL2ARSBVSNiD1EnB4jvqWDg5eGdWKkQxE9MrLRBKcbul6Owt+U3ZCQ6QVADj1
	V2GyTjuz1Kinifwj/9dgFj1x52Mw2nXfZh5yi/2gMg+aork/+zcMLRVFeLfzNpNyOgHEKZPtQOd
	GVlDP03YrlRkinsDyuAshN2kyjSzRzLWZN7IFOJ2HZUVgKT2DnCjG8MiesyVySUWB9K8YK2zrXl
	nqIxfhiJn0aEkUegT4pEJsW9zEVogTHz6XySmO+QtLgDnrt7AIH+muxhIBt7ztvmbFoe8dbfLpi
	mcKrB2j/B1Of7GWR+mOMs85skxyEp2GQ2N0OFBSBvaLcrYmOO56J+1K8XwbZXQAXM/kawDuRFag
	UfweiAmkswauv+pPKla2G7UlQ+ta0QJEbiPnY5tU9j78bVGUkvy+WgmqUVFw2B9Y1vXFQiMryOC
	6T9m8JJcp3T0P7XaoooB90k8HF3eWV+C8=
X-Received: by 2002:a05:6830:6d08:b0:7d9:f50f:96cc with SMTP id 46e09a7af769-7db991d6e1fmr2280114a34.2.1775048172927;
        Wed, 01 Apr 2026 05:56:12 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.219.144])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a82760esm10268320a34.23.2026.04.01.05.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 05:56:12 -0700 (PDT)
Message-ID: <69cd15ec.050a0220.f086f.9f2f@mx.google.com>
Date: Wed, 01 Apr 2026 05:56:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6622853200455601095=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, k.samburskiy@omp.ru
Subject: RE: Fix unsolicited AVRCP RegisterNotification response
In-Reply-To: <20260401114202.625377-2-k.samburskiy@omp.ru>
References: <20260401114202.625377-2-k.samburskiy@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6622853200455601095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1075804

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.50 seconds
BuildEll                      PASS      19.91 seconds
BluezMake                     PASS      638.55 seconds
MakeCheck                     PASS      18.03 seconds
MakeDistcheck                 PASS      241.62 seconds
CheckValgrind                 PASS      288.68 seconds
CheckSmatch                   PASS      343.18 seconds
bluezmakeextell               PASS      180.62 seconds
IncrementalBuild              PENDING   0.38 seconds
ScanBuild                     PASS      992.26 seconds

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



https://github.com/bluez/bluez/pull/1999/checks

---
Regards,
Linux Bluetooth


--===============6622853200455601095==--
