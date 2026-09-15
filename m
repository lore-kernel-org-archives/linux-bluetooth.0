Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008D53D3D02
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 17:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789492267; cv=none; b=Ql+rPxdy1J3Q9HPagb6Ki0CrzN7bclGSGA204iOxdNRcsKY/oMo0a0c4/rW9/r+BMkyBGUnQPM6pYfWn2AqNo3/HnKdB9oYiHjCYbdIklgGMfTuoCx6ffze87BpLVkSetPSe+xBCaPXMXrxIKGPYw9aKJ0Jto35xfdnkeAkaBks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789492267; c=relaxed/simple;
	bh=tAzbtAzYiiZxDT/7cA/nct1zP/YeDzIxyI6qbWjVA2Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nQAPhpkdB2ur3xAWDiyGupFz0F8noN5SmKnX+tWyWBqQVzwV29nwmd0ymxsGQmNWGFVDx6g7BXmtPXnYSTYNdAZ4vUWUD0hMilcOdi+jaRRPKjLGUI00VzlVtoJs2HW74CKFSAwKR8ysFP0fDNrEv5ytEAu04H/Rbjicm93lFVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iH1Xcrd6; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iH1Xcrd6"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-398b1e63c49so1079778a91.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 10:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789492265; x=1790097065; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tAzbtAzYiiZxDT/7cA/nct1zP/YeDzIxyI6qbWjVA2Y=;
        b=iH1Xcrd6qQNpLF4mRBTCMA8HW/5e3oFP7BMfCWxu4suDKD5rpjmp+m+yleiVLP5O39
         JWoaspL/1Qm8T0VMYgRbZ/H7N9HQrAQ80htWiku5falPO2qV938NbQHFiEuM86y0zDBL
         hUTDiCOqoMF7sWNZkE6lQIfiEnCMeYhv+lrRa4VyLSv6wM8cssW2oZu0YXYB+rvXnTpd
         nJqvFddbUXQUtxEapiXLEg2wXIZqYGEJMeAmsPsSK+ymLWAW/Z79QWQKIfE8O4sYL3ir
         RdDYUccBb0N2ltsh8aMVxwite4L/kbmE0ctBmdEr/r0yXv7bHt+3v6zyN+CjiQFSK9Y0
         LnOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789492265; x=1790097065;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tAzbtAzYiiZxDT/7cA/nct1zP/YeDzIxyI6qbWjVA2Y=;
        b=eNHTkc9tudsEJdxd7mD95RRLcuBLqo6NXQz1iOQROSW29FlNIcwHX7JkV+ffpkcQYv
         KfA9BysSOFyKDmFtBDw8+8ZBuZszWrzuZf0BX6DxrT2GG7zWA5nuwLNPvn01nyQal8LG
         YQT7K2TG1XeXh2Nwn73hhPoEz1y66FWSIDWeVWHBThEJKWnD++qHjURZP6K1ffYYYl2C
         ULtYvXcKgZTa7G6KrvpfuoFgdQ0aXC3+AVMqpZf2oEzkN+wJirxonCqBVOqDjZ0ueGCP
         /GILLcNW5rtZbPN2HDcLxe8VqCV6hmTnEIio1oOavllSKqtBuDOBFO1yPLAaRnfszsIN
         rsWg==
X-Gm-Message-State: AFuF++lRsdAA0q8MsFVnzAJ9lCLvrdXNXKaP/XkNs9O2ytrEzoXreWA5
	69hXLD5/NVuZgVCSCtHVgOWuOzcLGV362owEOwMM+EXybuqGFv9b7iTDpAspYw==
X-Gm-Gg: AYBFou38Anr24tSfwhgAJQEbBA8mOjwswjD9jQsNc8Tz5sfY+c5y2AmxFzp683bz6H2
	12zVNteHbR6vEhJ+cOnjT0y8OCf+SwS6uP8K57MMb1+qI5Qj2NCqr3LV1nBwu9e05/Q5jdhZvJW
	GYjnhMDuIzIzXxFx63OhzOr0ECmopdlgKxvjlvCetMy2kDeZJrNlNe51x66ovFlrRQjtB/UTJJF
	hTsCctZITRi9/9SxOa7dlB+raP0pp7WTbF/qPWG+wz17J85KJ5z2S7ODsR9S0wTNa2O9227cLwj
	XFBO90cAl6CTQMYSsu+24DfAvrZ8/vd3An36LpbrVbxboFQk8JcGqMR27c7CYy/sO6c+quk6T1P
	DvOzgvK9iB+Aw/oxNIeUpYHtIkI4JuMA7TpJyzZOwm00k43HTbNjdSAiKbJq0U35rOOhJVHoR6t
	p2RitZKJgQiy1dePHTaMpXbyfm/nHDzrjm+m1LyVXEnBUD/nkfMFl0woIe8g7+HSFOoLNMEEIJH
	+0=
X-Received: by 2002:a17:90b:2cce:b0:398:9beb:a2bc with SMTP id 98e67ed59e1d1-39dfe211ef2mr7002430a91.30.1789492265112;
        Tue, 15 Sep 2026 10:11:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.53.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5b0520asm429653eec.27.2026.09.15.10.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 10:11:04 -0700 (PDT)
Message-ID: <6aa97c28.7f4eb0be.14ffa3.1fe8@mx.google.com>
Date: Tue, 15 Sep 2026 10:11:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0041465188403271663=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, manivannan.sadhasivam@oss.qualcomm.com
Subject: RE: Rework M.2 Bluetooth instantiation using the auxiliary bus
In-Reply-To: <20260915-pci-m2-bt-rework-v1-1-3c7d9cf9c010@oss.qualcomm.com>
References: <20260915-pci-m2-bt-rework-v1-1-3c7d9cf9c010@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0041465188403271663==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btnxpuart.c:1884
error: drivers/bluetooth/btnxpuart.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0041465188403271663==--
