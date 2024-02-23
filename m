Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E707143C45
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 18:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708714310; cv=none; b=ckzK4upDsai0nLuoklxdrGTkzN4XfLe9NIWbY/mv9L8IjQRmoEK1wENz7q5obGPBYW2LVMrrd0Dk7oqglzt54HI6E0t8/my1qi0Ft9mIkOokvwi7MMPKgL9NSjeTU+bEhRWDxbLAjEY+xTmlyrz2y84xgxvIGyE6dQhOI1Ihlpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708714310; c=relaxed/simple;
	bh=v/C+4lxN2MEg+SabtpQVnH5l5gD0mndkNcChg5N2lt4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sSTS1iNSrVs1WjORynNHZ0+AIQHfIO7ZDh3SAhcQGu5rJTP8luuXfW48LKg9+Hl0j6RJxFQBqmAbEIZW/lAgCuvAV/n+5tsRAsIyVVZxwQp9DkCMb0mSXb23cRKqT+gaTpccnzsOOQMNd8kNUc0FyPQ85bLpAvdKJ5Ml1ASdjpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cTl2mqns; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTl2mqns"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-787ba57afd1so30606185a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 10:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708714305; x=1709319105; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9A0pV8TWTFdZhsgTNu8OlWDky1Ggd5oxY1Tge/rTm9g=;
        b=cTl2mqnseif4rD4CQUPW8/SL5gFm4saH8JIYq2+xxr64ei2Q1N0/8R1yvgInfUIQhe
         2qrLv0w7Dfi7F9mTDAJYUCc+bAoc9gk5vc4Zee0AWcestrzCUIJBwqcEBwBU4mVcm5ds
         u60yXrLMuobn+gzoYVboyaZpjqUsDLoGxRfMxdWirZSkKduDfW9Lsjuz+kPNZ0OOJsb/
         J4qqRUBHix9MjpeZENIXgebNSoZUGrZrX4ExBXnfNP3QgD/XVq3E9qMH/WaY9B90EUvl
         XQBUjFr+tjWefZa0c7w9owB/uVARNXJYfjRLEb4E2+FieH9GsXtK0dkFuiTJKI8W+Pe0
         fr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708714305; x=1709319105;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9A0pV8TWTFdZhsgTNu8OlWDky1Ggd5oxY1Tge/rTm9g=;
        b=sp64w+/ZETvt4rBLbGz/gaNbivjGyi1psinvH3i1Ihotn8P1fxwOHMx4XL6Vtz75wa
         9dvRkjdCqh/EkOGJ0vXj7UP0vTn6xO24a+no8PlD9n5Zs+HhpP9RY8TvlYveXzADnt9x
         RrGe/cWMEyOV1WH1/Vo/BEfXHNDL+QuZqP5kA+1e+rP+yxV3BfLkhJKfReSzpsOD0NFX
         ZnYdsdJ6u423dNP+0Eyaw4NovWw/ZwW5LktVyk/Zbn+pLYqACsIGgY86MfsobvbDoe2y
         BceU4Ao0EBWeM2Au815ahXfCHSdriY+TDxV+Y9Gf5WkAhDMI6ZQoLE2vqfw2c0IPKx6U
         RKUw==
X-Gm-Message-State: AOJu0Ywil7/G201ag40tDw/rqaobk3Bn2afuXPMVXIff6SnlNBxC6hwM
	P7WaxsaWNkLIfuMHaHyTvfxXSm583D8lr0e+3Z1zlbBjVLMdBpS45RYQ4Ipk
X-Google-Smtp-Source: AGHT+IGP1eTGo0NhSWwxVlB5hwUaSc1e/hR/ChLk5estj+mldUCPTzCYiiPiQTIMVQIDck+j/cy5KA==
X-Received: by 2002:a05:620a:e06:b0:787:272a:e298 with SMTP id y6-20020a05620a0e0600b00787272ae298mr690569qkm.62.1708714305330;
        Fri, 23 Feb 2024 10:51:45 -0800 (PST)
Received: from [172.17.0.2] ([172.183.51.240])
        by smtp.gmail.com with ESMTPSA id o28-20020a05620a111c00b00787a1c74595sm1828444qkk.105.2024.02.23.10.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 10:51:45 -0800 (PST)
Message-ID: <65d8e941.050a0220.4a056.95fc@mx.google.com>
Date: Fri, 23 Feb 2024 10:51:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8651876102105498255=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Add support for multiple BISes on the bcast source
In-Reply-To: <20240223164813.66484-2-silviu.barbulescu@nxp.com>
References: <20240223164813.66484-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8651876102105498255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=829188

---Test result---

Test Summary:
CheckPatch                    PASS      2.21 seconds
GitLint                       PASS      1.39 seconds
BuildEll                      PASS      24.08 seconds
BluezMake                     PASS      730.41 seconds
MakeCheck                     PASS      11.71 seconds
MakeDistcheck                 PASS      163.60 seconds
CheckValgrind                 PASS      226.46 seconds
CheckSmatch                   PASS      330.87 seconds
bluezmakeextell               PASS      107.61 seconds
IncrementalBuild              PASS      3404.27 seconds
ScanBuild                     WARNING   946.94 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/bap.c:1147:2: warning: Use of memory after it is freed
        DBG(stream->bap, "stream %p", stream);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/bap.c:40:2: note: expanded from macro 'DBG'
        bap_debug(_bap, "%s:%s() " fmt, __FILE__, __func__, ## arg)
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/bap.c:1281:8: warning: Use of memory after it is freed
        bap = bt_bap_ref_safe(bap);
              ^~~~~~~~~~~~~~~~~~~~
src/shared/bap.c:1699:3: warning: Use of memory after it is freed
                stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
3 warnings generated.



---
Regards,
Linux Bluetooth


--===============8651876102105498255==--
