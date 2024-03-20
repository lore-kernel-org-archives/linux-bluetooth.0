Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDED6A012
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 17:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710954316; cv=none; b=ulwSOCIxWxXVUHoVt8xpYnR5ZuKbZ79wZKGYctAlr/uqp6y/YJqympRd6rqglwM5mZzqJdXX0tkMNuLzoG2mllndpgVr8bBniGx8amjMbcuRypNAL+JPFHAWKGO0csJRkEmO+jNpaOlXLEGWlHFoNMjeXMH5iPgTXYs8buK8MfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710954316; c=relaxed/simple;
	bh=FGMj7sUMXZQFpgUwuHP2vysUfhjXMvfm590gWU+BY2A=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=olrFkK6Zxshzn2KcsPkCn67W0Aekds+wO3a0gu7EjIpQRI2vPn8GSJ29bBq3tHt6dz9mU3NYtxMoauhGxKoFu4Uw/rfwKRlijwGui3YeO3lA0vBmUVG3i5fJx4suULMZZqiA8C/yDhCiU0bXfvEkpTVLM/N1UCrveSSiywFEbZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwVZbaOh; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwVZbaOh"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-430a7497700so656631cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 10:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710954314; x=1711559114; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PsGSVI8yNwAYxux+wszVfy5yaiWBKEVNan+kKLr0xVI=;
        b=hwVZbaOhitxrxb2ijbbKZEv5ReXBlwiUuJ4v+I5WQbsXd6pADM5CtIyIIN0MNQGiH+
         b5PemMMHB1mFErzg9cDaaTYc/1N0aj9sYsgqgMURcAFf8Qm8tqALHKh+LrKsTSEwahDa
         KGFanFzlTEsg//mUQvq+C2oKjg+lHBAtUnmGG40O5ENKvUAYHrTCShytdnn+TwvYfGbZ
         jKfyXNZwEH/O8ZFmESpZT8GffmxjqQJy6cxzpwSZFVE/dGsOjC43wtLVPM2OxiA7WUpa
         kHdp6x9ytMSRpq7iyqpc6ZQIdOjpRqfi69bDoIBjzLR9j/9lEx5SPaj6GUTAgfC5UQSp
         2A9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710954314; x=1711559114;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PsGSVI8yNwAYxux+wszVfy5yaiWBKEVNan+kKLr0xVI=;
        b=Xb6Lijutki7Vb+0Cds8asE5WQPT+zMoG2TX5cVLq4hcuD8O42J7WmpUaacexs0hEjk
         V3TJ8vbNEeKMqDLIzklTIKm1U1hyRAwFPnK5njJDEezNJSkmhiMxdEL0vcvRq8X/exvI
         USeS/iKN+EdtRlqlV84z5Da5z/u+OmXzMmPz5jjTejSGd/4B7OkxS/xkcwFsxy7dXVSy
         Ly1qPdbGjrgpt5XQfdlqA8DVFIDZ78akmTTJ9CpSbiZtlXob/R7imkGS9iLDMe2ZSYAB
         uagri33zHLGAXwnYLdPHM6BqvOr78Z9isVtStUAzNsMqX7ME4qSo2jqmozViwT79Gpiw
         pAVw==
X-Gm-Message-State: AOJu0Yw60aY5w0hFj98FAqD1Y9YHhAMLtiK6Dy3fRB7lzF/z+30HLcOL
	F9Mcfl1mYDcqgWzPDp2wXD7EGjtOU3+FNR2/LOWkRkBleSXRjQvXKwS7JdLE
X-Google-Smtp-Source: AGHT+IG9woUpIhoL5DKAL74Q9FBOkLU1GTx+imAndfxPjsXPOrOIv+kU5XBAyYBpaEADNhZ9XdNs4Q==
X-Received: by 2002:a05:622a:11d2:b0:430:e8cc:7e0 with SMTP id n18-20020a05622a11d200b00430e8cc07e0mr5895751qtk.27.1710954314100;
        Wed, 20 Mar 2024 10:05:14 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.46.152])
        by smtp.gmail.com with ESMTPSA id j1-20020ac84401000000b0042f376886d2sm7643308qtn.36.2024.03.20.10.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 10:05:13 -0700 (PDT)
Message-ID: <65fb1749.c80a0220.19e1a.2847@mx.google.com>
Date: Wed, 20 Mar 2024 10:05:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4840819140018834962=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Allow endpoint config without local endpoint argument
In-Reply-To: <20240320144153.46408-2-silviu.barbulescu@nxp.com>
References: <20240320144153.46408-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4840819140018834962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=836768

---Test result---

Test Summary:
CheckPatch                    PASS      1.05 seconds
GitLint                       PASS      0.69 seconds
BuildEll                      PASS      24.15 seconds
BluezMake                     PASS      1635.87 seconds
MakeCheck                     PASS      13.48 seconds
MakeDistcheck                 PASS      176.67 seconds
CheckValgrind                 PASS      247.02 seconds
CheckSmatch                   PASS      350.17 seconds
bluezmakeextell               PASS      120.34 seconds
IncrementalBuild              PASS      3014.45 seconds
ScanBuild                     PASS      990.72 seconds



---
Regards,
Linux Bluetooth


--===============4840819140018834962==--
