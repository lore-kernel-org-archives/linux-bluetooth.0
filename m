Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1421332A7
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068781; cv=none; b=dV3f+RFEm/I2rFnGOLOcoppYYb4CZpxQUmf9tr1/+ztPUmqOdJoyANqBfUnUEuGWu1VKAPCDjrDKctwgeeuNvdC5cfNmxakagepq6gEbYS1Xv+MEAOkaizJgM4aIYP5SoUmDfcZtlD9fPywKIUfcyh8ba+8VF501WtRsXx1wmtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068781; c=relaxed/simple;
	bh=lSQbyo7eLhMpnRVvaIIwzLop0QKzQhAGkk28fOMZxIc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gYGh+sQMwDE3JZebc9hiKLs+L+hEb2Dhi+WGqV7BZVEUWzQ8mHc7SJnTUEPK1n12o7ABubkdRsjVaHfkfiJFxk9VzzF4m/yz4TH56sI4Q6lq5umAdSNA0y2KV2UbSJY6ERzpMEGP2Wuy8dVkcRCrj1lWNAOjnryMqtZpnS8nGIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbSADsew; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbSADsew"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e00d1e13a2so34792885ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Apr 2024 07:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712068779; x=1712673579; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U9yzNqR1q+l6ZGu7H8hq42duNkR80pfc+OOyi4A+IpQ=;
        b=nbSADsew5yeKZJ4D51NBaH2jJWyihSj0BK/ohHIM4C7njTnn4TyB6pmxfh995qTsMa
         WKMUJ5AnQZyA2D0Dq8wStfW3thBmX/hkd4JV1/IDqiN5xjPtrZBmIy/1yqndXEDfK4Z8
         MkuFJAhR5kGz9KcPhQghzld51Nyhe+/Kndj26jhYbPE40u24hYkUQhMph5ODTpct8jU9
         yWRO7p20KAey7tlnjU2e19a8SOd6zdD6vEDGco0AHgfzzHO6CudXbBbprW0LrRbsjtJj
         5zUZQ7vJnwtMFXlcoHEC3KTtn8jkYs04vd/EAmYdq1ERitU/8mY0LoLXHgo6GjGBwOoV
         bESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712068779; x=1712673579;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9yzNqR1q+l6ZGu7H8hq42duNkR80pfc+OOyi4A+IpQ=;
        b=eSU3IPCQgmrW1gArDwxh1aV7ovLSgBwAbUqS2BNRjp+HQVNY0RuO9vr2sUU3NEpac1
         JMRQAzRmRIeeOmtwQoLa2qj11CyJshwYJBRvEc/8F0YNYwUGi1IAvruDTtAde9NAZ6KE
         MZxN1sRc9esuENxKsYdz3Ws/qt/SUL9+rD3i7zLlOoWFx6wdsFqH/9vmeRF0X84Sxt9t
         wwvEkIYazwMYVy3TC55vCJjaGUcIqrjBez66nuQ0jNn+t9ZqbmNP/R80w7dec87Cu/IH
         ayfRFhpA5XpxdWmJpZukOA5QQz72zv9vaNWSaiogRaMGvoBJtn5pXYo0F6KNZyYGBFu0
         Lm/w==
X-Gm-Message-State: AOJu0YwxWNswuec218JC9Xy1dDRTH7Y9+5Y48sJCes3pPlduBf8WL/Mu
	ayku2AMIREVjelaGi/F3Uy7IbKSJh48YxM4i045AV6IaxtCLSIATJspwD1Lx
X-Google-Smtp-Source: AGHT+IEF/3d6PHHjDL+/Mj2prfA6WuL7/hTLnhxNBRxFhbaGg4aVDoSVvECnQexSqCBbLYLA2pDMLQ==
X-Received: by 2002:a17:902:ed85:b0:1dd:63a4:68cf with SMTP id e5-20020a170902ed8500b001dd63a468cfmr10479253plj.69.1712068778959;
        Tue, 02 Apr 2024 07:39:38 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.70.58])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902f68500b001e06cc3be27sm11208517plg.253.2024.04.02.07.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 07:39:38 -0700 (PDT)
Message-ID: <660c18aa.170a0220.3261d.c9bf@mx.google.com>
Date: Tue, 02 Apr 2024 07:39:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5616049339516824695=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: iso-tester: Add test for Broadcast Receiver Get BASE
In-Reply-To: <20240402114326.3330-2-iulia.tanasescu@nxp.com>
References: <20240402114326.3330-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5616049339516824695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=840594

---Test result---

Test Summary:
CheckPatch                    PASS      1.06 seconds
GitLint                       FAIL      0.93 seconds
BuildEll                      FAIL      20.18 seconds
BluezMake                     PASS      1616.74 seconds
MakeCheck                     PASS      12.97 seconds
MakeDistcheck                 PASS      175.42 seconds
CheckValgrind                 PASS      243.56 seconds
CheckSmatch                   WARNING   347.79 seconds
bluezmakeextell               FAIL      6.77 seconds
IncrementalBuild              PASS      4627.14 seconds
ScanBuild                     PASS      984.86 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,1/3] lib: Add macros for HCI_MAX_PER_AD_LENGTH and EIR_SERVICE_DATA_LENGTH

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "[BlueZ,1/3] lib: Add macros for HCI_MAX_PER_AD_LENGTH and EIR_SERVICE_DATA_LENGTH"
##############################
Test: BuildEll - FAIL
Desc: Build and Install ELL
Output:

writing RSA key
writing RSA key
writing RSA key
writing RSA key
writing RSA key
make[1]: *** [Makefile:3253: unit/ec-cert-server.pem] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1293: all] Error 2
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
emulator/bthost.c:584:28: warning: Variable length array is used.emulator/bthost.c:741:28: warning: Variable length array is used.
##############################
Test: bluezmakeextell - FAIL
Desc: Build Bluez with External ELL
Output:

configure.ac:21: installing './compile'
configure.ac:36: installing './config.guess'
configure.ac:36: installing './config.sub'
configure.ac:5: installing './install-sh'
configure.ac:5: installing './missing'
Makefile.am: installing './depcomp'
parallel-tests: installing './test-driver'
Package cups was not found in the pkg-config search path.
Perhaps you should add the directory containing `cups.pc'
to the PKG_CONFIG_PATH environment variable
No package 'cups' found
configure: error: Package requirements (ell >= 0.39) were not met:

No package 'ell' found

Consider adjusting the PKG_CONFIG_PATH environment variable if you
installed software in a non-standard prefix.

Alternatively, you may set the environment variables ELL_CFLAGS
and ELL_LIBS to avoid the need to call pkg-config.
See the pkg-config man page for more details.


---
Regards,
Linux Bluetooth


--===============5616049339516824695==--
