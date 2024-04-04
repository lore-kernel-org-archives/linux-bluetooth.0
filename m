Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F3A8662B
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712238464; cv=none; b=M5IEthZskxzYSya62AMsBxN5c/tA6ksMrbK6+1Z9jhIi/JhAI+7skRBHG0KxuzJcZXpBtJeog0IT97vkzSOOvCfo5BkPOWD7HeBkFEmIx0KB6zDwl4uSWFtBjBh5aGGqS8nZxfzWn8bMRrWjw+cDznzCo/yQXdXXVjnYGHiVpeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712238464; c=relaxed/simple;
	bh=NAr31UyiVs4W78SGYcNiVOtA6+RsGHGMng7emzOQs58=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aG9pBnv/RYew4C5utJ/p23rIds4sJGENBaYG1Yh4qhpqIGw7J/6+semRGJWZU3iARIz5MjFKi1wIJFMw10nYHeQdLT2q7cI4EEWKLdsGFB+oiCvOxYbI7HXL/AQCAswc2c0ewBlDUDD4AeUk8uodnaC8sMgg5RoHwUVQHRpHz/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcbDeB6X; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcbDeB6X"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6ea9a605ca7so754860b3a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Apr 2024 06:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712238462; x=1712843262; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qmegCHCVJR0uQAsDpig8NVUWjsbRKYzCmOuiUBShJHI=;
        b=YcbDeB6XSeIwd+xOMTkatlHEiWKriLAqYDPoT1ORReXE38b5DKMtNghlepJTl42nXZ
         oMS7ctaVjd//WamtubVnVuGgGb9b/8eve6RKPRrhePOKZsp1k/vTJ5aRJnp5/A9wl404
         tEi+WtexzoPjiCBTCEnM87qidLVsuhs+taLNwg3Gocx99MrZI82rnGdoPkA4OqsEMdl5
         KNV5v2N2SfB6gf6hKNu/kDIpIJNil0vdBZszT7qR6r9qLTmyessrJ4lIiCvE+Sq5LyxW
         Au781bJx9CnukZhZOoVOB/9RwchmlXbfRppp3esfMU4FAMFEFmt6lB18b251uV2J/+uk
         3XuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712238462; x=1712843262;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qmegCHCVJR0uQAsDpig8NVUWjsbRKYzCmOuiUBShJHI=;
        b=j+fH/2FJIUW1IycYrmRBvJcLi6QLRoSbBAylAHBIhOB4pEpzYG7TqOniErpVDGkbdy
         zm+/Slffs6oCnbNvPmMzkrEbPdkI3e7xDHeK1QgB+kYYfU68fHM+/ucuUupdijmvCymW
         sar3CtzALTA5ZWpyMAINNvHcv8VUXVZnt+7V/fYIO21txejAPRxq8S6vWW38WAldtTi4
         ozEX4QqD/+oEpGWOpP2fXGJjH+/zs1PtHghcBRJajOn+P1PWhfP5eeYbYsSS/3snbPZR
         02HMxeDbh7ndOv+AsQzU8A3MjYRsGpszRrIEZni+qSlBJ9aXb9u97OzfBDxr1muKQuii
         K/8g==
X-Gm-Message-State: AOJu0YzxWN/pvkvZgUdTqo7EIRehz4lp5l2rHqAIrpzINt+mPPIHuCW2
	qdikuFnRYbchX4gKLcv7B1IX99HQEnHrypKdeVi0lL8Tl274Xe1pPNJ3xQCU
X-Google-Smtp-Source: AGHT+IEc/XFyWg7dEmDocwabPFrDRemFyMz00HLnoWJSVvOVMnkoNrk++vYgnVFD0gb0lJGMgdjdYg==
X-Received: by 2002:a05:6a00:1802:b0:6ea:f43b:b961 with SMTP id y2-20020a056a00180200b006eaf43bb961mr7720660pfa.6.1712238462038;
        Thu, 04 Apr 2024 06:47:42 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.5.217])
        by smtp.gmail.com with ESMTPSA id g18-20020aa78192000000b006e7324d32bbsm13652510pfi.122.2024.04.04.06.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 06:47:41 -0700 (PDT)
Message-ID: <660eaf7d.a70a0220.dae91.61b1@mx.google.com>
Date: Thu, 04 Apr 2024 06:47:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3835580915271529115=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mahesh.talewad@nxp.com
Subject: RE: Autoconnecttimeout max value increased to 20480 msecs
In-Reply-To: <20240404114054.4987-2-mahesh.talewad@nxp.com>
References: <20240404114054.4987-2-mahesh.talewad@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3835580915271529115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=841385

---Test result---

Test Summary:
CheckPatch                    PASS      0.32 seconds
GitLint                       PASS      0.23 seconds
BuildEll                      PASS      24.59 seconds
BluezMake                     PASS      1652.90 seconds
MakeCheck                     PASS      13.39 seconds
MakeDistcheck                 PASS      176.66 seconds
CheckValgrind                 PASS      245.64 seconds
CheckSmatch                   PASS      347.36 seconds
bluezmakeextell               PASS      118.76 seconds
IncrementalBuild              PASS      1418.35 seconds
ScanBuild                     PASS      990.80 seconds



---
Regards,
Linux Bluetooth


--===============3835580915271529115==--
