Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C242DE6FD
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 20:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751489722; cv=none; b=btabxuJKOD/DLEARiu1enCO/1bPyAIhWEhlwc2tYXOzWrggu/32ZECJsi20zEFr7k/R4pibIM+Xfzx3KpAFQD0jCe6n4Mf84aZyxdp9VNFA/ItirNya9ODD6uSa7J0Ov0eSDja29qvZh8KhxPjRcO5L1UP8NSAOGz40fqE+zCXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751489722; c=relaxed/simple;
	bh=R+T1dSHoipYjyfUFMZEhegYpzP3eu34r94qUfnCqMvE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JMPUpSZcsBZtT3lDoKB43LotO7PfktfcGCwn7vrsMq7uLWYYted1/W0b+9SkRvbCy4DsHpdj89hSqFrGyjah2JEER1fSbAEAaHlND8b4uOQDfrGcolt+H0vHpcA6afPls1y/Pe41a1SiypC5RW+qcKgiiQdh3GnayR+fw9JvEqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOO0RcdO; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOO0RcdO"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-235f9ea8d08so68161425ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Jul 2025 13:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751489720; x=1752094520; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iRtswpth0o4vngqvMTF8fzSJYzctzj1lYioOdoX6vnE=;
        b=OOO0RcdOjDDscK2XM0PGYiZjU17j7w/rO42b9QBJJpg1tNCIsHkxDk+01ll6ZZdvad
         +I1JMga3u5bWOYxqcs83+7LtsKu8DtLnEVQvPhq6RWjQf+QoQx9kZq60Z8oJaJJcXZ/F
         //IHwE7m13LZGNKaCHIyRoRSB8nKiwQzRDiKBqUd66wJkFZ4n4qfDIzCAF80xV2dcJfb
         6FTrDCLUC8mrm5nepXMFA4bAj9COh/Wo85TvQ3F2d0U7jnh0Lj1859CDMbNm2W6/xkVD
         QWxMeqBk6BYFJJV0BPehaA/BzievKPD6mpcZqEjhwUE4OLe24Q1O/4FMy4S0XmtH1GJH
         8h5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751489720; x=1752094520;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iRtswpth0o4vngqvMTF8fzSJYzctzj1lYioOdoX6vnE=;
        b=ICrGxGlEgc52qd/lYF1STL+Hu6TyvboOTlBxpsV3R69L51gOphag3r5rDYfT+AwDNk
         +wYgSLLO6Oa3oBSMdGZZRviOfeXq6ObkbDuLbzGr/tHrmPTAm1i6a1POSB8mEvCNGv6K
         0bS3AOeKVcCnUFhLozwYEsv8TiaQN50AP19bxk1VIhMx73ljbUL37q1DrqELbZuilzG4
         95xJ6u8gz67AagRzGzeywuvh+wcK+m9BnEeDsPt+HFFOmKL3Ix4XYN0VVrOrs4aI3a/I
         WRdkNsBKSJLmLmjSyUbOSuZHyIhqeWbnTaMMrrhJhibylMHRrGeHLoWiqJdocx+gF0g4
         VM1w==
X-Gm-Message-State: AOJu0Yx+kpOB00GTNhGNyHY1tCsLsRsDgRMc4aASOfcZBgG0wv07XDzv
	0EqNKZHdj0G9SuVXEIGF8gEcKDyFKXbc7kv3oYg+lnYdSjrZe+zyP+lyOZTQGQ==
X-Gm-Gg: ASbGncvoR/YRZ9MGcdfQdYdCfY4QsBL3sRQ8r5nsQHYbISAXWwgxFA9L/eTKVVeT+hC
	cSRUmhbMX+cg/t19IvHsTJDgEvXg7kSGxXsZGea4oMi1Dc72JhXFvdnljzekr2W7JMGlcLEW/uf
	W/xg2vy0GpBLEYjwvi2nX6JaT8MGxLaMZjcd3b2rLoS1ZFfWstBleYZchXp2RNQyaNuD07rwQ0t
	kAwqpIfQTuQ1bLM2NZCuCFW7ZdhXdS7XapNqkPZmMqMd5JV+n1RzH1O/f9eQHyGKURWwJwGmB8L
	nce6Q2f7ucfUmgdRL6kOo1LW5365tTiWVHLsUDuYgbVgWHzXXWSjna5n1cbNThAXIQV3
X-Google-Smtp-Source: AGHT+IGyW42qEiq6IiW45kbN6/p6WPL47Y3A/sg/+s8lY5yEVkM2WwVrGh74SaKglswggnCxVUuFNQ==
X-Received: by 2002:a17:903:1b04:b0:234:8a4a:ada5 with SMTP id d9443c01a7336-23c6e5b5d10mr55626085ad.37.1751489719941;
        Wed, 02 Jul 2025 13:55:19 -0700 (PDT)
Received: from [172.17.0.2] ([40.118.252.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39bf32sm138666745ad.94.2025.07.02.13.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 13:55:19 -0700 (PDT)
Message-ID: <68659cb7.170a0220.378fe6.2add@mx.google.com>
Date: Wed, 02 Jul 2025 13:55:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4810102868386794056=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] unit: Remove dependencies to android
In-Reply-To: <20250702192610.1547665-1-luiz.dentz@gmail.com>
References: <20250702192610.1547665-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4810102868386794056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=978340

---Test result---

Test Summary:
CheckPatch                    PENDING   0.44 seconds
GitLint                       PENDING   0.39 seconds
BuildEll                      PASS      20.49 seconds
BluezMake                     PASS      2702.29 seconds
MakeCheck                     PASS      19.93 seconds
MakeDistcheck                 PASS      187.30 seconds
CheckValgrind                 PASS      237.04 seconds
CheckSmatch                   WARNING   306.23 seconds
bluezmakeextell               PASS      127.86 seconds
IncrementalBuild              PENDING   0.37 seconds
ScanBuild                     PASS      912.91 seconds

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
unit/test-avrcp.c:373:26: warning: Variable length array is used.unit/test-avrcp.c:398:26: warning: Variable length array is used.unit/test-avrcp.c:414:24: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4810102868386794056==--
