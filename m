Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0493C2222B7
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Nov 2025 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762004475; cv=none; b=t7tyR0re2yGZEOrpgljMPWI60kSy5Cqj54nV9191Vm/X7TMvWcZPkXs4tEC9z3x+QqHf7ZZ1jhzTqfEyfjXZEwPzZULa5xCqAfAOfY5xxb2fvb79xa55KEnFV8ZXdcj304J63eRfbyvL03FXe1fLyJgv/xZYNeTq96/Lvezlaog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762004475; c=relaxed/simple;
	bh=u08XEgvJfDSPMOUTeSxNZNqhmzYAK5x+y8Ixit4O5ig=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uP1QhyvmYlqatd9ks76BH4AO1MseeH7kebzz5+8angILfGzNlZF/oydVIDbQKzyXyyIgMYmSvE0iQxitduEpeakxoHLjqYggjm7aC0biknYu/9X4b2rlORTmlAEhZqmTMJK27PMgZj0poC0bSuUC5X8J5Nj+UvjwA7rmbeEODas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZy/GFX2; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZy/GFX2"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ecf0336b61so30026111cf.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 01 Nov 2025 06:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762004472; x=1762609272; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TYeBwBx/0l9YWtInMmbsS8KA6uqeeiZvGHg4xuBPjMc=;
        b=LZy/GFX2io1VfajI8909EqSyCM9NPx9yoX4QrBIkpbPjcfs/Km0HhzCgk3d8a7Lb+H
         cOApMG3+RK10CMLfnwq9JHiOc5s5fy1y+/GgotfJh5ChHDEkqAbOCgWKLKfrLGkZdWFI
         GgHOnGXBvHCjA20bzRTEiSqNrYTtRoXbnMTWq02KN2DNwHzPFzgrQWKWLg6uekqpj/i8
         QIL/tNqxop7nJwnhqEB2f6CRz/s8uV9BYafE/nH6b5TS4aIo+Xea4Fi+2RP8j/LXPnJZ
         zXTn1Zh+843MfHVRjjUjhDRbuVvxjEIWRhgXzAc9tvqbygw9IZQM9LxNxmAO6z0eOjZH
         3Wiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762004472; x=1762609272;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYeBwBx/0l9YWtInMmbsS8KA6uqeeiZvGHg4xuBPjMc=;
        b=ngKVkXcfHr+6BpaGQf9rwkrMz5X3rtasrbC+GjYJSKMw1OqgrJrGEvUWfAoqzu/YUC
         YOCAjeKDMlt5sN+vCl8kcZAFnLmIA3btZAfXMiKHnEtoru4w3lV8HhJrwVj8FaR/NgKl
         76NazXFXxCqLtoXw3YncXZL7enorWW/vFzCBmKWhfo+e6z7rCq3142S+k5DieJ79nzLr
         wqvMyTb/MpKMQq9EpVZmzWyOj1c79/R8f5Jfp3v7l8WLCRflj0LDvzZj8Po3H1VY3iky
         dkPySDTXAsbwUkxDqNljsfddH7uGprWGSFZOyq6erJdDyUf2v1Yi7bsT7PGbCXC5lLE/
         OwSA==
X-Gm-Message-State: AOJu0YxClX0YM3ps7MB7yyEWYbeJzEQ63fO1tReCIt4qUF7891xGFyUw
	Hvi1ZlVIPiWJDLixQSu03QaaNZkFWIFuXwqI356aUgPKgHSzttcqx+KHoGZcrg==
X-Gm-Gg: ASbGnctcJnmY6JG8X/9bw3BgFW+1l7mvlcYyd+T39THBHqtLe9iZ/B86QJH9uiWsNWE
	dplLKbQ8IYiZsbumYiopUY6vQx3K3DKpbFCehYlANDDNcZMf7kGtefSmcKutegrklmKb/1IvrTp
	1Ca2RN+CLjY+mBXy3mNApED28idh0C7LR5+sfhX0vlNsQ7y6TtDoJjmjK4cz0d597eV7OMfnrbg
	MT+KmnshFamI2mALKJtDXH8o3AjhgAbxwUvOebUOXP/w8Io08xHdv2zjGSetQWaRnduKTgdooNU
	LdIkbGuEcc+qmKQYciQGAckBA208irDH7dNoVqQHCeQA6K3SN6TOm79/jTHaxJPciU0x6QBMaBu
	xyuniSgArphXQq0Ykqgv0Vp3F7rttQ/QQe2gJDt3HCMEh4KNLzc9PZBgWwAFp6I6naehRh1uogA
	3V8FlneTNnMdePzDg=
X-Google-Smtp-Source: AGHT+IFv3q+I8eGdgIkDC7M577LltEMdSREjkggMPfiMUIQW21mqo7hZbfKKiZXLrhiSzAIg7ecfhw==
X-Received: by 2002:a05:622a:1247:b0:4e5:8d07:ce80 with SMTP id d75a77b69052e-4ed310a7bebmr101475081cf.41.1762004472499;
        Sat, 01 Nov 2025 06:41:12 -0700 (PDT)
Received: from [172.17.0.2] ([52.150.29.96])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed3538ae0esm26487591cf.37.2025.11.01.06.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 06:41:12 -0700 (PDT)
Message-ID: <69060df8.c80a0220.2b9aaa.712f@mx.google.com>
Date: Sat, 01 Nov 2025 06:41:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1852850367897730566=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/2] 6lowpan-tester: add test for header compression
In-Reply-To: <2fc1c535e6642706aad81d08bd3f8b14ee4f56c7.1761998984.git.pav@iki.fi>
References: <2fc1c535e6642706aad81d08bd3f8b14ee4f56c7.1761998984.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1852850367897730566==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1018491

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      20.05 seconds
BluezMake                     PASS      2586.97 seconds
MakeCheck                     PASS      20.60 seconds
MakeDistcheck                 PASS      184.21 seconds
CheckValgrind                 PASS      236.00 seconds
CheckSmatch                   PASS      309.75 seconds
bluezmakeextell               PASS      128.82 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      915.36 seconds

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


--===============1852850367897730566==--
