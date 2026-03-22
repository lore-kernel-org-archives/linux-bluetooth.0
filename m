Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD38B2D6401
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Mar 2026 22:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774219122; cv=none; b=mP4jZMrtN6pluYhjEygnKc/PI2M6WETOw4MVkJ++V4D8cbQ/bui9U3mv+nDYSt8laAfGtaNlhOTuz6H+Um4CdszQzw4+Et1Zz6tIN96JXKfX5ehyF4JUYIXmGJAkgLHMfUKS7ERe5mvnNyqU3gU2Jg3vAiDVbzyTfsgDwk18o1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774219122; c=relaxed/simple;
	bh=nrxGdF4waJ7A0QgcfXoDVuvc9uecGMMgh8aa/GZGYFU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=mQTkSkQPJqt+6tE7Qxm63017GqJ6FJ4rectWEIvdk/ix2ArKBwERfI8eHzp0pnwD5ISpF2wFwLSpuwJXBFoA5zSOyc2zzCX/1LuKVHoxDEClJs/e4whr8LHSOzAdDQoIH5wmEa0i8Y0MjOxK4EhbTHjgGl5Woq2lMFjOnrxFFxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=diRRJ3+U; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diRRJ3+U"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12732165d1eso4574282c88.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Mar 2026 15:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774219120; x=1774823920; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NXA1HRFAxM3kL5RxK2EDEsBx69JR7gSiXJRWzbAtGv8=;
        b=diRRJ3+UVREbTKpAdK2Z3CtdY+CM9zi7GhbU4kiOX7Cfbc3WRMLkg8Tjp1K+TGy3cY
         hRDwQ9g0OJdVc5PzN+5d2A3tB9XkjGvexQuMFTQArxJMjdgbsJOB+trRe0/hRxgnH9LS
         RQz4u5Tvvze2C+mb1xx4c8S1NZhB86ZncDXYJ7TXAKcwo3Vv/R4jpBIv57J7AxTOTfws
         H8zcCX05rF3dN1T5geR4UyV9zd2dHJfrvjQXRJhTQ6OeAczGiRTaUcAL3IvXbDNVS750
         UYuB1ACey89TTc1jdB/7768ZeTy5oMJgtILWAVeZ8uSPpxvYRWUm26qxFR0JhBSLBVch
         u9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774219120; x=1774823920;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXA1HRFAxM3kL5RxK2EDEsBx69JR7gSiXJRWzbAtGv8=;
        b=nb1rax29zKMoO6CVQaXLkKGfWm22fK2ZgaiqXL6VsDxTRDpGF5nIoIBC2sJ8mLQYtz
         8Ng7eF4Js17SzeILxLWq2Srw9OiSQXHU8jsiJAXNpIC1urpjmNkQ5mXtIJRj/IGkR16S
         2QImQxCJX56ph8/6YDYo/NbPlVi477lAY77z2iq5IQL5QvgqCiDR1FiAsR/sMnb126ML
         M8Pwu63GcvPrUBuEmGylXY2oHyqO44/vaK5LVdQGIZxSg5uZlduptfY/5ufA+yDXNWO8
         VgF2ljkEFVUzbNsgqq6pqcZRap8Fyf2baiI14Wd57gKoFkYq+ofXmLeIWr6RTMGNbv9u
         n9YQ==
X-Gm-Message-State: AOJu0YwIpMq3PYCiuC97FGricXD6XoIOgKl1ol8Diwm3q+LTQ+c1e/oK
	dGi7pPANA96MbT5JolzYEgje+RLcUutxkl1z2fACD1I6alv6DagG7GXNPhmoQQ==
X-Gm-Gg: ATEYQzyl7RM5FeaYjlO5RBzZNsKVIyjoyUUNEVe0NXuGR761gNVJl/B1Hrkq9WQGCgy
	W5tpW2zaQfy6b0ISJyluROZVkT+TrA0fewgFMda/eTH7xq/s3d1qSQz7I20mh/iFrnMj9yy4BY1
	XlfW6CqQf9zY1vbcOaf71HrdWF9m7FdoAxHnUacVR59sJIVUmPi+lp7Sk7prd7H2vgjA8T3pkS8
	Wx2u5b+k4YHj/Oex2gz9cQYq4Dci+jDVPGUd0l3IrTlqJxfj5MscfsIWm5ijqDNjHLkjNxT/wQK
	KqsBEiY/xkDMzDBPiDChZUrt9kW9+FJMTIOA/OOdSIK/bDUEm35H3LYiLRcp9MDFzcJwruTFx0d
	Z7/LgzCj03vI5tQAEjEr14TbnOl3DzyLn7oN4KzMUvO99Y6Ywx9xoF8oP2GEN2NivfoiOYjr0pb
	ZWwDNRFqavZiGdcUl4lGvT24qEjcQiKh1YqjwbGQM=
X-Received: by 2002:a05:7022:2385:b0:128:d2d1:8a5c with SMTP id a92af1059eb24-12a726a30famr4346805c88.19.1774219120302;
        Sun, 22 Mar 2026 15:38:40 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.137.34])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a736b929csm8176649c88.13.2026.03.22.15.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 15:38:39 -0700 (PDT)
Message-ID: <69c06f6f.050a0220.123ecd.9e31@mx.google.com>
Date: Sun, 22 Mar 2026 15:38:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0706161851646962100=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Functional/integration testing
In-Reply-To: <c2a503373330ebcfa8f8a20f8378cfda5d17634c.1774214693.git.pav@iki.fi>
References: <c2a503373330ebcfa8f8a20f8378cfda5d17634c.1774214693.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0706161851646962100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1070560

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.35 seconds
BuildEll                      PASS      21.16 seconds
BluezMake                     PASS      648.87 seconds
MakeCheck                     PASS      19.44 seconds
MakeDistcheck                 PASS      252.06 seconds
CheckValgrind                 PASS      295.83 seconds
CheckSmatch                   WARNING   357.92 seconds
bluezmakeextell               PASS      184.14 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      1015.16 seconds

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
emulator/btdev.c:480:29: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluez/pull/1981/checks

---
Regards,
Linux Bluetooth


--===============0706161851646962100==--
