Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A42C139D
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Dec 2025 01:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767143766; cv=none; b=tXikorRU4FX+qCDfRD/OizXIv6GKPAifzvY1XJwMQF+Y1t67fgL9T2UD8aE5Wk9GPIMT2dhZAKL2oznjsK3isZCZNrzTaLYbRjNVuWfLBcRSRcj6BW/f+zrrm8Bg80vCKsdVkuggc00eXP/0oNmfqUhx/MFCajGCnRTjsmeUx2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767143766; c=relaxed/simple;
	bh=6PktqEC7NSOC201Jpjuo5HRRLk2Y/2juxtfF76dAhD8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XujCx+O66ZZ0TZ8DuULSO72o2V7BZgIp7eOZLFqmSYprmeFUfIAwiX8LGFc8vBgGkvRQxC1L+c1w0IyEMDGhduHzObWWJjPTns3ohShcHOlPDhOdQ8VOr8FCz/FQ9LbBaMk3w3te6bt+uHtbBjvood4USqGJbD4lOQRGAaGxras=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TbhP6TR7; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbhP6TR7"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a0833b5aeeso142268235ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Dec 2025 17:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767143764; x=1767748564; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6PktqEC7NSOC201Jpjuo5HRRLk2Y/2juxtfF76dAhD8=;
        b=TbhP6TR7P3hqIK8DKmiXQcCoFbhUD0oqq9EpSTeI8c3/sgRIW//AMRx8V70jVkrgVc
         5pLkjAkMrhCnIveUvQ5kwJBiKvrzzKHDZ9r31du+wneVt0F/AEgq3o6u7dapkWXXbfuH
         FPmCDUvQhprJ+KYWgHDa74hHsaEj/uwFaXYxqtnIybDBsaHRzy7kXZ+jKGQ7rS97tyhZ
         /J/NVWJ/bftkZeranggKw0t6bvA4+dDSlGhVKVL4Yilpr2Pag9JlLsmnLf6rGegbIPMc
         v83Co0JljSXGB9D8aEvRGWM7xZWBKKDCryTKNdJvUcF3eQsoa2gdgWdo674GRxGLpZMf
         wJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767143764; x=1767748564;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PktqEC7NSOC201Jpjuo5HRRLk2Y/2juxtfF76dAhD8=;
        b=PpW4s568p+rXF5acprbrbbTzEGrmbf/W+led44qfbOAyPqmACHCnQs4VYcVfMnVejH
         uiTBxhK1Jh5wBjbjHDYPJP4J+3bIGA3PyL3ymMDN9ToA1O2PsJ1AsEAU2o80oJ4bdopH
         Y5lgtlivF8vJLtJrJhjjB5E1ilKCBpFj1RsMkqm5NxpBtT8rrFNKd+DrHRW5iWF/3XVp
         1PfjMYAIk8fLJ09UXHeLOpo1XaUReKhJBgP2Ee9/lrhAof1b5jAoH/8w3cIMGw9aEgFo
         H6qOObaNtiRxg4zs+EY73yKqivEh77SXfYnrPs8U53v6BR7vYcOaOnPpOURl1tkVa8Fg
         WwaA==
X-Gm-Message-State: AOJu0YzfCwQhMNNhSgAgi+S1c6UYxSDk3Onh0k69g64e6Mb0vifSfA98
	gHCYsMpiwHGhLYCn1L9yyy1Qak8F1h7Z8a+lGyPA4/d5JSBPjHImcBSPGGg07G8X
X-Gm-Gg: AY/fxX5ti3e5p8RyomtqsSTexvhAkkSbAxQwxQHybSynMEzzBsAoPDvxiDscCtdw5bd
	A+e1DT7Jjm5fT4bKFHIBTbdUW+YDIjqZHwJdW2Hk4Eoln61wzNwqDplAVI9wzHGQ4c6flAlX/Yy
	YIUBWyHZd+UTNa1KlUPyts+tNYwQObI7lYf+HxwsMHxTsaXlkAWfzUnR8KswUVkUPVFpihxhGtD
	qHK1jZthlYYheyKQLfFEoNulHJq+enWALoqeOKsC4whunJd7Gz6YBDIl043DzzxR83w9z+qH7mp
	EQI7+elzqKrDN972bxRuroUQ9UtFHac6oloXecCRxbyooD2+XQdobizEHkCxL311g1T8l7lzD5G
	6N6Cmk9+wkpu2EyUA15UyUfRvM/PLFgg6JSUPuVOcU787ax8m3prltdhf44R+A+R/dWxXNSMUqV
	2P8RRbDxJiuyU3NcMBjA==
X-Google-Smtp-Source: AGHT+IHI79IS/ssqboNqG7yGqpwWnmP9kFs7hSyr4HSYd3SQ3/yh8YbVwolGFJjp8RJw2VUFWsnFgg==
X-Received: by 2002:a05:7022:7e8e:b0:11a:c387:1357 with SMTP id a92af1059eb24-121722ac203mr31413077c88.16.1767143764260;
        Tue, 30 Dec 2025 17:16:04 -0800 (PST)
Received: from [172.17.0.2] ([172.184.211.35])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217243bbe3sm139145252c88.0.2025.12.30.17.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 17:16:03 -0800 (PST)
Message-ID: <69547953.050a0220.d1924.58cd@mx.google.com>
Date: Tue, 30 Dec 2025 17:16:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8429792558584745830=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com
Subject: RE: power: sequencing: extend WCN driver to support WCN399x device
In-Reply-To: <20251231-wcn3990-pwrctl-v1-1-1ff4d6028ad5@oss.qualcomm.com>
References: <20251231-wcn3990-pwrctl-v1-1-1ff4d6028ad5@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8429792558584745830==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: arch/arm64/boot/dts/qcom/qrb2210-rb1.dts:235
error: arch/arm64/boot/dts/qcom/qrb2210-rb1.dts: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8429792558584745830==--
