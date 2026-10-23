Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792760172;
	b=y4ooIW8Zb7cqMMlFW92p+PDkOFQjDkPUpDqIj0VGtA6bogNAeXgy11GldiDxrjbQm9cr
	 WiaYZOLwvNFEMTmYijvn9BFP22nSVHsSpE22MAgI6mjoEfbXxToo7lBEhFKI05uV7l0YV
	 SUKoQwXUnhxxKWeWBlWfyz5tCflkKkq+TDEClVfC5BQzyNoJVeSIDG2Qwxs+UnzPJJ82W
	 HbF2zf109+P7nY0AvJxttwxm4kl/QAAIBdQUSC24go/RaSoY02A5o/eRC7mOt/2pyS/CI
	 21EYFsM2x6p3UuhK4iZ79X4CQqZenSbUhmfqI/RuanVqXM1QbjdDtKttszgXH+esPyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792760172;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=zlWivWgGAIiX92Za3kRqww6Jgo93jTKkxMUqx08ckqM=;
	b=ClRDS79e4m7RS9M/d87WMaPVgc/Rq7+qdRveu7mEfMOJ69xvBxh/zZ9OLa4UNQ2eEwe/
	 daVronG1QEjoYDVVAifvJTLYP+BTbzXFuUg+7KrEAoq8PgfRQzuw1xiOGrJ2ZGLTQ6Thr
	 e2dLqVn4T0ffPLU3TShgTD72ZwNPPLK9aHsFypHOQGgDX4esvosZTxkBBoa6kNtVpCmcQ
	 97BBm4f1fBS3j/gy+mgXlUu+wCh7XKqCb8C33GQw0Db4TKpj8KqWnuODh0cnSqMfPwAHf
	 /RRnjGE9DPGfdomWE4+0qi/B/k1QnK03EHAmpjri7C0tpkXgUrjFabOwfBw33N5G5mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cexDfQ8r;
	arc=none smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6111C606A31E
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 12:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6111C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cexDfQ8r
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6df5e315bd1so549787eaf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 05:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792760171; x=1793364971; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zlWivWgGAIiX92Za3kRqww6Jgo93jTKkxMUqx08ckqM=;
        b=cexDfQ8rWMHlUEEM0Zus/2GuD9aRb/pxJpXLVP58gssKWve9D1XQ7hm7ff8fk2zce1
         JEnpT1ksN0fcff5fQogpOJL118J1R9TbotaQ2Lxat0HmLX9TvjMTwYXQwuw+ExZq2rez
         OFWhHTSU2a2apQHpagjPZuTbbO+xCUjRfuPKw8Jt8OME3VZ/iBod9bGYPIcYYnOR5zQ1
         jjUTofQuYtjq5zYDUirsD48PaaddCQpIgnFy12zvuJ2otZ3lfNrXTGrifOR2sdXSok8U
         aVk0r9NfmsTUXtUBD+81Z2kbSP2o/Czh5Bh3KXCtqUh+Z1p1/yiI46BHJLmeMHolVAcs
         Ub4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792760171; x=1793364971;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zlWivWgGAIiX92Za3kRqww6Jgo93jTKkxMUqx08ckqM=;
        b=vle2dHr4SxMjwx1rNuU3v65MztyZZ0ypCDiy9V5lnlePlxIsrESh2ZoO7DuiufGyJo
         g5Uv3zutZlVsRq7lVia9ewaDHc/Vy8DPS2YoWDN8bCtmX2Tx9gEMuE0YbYN6XZ56kK1I
         wCPkzsbf26UdaHE250dEyRVznNGPqKUhyDMj9x0G4n1Ne58f1ZNk4aU5D7mivVlhWGuH
         /lqDxh7QD3S6fHUFhhk57CV5alj+n/1KFM+ljgLJYAGyA7BkiPXfhsWeCH6nUQAF21Yu
         zo8XxmqIHDg8bcZiAs1l5je0mFBxK6Zlbr9/o4c7y4R4fNJr54iOtv01fBc40YD9tLrR
         idOg==
X-Gm-Message-State: AFq9FYK93lYaefT9yx043j5J5jDLHPGmb7OgoPTeRiToQjF/UhiHkqtW
	NfZVVccuwpbrafguH/2XGvcIFOu797cXuNPO1UnSyK4lDZpEi6VHVr3s8bdRGg==
X-Gm-Gg: AYBFou1tOscPZqNU/xc+PaK5GqB2ymUVTVR/Bu6YRCpaeebeZOeQBbYEYmexKevHmqc
	k+kCULoW3246oCjmIHtnnzanm7yGnsgZcv4o10/2tKNJJvgFMl9ovCnlKrFuzFXoCKX1I02//TE
	5Q8xH9WVU4BSSrFYJ42Sbucovn1JI8xLRBcq6Z+O84WEn8dJ9TmhASk6Dsji8+bGtqUbeT4pSBz
	u/yIYqKp0rJToQF5pRkImx3P5qSurRQ7x1qpVchZ18GLXJzZpLqd6zqU6Qj0GYpgKkzylTUL4Vh
	lwCsb/qp2grSDz0R80Vvs+ChCXWg++W1TJEGrGHmQY3tKoQ3flKq/LwpB5JbkmlWIwwlyH1R0Al
	SRwGCjTGvDgHCvaNhBNFCCwdwPQdkqj3GMnNy6IO32QGRx6wRm70GWS7z89pJ2AELXKw4lFeq9b
	9bRQz4JQQYDYzG6Etkif8mBZOk8c3Zv2OhWDnpW4+9KDlNxIppG0uSir7bnGYlptgk7Aj+3vbUd
	2ci+CyOzE//11Ifum7WBUzZv/TqwNFfPjHK3x8r5llNTo51x43znxoL7YZ5O6yp+g==
X-Received: by 2002:a05:6820:3399:10b0:6f5:cf41:7290 with SMTP id 006d021491bc7-70b88a1cf20mr959518eaf.30.1792760171250;
        Fri, 23 Oct 2026 05:56:11 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.176.166])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a83829a062sm62396fac.9.2026.10.23.05.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 05:56:10 -0700 (PDT)
Message-ID: <6adb596a.a932eb10.20726a.e23e@mx.google.com>
Date: Fri, 23 Oct 2026 05:56:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1820708004267045346=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, abo@medichon.fr
Subject: RE: [v2] Bluetooth: btmtk: remove redundant memory barrier with helper
In-Reply-To: <20261023093645.4669-1-abo@medichon.fr>
References: <20261023093645.4669-1-abo@medichon.fr>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1820708004267045346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1191995/

---Test result---

Test Summary:
CheckPatch                    PASS      1.16 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       FAIL      0.32 seconds
SubjectPrefix                 PASS      0.37 seconds
BuildKernel                   PASS      28.69 seconds
CheckAllWarning               PASS      32.80 seconds
CheckSparse                   PASS      35.70 seconds
BuildKernel32                 PASS      28.62 seconds
CheckKernelLLVM               PASS      32.40 seconds
TestRunnerSetup               PASS      664.85 seconds
IncrementalBuild              PASS      27.37 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: btmtk: remove redundant memory barrier with helper

18: B3 Line contains hard tab characters (\t): "	* perform the cleanup in btmtksdio.c and btmtkuart.c as well"


https://github.com/bluez/bluetooth-next/pull/986

---
Regards,
Linux Bluetooth


--===============1820708004267045346==--
