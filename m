Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B905A237164
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 21:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753133535; cv=none; b=LXdPPSmVlflGHypXQEJBOSt3r5KXATRVz5dwO4Dqwf0yZ8WxxqFbxeumKjX9T2jt/LD12ROlplAFC1nUHxEw7yfT0jzb3yS8/dK17qjN3we5XLYkRI84Dhg+8aAi+2wh5atKgNYiTZ8ZMlngMyqnhelqeR3rqGPIFPVQvqK/WUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753133535; c=relaxed/simple;
	bh=QtPK0pdSS0cQmxskXDTOBHVMi+CuTBi3gf54Oedh5To=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rMYcYcNXgi2yO4lE/RboQ4hi9xN2FMkG2UfRydyA48QvUi810ll333qaePoYZCDX/Im8vF9YmSJ1VDH6H//QVaLHC5ms7RXH52/o0zfsKg6TDSbQ97i5m7FPSdebLA70RBvfqZ9HF/aAY4dIYVYAiOq18zu6gi3+FASLJaAdbQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=id7QDBNn; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="id7QDBNn"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4abac5b1f28so42157721cf.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jul 2025 14:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753133532; x=1753738332; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KlhTh31fLvQ4JoRKOdj41XC9VBOqSmR6jp9c71CPE4M=;
        b=id7QDBNnaxPlmmlGpkkyhccJjXg5LIE1YDQzvICTOf5Vib3m++z29h1SEg4wWwXX2F
         BPK7giwcj7/w+598W7IN0sSUieBCbnBGQ4QSolxcrqPjWv1up0pDuXTN2bhbCmknM90t
         mK3SXiofBi9UL171BznKvp24YJ5jl+c0/2+t7T2puz/dsXj6MwpFxPfq5B/GGKGoTSwo
         U1GJ93k72ObQWEJxzlsShN94fzdaeBET1NpaWsZnFbbfKLDpwRGJByGJqGtvJA4JkuCz
         q3hAgbembx+Xvwo+mK4bVYhz+J4YcVnqHnkRrVFFuo77my3uKqT3PNGkjeFcX9vpXNSR
         3Fgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753133532; x=1753738332;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KlhTh31fLvQ4JoRKOdj41XC9VBOqSmR6jp9c71CPE4M=;
        b=iOTMQ+q/TXFVXuStLoe1dvRgRe5eeI7AP9IE3eBqBjK1H/cLy9afnOUXeNwcONe0bn
         NxHM6WkJFPhtZLpEJ/TbGd8fZXrnDsgc7y2nCnNQ9y9JyuPDJm1lCpt22NYb2QZWOMk9
         jFSuOARIbm8BM6W4zOKCF25Wf22ZfdrwNouRzTS9lCKKDm4US4HGKttY/D5FffFJc4l8
         W2Zc1o3fjoscbcH2FOmWwzhVb2E4YQR2qSBIoy9eE04ueOdd8/haLQV37P1IuaqTGB4X
         JIqjjpd5TSDXKqL5VFeJlWpsENEPIuzWn/RdbIc8hicfG6x1aFN2MmpGiI+GQKAfMv2w
         hVFw==
X-Gm-Message-State: AOJu0YwijqlBjTyypUPoGaPinagcNxKrB6cjWqCNUqyGgMd9Uh25BPk6
	rIM/sTYnHIOb7vdhx+HMa27lVtSZJIFI3JO3DOYqnXRZqF+ncMlThyzRNmMsfw==
X-Gm-Gg: ASbGnctsYoo6ITwTOQjDL6LUThm1xKTNh3GiwGvSTLJWX2uF0kawKgiFQTU3JUUNjed
	qUx7PDzMKNF4hhGKORu6RTYzkz0hqPhLnYQ0kFCkE2pMWS8uq6EOFlezAYADRhSb4BTpX0TRnmz
	+q8nrknbxcSakX+1F9Uta2aphvb0YFvIDWDUK7Q168gfk/fr5/uCi3sJ/V5v8LC7GrBsI5GOM//
	SSnpHcv4vUeGU/Do5EJyC3ZxukcHeWvq3alEg39UbqlFjJqetblgk0qibxy+gh8Xpedxlmj8JPD
	yg2A4Mf3NXRZIC/Q/riHtKQO5F0PLslaeO8aQcI9hNp24Rf9hyux2tQWnr6jLF2QHSUltRBI4Vn
	0BTYYVSwetZpfitFHlV4NbD6nWcAiUSCvKcqxvA==
X-Google-Smtp-Source: AGHT+IEAVSgeJEWTxTEgv4g+7jdisofcuAQxCVzJP3XGpgPN4PFDolvA0I//RO+1UAgRdzVmSTd9DA==
X-Received: by 2002:a05:6214:311e:b0:6fb:619c:98ac with SMTP id 6a1803df08f44-705073f4e81mr246232206d6.39.1753133532027;
        Mon, 21 Jul 2025 14:32:12 -0700 (PDT)
Received: from [172.17.0.2] ([40.79.247.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7052371669csm39838156d6.33.2025.07.21.14.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 14:32:11 -0700 (PDT)
Message-ID: <687eb1db.050a0220.2a9c86.d064@mx.google.com>
Date: Mon, 21 Jul 2025 14:32:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5628635365211292933=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] client: Fix gatt.{read, write} not working on scripts
In-Reply-To: <20250721200933.1102559-1-luiz.dentz@gmail.com>
References: <20250721200933.1102559-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5628635365211292933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=984445

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      20.49 seconds
BluezMake                     PASS      2636.17 seconds
MakeCheck                     PASS      20.59 seconds
MakeDistcheck                 PASS      189.93 seconds
CheckValgrind                 PASS      242.87 seconds
CheckSmatch                   PASS      315.63 seconds
bluezmakeextell               PASS      131.75 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      926.47 seconds

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


--===============5628635365211292933==--
