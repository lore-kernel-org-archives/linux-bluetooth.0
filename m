Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420552;
	b=s5TJqumNMPHCbZxcGK0FhhEJZJNVRboi5GRDyhwR7KYShSk4CA3v985RWgWYq+IPh2AL
	 egJmgdA+Wf/Gmx4a+b0qV7QO8Y2PAX4DfHSuq+PAbfaZ92PQ9yQlKMqy2feJF+M4H9jpJ
	 MzBVqm54LFTqvTrB9YH7OeVkUOT79/GQ6t/C3Oq8RLlRdMRIjXIm2nzv/hU2rT5kQk3qX
	 gtYqux1JyiOfkzF9q77lxsScMwZ2rITZRP/bLwM3DxHenG+IpZG1SzEGmBvYitojVns2B
	 QCiiqd7rQQNcHVLHpLnpG2j3xbVXFQrT53PoxB9NeXLzh7A3L2NJOMmV5iZJGht+JVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420552;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=xWuR5slHI5w9xzN9ertwasnAgtT2/j9ObU72LHtfeaM=;
	b=CTwEEEeTtZtLeGhskR4FCBGnJcs4Uds1lysApDmCnvGbek07xAb5KuBbS8r3Yprme8J+
	 Q/MJa9aH+L2qKVPINHG62i3RJjMruSq3VLD0UoKhLIL2BwBu6W2m2erp+IxWUUtwueg9Y
	 MZzqzrjcGGwqG0q8QCZ0Hpkw7AGpW8O5+klwkl17A65qIGIAxxX3UtnsF3t4mUDVm5LYP
	 4E3Gk/JCw7lHYfp8/6aAC4gZHChiLq1kfWAoXxvOu8k3z8zivLNTr1Rl7wNaS2kFSbaib
	 GXOzaB63/scgHwLps9nzogSUYiUXTtyDVz7+ujOY/6m6PvIoa/OtEjwPmHhxxOdxcGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hTDIsBes;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E36606A31C
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 18:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71E36606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hTDIsBes
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93f2b8cf037so302748885a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 10:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794420551; x=1795025351; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xWuR5slHI5w9xzN9ertwasnAgtT2/j9ObU72LHtfeaM=;
        b=hTDIsBesgGTnv06rakI2vKCI0KCpQyrbC7SKLrj7DlSOTn0mQam1tQKgklN0ayRDoB
         lbkYyfWOHITKkxrz5+oEmJa1KlVdv+LAi104gEuvOAq9upfrn2UP+adU3WZM7K6wDrSp
         xxcqxDZPv+8JoVeTHJ08U+YwtnsB3GtoZ1qYOIggD7N2gkgKE3otEhLA/L7jxwWMcNiu
         yR2btMTE1qb6A6qdPV+4aOgHJyh0RajvC1nLznSCFZA/wZSXx1Zibsa7uZaj//O1o7A6
         E6lY+ZGICI4logD2LaC+t3y36wtidLrdOyC4AWtp/+/iWeUL2VhMOuIZIe3cF1WTM2O7
         VHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794420551; x=1795025351;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xWuR5slHI5w9xzN9ertwasnAgtT2/j9ObU72LHtfeaM=;
        b=NZZZDsX6xJTea2Sf4vKW4Q9fgmTRYGnqcXA7ofT8yLD7K3cs8S7xFKYJZKf4JBNNja
         QInrkg7A0/EzOUmqh6Z8m2UL6+kjNawAeVVJUQzb3PlYakg9rLeH4QqMeVGLNZuTwtdV
         /V8xH4wb2W5UCSykr19CHPEPhV8tiG1NPXzNR4lm2VyC4gH4oRDU1rbrvkd6g1GjpHi8
         Gd4llqJB/iCKCtYDxizFmBFubHGhvaJnelTM+90bo9xXCDtVSgnAHapOcFg/VGUTp4ty
         lq+8SnCVkcWjZzQ9gI33/oBJAvM6asWS9RfaAL9jnakaOpV3GXcvCmQQj8Q6N89I7luq
         qvkg==
X-Gm-Message-State: APuU4Z9sjwLUdz/e+Aevr2S+spxhMz92+KikDIdYP68GGB0pHMUJ5ySG
	OFI5nYoDYItcb3zyHIdtE4BP8M3i0rvdcrkoTIoO55Z5oatY11WD8MpHhBPSmi1H
X-Gm-Gg: AYBFou2QY3XqCxQManIgpnSB1TDcRl6ZrTDJrs0Z2nz5V5okOs2CAxQ0xbkXIeJVJWz
	0wWQHToq4hi9Bq8OSnb6sSCkAR+kZ1VII54y12eTxJgXltkja090OJxCPgmvHV6Tx+RK+1u3VN2
	k6Q65C9JVUH3cHmSi3Fo0vfXMKNbUCf5pNLDCFwZvaO1P00kXFP+IUfpO/5JTId7NouZWeFBBAG
	dx/wl7MWjrZNSkySbVsmrcAEwLzYZ0CUmedC3zyNwZcS8dmLylauw30rNROxEyCjDEqpz9iwYSQ
	qmteAIVak0Z5m03HDx/3K8ZLj//X/WJxgvQnCmrG/t9DoqlHE3OVIrTq5qtiaZicAMPTivNIVag
	zcRKTN3tq8Dp8opL6UWpH9gU7UCVVbHk78Mf2jGPKAdSVnmn7cfkes9SewdWcWtIfckYQcbypYq
	+tVerIB416kLRfixZWrK1Xh8RzThWl3sDBHQYgfIJd152SHlCGWgx9F0YNq9dDwEq13rgql9hS+
	CNepkP9UeOA6oto/8XeW8GWd2hmBuOfSSjn5huKaVKxwWy7+mVCLabFNfKd7oNr
X-Received: by 2002:a05:620a:371f:b0:93f:2e7e:c818 with SMTP id af79cd13be357-947affc2c9cmr548617885a.59.1794420551301;
        Wed, 11 Nov 2026 10:09:11 -0800 (PST)
Received: from [172.17.0.2] ([4.227.174.184])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e61b8f8sm540259685a.1.2026.11.11.10.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 10:09:10 -0800 (PST)
Message-ID: <6af4af46.8c8d7b34.95489.f654@mx.google.com>
Date: Wed, 11 Nov 2026 10:09:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3856997948768926013=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,2/8] unit/test-bap: Add test for disabling one ASE of a shared CIS
In-Reply-To: <3eeb1d44306e1c3833788460706ae2fc9803f4ad.1794414122.git.luiz.von.dentz@intel.com>
References: <3eeb1d44306e1c3833788460706ae2fc9803f4ad.1794414122.git.luiz.von.dentz@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3856997948768926013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: unit/test-bap.c:4952
error: unit/test-bap.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3856997948768926013==--
