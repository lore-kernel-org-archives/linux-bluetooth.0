Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23EC3BBC2
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 23:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721951608; cv=none; b=TDQ4x6tZ3lz/OJNF/dSNt0lHeHq6RuNEri3M3IpT7Kl2kZrtIoNEFqgrrwyn3IcfVFz2AMirl+cJvw0pSIn7Ckh4Mn/6iRDvWPSuWLdTVwRbP2nHCtVY/vds8TlxWe5nFtYM6OG4sDJVzVDq2ilAM8rZudfQ1HaVFvAwU0JA+2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721951608; c=relaxed/simple;
	bh=ONT7EUg32K6GwtmaObusjlG4qi95x+M3/oVW66DiP5Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kCHCfwAUTmcfsnG5aF95EZdZqmaIEDBJLjbWBaJTtypMVBoGyyCu/FuRgw35IytVM3OOpLr31Rp3pldhl+o5m7UmpyauQJo24ei1Zee43UeS6oiZKON/EOUFKW4qELri/Efhpjhf97XEJYvBGVbFavSlBaue7hJMe14Ys365lpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRLpkIOk; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRLpkIOk"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-6e7b121be30so322511a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 16:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721951606; x=1722556406; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nNUp9KfnQvcrXtM0ekNGExPlqhSmJrttf3zbqeGBrL4=;
        b=FRLpkIOkPAbBFXxLFzbSM83A2FwjpeHDEk5lWC5qQmlw8a0Mfi48B6EQ4OAc1r5Gxr
         7e4bXt+wyUij1RCH6cRTvnJ/yVS68rucRKffutsntrFW66FVO4Vxqg1Jh1yfN7BIPaWo
         4zuIbn9h+w/qvruK7DXW2420PaeDUrXOgjl3w84CK8QuXtB8/1YvEDGzdavWh7Qw1gBb
         Jrvuz2Np+qEnHUPXpCHRrQeuKhRXUco46aD1hnWjCVfpYKdygPV4fh/eJawPHnPRcNwD
         Q55xtLYQsF/QT15qeuF/0VFKiVIZ9ozhFXz+mGoBl67v4fKr1lRBhnFtgI7kvv0qM+Uq
         MWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721951606; x=1722556406;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nNUp9KfnQvcrXtM0ekNGExPlqhSmJrttf3zbqeGBrL4=;
        b=wcle9c89fG4pz/XNsgzBr7It6RUdOag4kfZsYRWBzdBjThWptenm4DrZWRSwgGRuB6
         OPqyMiq16GWh4f0sarX9BGzKGTrZNQ57CrXjbfax2QtuAPlN1z6420HU5TL7VYe6rNpC
         ljxwwmDAIxR/64grvOiMa5Lxxd8J4KekiBEEZrftj43pw0mXgst/F1fmNc0+oRbEKwTd
         h+RQ3XDXWqF8t/VWhc22BSRUXv4kvWr0HnnKVS/mheQIhz8hTECPZfwVmOPuNzNlV7MK
         VRk4QqYOy1eQoggWfq3uF74zhqkrDt+Bv6gyDFO0303lXb0aBylA9T51eQs6HngyJ7ot
         tukA==
X-Gm-Message-State: AOJu0YxXmesqlXoRptVaWWjw0U1NgtCoLYFDXD8WFlJy0XKYCNiqRjLm
	CJoX9BeQF88MbcbpdjnrCI+kgDRqCrxFYCw9B6G3PP+I0zFEzH5hA/vCTg==
X-Google-Smtp-Source: AGHT+IEi5fF2PCy/rMebbP9gK4j2UsuFI1qHVpgnmkjxf1K8EXG/+MnCButLMI4yaqcFaqntzTCtOg==
X-Received: by 2002:a17:90a:62c4:b0:2c9:7e6e:3578 with SMTP id 98e67ed59e1d1-2cf23772fbcmr5024455a91.7.1721951600878;
        Thu, 25 Jul 2024 16:53:20 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.142.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cdb73b9458sm4120188a91.19.2024.07.25.16.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 16:53:20 -0700 (PDT)
Message-ID: <66a2e570.170a0220.1ecb84.b7de@mx.google.com>
Date: Thu, 25 Jul 2024 16:53:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1359693731290171959=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v4,1/3] client/player: Set number of channels based on locations
In-Reply-To: <20240725213626.3183962-1-luiz.dentz@gmail.com>
References: <20240725213626.3183962-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1359693731290171959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=873929

---Test result---

Test Summary:
CheckPatch                    PASS      0.87 seconds
GitLint                       PASS      0.55 seconds
BuildEll                      PASS      24.34 seconds
BluezMake                     PASS      1636.82 seconds
MakeCheck                     PASS      12.85 seconds
MakeDistcheck                 PASS      176.01 seconds
CheckValgrind                 PASS      249.69 seconds
CheckSmatch                   WARNING   351.84 seconds
bluezmakeextell               PASS      118.52 seconds
IncrementalBuild              PASS      4526.64 seconds
ScanBuild                     PASS      982.20 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:288:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============1359693731290171959==--
