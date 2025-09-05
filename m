Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2401C6B4
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Sep 2025 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085326; cv=none; b=GMJQGEn+shBdqBldITEVV60EQhmaZu1m9qKf4IQpMyy65c/M6Pohu5fisMbqL2E/XpF4Xgg6fmbKY4JOlE7jyj3Ye1XkWeJk7iMdzlP9vc1rAwBA59/ZBsCQmIcuaSc2I+ToOWAXZ3RPq6hkNqLlMP8ZTjvzOEOBAn66mtpqRlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085326; c=relaxed/simple;
	bh=EipGUq7ECYod56Uy18KT3H52du/qQ63K3LHae5F+aAg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lALA2CgmpN3P7LmOYGlhes4CC/vpatSmFSjVJEnaFbMN7KoPHVwcGX1xZhChaFBRI7kPHvujEgVtahEIcG/LUsftgH0xKpVpHN3nqaNtlMyaSVEAuOOOK2KMTYs/Gc3zCeD7iA6al5GdRBVLGWJ8pItqOSerNkglais6eJed1Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qmgi+qOY; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qmgi+qOY"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b2fa418ef3so20571571cf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Sep 2025 08:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757085323; x=1757690123; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8qJrgi6aX7Xf5YGH0+4pztXvyng7jB4w7bSrl1ZzF4w=;
        b=Qmgi+qOYEUaDQQFenZVedx6olznXq+eMJRC/cIqbnNdsE1dgs0bo9yeOoxroWmRujt
         4EY73sOg1MozwwulYbgZokc6tJTxIZ3cXYgCDqF4zqC14fqdc3PNdxTwspRgheFdNGRh
         KVqzd4tgskV6l0RE1etrPPYyjjgJ7f/8xuiQaGZQxdUZvW+NfK37AD5DZlzTJuJjHi9P
         SDjUNIoLffUSdFQA0ks7npz1jVelh8L16Dy8dOIt6thql0iU6PtQXS2f6luobGMyu4QX
         UtwF6KJkwSSee583u52mDgwRp5NJeGjUxm+IYj/BL2wbUf7+lOy5Fr8JmCOGbUDv/+w3
         3cjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757085323; x=1757690123;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qJrgi6aX7Xf5YGH0+4pztXvyng7jB4w7bSrl1ZzF4w=;
        b=RlM3Cn5eaeWDnlJi6K92GHyy3Rw5mvKzw/WH1D6hxiSzI5Bh4eATbz+dqpNURfGm1c
         5XYWsV5OnxcCsUTcuQaQnHJEUtTP3ZaFJ3X8Y2H9vTJduEnvHkTzdm1y5PHhUWZ8oKIh
         FkhOebhBrMbhZM99kBCldcIEGtTpMODzbTC2s/evmwGQZYlW+dBs8yAmbXZz7j38O1yi
         hhujmUbGztsU/8eWNRlpPX1VZ4VfzlZXKOUdO4ccngStXmLLmMzZ0jt9ROhcMKBKay+d
         FUIDke9mqLYkyAQr0HSVSvjCjyqZfx5rVuMZWgx0f1dPzJK12/kCWQB298y2OPPGCiw2
         eULA==
X-Gm-Message-State: AOJu0YwM5bhDHnBELo6vSkCTCwoy9CpGqcIwkYZX2Kxi8c7kNl8GNTGD
	OwLe6IMOlDPbr36N13Zh4fPLa3j0EeM61r+HqQqL2A6nSAyeHwsfgveghRoADw==
X-Gm-Gg: ASbGncv8+FMkeMaKZGcqcXXzmnitpLkPgnLuUyjND9n/0k6bRV5hmnXTXWYI8XCMA9P
	IniVhPWN8PWsitegR+MvYAcIge4bmQO99r5vkE1DK049k9uBC0bokX5ytnvO7AGec1oqCGVVAFU
	ArEAYoZxxSnK5jVaiJc6afbY+KZyeRJQ/g5wBYWyIOo5iguIyRGxkDSJjc8aDjwecRHrF5mySoz
	VBPi7STS/jNit92iP5FmY6C6qzOZv+jk6jq47VV6bYtPuWauHEfWXsgG1AEIXvg65tF3ELqfMOg
	RRDFF9NcfmGxBYCqVc25slMRnSW4lSpLCC+/Ruh2SPLXJ7wnW4okpBdEfAGmaIpkY31OrXbwava
	DPB9sj71kpMTXIlDI47oD/rIQS/+J
X-Google-Smtp-Source: AGHT+IHJCWMtzqvb0WQkSR8tqDqK1+fwoOt7Yf/z8b2elmRPTl/LtV6awktT6OMOMyxLMrwZqGoWYw==
X-Received: by 2002:a05:622a:229c:b0:4b5:f2c3:e756 with SMTP id d75a77b69052e-4b5f2c3eb94mr12268121cf.73.1757085323170;
        Fri, 05 Sep 2025 08:15:23 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.126.85])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f653a08sm47882291cf.14.2025.09.05.08.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 08:15:22 -0700 (PDT)
Message-ID: <68bafe8a.050a0220.174628.07cb@mx.google.com>
Date: Fri, 05 Sep 2025 08:15:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6945532208791986176=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ] client/assistant: Use strnlen() instead of strlen()
In-Reply-To: <20250905134942.80833-1-r.smirnov@omp.ru>
References: <20250905134942.80833-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6945532208791986176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=999352

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      20.90 seconds
BluezMake                     PASS      2708.44 seconds
MakeCheck                     PASS      20.14 seconds
MakeDistcheck                 PASS      193.26 seconds
CheckValgrind                 PASS      244.36 seconds
CheckSmatch                   PASS      314.61 seconds
bluezmakeextell               PASS      132.62 seconds
IncrementalBuild              PENDING   0.23 seconds
ScanBuild                     PASS      944.35 seconds

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


--===============6945532208791986176==--
