Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA4B2114
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 22:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752530442; cv=none; b=fC6IVe0rrqeUNP8idG8fUe+cQM1qKQ+PAK+N4NYWl029DVaoMLXlyHfYPrrhxKJ3tPaw1hySeOX4z2xfbbD4ejm8rH1cpHUMPJdFenxy2HCh1BK0OqXB7vGCQ/6PwW084YwRkDR9Fnp5hDjuf1p7yPBu80P1ttQ3DSpRpFhbvpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752530442; c=relaxed/simple;
	bh=gLyhHaalEMdSi3vM+119d9WlGjvT0fNuv2UfCaCcdbQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qSNVBxl37ypFkGtRemFUSG+I8K85JYjRe/xiVKAD+OTvHAu5nNAscX2Cri6IMNYMhoAoVNs0drp75WRTJ6MfOJff3+KUJRwKuErCIUVF8dqqJYbKsOB1Y8pCQcDCJXLjeNj1Tu9z9l217d8plr6lhEHOeMeYYQNZeHo2Tpi3oXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLmCwZOH; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLmCwZOH"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-86efcef9194so196725739f.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 15:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752530439; x=1753135239; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dfn5FR4TdrhTdAEpiEnLdDiH8UVV3NOwXG2z10SELak=;
        b=DLmCwZOHJBmKOaXDH1Mla9lJaFM5gI50Tvuz2EYnZ/wJgalKLtljenRldGe30Ys4WY
         DysPeVK8NUaTU0k9xaBDPyTHeo0wNjjXpuZQh/NXIc05s01J/k3FotirSJX8xTVfwNEl
         nWH9lBSagEMUn4t5zebyU7yyPoOElSrMTgz4jRYQg7zJR58c3MiMMWb4GTt4tLWhd7Hh
         4qIWkcwbldhc6DtprTSXgleFGysWdGrPGpugz0CI7Qf64LiNyXTu5HkQyPyDItEbMhcN
         f7FOMCPRWjaARWTKxpPgDQG8JLMd1296uk9HgZrkMTyVd20F6UgZB7AfMXtrvgzsUBgc
         9qEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752530439; x=1753135239;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dfn5FR4TdrhTdAEpiEnLdDiH8UVV3NOwXG2z10SELak=;
        b=GeJcI/C75i4F5dtrd3/0Js09J4mo1dKC7araOBijvt+3iUrLe3mZC/mqXXGPbnaoQB
         7qYkgztO2WL8EwOwun5XK3ATCP1Gzz12MKcTZFJhEWeYVzZ+SKfdkTWn/zOKyye2MK1v
         XJ6Jt7QctDuio/I4JOi1AsLox8k2y8nDLjqlUcJHId7zYB3buVI353Ht7BPplDK44OxW
         16g6RDkP0X3j4gtnQq0SjMEmSQwB0NdBnDe86D31MiHuQFhItLGan4hCNpkMs3cWtGaE
         DoAG6JAjaniJgcadHnooJwI5JDLOHNJ/5ERugAinPAGiMi5DVSi75nToUT0stBdTZ3Ox
         pzoQ==
X-Gm-Message-State: AOJu0Yx5SOvsi3zfRzY0oKC/nQAqEkOJ/tx/SkILy7uYQn2BHd+F87TA
	2gMgPr45pS9HkfJJ8vLOvp7x1eGowyGsPmfvqBvaTGkcQ1N2L/OxpS5VhBM3PD2S
X-Gm-Gg: ASbGnctadNti4ZjFEII5FjOH9Z2AccqZ7uKa7GlEm4sj9nrcdJpWP1KF8zYzdOMYtiA
	Qvbl8bojaLgIXyjZEORL0AIhJXoigfHRLtIVGbbiN2v66gaNIYzRp2yimVRE8y4ldRNy2AvwfUf
	8ryG2YJLkW5ddtQYFt3I84Zpn5m/w356/MLVLNwVrmNKJjNQsJlVk4DSXB0+Seccc5H4d7mteHE
	GPe6NR1iHs4z0sWHRIGitbz3YkCT1qnBB7DamOuGN/cQL4S5bCnmzqXAsXe46u6mmDW3RZRkEun
	M2C++0dm9/2ZOStQI0vzDEbN3wJ5eMOuoOz2fV5MHbOiN9e9ZQXNix39xdWDZLJGQo8RVyxTRJU
	0QhB1InpYtzDg2gnuKMjAE/cB7BGt
X-Google-Smtp-Source: AGHT+IGUVGppRkRN+6EtMaxc56nhJFyYuuQS2JHitmbxaLVJrzI4wHqC6zJvRJSxksMevF5BQVDTLg==
X-Received: by 2002:a05:6602:6403:b0:861:6f49:626 with SMTP id ca18e2360f4ac-87977f752f4mr1833024739f.6.1752530439317;
        Mon, 14 Jul 2025 15:00:39 -0700 (PDT)
Received: from [172.17.0.2] ([13.67.150.153])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8796bc5bca6sm272429439f.43.2025.07.14.15.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 15:00:38 -0700 (PDT)
Message-ID: <68757e06.050a0220.431b8.3cae@mx.google.com>
Date: Mon, 14 Jul 2025 15:00:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2989560069298338266=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/5] device: Add btd_device_bdaddr_type_connected
In-Reply-To: <20250714203519.345226-1-luiz.dentz@gmail.com>
References: <20250714203519.345226-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2989560069298338266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=982213

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.33 seconds
BuildEll                      PASS      20.15 seconds
BluezMake                     PASS      2519.77 seconds
MakeCheck                     PASS      19.97 seconds
MakeDistcheck                 PASS      183.84 seconds
CheckValgrind                 PASS      236.40 seconds
CheckSmatch                   PASS      306.15 seconds
bluezmakeextell               PASS      127.83 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      908.01 seconds

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


--===============2989560069298338266==--
