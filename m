Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7AE433BA
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 20:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115817; cv=none; b=BIVTAsdPWxElWouXruwYW3uZReF6FJL51NoqT5uXZDd20kASs7+pLabdiFQG2Om5Eb2Utlaqsla57kQ761hhzH/j17ZnO9EJzIVvdRR4ICQUMTrbeD20+xLAnxOZINg8DHCGqzk4OAu6I2fabSLFZtbDCLQwssxtF9YOVYYrE20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115817; c=relaxed/simple;
	bh=U2BvCuwUkY1UGXy3BiruCl7JIkfVMwgfvwEXIoM1quc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=uyfn0WN+ibiF6Q4j5d6yrUVkuSSe99/hz5s1NjcbYZVn7PyHiL2hjuf+Qg21rH+OrJp+t62gR3JnH4Jd0BrF+ElWs5oROPg2fhxPF/JCW+lHBldU26Gbpuvmx2I1Yz9kJtNqFYUUrGxw7icmaz30KrR05/yPBiYYjPbLazB+NY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLqU6Wpz; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLqU6Wpz"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d746856d85so11024685ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Feb 2024 12:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708115815; x=1708720615; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U2BvCuwUkY1UGXy3BiruCl7JIkfVMwgfvwEXIoM1quc=;
        b=nLqU6WpzEJx514wrLtMXr9R9fbRt+O4orULTcybrM/PUAkn8XuSTxkYR4Hk2f6WSp1
         OrT6on+hUClr/Y5IWnky3VfrZ7Ii1eLVQKsHzrFNry4wOcMS6hjIKcKtrSp6mOKOe02a
         CvEwLk3UTn58Us5MPDcBkj2NAKqBPeYB3SsxdDH/AeZKW5uIeMVrkeG97RKv1vG+nEmM
         FjMjmgxhsa/n3Ne27tyGPK5ioh6rs+tL8ap9xaBFTuFhVKMctdRKiK8BUgHG0L3SlVOt
         JVTYXuQtSOMQ5oU9YJSuCVcWa4gsy6MyPZ5o5uJmHe90gsRhkBVdd8TpOjiypNl99Xih
         Q28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115815; x=1708720615;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2BvCuwUkY1UGXy3BiruCl7JIkfVMwgfvwEXIoM1quc=;
        b=wQ5db2YyzdYEuWXlTP8xlu/jktSKOo8HLJoW3xAHI3RBfFconb0EqD+VBtjrCw2lRO
         JyqWv4QPu2pVgMjULYC7fnfoE9siPlumkBetnCwwsL6UoGTd/wFvwA1HCWdx1yd8vcOC
         hzIwlr56rzWyA7KCgPiC+4AtKtnkMrtSXtOfOAQWSh9IGlDToqcpvCeOowFUwa/JFE3F
         lqmTKeg6CE/ztDIvR0jDTqyPmJ3XRhTn8y913aLY4/TtCGee2CxjBjocDsWoKt6i1Ktn
         wUeA4d28ydd/iVXQtOkgcSDsEdaixbbqEsdQSYwNMG8UpdHWiP38iPB4QkmLhL4auQEB
         hSAg==
X-Gm-Message-State: AOJu0Yxm70WIV9TCpvrvA4w9NJDLDSYy4KaLYomNaMF3eRGsQ2CjiBU6
	g3MmIOmUHFI0qo1wavAElcZUUvtiKzqhVUOtb5Dl4gsujG0xUNMNmdkhHFTg
X-Google-Smtp-Source: AGHT+IHLi+XnA/n7c4JambJjvNb0y6uWYmRz1XMyLITjcmAElLU/uhU1QeDmVDsDCEM8H/3PE7RtjA==
X-Received: by 2002:a17:902:c1c1:b0:1db:b43b:e9 with SMTP id c1-20020a170902c1c100b001dbb43b00e9mr1350004plc.7.1708115814730;
        Fri, 16 Feb 2024 12:36:54 -0800 (PST)
Received: from [172.17.0.2] ([20.172.28.132])
        by smtp.gmail.com with ESMTPSA id mo7-20020a1709030a8700b001db5ecd115bsm255979plb.276.2024.02.16.12.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:36:54 -0800 (PST)
Message-ID: <65cfc766.170a0220.d3bde.1f8d@mx.google.com>
Date: Fri, 16 Feb 2024 12:36:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7593378394628848044=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, brgl@bgdev.pl
Subject: RE: power: sequencing: implement the subsystem and add first users
In-Reply-To: <20240216203215.40870-2-brgl@bgdev.pl>
References: <20240216203215.40870-2-brgl@bgdev.pl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7593378394628848044==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: arch/arm64/boot/dts/qcom/sm8650-qrd.dts:1139
error: arch/arm64/boot/dts/qcom/sm8650-qrd.dts: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7593378394628848044==--
