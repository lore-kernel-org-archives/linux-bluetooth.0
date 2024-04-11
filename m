Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8424317C6D
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 20:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712867675; cv=none; b=PHVGpP0fOv462gSlfk1P13a4K856/lbDipzP6XR+96mpCnCB2A9Yw6Pt/WjQJzIvNI3/OHujai9Ta1U16hW8MQPGwMNj+aFJn3nKGvd84isS6CFf/5RPtrRCeFNanCunHHXrMxdFOVeWl5HcQNeE5gINXKsfhf9bmV1an0eYpX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712867675; c=relaxed/simple;
	bh=J4lA4bQQKe0wMafxwsrF8oEI8ZTunCirG5+JUDsnRzM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DFfj6mQB6jcWzaptOIU875M0MSnkjTjrbgm68KEjytNMd3Ttk8Zg+mQ8xbQfITn+7jDBM8oefjmT6xk4bJTfhmRSpM7i9wNeJcpLxJkzGXyRxFTf/eEfhN3HJMCQ0gAeZZrKnkIA/JlVnAZXhWUq3J8lE5VxywpCylI4Aqcvnvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIpqNCij; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIpqNCij"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4347bcc2b47so745881cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 13:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712867672; x=1713472472; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6d5/zZMetxz2E749x7yHPar+sSYn1Z1a3Yy6ctoBmUU=;
        b=WIpqNCij7bOnOulKSuFlJIYB4GrKl9m+FBZoWm12jnEykbBz7n405DGnpceaSliQKc
         olpzLIp0vIxILbFbuEC20nt6Asu0qin2NyS/kZOgGA3IIGlOSvint9LwV98WKJWOL+2L
         7YHBsMVEsNuCJLVHLwSElIUoYGqYwppO6qESI1J8q07g/UrSEEg4QfmyKomXGIXnwDI2
         iLZEDfTI3/ih/nwbaJp7nq7Bs9KxpNpzgHF2r/RxB3rhR4GtegFItNLVU7nkplByxVwc
         by3Nbr94OlXbbLxHknFdykaBoGgYgjA5ZgSLk6tSMWjgZ/ss7UyYWQNiqj1EnPwi449C
         Loig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712867672; x=1713472472;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6d5/zZMetxz2E749x7yHPar+sSYn1Z1a3Yy6ctoBmUU=;
        b=NxQXn70MNXyR6P138fmi4bPhajkntXGSr5nkwJVxP7tPLdM2WtFsW/8K4UkFj01cXg
         FkSsGWMgceKmW8zX4EM0/vFj+kAy7hbDBCIeQZWN12roSzy02J0DMObcgjVGRhVF8nma
         vKfRc4vfTHH/XxJKi4skpVQvMS4n0cIHhYl9SIzyGxq/Wi9Cewlbuc/55PPvoKoVt5bv
         TMUQWtawQIQDRudDNmkaoS1X7CnmS4h8EQHf1+oiJRIagxrz5iekRMid9oGIAGMYxAjt
         ZckAxLgiXK2eiu8xfgeCiZM9oJC1t5n9ulpaOQY/dEoazGG6/7WR9fYmChn2hC4/b5DG
         iz0A==
X-Gm-Message-State: AOJu0YwtD/JPc1FP0DkTerLiV51MgeCsoAH63z4eg/fRiK7Y9o0qlVUm
	H/bHLrnkp2uhof1rfPTHuH0uM2dNdXglUnONAOpu961AzVp4ZUsAtLHokQ==
X-Google-Smtp-Source: AGHT+IEleYeRHtesPK9GSCZpQuf2JrjM9fRAB1YM3tA8vcf1CQhc+2tsPyRC6MDjq27Hh1WRTRGy+A==
X-Received: by 2002:ac8:5f95:0:b0:434:ffff:698c with SMTP id j21-20020ac85f95000000b00434ffff698cmr718976qta.35.1712867672266;
        Thu, 11 Apr 2024 13:34:32 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.210.214])
        by smtp.gmail.com with ESMTPSA id s11-20020ac8528b000000b0043476c7f668sm1334202qtn.5.2024.04.11.13.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 13:34:31 -0700 (PDT)
Message-ID: <66184957.c80a0220.5236e.346f@mx.google.com>
Date: Thu, 11 Apr 2024 13:34:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2186040712180123369=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3,1/3] shared/bap: Fix not updating location
In-Reply-To: <20240411180721.157181-1-luiz.dentz@gmail.com>
References: <20240411180721.157181-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2186040712180123369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=843744

---Test result---

Test Summary:
CheckPatch                    PASS      1.25 seconds
GitLint                       FAIL      1.06 seconds
BuildEll                      PASS      24.37 seconds
BluezMake                     PASS      1666.15 seconds
MakeCheck                     PASS      13.36 seconds
MakeDistcheck                 PASS      180.32 seconds
CheckValgrind                 PASS      253.00 seconds
CheckSmatch                   WARNING   350.35 seconds
bluezmakeextell               PASS      118.67 seconds
IncrementalBuild              PASS      4594.81 seconds
ScanBuild                     PASS      1021.15 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v3,2/3] shared/bap: Make bt_bap_select fallback in case of no channel allocation

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (87>80): "[BlueZ,v3,2/3] shared/bap: Make bt_bap_select fallback in case of no channel allocation"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============2186040712180123369==--
