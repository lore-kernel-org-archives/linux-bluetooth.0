Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8A716131A
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719935203; cv=none; b=JPJ8/4lZiafoEOm9DPt+eIxJKFzCI1gnlQuDoelBldMJzQogT7FKoftZVWMSsBHnVtw4SrHN0DiMD7CgjAA8vfmO9EadhYwjbkP25tBD5AgGOECEU+GsqOj/x5afoOvAITfgObsKJj1R6D2euLGGaglM72zoJPl6NlYH2MMewtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719935203; c=relaxed/simple;
	bh=TZDQI87V70AfVTPoVPKoj+Zc88N7h4OnJxu57UuTzL4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gJYFASPSjPZSHjSMf2b6bCKeQkK7EWThpW9TbG5j0vPL1gXcysLyDAZIG7G3c+ldHbbWRHkunkDbvUV6rSL7GYGkDEWrhop4GMjQP4MFuaR8uiAqCXGqNXWO4IxZQ8HyHQqtMTdu3JOF1NefPiDZaBjgoCjGslGWwXO5oWcEZ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSZzxlnq; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSZzxlnq"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d564919cd6so2593024b6e.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2024 08:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719935201; x=1720540001; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=m2HNg1kDtGAI3Vd6RG/TAW+woB1WFlMLukyOvKLc0p0=;
        b=TSZzxlnqdQoBJDacdozleCYSUy2cnYvMBoZRqdni3c5dYh2jg6NwLEjQVCtbPty2Xd
         LJOZt8ZywFJp7m069NxC8IYgFGxb9NRoNBsdxawZO++hdZ2ZhG2nkhsuoXPPLgB4re9T
         ophQb6k3XNbgAFp+mI3ZUXj85E5BBrbxGs6Gx6cMTuv+eMFdjkFcx69fm19Mrj85YbTC
         +veGaMQYDT20uBSwkqVnlnqOUvB8aaladAeZdIi85eH8IcF16TcWAxjDlJISyQAp88mF
         FrAmrDKa7oBBGZieLDdeEeuIFDDI3U76pLdvdj5wnELgltc2SZPDiQXrgtCEv6ieqJGS
         DZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719935201; x=1720540001;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m2HNg1kDtGAI3Vd6RG/TAW+woB1WFlMLukyOvKLc0p0=;
        b=jfn6DhTfTpNG1NFD2mVHj41SQmYX5R6mO5PayJ03ILPdiiYEQwSiGK5JPVZQCTC1d5
         bcvDXVUxzbnL77I+KnbGh3ckkLvhSM6Stnd0vSzAATb842seY0JGEo3eX38AXpkgQz3i
         03rg9TZNql47mu+QWKX4fdvSE7RzTnryfi/8vumv6jn5BWhtC69qmR3q2d984AODcdNo
         nVHjgDw38veUsGacikDTjTpMHJG8B9nSnbUR7PDACAm+ypWU0RVz8pn0XBRfBBBBI0wI
         GEI2kRTNoznWOz57XZrTzDVYg/scXJBJGq9PuYXBBNEuXQrlQB5zr3IZvYJyeKw8Xy5j
         e0gA==
X-Gm-Message-State: AOJu0YwAJv89NwxD6nhA3IhSIz9qa6/Hn4hp9XoX33Z964X4tdYtnkKS
	/wD0VK+zRoNatk6M+GjsyZEgzM6eEv59LoAxrkm+j6xg3Agy+e5x0SpQzw==
X-Google-Smtp-Source: AGHT+IFQ3mpuCDzGns6V0cjyug71SlSo5svRJliKGPcKig0tuWGL5CkZ27p+6M3iegrsLS9rzofdgA==
X-Received: by 2002:a05:6808:221a:b0:3d6:2dd6:2a6 with SMTP id 5614622812f47-3d6b30f46bbmr10714071b6e.7.1719935200270;
        Tue, 02 Jul 2024 08:46:40 -0700 (PDT)
Received: from [172.17.0.2] ([13.90.174.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e57645asm44936246d6.57.2024.07.02.08.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 08:46:40 -0700 (PDT)
Message-ID: <668420e0.050a0220.29347.2117@mx.google.com>
Date: Tue, 02 Jul 2024 08:46:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2418131682234605688=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v1] gatt: add return value check of io_get_fd() to sock_io_send()
In-Reply-To: <20240702134106.102024-1-r.smirnov@omp.ru>
References: <20240702134106.102024-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2418131682234605688==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=867565

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
GitLint                       PASS      0.36 seconds
BuildEll                      PASS      25.58 seconds
BluezMake                     PASS      1814.43 seconds
MakeCheck                     PASS      12.99 seconds
MakeDistcheck                 PASS      184.08 seconds
CheckValgrind                 PASS      261.93 seconds
CheckSmatch                   PASS      361.97 seconds
bluezmakeextell               PASS      126.68 seconds
IncrementalBuild              PASS      1686.86 seconds
ScanBuild                     PASS      1056.50 seconds



---
Regards,
Linux Bluetooth


--===============2418131682234605688==--
