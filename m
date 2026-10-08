Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8590D42E8F0
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 08:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791446961; cv=none; b=a8/qTe03Z6kgZZcmCC1Nwc47zO4PfQbJk6GaEXC78Zh+D3w/bUCRAvvFVzSbaeayuOv3Z+gGuoNovJvKhrPRXr1W4aOWqDRfUPsT8ObyHJXgCBDdpkU4nr9osm0UufYE56gBMa4q6qXW5N1lqJXiSoZhsskNOykZOo2t++frI8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791446961; c=relaxed/simple;
	bh=EEtMX9CnHIcr4vjAOGNHROQrZ17POK9EdblKmaDrIDE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=k4b8Q6QfHZBajOk9dcgF+ULBhHfRJ7NlYxwMlIqAjnw4Qti94cz3i4y9Qo9Lb/gef7vF3kgIOC3E011S7BGBSId8rD+hBjLycJJ2XTXfpsaLjwNuZNBcE3IRPfcpwe0S8ft+NzhBh8fftI61YjE2+NuAxVZ9j/pvBdgvbvy6W2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdHb/2jG; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdHb/2jG"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5352a876d5aso31604191cf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 01:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791446959; x=1792051759; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YOvMss6crVexfo/azC3mNZgxRs4aUqmCNMCm4ek4amA=;
        b=HdHb/2jGpkYMFiIBghtkcwfHE65eftr5+9+TSD0g9OM5mmPCo8LD5WuPVN/XrTrOoo
         UGR6NqslktiWPeBWh53fl7CNmiaca29zw3a2DcMC9lsj6epznrX8K09CD4BfqEgOx8j0
         /MHip8SPAtvVjfQIxLxJhm8vvevFOBapVxzBprFI/76ARlOQAZWVrYUje0b1vFPMvqPM
         LndFBT+gswurAvTcM55nPvlZab9BCGlVfQEaO39uQlIyEnjltKGFVMWu6/sdVs5MTRdl
         n1c1evJRFNjPiQeNQt3qcNKtZ7FGPTjfYLHh9kIngtNx49Q9JHXut3qhDzk1xPweZirr
         nP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791446959; x=1792051759;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YOvMss6crVexfo/azC3mNZgxRs4aUqmCNMCm4ek4amA=;
        b=0ZiM4KTc5hMjzbT+uPB/P6pazNxkongcio017YXnGkBx9IRzgtXbmtP/5e8uRER7YR
         +/DIOfx2YT+iW2SwSNVsC4kKOttcOh6XuwsavDd0N9Kzws/yiwfNZORRcx0b+Y6LjEa1
         rprBCPQcF64pully1A3JrrULiz5gvwbYp5rAOQvaPt19E618RTv+4pTkN2opPsqQ/xdb
         eh/OXQWJAyUKtn2GRNBk5iD9J+s9adTZ//GaOJHY+7rPAMZqoidpw+FivE9Ged2XyV5q
         GarXu6mdFBAkyfo27JtHFWinluxk71J0ucKtQvZQgSp7O85if8h827ZEQmlnUxIkD4fF
         ql5Q==
X-Gm-Message-State: AFuF++k+yFMhZrmLnZJee3AGVqH62oKbV83z+FJZa33IMN7HhgRfM9+1
	XzwADLwUiQJm2lBvWByvLQjt+KmuVAea1dtWBaasCCvWgUyPac1+niABiutJlw==
X-Gm-Gg: AYBFou1CV4kpCl1gjy53ODKpuEo5frq3C1QKb5c3NUBNiqUWR6HEICULj0fHgyHxipC
	f4rxAv4pkbOEuSIbRd6TbCwxyNWa7dhnDgPkP6j4rFIlsgDQVUiyuSRI5aKFU3wLg+5pJW85rtN
	pcqZx0Gl76zZ1NwQOQi9KYrhO0pyt67HnXaAKxSz8HJxc9Zmd5xMfxt/6VkMLIrG4YiqEDWTre8
	sEO2Q+0bt+fUo9CK1tZQAt9Zgn2JgSviBTRhfB8Rys0Nn1NsSVVspqA5cLPfMEIBZ2wfcIggFSY
	YqENwD7Sc/j2+oQ/jtF7jKHIlG4pdFMEM4LUaNfibBgcE6kEL/3wixbH7Zs2bR6PAjRFkhNQtve
	KA0mQAvb9+6BrvOpEFat/VsW1zameNl7DSSXZNqzviDlLcT42vxWdT5BG1ZXY5YwJH6nazjy77P
	lVJBd6lVmmSO0M4kltPVWHzUjsFqqFXp5mesqxPbLJswOB0ojVv9YoAqdoqydlqbB4HsZMhNj75
	FN1GYc=
X-Received: by 2002:a05:622a:1f94:b0:535:80b:9911 with SMTP id d75a77b69052e-53575522b84mr83614341cf.24.1791446959307;
        Thu, 08 Oct 2026 01:09:19 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.102.82])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-53571d0e9d4sm39901451cf.0.2026.10.08.01.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 01:09:18 -0700 (PDT)
Message-ID: <6ac74fae.bca2e9ab.229c4a.d184@mx.google.com>
Date: Thu, 08 Oct 2026 01:09:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0856560957344745127=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zzzccc427@gmail.com
Subject: RE: Bluetooth: MSFT: Serialize handle map cleanup with event processing
In-Reply-To: <pm-bluetooth-objects-candidate-0242-v6-e48e08db5265b66aeda9@gmail.com>
References: <pm-bluetooth-objects-candidate-0242-v6-e48e08db5265b66aeda9@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0856560957344745127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1181295/

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.63 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      29.15 seconds
CheckAllWarning               PASS      33.89 seconds
CheckSparse                   PASS      36.72 seconds
BuildKernel32                 PASS      29.72 seconds
CheckKernelLLVM               PASS      33.71 seconds
TestRunnerSetup               PASS      791.83 seconds
TestRunner_l2cap-tester       PASS      12.87 seconds
TestRunner_iso-tester         PASS      11.00 seconds
TestRunner_bnep-tester        PASS      3.11 seconds
TestRunner_mgmt-tester        PASS      61.63 seconds
TestRunner_rfcomm-tester      PASS      4.47 seconds
TestRunner_sco-tester         PASS      5.64 seconds
TestRunner_ioctl-tester       PASS      5.61 seconds
TestRunner_mesh-tester        PASS      5.55 seconds
TestRunner_smp-tester         PASS      4.35 seconds
TestRunner_userchan-tester    PASS      3.21 seconds
TestRunner_6lowpan-tester     PASS      4.44 seconds
IncrementalBuild              PASS      27.71 seconds



https://github.com/bluez/bluetooth-next/pull/886

---
Regards,
Linux Bluetooth


--===============0856560957344745127==--
