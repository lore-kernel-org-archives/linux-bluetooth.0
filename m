Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1881C5F1B
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Jun 2025 21:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749419811; cv=none; b=SvW3SNXxJyCESp/v3w9lf1ejFxnGTi52kisDR7T91IAjjOejBR6MKBawCWPXD26OfsyrRzSRn3PddbYO4vgD50rt9PpHmCr6tobBNuTiD+Py0S5o3/BtXuw/JiRq8Pd/iTbSINuda99oRMtK2atf53oOxfcGyZpVp9Vwdm0qwbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749419811; c=relaxed/simple;
	bh=7k8M9OIZWtSqbONxoYykQgDVgQIVsmf7Mr3FUTCIVIc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WfqoBtmY/6nQ4yeLvpgYwO2GI+1O2LWowtkfFyKNDswGEPZEGTqC+BwQRfkaAmuyVjYAcv4/eDRP+D+PNRB6QOw5cXy8JwLwV2xFiFhP9Dlm/AhTZvm626PA88C6gTL0Wv7kbh5v7K5fu8x2qaIpQONaUmfoBzm1G8y/BO4VCqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVG9dcJY; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVG9dcJY"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-72d3b48d2ffso2817826b3a.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Jun 2025 14:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749419809; x=1750024609; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u5DYVzcSSUNTfHTev8iOD5LNdNW/bWcyPmOyH1JEtMU=;
        b=EVG9dcJYV4dhm9O0AQvO/BU160REX86vXT7M2nJhI2rpbb7rFWCFKuDSwTczUmXC6h
         x1C5DQdTATMQYh0AOaSsoi2wZApu/hvIw7sQUK5ELkVMu6NaCg7JZLQWVl+5z81rU18Z
         H6RvfsxQTYKsbLrXfO8EQzLQeGFLtPJh3Ne/LShQdq4AXyGY+sq0N26AVa0ksoiu2xa9
         qeSpQov1EBT8/mQqQBK0GBT7gMhq/oR/p8FcYC8BBuDzCrKI+Az9R8L3fmW5WonmHFIK
         3Rnvazn+00uv2/u/dVaUk6xgsC+7p2dbZjnNYrDIEA//twYn5a8JNjKuYZ+9YZAKeWWP
         Atyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749419809; x=1750024609;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u5DYVzcSSUNTfHTev8iOD5LNdNW/bWcyPmOyH1JEtMU=;
        b=buvTDVgrZiyArM76dmGhoGGOo/d78HPN10ypHauZLtsPiv1F7sBqXXJawvMknkiXNX
         QUAL31tAB4d/cHS8SHIAnjGy8lwGIFF0qaWHfGH0JGJcO8YR30yH5iGwtxs6HYUejlsd
         s5Q/XjU40TqNnen0CeLAQdiIkDMaejRzQoFaTZEVmjxHWAuhRvI6awVGnB8tZ4XDHU/U
         2QqhVDllpUvGFD1bzFEEbm8eWhhq2wNNnsVYAIcabH/2GrQiwz8lqrkpXtPVuOxIU59i
         YPzWPPwDKyDDx9eiS80iADQWUQKrg7wPayO1rRQyuQQ9aKfdTd81TLsL0lpp/8N1wUIC
         YJrA==
X-Gm-Message-State: AOJu0YxhKfqW5s1eI5IH4Xiwvq86UCN1PqtDOE9uqFm7fGRzymMuxDSi
	Yljd3FGzPFFA34D8YKmRTFfS3JC3OFp24OG8I+EzaGRxfuo0+D5c5NlRLXRrrw==
X-Gm-Gg: ASbGncvB8CtOeMfpAPEsb6Nzhs2GRcTZo5QlyIpnK0va5UySKcgdWV2I4Og6LgLxf4C
	xyx12wlfGBEZx+mFprDmN9HxOZeTS9dOrDzvuX9SOEaPiij3rgutzESKdtcWeJur/FlFW5wkwvT
	hJaODnCqU8YPM6Z40UfotzjwoaMfHQPF5AzOks6Io2xkR6oWaapqtdFrjLbfdF8CvFAqxtv4dFK
	rmNwFE9SB7JEaRX29SoEpPWgKtsrgM6dBjVSQ0N3DLf++VllZba4XsizGaF8YR6+bnKA1SihstI
	ufWcMJNDmMedBLj9qaQcgqJV/GEUjVDEycpoIgkvzopnleix4ysJyCkbmPqXwD1WMr/QOA==
X-Google-Smtp-Source: AGHT+IE0uvQWntvkzcO0AgLnVWIk2U3TkL7y6hO2FFqtPpBUZ5WsR4H8e8G40AC0eQF7jBnV6Ifw7w==
X-Received: by 2002:a05:6a21:112:b0:21a:d061:2f84 with SMTP id adf61e73a8af0-21ee26198edmr18268016637.30.1749419808823;
        Sun, 08 Jun 2025 14:56:48 -0700 (PDT)
Received: from [172.17.0.2] ([40.118.173.141])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5f782283sm4124559a12.54.2025.06.08.14.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 14:56:48 -0700 (PDT)
Message-ID: <68460720.630a0220.1b666d.f239@mx.google.com>
Date: Sun, 08 Jun 2025 14:56:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1436903362874541458=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] shared/bap: check lpac type in bap_bcast_stream_new()
In-Reply-To: <33226743ac1dc2803c5a90a1c0cdbfc97e3ecfec.1749414200.git.pav@iki.fi>
References: <33226743ac1dc2803c5a90a1c0cdbfc97e3ecfec.1749414200.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1436903362874541458==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=969619

---Test result---

Test Summary:
CheckPatch                    PENDING   0.27 seconds
GitLint                       PENDING   0.34 seconds
BuildEll                      PASS      19.99 seconds
BluezMake                     PASS      2621.48 seconds
MakeCheck                     PASS      19.98 seconds
MakeDistcheck                 PASS      200.23 seconds
CheckValgrind                 PASS      279.64 seconds
CheckSmatch                   WARNING   305.70 seconds
bluezmakeextell               PASS      128.05 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      911.25 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:315:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:315:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:315:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1436903362874541458==--
