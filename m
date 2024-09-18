Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E563314B94A
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Sep 2024 20:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726692002; cv=none; b=H8NjDWydDb3u8CkbSTfBO4SHg6M/c9UMnFHOz9FSezjxwEor9nm7UO+xkggB0ffnLPFnEbFIoNYANzVcJHmn3+npg6ESHXuxBSGgZKE50mqBvzaZqYkc/3MRBZJ6kANDl2dN7VQamc8J1JArYZUYfJfW6o9/maC8ao6bSFIWCMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726692002; c=relaxed/simple;
	bh=vdlqGFTFdA76ONv2SHR6i0aN6bRsqQUemop6UOGTiA4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Nz+oDD0Z5pB1BsZ5t1NLRaL+8IMd5OWFzArGijAUpExLGV3O2qw8+InQHJU8hL/SrdyRli8iMG8kfETXoPH1z25Yll7Kjue4YzRMbMADbJI6kVtv8AsWhDkx8t8ZTnqVYI9lE9e2HfvemFwQX018CGOH02LKxWST+HBRdjFl0wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Al30lX0m; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Al30lX0m"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a9b3cd75e5so11936785a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Sep 2024 13:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726691999; x=1727296799; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0RUJKLeB/Gxspj/c2tcb8BAHK1HhesS7GNjFC9eN4Ls=;
        b=Al30lX0my1yOzOeajudPsKBpFEevqjUPT3QaNUvZx0u/aeB2WZPPqZEkkH4Ne6ItjL
         LMIL12R77XZ7AmLjQkiBCZV0L+9i+SeaPtfZS/woXOfZZb+L6PxpixR1ZZwzmDj4h4UB
         rpbyV519q8+cid/RK5BVOrsF49t+6rMRqDT9iS5jKA3LrW+dOP7xPUh2eKvZVIDIR927
         1an2p8JHnDm5FOXXpoX8sQS9ov4yCXL4dxqxN+xYwr2BhRIUcBI81lIP2n3T5N8xpiQZ
         nCag6avLGnABLdtSeZYvdVuudqS0WdQyp5W7p9/JdTv16JDqYQyOsReCrY/KRSWwX5i4
         3yxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726691999; x=1727296799;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0RUJKLeB/Gxspj/c2tcb8BAHK1HhesS7GNjFC9eN4Ls=;
        b=YMgkDO1E1TFpWmuGMUaOG7LoM1vVxp9fDNYsIiCgUXXx55wggdXohwKVpqpqw27y+/
         K/IEz5cQHkZQilOJT+oWNqJHzE7atvheWVY3CzzpN8nLc3eaEFkBkImEGYVfY55e6Hkb
         DgWIXQoceYLkfJY1TQFljTPv5lKWkDt+Pa67clwiACnwsUfVczvxtODVSMp4Yw4G6eWz
         ROCNnbIShOK2ybUx2TSzFa3XiF83aUsy9PD4FtPBZGeUfjP6JPPLpe2Lx7GaIDuUnJM+
         9MGPmvwi+vnkDTYIgQ9n41QRJH0TKRiiQm2GgWhvcyxmHIAyQoxkNZflQv85aeMcGP+C
         kDxg==
X-Gm-Message-State: AOJu0YxvWjpuL7Jcmb+MR9jSMFpiGc0H/BlalhaFkblzQK9kaD/hDv5y
	VWB+rQuDeyc0mQyHVQnEeq9sQKdpE0A9Bw98FF99067hZ/blL0DmNEokpQ==
X-Google-Smtp-Source: AGHT+IGtP2v3Bl4fXJ27m6MXJShBAWTUfPlZs4E+Ebx8xgpVLUEN4MysYItglCBwfEEjIwlVjzbjHw==
X-Received: by 2002:a05:620a:394f:b0:7a9:a6a7:dc46 with SMTP id af79cd13be357-7a9e5ef6713mr4527470385a.24.1726691999482;
        Wed, 18 Sep 2024 13:39:59 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.147.127])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7acb08bc4c1sm8410985a.97.2024.09.18.13.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 13:39:58 -0700 (PDT)
Message-ID: <66eb3a9e.050a0220.ed07e.085c@mx.google.com>
Date: Wed, 18 Sep 2024 13:39:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4747860523815837245=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] doc: Remove Pygments dependency from manpage
In-Reply-To: <20240918184839.662364-1-luiz.dentz@gmail.com>
References: <20240918184839.662364-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4747860523815837245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=891245

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
GitLint                       PASS      0.29 seconds
BuildEll                      PASS      24.53 seconds
BluezMake                     PASS      1669.60 seconds
MakeCheck                     PASS      13.51 seconds
MakeDistcheck                 PASS      179.47 seconds
CheckValgrind                 PASS      253.79 seconds
CheckSmatch                   PASS      357.66 seconds
bluezmakeextell               PASS      121.97 seconds
IncrementalBuild              PASS      1445.68 seconds
ScanBuild                     PASS      1019.07 seconds



---
Regards,
Linux Bluetooth


--===============4747860523815837245==--
