Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194F385923
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 20:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710965033; cv=none; b=RMrtPNt+PguOddQgfzl5mvMYyfbNaPlBRYbE6064Js+3O9c2qXxJfPrpluFpmnDB7xOonNmfYTqLgDD2G0GKS46XbzfCC04M7ptPLCI5hJJmryEIPXbKDpi5bBOFrrO2DmM+4v6/1Dmv3P2S5qS2TQxm5qxhj3Ujx71z/ExriYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710965033; c=relaxed/simple;
	bh=U6JIEUIx2TWWkrc1X31cjLskTAPioQtck35FTzCs/DU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bAWicv/JNvkK/Ayrw+uzOcbcYQZp+Royxog5IcGCvRNmSZF3KAZxFH4DnQA4/7LUWMnotvsnnfORySqj5GRRjAV16OFipEz6cuunzcwG7ZWd1xmxBl3vC45Q1QWjU8eTZhpYRqTjwlorhHt9O0jcm2SFPji4JwIAw+ISbgvAf7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHD8gPnS; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHD8gPnS"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-789d0c90cadso16263385a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 13:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710965031; x=1711569831; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5b0LfF0oERpXgxPRFfV4DG9p3yh9z62csM//+Ls5P7k=;
        b=gHD8gPnSXp1lTjRJywlxTUZXJo3R6uihg7gSgpWlgDTLbBhVsnBFkjdL7XDs2URcSl
         QD7yYYSbnnHTUEgCsu3xBFTue7yjpw0ig2/lxWwzUZX5HYalBEJt+hphxVIjwYCgC2oV
         vfGDd2Q5L4VWmK1WK57XtpC1MD5RfmA0GpAVCDJlIP/u6QxtLayQCbgiG+RKkvIWRHIu
         u70qmdvEmYhfnNO6TaO542Mdcz8h4vhmQD+TOGGbA76O+HunTQUsMA5o4JYMzvDRitWE
         zhTuNR7j/HiOGwL7OXPbdrrt48rpUn+6xsNFhdJyE5oThZhiNYiO+i2MQ/brJPn55mUB
         xXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710965031; x=1711569831;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5b0LfF0oERpXgxPRFfV4DG9p3yh9z62csM//+Ls5P7k=;
        b=S9aPdE5sP580HtKMa5XwImDw9Wtux8fty/9hOVOR6Gg3s1ghdCQkzQaYtuo6XiAWp5
         /t5DsJjqOSEllA2eOIRvb0CFULwN/BrX7FdDjI54VKgRhSfq8ufOBs7uI+LN9YU0XvYy
         TaG7cDzL9S/4EqwAGBhWXTspvkxNFCNtAyaEmN9gQ3/79pSYNwexyXuZ+GQ8xk5QC8FK
         HQ+2XYRfMZ6UCd6Y27bhy4OyaFTN3sRfruM18hU+uwPvyKpFQcmQQavqPzWBmDMW7nBz
         T87hujvPWJOQovqcWNWvIF6ekt2rJMcSMsf0YsBRQyD5kJ4Lm2nSAU18u4xceq9lWkGi
         0Z/Q==
X-Gm-Message-State: AOJu0YwB6NZt4UmVOczIr+y477erpSphi4mXNxjK3KRapPLcfgjKPlgm
	sOfmkYfm+vYa1t1PxPAP9ja7kb8PJhjkGuSLzwgfsk3eqNGx+glFTqH97AyJ
X-Google-Smtp-Source: AGHT+IE4ZAfs/8zvCDtntH6/5Q+KgRBB0r9nmWojpv4MbL2OsXlFT2bNvf5mn/J7meMldZB3dMuzOg==
X-Received: by 2002:a05:620a:40c1:b0:788:2f70:a1a1 with SMTP id g1-20020a05620a40c100b007882f70a1a1mr8959446qko.15.1710965030905;
        Wed, 20 Mar 2024 13:03:50 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.91.41])
        by smtp.gmail.com with ESMTPSA id x16-20020ae9e910000000b0078a132713b3sm1910872qkf.55.2024.03.20.13.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 13:03:50 -0700 (PDT)
Message-ID: <65fb4126.e90a0220.6f9bf.e37d@mx.google.com>
Date: Wed, 20 Mar 2024 13:03:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6489070009513496332=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/btsnoop: Add proper identifiers for ISO packets
In-Reply-To: <20240320183038.411332-1-luiz.dentz@gmail.com>
References: <20240320183038.411332-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6489070009513496332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=836816

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      24.02 seconds
BluezMake                     PASS      1746.26 seconds
MakeCheck                     PASS      13.24 seconds
MakeDistcheck                 PASS      176.76 seconds
CheckValgrind                 PASS      248.79 seconds
CheckSmatch                   PASS      353.43 seconds
bluezmakeextell               PASS      120.04 seconds
IncrementalBuild              PASS      1488.60 seconds
ScanBuild                     PASS      996.75 seconds



---
Regards,
Linux Bluetooth


--===============6489070009513496332==--
