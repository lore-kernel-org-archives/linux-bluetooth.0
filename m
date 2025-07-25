Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6081FC3
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jul 2025 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753433550; cv=none; b=bRGYAUJYYZaFaH5hwU5z/YMoStcaTAsrZa2PYRR9i0mOFzU/EXlY0+XMIce9hauWphPSWueNOdB84PC7NCbax+E+WrECz1kY3OizrpyJjrYpOVFSHjjAP24Zq36f75iqHXT6FRP8hOejByuvbCE07IC+tR3fur3l2KyeARCWb4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753433550; c=relaxed/simple;
	bh=RLSaI+eB3pJYY9Om2ECM8AKDmfgBACzxVBAsam4rufo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=D9Zv1FNmSYWyZ4gglGZ07ZafflSHPGqEv02G8g1Lmgc+7x2CPBMstIN3LNs++/RJ2E7XD/X3xPVfPLtUbUGEErOj5GOUq4EqBZ/JNt8vF2liOV9JLdXfliMIrOEhX1+uYE3QjlZdvsExHRl12VVedenABnCI/fbhvvIkfPSMS0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mq318Na5; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mq318Na5"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-86efcef9194so74539739f.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jul 2025 01:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753433548; x=1754038348; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RLSaI+eB3pJYY9Om2ECM8AKDmfgBACzxVBAsam4rufo=;
        b=mq318Na5A+5DCqOwSUCM3dljvhxtIe+l4Ab1u+gwuRXypm8mrzVpbke0L6M1O7s4Xd
         1rh/adPmiBl2YNqlIdUxYg+A34O4MisUJA0wWTcPxeURhVbcvCskOyCPKDP7Q4uNB7wL
         EAdS+w7pQRUKvZVo8z1nT/75vl5SywS1hHFn5n5wQXqgXefnA3AZ83cEWs8gnzdX3h/E
         MmTwgp5yK2Z3AmhceE3MuQmDQcC9yvlCq+1SyHmTQPkiU+yqZ/K1IueSCUm2Xcoyv0l6
         iyEfMqnvhLMhg4e671jVQOfV0xnCZMxQQvSBqyB8ayqnU4Oo+iRHd8HnhHblUrFoCjNv
         DHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753433548; x=1754038348;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLSaI+eB3pJYY9Om2ECM8AKDmfgBACzxVBAsam4rufo=;
        b=dAH7egkvWtwr9OQtRoO4YdgZX99gBnkbQVPFX5u5yQ8PcvGqIdXyY0XE/w7xlIauiB
         IKP09/+hdFKz5+gpATz+yi0/s67bBIXCTcp8OVDn092/HuTOFpKfmGDWNw+2kLqhOW3H
         Wl69EP/uRipjZxDc4cdDw3dnKEVCd06fzAqZWmIzg1+atOQGpCBzRjGixICaTc1BiS1i
         m4vccuFyQ7W5VilrILEIfbPOwHXeIOQRAHc0+K7bGN83FfvK1BqgkVph9WscwOnmrFyc
         L3xacQ9tACHzrsncWfL0giMliPSJ3qa2ux3VfICiTo5TCK26v+lPfN3TJOGmevl+LNqA
         uwBw==
X-Gm-Message-State: AOJu0Yzb6A4Pu27p1xPnOCCiqljLG85XdGyueviAWsM5fvamt8YgD284
	8rkRsI3NWIgqWVWjaiSGyx9LR4Wp4lL0B70QOFi+V6ZU9fE2NxW7R6oPtBOQEA==
X-Gm-Gg: ASbGncsNvfeJZzZgbdzdQ9qabuirQfUEq+ABifguc85jTDzvPScHhHJbuWVjqz0rUpJ
	wemFzpuF7+PzAjDJZFg/EZ7NT+kPWrGKBKwktAWcBbI9YJjFEpwwW2XPQXj4lDaD/TFyWAbgOi4
	JLmIHa7DXkS9pfu+ATRSrtUNL41u8XDfdkjNsxlpi4GYe7O4EkIFN0Y4NPfmsrGp7TfUYmNEE8n
	+mkPJtzArvHGVKdx+BtxverxGdQkdg20Uwxi/VkpNdQ12f4OagX/X/51KWAvPy5zK937YhkChcr
	2k55+nL/MjW0JcxaHu7q6qoxI9i4tIAdEJe8iERNQVcFc9+FOlmXMQPOkS1FLUC9yhP7IPstJaS
	mHK7sDmo/FSpmwXrjnGG5eAG4kYdM
X-Google-Smtp-Source: AGHT+IEwJ3J00kDjjD8G/Trjn/17lMoJGD+MkIYaBYfHnWvO5670y/iP7dDFHiv47nPt2oAKqACtYg==
X-Received: by 2002:a05:6602:2752:b0:874:e108:8e3a with SMTP id ca18e2360f4ac-88022a6f80dmr130278339f.12.1753433548212;
        Fri, 25 Jul 2025 01:52:28 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.169.99])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-87c74341323sm91050639f.38.2025.07.25.01.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 01:52:27 -0700 (PDT)
Message-ID: <688345cb.6b0a0220.357bc1.134a@mx.google.com>
Date: Fri, 25 Jul 2025 01:52:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7518901252677478198=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v6] Bluetooth: btintel_pcie: Add support for _suspend() / _resume()
In-Reply-To: <20250725090133.1358775-1-kiran.k@intel.com>
References: <20250725090133.1358775-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7518901252677478198==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btintel_pcie.c:2573
error: drivers/bluetooth/btintel_pcie.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7518901252677478198==--
