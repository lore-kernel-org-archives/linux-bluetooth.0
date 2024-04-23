Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91CD56B91
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Apr 2024 09:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713865217; cv=none; b=uVWGTMZ8Au8ETUCZNYMTasnnbNsuHO1sSej5/046y4+I3nUxM29P4Rzxao2asLkBixlsr3ZcqvdOq9PKa+9LmzNJbTVw40/9ojVEuOboEebSbyCne2xLXUDoqp41GfL/QkM80Fgk7XLj2A14xlK05L81RyYF7iWFIEHtCrTRdks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713865217; c=relaxed/simple;
	bh=pqu5bLeRaaADRH/U+k3POi+nZBpQUbwAYJ1Xfc49x6c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lYXvoTAjSClB1w8fq/tDQB5u5iAexVB8O76il4Uk9VAed12waiSifsxHKWyTXQWKtT1t9KCVra3cLyrmY1FErpKrT2oKCtSjnl4uaQoWCren7SYtzUTvdPrYnmjgF5xPJt9agO24RHr+Df6qAE4FYntJlzHmI4IBCAQv/zSrbhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZFxNGxG; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZFxNGxG"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6ea1a55b0c0so2851420a34.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Apr 2024 02:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713865214; x=1714470014; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/78R9BEG2qwgp65pqkw26T5K07Lb2yCf96DaS+zlFBU=;
        b=SZFxNGxGPmGsB4Qd7SPlpTipMUbOuy0Ntf6/XonKqZm7ejNWBC6qF2dprKjkZyHI6P
         GcIevTB6Q9jG2UdrJqwsyxe3FFiKr8k0jysz0u6gT5xskRetd+BfRQA1ExmoOEijV6O0
         rLKWpntivq+CNMSrFQINMb2ROtcAtIZNls5Iqt01QmYXX2AKmb45x4+02BxyhnxutS1R
         Kx+GTfp8MQ4Yn5f7kgPohTHA9dWUdG/+iBpul4HV6tZNRLH3/wmIBnYtMWX3J0W1+tFM
         MVaDx9ZcgP2e+ZPraUQ5Gwc51jAPYuvKPg/B8IEfPmAv7kRIXW7GTnZ37Ob/OoGF6cmC
         4Zfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713865214; x=1714470014;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/78R9BEG2qwgp65pqkw26T5K07Lb2yCf96DaS+zlFBU=;
        b=L+ViV+Iuo8jQmY7LQQmOME4oFCSu3+CWKrb0ZrB4ygVpt0mb+ZyzQ7ToKTEvMnOuHD
         HpXr/Z1QH3u7CqD/gSj2jEXzu2bWTJP6mcoOgrIet/WdFAeGukPNXDqqJV552DojTKLH
         iliC4VjhS2RczJyEADI8WbktCA2FWPA7syMoolOnLjjZrvbchrrEhAS/4rDwvo777pOh
         62mgbjawF85CcD0ndqkCkaUY7yOS7PqhocVIPP2UE0fEOWvogJ+hectjR3Di19z/AHgS
         gX2oleG5vXQ71WRP3TiVjKdIQ3K3DFgtyasIxvD5WCDtSRlqde7gP+D3fSxFHi3WFTUE
         i8/g==
X-Gm-Message-State: AOJu0YwgDOEZF34ycuRaMwDJLNQH/iRKEb1nnC4cWLBDNKNYpYfEFbeQ
	XHiQc45uvfgDSjFB1/2uvi2Ot6Eal289EpkzCRPmAO5D2wqNNDg9T2cTrw==
X-Google-Smtp-Source: AGHT+IFXWNqgAZVgk8JfizeY729ZRqb+QV/LShB3nQwTZKecy5ExCPjByA2YJl4vv6bhwJWLFfm8tA==
X-Received: by 2002:a05:6830:610:b0:6ed:5dc8:e51a with SMTP id w16-20020a056830061000b006ed5dc8e51amr1289314oti.24.1713865214665;
        Tue, 23 Apr 2024 02:40:14 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.115.6])
        by smtp.gmail.com with ESMTPSA id u9-20020a637909000000b006047eb9c7fcsm25088pgc.34.2024.04.23.02.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 02:40:14 -0700 (PDT)
Message-ID: <662781fe.630a0220.8b2d5.00a8@mx.google.com>
Date: Tue, 23 Apr 2024 02:40:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0975483156101221233=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sarveshwar.bajaj@nxp.com
Subject: RE: [BlueZ,v1,1/1] Fix null pointer deference in bap_get_ascs()
In-Reply-To: <20240423074426.62480-1-sarveshwar.bajaj@nxp.com>
References: <20240423074426.62480-1-sarveshwar.bajaj@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0975483156101221233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=846898

---Test result---

Test Summary:
CheckPatch                    PASS      0.29 seconds
GitLint                       PASS      0.21 seconds
BuildEll                      PASS      24.58 seconds
BluezMake                     PASS      1601.80 seconds
MakeCheck                     PASS      13.30 seconds
MakeDistcheck                 PASS      165.87 seconds
CheckValgrind                 PASS      232.35 seconds
CheckSmatch                   WARNING   333.77 seconds
bluezmakeextell               PASS      118.82 seconds
IncrementalBuild              PASS      1420.00 seconds
ScanBuild                     PASS      1028.67 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============0975483156101221233==--
