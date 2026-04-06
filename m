Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A77123ABB9
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 13:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775482579; cv=none; b=WjlD1Jlgq7IYLxO/f6RFUWa3pKwC1c5VDtouYQL9JVcFOpn3DwSLFB5z39jzCFO39m+l3u7LITeQeFURvjTwMRQ6P32X+vxg5LgFXwPnNJBq8b32XQ31qiBmH9CXbkhkXIibtU9BYpAtEn78w3pXetgmJRdMpH7R0Bv4oX5+M6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775482579; c=relaxed/simple;
	bh=adkD1Ses5nzmhShqZdSR6hpWvaO9y6lLxt6SLejv1Ws=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=f6L05tzngKB3Fw/PBf9cDfDLyeMUEsHl0nOYmN+i24r5Pn4oN1xbi426O510ftbgR/dbW6OgD35JnqixTBCM5j2emEEnFkUqnPVWtoFaTgwr8mQjmjJzgdWKzSKXWKbJN4ZdtyzchefFiMyc0oDmHICw14TC7JlSoz++nSQdRPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPtMyxf8; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPtMyxf8"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12713e56abdso1281448c88.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Apr 2026 06:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775482577; x=1776087377; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t6pULyZfqvCUNGBdQ2HUyskM7F6goST+I5qpXSleUMA=;
        b=iPtMyxf8U8NXz74wJ+rPEpSoPrDtk/UgAtv2lWRBbGcr0fF/5WsPmA3i2lA5wK4085
         r8EGZkUd/MwsAQQUug0yVd7qP4nCUwwooUxkrOidT9QnOh87HX/KOvgr9CMcXanXZqO9
         2vt1dFT7BHr02K60Ae0dZv7gxDUNL4bc6r11bF9ETDH5SIRWgm66+T6LNa1jD1PLP+jZ
         /BQyQnabGWA9wojyUFr4aLT3UMlaaQ6riGY65FhUIDkaXSS6Z8ITvyvK0S4xyuiN4bZ1
         pTkHN5jlnXZW1YaZAmdfAhZi+I93CY84LRDLDryojXoJR4lx72DG6VlQ8d6qD+ZnajvB
         +c6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775482577; x=1776087377;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6pULyZfqvCUNGBdQ2HUyskM7F6goST+I5qpXSleUMA=;
        b=D3MYNLn08UKTMu6P7U914SyDJ6/kPip62cEN0utJaMo2z7NCQ41pwN1hx9ZSL9NGY0
         lZtHg9Gc1wk4JRTLJFsUB5q46UGGWBmEtBpaFEN+1Vi8WvFs3ThB60OEdWbbjBBzAJjL
         v7dae8ZzTM2+cPyCdPMhMmQAdjtO3hJ/K9UwdfyazA2/OYVrM5EUGEl+LBXtCsTxlYOq
         GogoxGaLXFaUb90GF6KXq7o9+g1pL91Dr6jogCOHCm7lpCxSl2SFn8gSyFv/m9eFb0tv
         ImBV2A71Sb3VzF6NGzHz9HPEMOBTcoBDdEsxVPndYySiZL4NT8QO55bRo7SPGzV43mI+
         CkzQ==
X-Gm-Message-State: AOJu0YyJPtuv5i1lArDnRSgi/DRoLfXTXxGp1e7yxmFHuYjkBXUpElYY
	5b/kZbO/lax3sWmsx11GJfjktRGG5jmGIO+V7XjajGTdAxiVYGag3JaD9mW9lw==
X-Gm-Gg: AeBDieu7vXcLLxv9xU4RDD7MP6PWOpEub7hB0JLZ2ln4JEjDCtLZKgA5ar3y7rjNN+Y
	2fXxcNPRZ2jtNYuo0GPAYDJqYlkTINVbra7PIpDdi6PvxJOqOVUbIXpTxfJRN4m3xGcgJfK5Ye0
	VFnoRLPcwnjARRvJRQZ+LiRBk5iZU/unQv65rp56nLz5PnsubfE9W1T9SEKetkefaZCRM9t9LJj
	UF2btZYqxgjMl0HpQbEujxJo8Jltsy1eSHnoBv+QykEJOqQIex+qmdi8khF6JJWuiplciTs6djT
	6+MLLSQd+7Qhtxu+VZ7v4bHuDdeahh3aFcwuMsrjsNl+6MfP8DJXICTQWcNr/JWJhWoh4vK4t8s
	ta2oT5Zq15UmWY1GHp8bhlRNcaak8asstwovge/9iRc0Zlhz4zIW7tVsXMFMEmMUrBecnqQRmfX
	IhLdvdxFlDOvZOJc7VPhs0oD3mozZWF5Xz
X-Received: by 2002:a05:7022:221b:b0:12c:427:dacf with SMTP id a92af1059eb24-12c0427de30mr2848438c88.10.1775482576741;
        Mon, 06 Apr 2026 06:36:16 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.213.227])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c0ce7dfe8sm3590203c88.3.2026.04.06.06.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 06:36:16 -0700 (PDT)
Message-ID: <69d3b6d0.050a0220.20cdc0.c511@mx.google.com>
Date: Mon, 06 Apr 2026 06:36:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7580420922761628409=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,1/2] shared/mcp: fix crash on destroy after ATT gone
In-Reply-To: <020cbb8375aacc6d8d9edad9aca96a6cde131dfb.1775477981.git.pav@iki.fi>
References: <020cbb8375aacc6d8d9edad9aca96a6cde131dfb.1775477981.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7580420922761628409==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1077651

---Test result---

Test Summary:
CheckPatch                    PENDING   0.44 seconds
GitLint                       PENDING   0.44 seconds
BuildEll                      PASS      20.32 seconds
BluezMake                     PASS      647.48 seconds
MakeCheck                     PASS      18.63 seconds
MakeDistcheck                 PASS      243.38 seconds
CheckValgrind                 PASS      292.86 seconds
CheckSmatch                   PASS      345.96 seconds
bluezmakeextell               PASS      180.59 seconds
IncrementalBuild              PENDING   0.42 seconds
ScanBuild                     PASS      1010.00 seconds

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



https://github.com/bluez/bluez/pull/2020/checks

---
Regards,
Linux Bluetooth


--===============7580420922761628409==--
