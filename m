Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83EB2F49EA
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Oct 2025 15:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760109400; cv=none; b=KN15cimPSpaP5UD4nN6nXNBEYXbKFLyg4oXi8TTqX8bAUz4v87QUzDGbjeDhqz9/JuEvvaWfhpmDivuqSnGWZTFAwyCDd3hVrjxMroUGFGkB1o+gjdw9BntxuIjnYs26YGf6sInV/xtvLnsziBQQledDEZEwn4ZeboRobVMLE/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760109400; c=relaxed/simple;
	bh=p+RLQAOKBtDt2a+G3xIsIm4LfJAbsJYa4uinqxglJdI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=j1PmhqmYxk+4NDNOnNEGWUn4hR729oDrFIIprBxoo7LDIZOfF/jjZQpKgNpYHqTNCshe7uKUdmzXxxPjJ9ciMpGUU45Nm+A1fu+jSaVgl7/S+cREB6TZaMOuNArUIpHBkky0kSe5tA4Yxsrjy6GEi48GPTHIXSZ1zFSpq2m3y8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvXpTZfL; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvXpTZfL"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-782bfd0a977so1963829b3a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Oct 2025 08:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760109398; x=1760714198; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p+RLQAOKBtDt2a+G3xIsIm4LfJAbsJYa4uinqxglJdI=;
        b=ZvXpTZfLSoysLyDPcdgods2fqakW2d+rsywuDRF6PgSboO5VZZRtRx3g+KeNegBqc/
         L9zGofahxeQmYNTboMbddHDrDdVAl52kajhivaoYPHuep1PXOGlalBuxdY4s5JXCMtDi
         W8VAWLmI3roIis93pT+5OVjnyzW/r9mpWVXglUSwyNMJpSDxCkXdS+XmeZv9XbQdA8+u
         YcpB2daVVLl6kNlE+jTCUTw0KOITSVDNU2k5mXVBr8j7oAp9We0qbIBypYI5gIQwfZa2
         3tdLWnXyGhi9VybJGJTArje0EEfWKCE2XTkMLOHW15XNZMyX48VK2ztk9v5JOR5gCHFt
         OpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760109398; x=1760714198;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+RLQAOKBtDt2a+G3xIsIm4LfJAbsJYa4uinqxglJdI=;
        b=goGTEeqa2k9MrCr2M2PEjj7SUD6PoEOGZB4PL7/jv4c3eRZShUjl3olPDUvTKC/oIJ
         dHyLVf+z4qSRBFtL+PKLZJLUoygJ8gDVs4tDBc2EbAT5F0wRI+LiNvEte++2s/VKqZOF
         VAYVYPRWBAtJxgaLshR0FTpSAtnFEQ0g/wK9SFZ1hzHntx5wOAfnv+IrVVZot3dUiLt3
         XpeV69kMg3L4OkrG043on8/9i+pMRlJQxhnbkKCBXKiA//+knxGcex+lkJMBmIIdNtAc
         q9J3sbz5si4X+o+ymceMDJp8/h7w+2kO0ZWXG1xn/j2JXNjAf0ByjlIUPmd5iMttso5Q
         jF7Q==
X-Gm-Message-State: AOJu0YzrpYl3J4yQFPW107JtBZC61aXBaPdInbWV32YrXfAUPpzquuFv
	4eRZPuogX3ojVhDPicrr4iqofrvKNMGMwjG+iI7k0BoswlcsgImjcuLhPP6Jmg==
X-Gm-Gg: ASbGnctg35oJ86CpSq03XUU7nuBx8yZfAdyv2WPBhg1XogfGWPJx94/CphyrJEDlMuY
	jxTr1PdjWHwcbADvLGvWZTetMDK+BBrpfZVhQ7W1AGqLxuxJYZcxrOXCEMCC8NeOHVyHdiu3/RO
	DxC+qmei806Gd0Vwj9xk8k1cp590EMM6F0slrSnVk3S4s9PVcZrrZc2WoIYVhp5EIWyI9h1eZJc
	pYSLnupzuRn+guPz7HC5SmMmmMECN/0GrSCkstu6mQ6CiwZ9hZTpbcA4J33EWkZj/4Woen+vhFv
	fIgMiAeQTWCYX6LyuhTKvSJU7tuUfsdBsfH1FCzcc8/R9Gs96nn9dRBfF7GxRbsAYU7TgkjsMJe
	50C3hgqoqnsYYS57zZfK0Qr6tAugBQCZTgwZSAtujes1d7OQ=
X-Google-Smtp-Source: AGHT+IHPUGIKIJG+F2YUj2F7r3mjRIMITEtgYGUIGOjE7ddOogamp8X32eD5MAEZQZOL1OAwFPRYkA==
X-Received: by 2002:a05:6a20:258f:b0:2f6:14c6:95ea with SMTP id adf61e73a8af0-32da8130d99mr16274899637.20.1760109397626;
        Fri, 10 Oct 2025 08:16:37 -0700 (PDT)
Received: from [172.17.0.2] ([128.24.163.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d7e4sm3627243a91.3.2025.10.10.08.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 08:16:37 -0700 (PDT)
Message-ID: <68e92355.170a0220.6bdc2.0e80@mx.google.com>
Date: Fri, 10 Oct 2025 08:16:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4623900778411923628=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, aha310510@gmail.com
Subject: RE: timers: Provide timer_shutdown[_sync]()
In-Reply-To: <20251010150252.1115788-2-aha310510@gmail.com>
References: <20251010150252.1115788-2-aha310510@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4623900778411923628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: Documentation/kernel-hacking/locking.rst:1006
error: Documentation/kernel-hacking/locking.rst: patch does not apply
error: patch failed: Documentation/translations/it_IT/kernel-hacking/locking.rst:1027
error: Documentation/translations/it_IT/kernel-hacking/locking.rst: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4623900778411923628==--
