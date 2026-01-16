Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com [209.85.160.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C93399A45
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 20:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594327; cv=none; b=lCMr28UTwVZ+xFwS1wB5soJzqQWBkMxo/vfTmO3KK0mEvXWohku2iYhgIcbgOKr30myOAWAmRXy/O/EE/7MOY2HHyOzGftc+UMOGggg0Fbxi42f2luWR1p8Ywp65s8KDlZRItQIXFc7WT5qnQ7KNxVf+/j5uFhPf2F0ObuJquQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594327; c=relaxed/simple;
	bh=tKs9JhzwSSq2AbMC+ocp8aQ6vwmIHyH4Gxm1r8qzyfo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=taL09z16QZA7y9aPma0Y5A1uIzHKi84NJqI6OV/AI1pL557LMCz1L33kQ61PfT71TJM14LdEHo4u+pJh9DGPEWG/o3WmPCGnaajiKrlb4QRLLiy7SLMfM24c4os8EEppJwNAu1TvRtIk97UejSNTRVCWeb29inOTkZm02a5VLzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V24HOjaC; arc=none smtp.client-ip=209.85.160.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V24HOjaC"
Received: by mail-qt1-f193.google.com with SMTP id d75a77b69052e-50146fcf927so29767291cf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 12:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768594325; x=1769199125; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xWdkCAX3DXEgza96g7CpAoU/Mmqlpmu8vtCD9giyfBk=;
        b=V24HOjaCdQHxQ2M8ySYgCyGKjzdrqC+bEFrnyheC4pQGvC5xlB/G+/CYcKvvyh2JkA
         10iHy//+GPDhDXWwK2x+OZYAQDdAM+D2m9XyXYhG1ekZxyuAHKNXWF10GKgQwwDTT7l1
         Ti6PafKy8iGZC2vXpLfs81HkJ3ELaT++pNWI9zEbVu922zYcW35nWqvpxjB/D6S37Nsu
         Dkex0YO5CpDn6Eu3k+05JVGPXwT68JyPKePyChL2TgPquLYmZUiJuIuj7VfEVBi3pOOF
         h1L+FlwqBppfZzoQRj+ktU7XzhV/7vR1//0K7svPaixHvWy/xdFWeZanqDRLzzleUZxV
         WF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768594325; x=1769199125;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWdkCAX3DXEgza96g7CpAoU/Mmqlpmu8vtCD9giyfBk=;
        b=F6LVRWid6f82DkPzhGXfk4f009r2JYHmaLBqdNkAkgMhBG0Xs99hxzw3VU5U/tdmqw
         24rtnVm+TSrJkFMLjIPWLoDX1JZBjc0vP32QsWhwa2P6GiR0lhUr+reoaZE0Dto0PBjo
         KmC5wUBUrf3Blb+W7lnJexhsKnx2JkIM/3P8tgSv7XQ/n0E9xpyx+dH2IypDKGRHf1GE
         0daeQHVDu9PFJmtV7gtpgqZDtvrG7N+OlsutKMt3HVBkw1riHDg7bXh7t0hP23HRlzWy
         Ls9ZaV3ix0ePSayoG3gpqRhl3jfvi+xaVM9TGEwbVgNpxIZk0J82o0IbMsa+qyoIL43d
         CROA==
X-Gm-Message-State: AOJu0YzmpQ1qptlEoKXbveoER/YfdTRqY5GuoE3hgk2szUGbPMCG8uu3
	osbQHFLZwK2Ws8QEQsM2Uc6seAwObBltwZMH5WJq2/wyUt/RSfYYiCAr4Mqv/8K5
X-Gm-Gg: AY/fxX6KoMz58uMqYydv8Ll27nGyJZ8YZSdl/2AHbtcZj9SQbLBkDPmblli8zbOrZDZ
	hkoUe7r2QqMxFSrsnr8CIc0RVRMv5QsKD9tz15ce4uP6B9Cb7sL4EoObZxFFRe6tLBaQ1sxOeRV
	puA5Lf5LF3Xyw+57mD57/pLEB0GcWA5WnW0GsBv1LDT1XqssCGw9AiPwLYEMC5+3iBpQ6jcI4rY
	MieZKTjqy4Nse6G6RZc/BI0owdnt/Hp/nXOJNWWwoGOjkXXGEyC0+mj1g3jpUzYhk71O0XslieG
	9QftzvR0UacRqPliomu1cvQXgJYGYA1udrm3pbLsVQwhbbFA01YHx9R9L9486XilmDPLZxqFcnb
	E3d9XrloyX6fVjM1zFhVAJYeACrdy6KeH4ZcMh4FDNdmSFKhuLgYx+wBBCrX+OZOEgGNXVe338k
	WlQ1dSsSvQdtnX2QuY
X-Received: by 2002:a05:622a:94:b0:501:4808:73fa with SMTP id d75a77b69052e-5019f8e3ef8mr101905311cf.26.1768594324944;
        Fri, 16 Jan 2026 12:12:04 -0800 (PST)
Received: from [172.17.0.2] ([20.51.198.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e5e5307sm30894916d6.9.2026.01.16.12.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 12:12:04 -0800 (PST)
Message-ID: <696a9b94.d40a0220.49b47.e864@mx.google.com>
Date: Fri, 16 Jan 2026 12:12:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5533762202623759831=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/util: Add missing entries to bt_appear_to_str
In-Reply-To: <20260116191120.1768270-1-luiz.dentz@gmail.com>
References: <20260116191120.1768270-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5533762202623759831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1043486

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.38 seconds
BuildEll                      PASS      20.34 seconds
BluezMake                     PASS      653.54 seconds
MakeCheck                     PASS      18.48 seconds
MakeDistcheck                 PASS      244.62 seconds
CheckValgrind                 PASS      296.11 seconds
CheckSmatch                   PASS      351.37 seconds
bluezmakeextell               PASS      184.18 seconds
IncrementalBuild              PENDING   0.25 seconds
ScanBuild                     PASS      1054.19 seconds

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


--===============5533762202623759831==--
