Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97FE23E32B
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941914; cv=none; b=F+cDFbyPX19vy7a8hvo2CJlvtR5XMy6qwRFOv8szLhm6uXyBb0jmiaDGndvuDCp0ScMzQ7lYkS9y6VGAK5adEc0She4MAf9LlOgEcR/iXlcxxC5pZiW+sbUD9jrI3vxIEKQ0sxkMO1lrIoXsiUKBhFNfGIB0z6xqtze8VIWJefU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941914; c=relaxed/simple;
	bh=G79Oc/uoXcosMwqbwelf+9fs9oukI/RZ5COwbUyYKt0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gOsFLxlSmQG/OMqNsDGmcJQSz2DHl68t3F4pu9J/cr3DYBFmUfZsHp4LQWT4icepavtWyQ5TJyHIk7lCuqc3cSexAsmJpPfjvb8jPM9FnRxcourAUfDLVD2n/ocA0AhbeD3y/L5EOOxYFFMzIUXyrif55w6RPmZqG981sYsOr6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXMbB6Ph; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXMbB6Ph"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223fb0f619dso69490505ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 08:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745941912; x=1746546712; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kLS52tfgS4t/FhQ5jokt2p5RB/E/0VD9dIEFEw8mpaU=;
        b=fXMbB6PhuRitUWMtBFWK5uh8RGJph59cqT1Q8gLO9pQ2GNSKZum2q7SsolgrI+HrdF
         FGbTVTnC3eoT8ZDc2GA4jTDgnBKLRTnPXYALktrL6YZzCeQpy5hU33J96Wolsa9i785B
         fK7inaouzI+MaAOokiPIKX1KhZl40wkS6TY90ee3OtqcMGBzz8EoiEWgW54Gx9TLs5VW
         8Bzmfv/x6HQRMPQVVf9oumzhEEc5XzIhZaQQCXfgDycmezMs4mPKC5EoPEYHgi/e9lsm
         1v5amE9//OhGlceju+WdnVFBnTHU+/oWLhKU9yqOH1z7UlQQISjGXHKbZTcJiamnBp53
         1xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745941912; x=1746546712;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLS52tfgS4t/FhQ5jokt2p5RB/E/0VD9dIEFEw8mpaU=;
        b=UDol9pYQR05kcGZBxHaiTJHLl4OcMHE4DkCoaA1LrYNP1UKkseudrPAMRCf34uipBt
         0gYB6xBAfHwfZWOzLNCFfdyuY/CAb8UQetSXdni+weh1exMmlwjVdOKzY7UK/8jYf52r
         9146zZSmGZjtV6Mmg6kSg1HHn3hNevJNHM9gAROfYO5puJ58q+85n9Q6bXgCzyCNkEXe
         3IgYMv84TZrIHyXn8tFtnY3kxORxSHfmUAzTNKAsK+cof1HMh+yDDgCe6bMvPKCrh77N
         vy5SeeGX39FmzHF9sVadp8NoWNS9T1gTp3iHG1guVdQN1Z3JLfcw7wBAIwkm9XwR65o7
         U8qQ==
X-Gm-Message-State: AOJu0YzBMZXVnNELCvojigBBmoI2GUPUQY3vOBL5WXCS0ClUTZX/0iaz
	SNZEtAxEZuVWNZvBgsSbfA77Hs5dwUsVHiewmToKBLzkWM6CjfaZ4nhvYQ==
X-Gm-Gg: ASbGncvTSBz7e2W45q+rq/jzsUGRhqMCfpXgJgv0R2H8t/OwSvNwPG9gRImwvt8qYlo
	L1LOFYD88rY0QuJ2GKuyEg6bU4Q4Y3f8DPcwtcoxh6oRd3jXplV5I7Vaj+YzlHJbBL2vWWubqm2
	wNpQ9aFVuiFsKOCImu78P0+qcjtdhV/hzZg7x/ExFectJE4iBz+2q5Kgf/86Fg4aycln485Wrw2
	YjPxjcwqP1cYeg1Hwix5CM7I37ZMFUSwOkiAWZ7k+EeDSXS6A3Sg3ht0ykLOaowkiTfJA6fnSNa
	zX9aXPvWE7DZHVepgfOqhVU4uB5zlzPxtyjFQeWVV/Zg
X-Google-Smtp-Source: AGHT+IG1jzXcWGw3yE3CGroNIxFWx9bpqypJJzFUzkhtYk8SqPSCSMzxr9OAB/TlFfXYqApcP2N3AA==
X-Received: by 2002:a17:902:e948:b0:223:517c:bfa1 with SMTP id d9443c01a7336-22de6f1175bmr58250235ad.38.1745941911850;
        Tue, 29 Apr 2025 08:51:51 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.2.208])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15f8597e0bsm9197730a12.44.2025.04.29.08.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 08:51:51 -0700 (PDT)
Message-ID: <6810f597.630a0220.10701.f327@mx.google.com>
Date: Tue, 29 Apr 2025 08:51:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2664547387841097875=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kernel.org@pileofstuff.org
Subject: RE: obexd: unregister profiles when the user is inactive
In-Reply-To: <20250429141533.803295-2-kernel.org@pileofstuff.org>
References: <20250429141533.803295-2-kernel.org@pileofstuff.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2664547387841097875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=958158

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      20.64 seconds
BluezMake                     PASS      2678.12 seconds
MakeCheck                     PASS      20.86 seconds
MakeDistcheck                 PASS      199.06 seconds
CheckValgrind                 PASS      276.37 seconds
CheckSmatch                   PASS      306.71 seconds
bluezmakeextell               PASS      127.62 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      925.74 seconds

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


--===============2664547387841097875==--
