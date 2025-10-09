Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314EC1DC9B5
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 17:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760031873; cv=none; b=Fs1PWbiTtjbmjY+SJOZ8PqcvziZXAy5c9y5jsxJ8KrMFmBA7Su09lgAt7jfMhqUwOljtY+u1rgcYntTbOjphIdQWM4CteDmw0AmlWoOQk1/03L5/kAduXGHekL9sErHna0ChOcPxaAgSiEA8Ac6SDxmrbIRklZO2zmMYitJbzjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760031873; c=relaxed/simple;
	bh=tlf2/4QLvHrHQi+oB1YLueycAO0pnyGA6SMWktbtD+c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ond6NVtJ2t0eUSxOJmGd4OG3JfYYn3pWIV/RlkcoduaFKVsw3J7s2I8nmqbNNql57MYpSaw0vgxHB0ENPoXVRiHBnzXqOg3v+JuA5qW7Z7xY+T+uN5ltEy6wmtJ9l3B50aDEPBtZinFdtPHKqBRlwlTk2dZGvCw8ujxHboZsNAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gUvAFDCp; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUvAFDCp"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-911afafcc20so44870039f.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Oct 2025 10:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760031871; x=1760636671; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YoAVSW7xRehGkDiOkxXkPmSIV8jR2d82qubWP7UQ/k4=;
        b=gUvAFDCplo/pmf7YvYVin4jgUFiuY5w8ogGqKXyoXDMjbWofd08kDh0IbQSHL+rcNd
         iv6DTNmnw+3jr5AYhcmFt5QGccaTa4ktJW/X46bVbKNfba0nCyJmPBjgqpbkBHIY9nfD
         pcfjyv9jAHKK8UQK5Xve8Rs0bKNDvWiv1cYZyL/du8REuuP8WXX7PFxHjuFHP21hOfZx
         XZYEsuS4UhJ7STxX6UrP4AjUf4K30RMvYlkIcrUZtdeSXiF7wS++Elu7jDdS25KxsCLL
         sDdMW3EMY3BFvwyuK2jGANBlvkkPbGybOMVxf0PaeKljJhVwUUwqFNjh7TV9iaO9H0yK
         ippQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760031871; x=1760636671;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YoAVSW7xRehGkDiOkxXkPmSIV8jR2d82qubWP7UQ/k4=;
        b=M/DL3esCCd5Gbfs01qCznAYmhnVGzzFrsojj9epQUWwmYOEdE9mgKD5yllX5uSJzSX
         aqlS7j2AjkSWLVgY1tEKQDImwsempi2GAFau3OUujyaVfQwE+yoWJwaZWshQzq1Ggelt
         UEkIjdUmQMLAGmMXqAwyawWNY313JwlngvECosR4nYTvLKYqTenJzBfefu81RZdi076Y
         SaBbBmjNis8gptCJ2syK67aUhJnSc3MPaA0yQwXWNaujPm5GyyGO7UQKY4Ro7cm4BkeH
         +LSD4Wt1LRg0fe1kDQGNAhVw8iEaG4JlKpfR+HPPntdGECQTJViZxiMm0nwQGfySzyuH
         D+yw==
X-Gm-Message-State: AOJu0YwfyTwzBR1v28F00HSuc1Vzfr+krB5ACXljdNGTA6mA/x73ASo4
	3aBUQJ0LGBjKkCF5y2dkH8GgRaCb6makLKHKfcDYbo7k5ks+I2F1bW3+W9If7hwa
X-Gm-Gg: ASbGncvaOrPRnAscoFmL9ByBYuIbUBPlq5pW2ZfZkqB8zcDEer+ZhxohhpSd0GPGhcd
	bfRHLQ5za/jTCm8+FNF3ElDDFZr53N8Yu4OOkWpT0WMbYHyhygEU7p6ocpMPyPDe0x0AB9XmuAL
	bD/2zdWjT5CBzoLsKFsrDFRb1km0yUlpFRslDf96qFDtn3UuusaAcq/IfeDrde3zfdEHMxbPilr
	ywVijXWjhi7UGktu5KvU2ZO9B58tb5wL7vAOuZMx1mW3ojdzVAIkSZyL8wOmrFkTeFPpsei7F9z
	kY5dxZjOBvRx3RC9pqn1n8pjL4mI2Lg/EE5X3H5HvUZjJuySaER7lsS6wfF2e3yfOJ3Gl3zB/6/
	XGPESYhz4bRQpnZicxJ93i3rusr/ewNU2WgUwAoEoWqZn3DczdDucslsYib0QqHKCEhfYiZjueg
	==
X-Google-Smtp-Source: AGHT+IG3SZ7VAW4AGWxRZSvapYy8+jWVUbjppk5LyLAb2OyZ+rSetLdnN66deNjR6qIDt/w5Wbto/A==
X-Received: by 2002:a05:6e02:1707:b0:425:e850:b2e3 with SMTP id e9e14a558f8ab-42f874537cemr74145475ab.32.1760031870866;
        Thu, 09 Oct 2025 10:44:30 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.38.52])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42f9038bee6sm12046435ab.39.2025.10.09.10.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:44:30 -0700 (PDT)
Message-ID: <68e7f47e.050a0220.64db3.2e16@mx.google.com>
Date: Thu, 09 Oct 2025 10:44:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2634256870212020874=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/3] monitor: Fix instance where BN is printed as PTO
In-Reply-To: <20251009162111.221677-1-luiz.dentz@gmail.com>
References: <20251009162111.221677-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2634256870212020874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1009812

---Test result---

Test Summary:
CheckPatch                    PENDING   0.34 seconds
GitLint                       PENDING   0.34 seconds
BuildEll                      PASS      20.16 seconds
BluezMake                     PASS      2730.75 seconds
MakeCheck                     PASS      19.88 seconds
MakeDistcheck                 PASS      185.30 seconds
CheckValgrind                 PASS      237.90 seconds
CheckSmatch                   WARNING   310.25 seconds
bluezmakeextell               PASS      128.86 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      921.82 seconds

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
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1931:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3822:52: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2634256870212020874==--
