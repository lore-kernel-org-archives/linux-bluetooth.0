Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0618BF8
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jun 2025 20:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749758493; cv=none; b=RtuYrG7wfCxIv3i7yTMsTEnXwxECKSdHlh9xp7l6RWcHOjPotBNdoSLBCHH/A/gyhFvuA6GRy35bo4/jMXyBqdAwEMaLrgOHaca4H3Q99OJnAf6XC8OnDg+P+4KMcYvuobFb4BGBff0UvtnAVxOhaUxb4EnMPqLKR0MYLatZatU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749758493; c=relaxed/simple;
	bh=gxNKRJLjCCWwR2qfiLN4GcU5O1xuD1n1b30arq4voWE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=irRaKKeksqVIlx49rfXRQopa3VdcCUiIS/gbfWimnK3uDKRx4tCH0n9U8XgdxoaD/H45eRKgAipetJggdjZpjp9SdI+Z8+Qlh8kXhYRPLUYBD0rUCEeIy5O1X37lSdPyp4FgDk1qcNLQTgfv7zrZgyXpP50xnVehYuh7PW6pwRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NC00rpFe; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NC00rpFe"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a56cc0def0so22401571cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jun 2025 13:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749758490; x=1750363290; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7w+Aa/c+a6f81XNhyYeaNTYXTD8UX/spwRxMKrMxmv4=;
        b=NC00rpFeFV/yZRN5V3d8TmEHjT3UIxFvGrE28PbRLQ8x7HXlBvHuJCCSW/6Wjfb+3D
         0oNKDcUHbMN0fvQORVcV0Owh+Q4HgO4SHs9xSaSUXUgqUfh96cfcREjsbmGEGvvjYEmK
         E4cBdD5Byqi1PboFa5YCvvlhMhKae6fMnN088jlx3MntSJND2ezvVPRnnRiceyZjN11D
         yKd4betdq5IScXDtuzrl4BV6IalbJgN8E3c32RwG8xhPrtTYPUm1qzSzyp0yoS4oD+38
         pYiE91o9cQkqUZ7PWWHtdNq+fpYeXSYwryjP+xzfQpy+HjxIO5YjHqWndbpR//HBOFAJ
         KRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749758490; x=1750363290;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7w+Aa/c+a6f81XNhyYeaNTYXTD8UX/spwRxMKrMxmv4=;
        b=lGB1bwNhbUR+ha8ZCG8DfXjwEVmGwI9vIjZ4bYJ+J9BwgR6SbXRzfmxG5z9b5olSgx
         6axEL4GPbOrQMtbwK2meRaF00ZTTdyYDoZId1J8g3h3hHIZK+9F7Aney74cGHVuKgXNV
         c/pHYing9/dIKRGn1vHR0Mp6l/sdOeboHbGT3CVfOhRRK0K6HgCHuMKPsaN/Bcc7vPWx
         gkQuhiyRifSV26lFRsl5EIMTiabpKcL9bKSo3wFtuGS6dQtswl8QDJ+BRdhyswqA0hXi
         0m495wrjUQ3OGOyzAoFZhnjtyP2TMHcM4jGsNQjkV7oVOBuWSg480eCTfFZyDcCc4ERk
         gs1A==
X-Gm-Message-State: AOJu0YwQCSJ2kiOzSdGyKmnXlGuEQaL9ydfuWJiK9POWUw0umQMLgCDF
	bly4uTF3+PmR5caFwnUT7Eyhe0LEE/cFM0sUjLVjf+h9qenh/apxyGBQMlvGaA==
X-Gm-Gg: ASbGncscz1sZGcb7olpFQ+iXAOi2HwJA8sw7yFlWabJ6yTnRjeUzZ4jxfAPaq843VSj
	es0eU4/h9doEVJkWxg1k5y6nke9GzlHb9htoJfJrHClN/B2C6L1SR+qr/6PC1FmC8jTaqYoDSd+
	yS+3416W/cD/qbjgzi1VEly0CUz8cde6Mfvg26fQc9AnGskK14xXCEmgvYLNPGRk+p03MxDsE5s
	TBoTRQyulBw3CgdgiCxdM35xuTq8DjpvlOB1ENId/wzNpkOW7xr4B0R266vnDYBunWKWLQB21xi
	l5ghemybgAqp2PpW1sJGpSTbykHBwyUjasSJXY4Z4DWgxXsIoi3/l3WX9XhFc08Ial4=
X-Google-Smtp-Source: AGHT+IEGETHR9Rfo1GfQDcEIwWMBOSd75sGWM7pbwIu8BqtJfLjrz+Mrlk1YuZCfiZipmseE1FJTkA==
X-Received: by 2002:a05:622a:229f:b0:4a4:3be3:6d65 with SMTP id d75a77b69052e-4a72ff52a08mr7819071cf.33.1749758489887;
        Thu, 12 Jun 2025 13:01:29 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.77.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a72a30ceecsm8032231cf.29.2025.06.12.13.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 13:01:29 -0700 (PDT)
Message-ID: <684b3219.c80a0220.371a8.4e99@mx.google.com>
Date: Thu, 12 Jun 2025 13:01:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6943642756999532341=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/bap: Use read long procedure with PAC Sink/Source
In-Reply-To: <20250612181524.1812431-1-luiz.dentz@gmail.com>
References: <20250612181524.1812431-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6943642756999532341==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=971489

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      20.18 seconds
BluezMake                     PASS      2873.33 seconds
MakeCheck                     PASS      20.50 seconds
MakeDistcheck                 PASS      200.63 seconds
CheckValgrind                 PASS      279.95 seconds
CheckSmatch                   WARNING   305.61 seconds
bluezmakeextell               PASS      128.52 seconds
IncrementalBuild              PENDING   0.23 seconds
ScanBuild                     PASS      914.64 seconds

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
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6943642756999532341==--
