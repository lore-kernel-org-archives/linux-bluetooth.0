Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74C013FD9C
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 09:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719567770; cv=none; b=R4Tc5I+PX//VtSTGeqmRvhcsnAOZjzeveTSDfrZCUut+9Fag7jh5Z4cYwSBG3N2WrI9aSnoKle7El6ZZgquaCN8icAoOkeZkNqOJjEnDTCKCpySWdqDaOiEo4IIreuZymCb6F2bjed93wJP++PoGgWYhCHlYTaQhyzhmO0cGm8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719567770; c=relaxed/simple;
	bh=J821jQCJ+nJOL5dQVpGp3OxXhsBSAd2A+Fq6Cr8rwuo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CaT64Kn/9mT6bUtjT6ZhCpYziOCoUvb199iNemvr/UQrSpT5/XEAJXRDZuh6f5oXBcPy/grLp/+qMJcY6WEeiOj7dpE5m4hacLCsxeXGguFTxWR0vlySEiOYZLgql/q4rmtz0O2yytKEN62bCBMSfrNjw8zNWmPazSpnQGxYU3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awSgdeTO; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awSgdeTO"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-79c03dbddb8so38667085a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 02:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719567767; x=1720172567; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ctVD18d4KfIAMw01SrXKFgdMVb62GgacBTExYQ5WCHQ=;
        b=awSgdeTOg+zoU4/7b0PC2Eholt1w6DGKnoDCTXQJxoyCpbo4apMLgykkjsNGNBlZ2U
         2kMi6aPKEpIIgM6gMC9unw4LnCA7Tdz4uPj+AjK0eZRQynxsvTOtcn/WdyEcNeFvQqQ3
         W80/V7inaO6rUMOJBtmWitVDWBuJ9Y4RZTAKj8aiF1qA2qaFsAINwRRPjfuG2DfqFFo7
         8KqEm8gKt2rvLdNv5sBxDwhcJXy0gZvO2ZIMeTYtDOvyY+0ip+ByeFqQQuOelpipRT34
         4JyISClSo+6TystkW+G4r+IbEPxpoPefIzG6e3tuGYw/ZXMyqQOskMAYcYTi4910me6Y
         LjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719567767; x=1720172567;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctVD18d4KfIAMw01SrXKFgdMVb62GgacBTExYQ5WCHQ=;
        b=vMKbZOS8nMDrdlznvnpFbPudPM25N9lumJlc1pKgtFEZthZJ2RswzXNIKRlGM3610D
         FnzE/P6Qd1Xt72ofeLt4EM+xh8+gW1HafGTDdZfjFf3zKfxQfV07sxVgBhxOSdpCC9Hp
         Jlg4JWGeWufvbbjPXCH5SfhGsAlGbeyDUz/hGSB/U+Ek57u8utETjtOGsmnc/FJZraFt
         Tfpeer3c9edDarWGVR/suckvijYJ1potwJlTCXr0Kt4JGtfCkbDWKZkbASaAOYSnsgmi
         +P7yA1wqXcNE2PkFNcMIAjoisc2fm+qzbdMGq1nClw1JdUMnfnjIOJMDp9fLBtFsfbKO
         WrKA==
X-Gm-Message-State: AOJu0YxF8d3RcayQfHvT5pNpf5pp3lQoTAaYKt3Uh8iMcWn4jbgA0asR
	/WYtue4+m30sBob/nV1JE3NMPL6EHbbEzV7eYbJ3+8aS3BAUM6DH8wxlcA==
X-Google-Smtp-Source: AGHT+IGm5zRG1QNnPS0DU1byRl8ReTps0qYaiJbYhNAQGkGaIphRDxyd7SBdKkZbIMOrKVLcJItdtA==
X-Received: by 2002:ae9:e30f:0:b0:79d:5e07:5886 with SMTP id af79cd13be357-79d5e075b75mr400497485a.66.1719567767308;
        Fri, 28 Jun 2024 02:42:47 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.46.198])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d6929be9esm59084585a.60.2024.06.28.02.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 02:42:47 -0700 (PDT)
Message-ID: <667e8597.050a0220.ed7c9.2699@mx.google.com>
Date: Fri, 28 Jun 2024 02:42:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2477503791030547224=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v1] core: add NULL check to adapter_service_remove()
In-Reply-To: <20240628074750.35992-1-r.smirnov@omp.ru>
References: <20240628074750.35992-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2477503791030547224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=866445

---Test result---

Test Summary:
CheckPatch                    FAIL      0.79 seconds
GitLint                       PASS      0.98 seconds
BuildEll                      PASS      24.46 seconds
BluezMake                     PASS      1680.13 seconds
MakeCheck                     PASS      13.23 seconds
MakeDistcheck                 PASS      176.92 seconds
CheckValgrind                 PASS      253.74 seconds
CheckSmatch                   PASS      352.70 seconds
bluezmakeextell               PASS      119.37 seconds
IncrementalBuild              PASS      1459.73 seconds
ScanBuild                     PASS      997.31 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1] core: add NULL check to adapter_service_remove()
ERROR:TRAILING_WHITESPACE: trailing whitespace
#94: FILE: src/adapter.c:1352:
+^I$

/github/workspace/src/src/13715666.patch total: 1 errors, 0 warnings, 10 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/src/13715666.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2477503791030547224==--
