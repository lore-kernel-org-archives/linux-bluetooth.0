Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E86879D0
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 03:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740540654; cv=none; b=rzDyKb8D/9E1vlLg58thsmarOzJ2nEZ0FCP9/j/TmOvTyaeXiUqZgddJrI+18ClbUPdhnI0xKOx350bGtlNEQ0EB3s5mnl6+lUZc41Ui2+brkoDMr13QjcM2z/sHOey9UlAQzXrxjAShkJ2zUSCSUZntQG7k+aBJVnWcTw3VKqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740540654; c=relaxed/simple;
	bh=0Rek7uYlY1+R/NHssWE0P+ob251zgRmRF6cwMbwmDKA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BbNTjLLo/GbiHogqdXjeSsJgOoORaI02daxi9V76fZcHerhbQUgrcWoVo2y/VtdQEreH2CiHIzjZPTyF/QoOSPoo8yVDp2V3B6dCM4M9wK8vsKb48J4RbsSVnY15T+oxk41JlOdV1Wjb8VUU/s3jciz2AohkYA1lmoiEZW+8Ri0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OaSuvK5u; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaSuvK5u"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2212a930001so60545625ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 19:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740540652; x=1741145452; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8o3wDw0DV8tZrXrQJnT9GasMa234bbRnmZ0bolNVanI=;
        b=OaSuvK5ucPLI/nBAbnMGi2NOqgZIA6EL6uMq59ViJeu/8Lupdx4NuuVzHKe47IZzht
         9O/wN2duEwgckn+xz5eB4r2NE+5iblIsZgZIBTnAZYcn/1SyC8570JYSMTFqbwh2ANE/
         MMB9GiYxN2e9LbhoK4somPS+e6HyNT0n9Rf8Edlx8MkGkONf5X516g+yRB2WHyo7/sUd
         kxN4okxEbksoYy6L0Eq5J5mDb9MWAsPEJF3uLVjbwSJrzOu7x6y4FerD/9mSh+HaVedj
         xf108JALg34iO5EN8Qy5KOOVhl44m8SNZIe/KMn+ERxoXn3CYlVNIbpj4KgR5nnejB45
         cyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740540652; x=1741145452;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8o3wDw0DV8tZrXrQJnT9GasMa234bbRnmZ0bolNVanI=;
        b=sph3o/CJa7+8EcyyqnM7lHeFp+pDr/Jem9EXkaIKob6pXDjc8gcIwSbR0IH4E8kvCl
         8HcKgG1X7zhZP+/Cv/dKySpEwnRmDWLTXB8Sfgh5WoIaciYnEXQUjK/W5a8Xd4hqXgBK
         fp45fd5iZQRx5OVGXn5ibVBCM6Nxszd42Q3RlU1CnQMAfD1HazoV9UPDSH1lzcPMotQ/
         Wn4rK2MCHgH1o+HG8zC8I1CXnwTVBHaHT5h7puE3ZzFsNxn5T+kQU3i9+oh9J5yxJVUt
         80WhAhkKXEmIZotBE4OL6DSTQ2F3awXgFIKC5g66jQx/V0g2nGtSUmGJFWXmoZ1yuyln
         ZnAg==
X-Gm-Message-State: AOJu0YyNXW9AwrK8oZHsQWJPaimdcqAEVCtBJUK1B9fqPSsEaVP4QsuD
	/V/utdC3JFYh/ed66qdwXjuLrH5bYe0+C+r1TWWLAvNGDDhdBseEy6s1rQ==
X-Gm-Gg: ASbGncvUabfXbjaZfLpF+hGR06/8rGWRg4yBj0xAHaD+cGMl9bMASxHdZdWfds6JT5F
	UEjY14gjZp95KEIRi9RnSiYjMGl6jpq/jI9vaG07gwWUSSvrhPcaBmNDbRgczj/RKxW/6Lyhzqv
	DnDMAOgrJnTQWcxvVTr/0+DK7TuQouk0S4SYP1KYIyTG+41GXIBIMisT9QEe5x54W0LLPcY5Uel
	Fw5DSpA0QQt25QTGe1d8x6AVOKIjCksPK0rsyYHSKf/RdbAnRqhvkQ221fXIDxXysnzKIEpCnyJ
	7skjjXSS3ZHbvdjfPdTR9X+GZcGXxNqb
X-Google-Smtp-Source: AGHT+IGrk6Cqn6LGxKWTYeA18oWoCIOdJjqzRwKzsTZUWO5xxCJy4drcnX9iSwunbtR+61aXmnPTsg==
X-Received: by 2002:a05:6a00:13a4:b0:730:8768:76d1 with SMTP id d2e1a72fcca58-73426d815ccmr33930380b3a.19.1740540652500;
        Tue, 25 Feb 2025 19:30:52 -0800 (PST)
Received: from [172.17.0.2] ([52.234.42.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6adad3sm2439626b3a.15.2025.02.25.19.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 19:30:51 -0800 (PST)
Message-ID: <67be8aeb.a70a0220.28d165.61bb@mx.google.com>
Date: Tue, 25 Feb 2025 19:30:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8932809414345746993=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, devnull+ye.he.amlogic.com@kernel.org
Subject: RE: [bluez,v2] adapter: Prepend the new added device to the adapter devices list
In-Reply-To: <20250226-leaudio-no-media-v2-1-8d4dd95513ed@amlogic.com>
References: <20250226-leaudio-no-media-v2-1-8d4dd95513ed@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8932809414345746993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=937802

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.30 seconds
BuildEll                      PASS      20.24 seconds
BluezMake                     PASS      1438.04 seconds
MakeCheck                     PASS      12.84 seconds
MakeDistcheck                 PASS      158.69 seconds
CheckValgrind                 PASS      213.86 seconds
CheckSmatch                   PASS      285.58 seconds
bluezmakeextell               PASS      98.17 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      865.63 seconds

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


--===============8932809414345746993==--
