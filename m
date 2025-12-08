Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0222E5437
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Dec 2025 13:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765199693; cv=none; b=EI80rfwd8JOQcyV+av7t3N/lRGvLHC957Auq8hb1/DrHVFtuRM8RTYBaZky3HyZpYHlIvAD3okTHZFzoK0FZd9cjIsSwWkOE+5NkqNsMsLfNZXhL18t9RO6r/2Jy14lfjfDhAufXs6s+FXwsZKAR8O7nkKvLNx1H0kn1xfm63YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765199693; c=relaxed/simple;
	bh=VtfC54Bk9m36N3JzPDdL2sOd3ev2JVBJJgfqADSqXLo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pr2b+uLnyAbMZhO9E2Qj9KAWKYPxOAxHDggql1TPiG126KYzuLHCB/ndGxc0sa1Vd/hbIBbgXjnuXJ4u/7xySlJKY/TQXVBj8quNPI5Kg+RZuEph572QxXNgouSQOKMRvMViBjYqTz6MroNg03b4GJk9EnAEtOxfalOmDksiy4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkKf5WAr; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkKf5WAr"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29586626fbeso52147405ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Dec 2025 05:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765199691; x=1765804491; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VtfC54Bk9m36N3JzPDdL2sOd3ev2JVBJJgfqADSqXLo=;
        b=BkKf5WArLAfTNQBsl1qUYRX8PF2qWaRh0kPQQrqQTtspdNTa/InlAORV7FLAxrDx5S
         Zl+tGtFqTgyz28bAYCKIqmPoGOp86/7a/PBzC7OcIta7nn3i1dNkLYMv0UXty3BCQTZJ
         3B9uEQUfoz3gEEFAzDPFvIguKN+CuwyhXo4gdMoSQFnxQdTHsFmy9bxDVLIhr1T4joNI
         zFRODz61Ux3sY79iYWxpcf/LwR5axsoQqWtfO1hZJax+hfxY14Q1AHdl/pvjESIF2yWc
         DSs8WwuRPlstX76rArajG8N7SEKlWiJcVA2g+//REUGx1oLYmIYPCvltwfXozJl/c4Ol
         50NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765199691; x=1765804491;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtfC54Bk9m36N3JzPDdL2sOd3ev2JVBJJgfqADSqXLo=;
        b=oE4vMrhDcFvitSINQnNW5nwZq2LDyh6k0AW4vVtL13Pp1wjfvXiMI+q7lvM1zhEwYw
         OI+53Uu201aQNxGgrmSJQvmxwPiQGoyYWhZgLHkEaci8ZobfHgaVmrIh9h9gRrv/S7qh
         8aN0g1mXppYU0AXEG4zlmBYYIYOyUNZSv/xMLrBe5BaVKJ1NUJD6NmozLvdVHxInkWyQ
         eAoQp2Oz7cEeV6WGFGe9bLRZ6oM0wf5rOXLCbnxMUm2bft4RHIZBaB31xmFM34JfCYfE
         OLLpzHZOGq+cMuGSZv+t/zcBL57FLYUXEtaQQoFH/Em93WfH4ERsjGRxpH3I8ZTyrQej
         BsBw==
X-Gm-Message-State: AOJu0Yxjacu3T9ANPFrFHeCnLDH8MiSA0tZiutK43B7ckfelwMXJyZGp
	c411ztI/h6Olkg4Y/v71XH2r2J3YYiKe+YFLiJ0Zvyz4SBLwx4hN+go2UVPEow==
X-Gm-Gg: ASbGncsx4CZ+kbtB0o3jyuY0MsMH1n66JyCaL9R5hb0WzcoyIDUYnfcMUKeEV4KcJ7y
	4atlRVEA+NTmGa9Ouzsc6d/7TZJUe7XShZAEQLwXNlEj99B+rLbBbcjSvxM+8tbV++HZzZCMoF2
	vabwtp5CLnw2SFmZiRZFqNVdLV17S1sG0GB/pwLeFZP36UzyKsGo8qN7ivgJQpS2ka1JOYJwUmA
	/0iRRd7WkfA4f7jNE22b/Fm58qTSK/lUaWV6vncEbxo+4+LYrh6e06fb98U/NY/haBtzxzkY2+J
	kE4jlnZtydu286QwYi5zXoGn33kF2itGkiDqOeU5NFDBxOpSiGGVOM93HpugYHzE1qPwBpti5X+
	Y31Xhd7ZAA0d9MC93VgSYhJJGdufxR4qyoIDbNqzPxsCbZoTfhzCgrsHE95Q5VhyuNeBSrCyL7l
	Wuo/g+Y4y/hPD8zw==
X-Google-Smtp-Source: AGHT+IFpw3sEWUhdShBJlT46U1vMlC8om0u749PeZAKx34Z2TdDlTCSrEJiyC8MhBlRTwmj1XPsmbQ==
X-Received: by 2002:a05:7022:50a:b0:11b:8161:5cfc with SMTP id a92af1059eb24-11e032b2aadmr6643058c88.36.1765199690564;
        Mon, 08 Dec 2025 05:14:50 -0800 (PST)
Received: from [172.17.0.2] ([68.220.58.3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76ed82esm60395799c88.7.2025.12.08.05.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 05:14:50 -0800 (PST)
Message-ID: <6936cf4a.050a0220.31b226.e52f@mx.google.com>
Date: Mon, 08 Dec 2025 05:14:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5469576850256682846=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, wang.yaxin@zte.com.cn
Subject: RE: Bluetooth: hci_conn: Fix WARNING in hci_conn_timeout
In-Reply-To: <20251208203245047U3UW5v2aGUumhmvjLl96E@zte.com.cn>
References: <20251208203245047U3UW5v2aGUumhmvjLl96E@zte.com.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5469576850256682846==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: include/net/bluetooth/hci_core.h:29
error: include/net/bluetooth/hci_core.h: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5469576850256682846==--
