Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F88215A86D
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 11:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775476776; cv=none; b=V82h9UqvzpXBBcUmnxZwXx8/L8pnIcUMgKZZdqpCOeoaPusX9ZxcWcLsJjAyBXOFdPvRX6Bnt74MeEvY4a5ic3DHWrFuLrXUJYxpTlc/dNeI68pfKshz1IQSvU6ArL2vLA8a9TnwhTzQmWRisukgEVG2dXRkw/TBEs5FAHbGIR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775476776; c=relaxed/simple;
	bh=fllHHktpfTLQyYSxajSobdLU4k5Ak0sIejKIcT7wiK4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=OyyPH6CVF7kw9XsBrxsZVpCLGtzXM7HBxMHXNmLGHtE1vr72rJ3L4I81H5WcoTekroNLx/brIpB9Sg9WVM7+GRTU2SDj0JCsYSqVXfbtW/B2HvNTAShpDSS1h1eM6+8LkoZ9zRDk8IOnocfu7+efu+eo3rNwFMHVMjIEvn/UIdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEsjFoLU; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEsjFoLU"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-47018d34159so1519617b6e.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Apr 2026 04:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775476774; x=1776081574; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eSbMAC9HidAyA4XvpflZzHhrZZi3FLSyAss/SJPB94Q=;
        b=nEsjFoLUaW2IvXyOqCBoGw65jPS4HaO5ijtlNsHcnWwYuj4QJ8Xkjgtyys8hSIaZff
         iEVVtWUXiVvcl0WNXV4dtfQS4hYCm0pmxILqVbsKMZQWu/VHa24AqyE+hn53+No6OyZf
         RJuLyVBb1VKDeEzG227yKUXZMV/ppimrxYJENMSNXkF/6ipydaDNosFIrGXV9UuoL4Vv
         D3H5ukeo6Mc1ZhlQTWqX3fFPuV/pH+v9EBZTsQh8cwUSiKEie+ZfSBK5duzblligm1vk
         YNeCG5Pik/3QNArhNNu6l2RwLSzvr3rskqai1+jRbsAOh7xGqXsDVsuUERp4RDLYp8mG
         YjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775476774; x=1776081574;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSbMAC9HidAyA4XvpflZzHhrZZi3FLSyAss/SJPB94Q=;
        b=NE6Hs2saY6YQnoB7xOTbkUCoa7kr1cntFaeEABhPdql7uSGCSC5ZEvAOKqh+9YJ/10
         h5jUNRQdazPCrR4Sa6rbXlBeg4qd/LLFy+lNFU+YjMeSpvdq7JLVmESWsrvDkTWNYiVx
         FKn3fBoWLFCa6+Fd0yMMFny6Yx2mxHPEfw5YC/VMMhwC1i2VkiLjlo3dEAAHgTjKpFYB
         6ueHWTM6EXvlqGLJzhcmROmnE3eCQzKXdfgv2oS6j23oK4pSd4m9tqabf0G1iqgnoSEr
         pInsgSs696b/i3bieRIfKypuLOt0iVn7hRPBm2T0laN6DIBsfRMu25htcbUCTMyTBeAC
         74Cg==
X-Gm-Message-State: AOJu0YzRPuLMavofkDQOpBe1Ai0j9O1UQVgK4LUlQNYKiLcjpgvNcvhF
	yRc/8Dc/+SBGL9Ho5CFFQ7HlCET3Q78g0YQWZw83TxsrSGVsOllTiK4ZKEcRAg==
X-Gm-Gg: AeBDievWEYKBa5IjsjlkpbtEiCDjOeQ/yQQw4g1NztjELrTJZhnaL7G1q8+xM6SvFKs
	Mvy+TJwNt4lPn17bi4XrIrmmU7asgXjubsoFJ+vHkiEuP5oAxGYxFD+Ns/IGcSI6vmLh82sRE00
	swda10DF98hyoidhqL+CkjXxJF9QFTKuOl2X7wB8TXv/1r0+mVVARocNpH04DLqebb/SI/3DrME
	XJUX6sXk5E2Tb/w+k9gkwTDE5U9LkhumbVOuksJROcgfUFvVACWAPm94SMGJeruUxDqgCO78IYg
	E17XCG0Dsaa+FueQU6N0oYTDm7eLjV5Wheol4PeLkRk70LRow2CTKoVyhP/93Z653WGazhXLTgS
	n/Dn+DzaPfZpb8uLcMxBhMVZJWBNSuJMn9eWFp6hUcPB2mpM6sQ7S3d4uLqloLSwS1XERctAleq
	2cTJ2UohcxyWJXE51RRVte8ge1DAoc
X-Received: by 2002:a05:6808:c2c5:b0:467:11ab:cd86 with SMTP id 5614622812f47-46ef821cb81mr6320321b6e.43.1775476773888;
        Mon, 06 Apr 2026 04:59:33 -0700 (PDT)
Received: from [172.17.0.2] ([52.165.58.33])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4723c0912d1sm2259962b6e.11.2026.04.06.04.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 04:59:33 -0700 (PDT)
Message-ID: <69d3a025.050a0220.37ee72.509a@mx.google.com>
Date: Mon, 06 Apr 2026 04:59:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4661405382930432147=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] build: never build test-runner with ASAN
In-Reply-To: <968d832c1d78d26409ed751f2901ea5eb105541a.1775472833.git.pav@iki.fi>
References: <968d832c1d78d26409ed751f2901ea5eb105541a.1775472833.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4661405382930432147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1077632

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.34 seconds
BuildEll                      PASS      20.11 seconds
BluezMake                     PASS      652.68 seconds
MakeCheck                     PASS      18.11 seconds
MakeDistcheck                 PASS      243.92 seconds
CheckValgrind                 PASS      290.72 seconds
CheckSmatch                   PASS      346.74 seconds
bluezmakeextell               PASS      180.84 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      1013.01 seconds

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



https://github.com/bluez/bluez/pull/2017/checks

---
Regards,
Linux Bluetooth


--===============4661405382930432147==--
