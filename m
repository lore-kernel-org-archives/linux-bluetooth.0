Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED992BF3F4
	for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 18:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779475565; cv=none; b=mbHlZlYLX99LElN16tymedu80Cbi7cS8cGbkGZXFDyxiJDPIw9ygjc64dcjBjAx1KiCHXrbJKpYVONCbXRkHCkJKEEoHJHxhGDIAHFogsctxeX6MztrE+aTq4T0mjuVrLQ5Q8SBNb92/jNcee/X5y4N4LSVcnhna6v9Bkh8JR8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779475565; c=relaxed/simple;
	bh=/35Go+Vmfv+dBfwonINa3wQA07nVPScVle/VVTw02Ks=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kGUrTw3QgtAnGepicxEnsYLIVpa/bmKiF06xjGskd9K9XaITsZtk6ce/prh8XEilrmAqgyGnE6s5sOHznc++ZDw6R5oWb3Z4S6iGWQUbDbd2UF2Qdun2P9lvYE+ogb9ZFfzh3EzAP0airIEE9EO+p4fW5eAtfrY3dhJ+YcX6Eto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYGgPiwF; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYGgPiwF"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-910f734b477so811032385a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 May 2026 11:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779475563; x=1780080363; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0LE5ZnVbZP1U6vgDf07GrKBO4Ij49p6Zbe74/Ucke40=;
        b=DYGgPiwFQjk6R2HY2AQHGuUSBq9V4WcTd6mdX89bF/NUgOQtq0a2xBN0uPjCFb7kMT
         J5MhGrR4CPM9B42Tq6oXkmpvEBtFZAGjTyzrHSo3ovDSKGru/nXRaB5F01ry5DYUKTCy
         fmvMHaOmji7XgsAaU/cbQiOSejLI5UWL51XMa9wVk39Sj3M5Dks5HkW4KLMuX2o1Ye9u
         ElSDguB9fCWWdWjoiAOphpuYmsIQb1mwKZzNT2GUw6PUHVB9g/pxsHwJyLFafKYDg7fC
         0/ObQ2mK7OpVeNBxfQRUoYJKUkjxdJS6YW2h9b33i+4PYPcKSZ0ANhr01s12Ea8YHzrB
         LALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779475563; x=1780080363;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LE5ZnVbZP1U6vgDf07GrKBO4Ij49p6Zbe74/Ucke40=;
        b=TVtOqCgJEHHn+5V2PAWR9uYQbyOTvZlFEUBRYT8MpF7M1rjmICQS1YWBtFfzgsvTa0
         FYY31j1BC1B3VrV8XKdGU1zxAt03MadFi7H2zlsDfUX+R259GaB6+JOYgMw+iGY9yxT/
         pioStGHlg9Mqi0c/uUkLgoSYPzaE88VbOl4c9LS1fqS7+4fyTldRon9SWCWHtpQG0jwI
         KbEJrxejIrwhtPcBhxYLf67ArhhXfy5av6Snlbmsui5Y9FkFHrn4b9B4H5t4/zWCQkRM
         cQXltueceAU0oFrrTcGtO/92m0cpszzb2+L86kC0OkTNKq1pt/hlaFC7gEdH2J/TOT3I
         3OdQ==
X-Gm-Message-State: AOJu0Yx1CR2xxtkNaFuPb4MMHHsunrzUm1kJmubH4Bc1BlnB1gUSHsv7
	EtI88XSENtGuknzy4LzqNkdtoCjjieyay0ZbUo09JVcALDgxly8AcfvzE0UOPlFr
X-Gm-Gg: Acq92OFqcuWyL4KHovWufG3PFWguHnp6HYNlAjxvyWcy3LxrcIXVTvW9vzCsRd1FqvO
	/0yzc5blqDerokmeyevE2kCyERYqNC4F80goJ97j3xOq1ddzTR83WhvHCREtbTHxRRnPvHRUJMf
	JO8/i7h8odQr5J8e+v8nmZN1QL8bUduT4Y/vqU5+OFujFpdM18s203e8pDY/QwZzwQ/2XRuSmxQ
	yF2lkb7HZcCS+ta1kuWCfc5a++0aLY7sGWV2qIcmSExshs97tlPRvpMd5wnyol68PoL2axuwDdd
	qfg49w0qM+N4KMY3IockaAqcVfddsvquXl56HjwmVzhGmQdadUHvaiAW5MefVtZ6n/t0J0RUZ51
	6Ged6zp92KkcS8mX4FHgBtbxnu0OzShHonR65T0FU+e+qX2DjJei2WQLrfwYKqibkXOYin4u+tD
	BFQmT25dO3DUpNKKMIOwHYd9qnzQtr
X-Received: by 2002:a05:620a:4455:b0:914:c080:cccb with SMTP id af79cd13be357-914c09017c9mr261894085a.51.1779475562730;
        Fri, 22 May 2026 11:46:02 -0700 (PDT)
Received: from [172.17.0.2] ([52.188.87.72])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb9d63a3sm206626285a.23.2026.05.22.11.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 11:46:02 -0700 (PDT)
Message-ID: <6a10a46a.27addf4e.278d9.ef92@mx.google.com>
Date: Fri, 22 May 2026 11:46:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8828468093406991602=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] test-mesh-crypto: Don't attempt to run test if AF_ALG is not available
In-Reply-To: <20260522164912.3253018-1-luiz.dentz@gmail.com>
References: <20260522164912.3253018-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8828468093406991602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1099512

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       FAIL      0.34 seconds
BuildEll                      PASS      21.21 seconds
BluezMake                     PASS      672.94 seconds
MakeCheck                     PASS      19.04 seconds
MakeDistcheck                 PASS      248.00 seconds
CheckValgrind                 PASS      294.89 seconds
CheckSmatch                   PASS      350.97 seconds
bluezmakeextell               PASS      183.30 seconds
IncrementalBuild              PASS      675.76 seconds
ScanBuild                     PASS      1070.01 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1] test-mesh-crypto: Don't attempt to run test if AF_ALG is not available

1: T1 Title exceeds max length (81>80): "[BlueZ,v1] test-mesh-crypto: Don't attempt to run test if AF_ALG is not available"


https://github.com/bluez/bluez/pull/2147

---
Regards,
Linux Bluetooth


--===============8828468093406991602==--
