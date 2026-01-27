Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164E1233149
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537378; cv=none; b=lrrnbcW+j2INCtb/q5k9rNokKKcLXZAPqSG4uSjDkgCNe4366yjVt9UOpIL91fAC9bu6kWDf3VGpi255OmcnhDBULmP+6egHSOgbnFkQaFuBzAGdqbQKmWSltjf/5Eozv7+dvdc95OVGggmXH2sPJ3mchn/tIs8Xpq2alWFWofs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537378; c=relaxed/simple;
	bh=jyp11h5wDJwWSs+1B7FSDFQh6mrdfSR/uS0Qn9Qv9pU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZHukf9D/nVicJM4tP1qYGvrQkic/ZVLD6SesL+G77RMjPxj2Yj/9xLVOTbS/wJDv7yLHpSlhZd8U3JTgR6EDtiDgiq8vQ70iASwQuIEyY1EOKwXNz56cdWe8H3mHfzkQWlJSjQgR743LjkYykPbFDgGKRxI1Qeeb87HBUdlQuUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMd2whpX; arc=none smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMd2whpX"
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-89473dca8aaso76985126d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769537375; x=1770142175; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uKAsY0K5DGGZ6+JkfUaFfEzcFVlmZouItqkhPV13MCQ=;
        b=nMd2whpXKeRjVMPEYXlORjc5OAA5vulRolpA2Qdc2o8LjqLn/THmRVKeduY8rVa3hG
         xpVlERSPnsv4wiGUxaAMePRiBoufqQ1OXI/vil+w0kgSElgR2sehnSQiic2K2Szv3EAX
         L/B4DvDtcklBPYXnvhfo2iFoopAOJL7KYpYJMEdUto0bLHSPinEGVFgmPU8OHAktgW2H
         SRpKbijKgaBw9XA5sa3PTHaxw3sI7cMRtEUnsYFvGlW0dDEPjU3/z4887XEXC0YzY/se
         kgGRsNllzbg48WF0Sz1l8tGvXBT4pprLddiCijHhmXSJYQV97FJ1NyqUP0pHGRYFkUeK
         1d6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537375; x=1770142175;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKAsY0K5DGGZ6+JkfUaFfEzcFVlmZouItqkhPV13MCQ=;
        b=DrDkoZpTOTbViGKS+M/vbdquH6LXv0eZQEoBnBJ+suRbdStHueF72raGi0KEMPrLoY
         h2Q3cN6okmM27+oECg5Q3KWGbNVDc3rRInI8nQbMvoBr4gZr0OSxpu+NwzA3ge1oBeS9
         +iqxF5zBdupjNlmrziXKR3E6nzQ8LpXrYlv5ljJ/+6M/aXeRjhQwTTZmhxT6TSLtHn3q
         XmXDBS6bUytRmc3UsfN+wlN/JVROmF6IHMuVUum15j1bXN2uML3hcNJyCdVlesqahU+3
         +2w0IAfn3KywaJiuRY4QyxJwRonTfsIb7UClyEpppHHkQuZiEmbviorN50wQtfzT5LeJ
         kUMg==
X-Gm-Message-State: AOJu0Ywo/e2KXOCftatdaWkVVq/DlrJ8we+q3XlHz68hymSQQKhbjRpS
	vlJeyq17S56yosEtOGYzHh2/JJGUTPPpb+SHU9+De7UY42cdh0gVVAVnYpvS7UhS
X-Gm-Gg: AZuq6aL4VISPE269Q4PO48A3IEo51eQMn2KABIo9UmpkmcLlfPJjoDBAlUfxGGIPS3/
	lirLBJA2GPbq5t0Eh9rB0bI/p1kGjF1jViB72oZIKedMxIngB7bAztuRBv9muSHexXE1CngU8xE
	sxBE0g1efUsDOMjB2GIeXZgQ7G2JnNGHHzTuHsB0KUXHhDDAw+4Wk3H3zN9/I5xXSxrTSxg0/Ts
	1QD+T41hjtHLBjrwCoY3JHiabNi5U3dZcki5JrsEReeoVUpWPVOSHnfUcsB+RFNETY64Hx8T6L5
	N4GRzHWxOSE0lpsfZlTZGdDgoeR3lSLt9qD0yD7uLi7kTzcqRamfvSWTPgnitOkFZYJgLm6IKZf
	6uiCCD+3gcnzuw3WjgP4DUrPRqiPtsyiLe/1JugwDbLf0V2dCbj7Xjt6XO6L/KkOtlnlrYwOrwQ
	I8Xb9KT7erytTTh7Hov8UdSKOgU/M=
X-Received: by 2002:a05:6214:2486:b0:894:4707:abf7 with SMTP id 6a1803df08f44-894cc8b5540mr39284156d6.33.1769537375366;
        Tue, 27 Jan 2026 10:09:35 -0800 (PST)
Received: from [172.17.0.2] ([64.236.134.18])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711b7bb29sm22899785a.9.2026.01.27.10.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:09:34 -0800 (PST)
Message-ID: <6978ff5e.050a0220.11fa54.2f8d@mx.google.com>
Date: Tue, 27 Jan 2026 10:09:34 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5448577285746112271=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] doc/qualification: Add PICS and howto for the A2DP qualification
In-Reply-To: <20260127170358.150004-1-frederic.danis@collabora.com>
References: <20260127170358.150004-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5448577285746112271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1047685

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.35 seconds
BuildEll                      PASS      18.76 seconds
BluezMake                     PASS      597.26 seconds
MakeCheck                     PASS      18.26 seconds
MakeDistcheck                 PASS      225.38 seconds
CheckValgrind                 PASS      272.32 seconds
CheckSmatch                   PASS      324.87 seconds
bluezmakeextell               PASS      168.38 seconds
IncrementalBuild              PENDING   0.31 seconds
ScanBuild                     PASS      945.42 seconds

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


--===============5448577285746112271==--
