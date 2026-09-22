Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B3E3B2FF8
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 20:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108018; cv=none; b=soVd9h3hE7plmwai6CGvQ2vVY+4anJFgpbYTI0P8ovGv0XKzLJ68H6yJMJGf4FJPRH1z9hMSLyKyXrHYBD7eRZeWq06PU5e/E8a1jYQofq9TlY800NtcDwrcT+M0kT0/WlMi4wpchBoxZ1VvpkK6cxlwUED4eDsirkvoAkEq1Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108018; c=relaxed/simple;
	bh=9cEmM4DNk9aa/hj9fTmRXwiAHiykDinmUd+Os3W5co4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EPRbba9wcis2+nr21d7RebrJPEdOpjmoLy1EoIpUuSokpUZ+L4kfVvTrW1Y0bY1l48XBmzVVFAanKCmTvKGS6gslQwy+Zmc3tQPw8RHYp0fH7p1etSG6YPAgkQwY9bA4bs2ZxrZdlaOTi48lrFWs0KMY1FCpVUrgZV50/LyiucM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAIZb4jv; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAIZb4jv"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398b3b189e0so203838a91.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Sep 2026 13:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790108011; x=1790712811; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9cEmM4DNk9aa/hj9fTmRXwiAHiykDinmUd+Os3W5co4=;
        b=fAIZb4jvhMSakZ4+p7p5e0i1aFZTrAe7nsvQv4521qKNY29ZdaeNPd6OfTa84FVE+t
         jj7gyNF3rIr1+eymI9JI/7EcAY7n1x1zV2MDvlBtarY5cPrCb+4Ji7b09o8uM7mqFCr4
         OySmpu5tPAFnKVpDy42GtvNci9+PSeJqzjFb/2gCnfSx4cu+eTsLaV1hVzBwWNEStfZW
         HfiAwyPnlOV96M2Fxl+MAme9vJR3x+GS6Gj9eRwW2oXlb9VZF/ddf3BOw6dwiOhmK+hx
         3YT1g7vqtELaP3y7atc6vjow9l3xEVYXXoxOFG+eOXAiGfLObBA+/T7bQBPVKmrZpTZE
         gx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790108011; x=1790712811;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9cEmM4DNk9aa/hj9fTmRXwiAHiykDinmUd+Os3W5co4=;
        b=Gfx4yJXXhu8RYIWd1AyUK/3LNFwgYnLw6UBGAC4pOw/xplyA53ewTjs6cJlSnU4w7+
         T7k0qAP5cDrN+Q9slCv5hPACbfqrrjOp1ZFG+gxpu0t6F0PYHBJiu+dyzOsom71FZvVU
         g9c0+VRw4pEQeaZHk496xhcl8B4xVOQl7Dk2MV1HrgLTeG8Peog5EpsZR5xSOjgh2urJ
         xLXc8dqHZjw/UwtuVDfw7UC4t33UE4z54yvhM0FeifTo6rR+OhVolgxXUayfZGYlNMeJ
         oSUDUf+zmnnXQUUgGw3qpUu29RxnCOPCys/9OHx6pQTdKSoMIzPMDi1RMI/rBhsYAvye
         fC8w==
X-Gm-Message-State: AFuF++kpuK6NtDWqHhhAPGt1ZwCDBBmSv5oYEhqCyCw53JVqdLpnjdmH
	q8Eq1uEUW2fnvz1YATeqIi0FCQv7IhrHYCqh77Vx7Ynd7UTjuUNhDl+Z/4LGNraFjmc=
X-Gm-Gg: AYBFou20GocKpSuOUT4JpF/c878Y5PqbjQOPzS+/Nz4SdIlK1z5fqkC7HOJ9pepKgJF
	bYVvxzQmxETvkCP4qx47iz4jkvJ4YyGVlWIrvwmNrcBcbnqyyHktKxHIDNs/rfzg/fLeRjQUsy0
	OnOMzPljZpyCp3aJyfaL3Brfki1LZ78DL4WK1P02+jJnVLxqUJCxn/Gupp5XRn4fMyJXb9/S9pu
	2HG0jqMf/44ozNcqca4iTRW935GUFQSZuYSapJtN0TwRGXLilddEQvfdmbfJYw+pmWmOTxGYFfw
	3+/mz9qgObHRZAWiyznHOiOLiMZN3nju/Ik4qp0qkT4Gh0ngQCCcS3mU8iQ+TGlhGmZ/+ziuxd7
	ZPGki0UCm0MaguNcs1OjJbp38Y/B737ac1Oibw5f+NxMEOs4LqTPAnZ3373YdY9zYUNeEPGTQvB
	hvbmr9I2fH52oBtlc4Do0xlXUao++Kg9mecLplMeMZ3lnFWvkCAjKThOza9NnnObd9gsC/VqWbt
	GhNNw==
X-Received: by 2002:a17:90b:588e:b0:39e:6a81:5a98 with SMTP id 98e67ed59e1d1-3a07e71658dmr461786a91.44.1790108010471;
        Tue, 22 Sep 2026 13:13:30 -0700 (PDT)
Received: from [172.17.0.2] ([20.98.116.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07dc01df8sm909854a91.10.2026.09.22.13.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:13:30 -0700 (PDT)
Message-ID: <6ab2e16a.db3b4da1.24cf9e.56d5@mx.google.com>
Date: Tue, 22 Sep 2026 13:13:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6470464402788616841=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, artem@trailofbits.com
Subject: RE: Bluetooth: backport CVE-2023-53762 to 6.1.y
In-Reply-To: <20260922194838.26223-2-artem@trailofbits.com>
References: <20260922194838.26223-2-artem@trailofbits.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6470464402788616841==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_sync.c:5587
error: net/bluetooth/hci_sync.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6470464402788616841==--
