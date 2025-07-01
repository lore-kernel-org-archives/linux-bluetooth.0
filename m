Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E8772602
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359918; cv=none; b=TvW34KNnFIj0XdUGEND8NheyslJr7qQnotzdMS9sBUT8asxJRkav+6EJWyQotnntK5AeipmrmR2lZsvDG1QQ47TqqBmFhvVU8Cep4wOoUNwPP5Zns4Yl79jOhXhLA1tXYyO+JgXoAOa9dqdme0gZfHkl1wLxKchIEGtuziKDmmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359918; c=relaxed/simple;
	bh=N5b9Hyl/Wk7TCs93G97Xdc5VAc/2Y32pq8BT/CfbeTU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Drrtf0Qv+wrQCkgIxSnGdi8juH5iOLL4s8HT6UT5qvIkePsDPSQ6lt1e4AVxXi5mRhl5X1c3gYeP4+QcYgVadBBv1wUXdD/z770idM8woKoLFz1IRHmKUbyxkvEUzIpo6O0KloWyUtRzlbRBtIYETxJA3FoTwKztvp/sw+PF70w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eyjYFj+H; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyjYFj+H"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a4bb155edeso64180531cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Jul 2025 01:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751359916; x=1751964716; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N5b9Hyl/Wk7TCs93G97Xdc5VAc/2Y32pq8BT/CfbeTU=;
        b=eyjYFj+H1yQB93usrFiu64h+sknW3kL/PKN8AGtg2NDK36O5c/HuQYmsuKHlfbJdvS
         nAHTjiXm40xwhJgYxWqLh5iCNntjK2S5T4lgIbJF36ud4uAbgZGEOUCQcnYGk11k/N3r
         C9ugYt2caBmwB1tnss9/sFK4I8RgJXwqpXwEh2IIiIJi8UdGBT9jjFOBbmp4QUUmw6Pc
         lZozjyAO7EJr4d0/qQWLvRZRepc/2NaCysnA9l+l7qTbQAf2vkaqUZqlB381Pz5CJCCs
         p8YgFZRWN9Y7Pe6ACvJ66CLKhJxtoG4YsQl/OwCSq+ZIDAEONwjMIVmR7dNKrJ5kuhau
         3SYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751359916; x=1751964716;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N5b9Hyl/Wk7TCs93G97Xdc5VAc/2Y32pq8BT/CfbeTU=;
        b=VCQlT1r8UGCDCUSCm6DPykr8Hz/TQVA1JQ8emRFVvf6xxoGh4aPLaZqWlo+K7JarFf
         NMxNORdOvC8i9YwWBmCpCz1cbo5K8+XNrU7e65EURqg4D85mac4LkNB+nE4YNfBVcpGt
         WUwX99txfPP38YV7reL7BjaYRZn0pB1lSnYUWQfrslTJNkBjRzIlWL/BdYaQP+l8AmBf
         joVA73uXiTJ5siTOP0afifnCow1pd4Fj9GK8/gvrC2FwYYvm3Jg++YY/h/rX2S5g+aqT
         +6ksBTGPXmmpvwsdkzz6tooS8ToLO7/KUUmaPTg5g8YLp0DMLjLMH9ZCTvHcaMRDx7Ji
         iYmg==
X-Gm-Message-State: AOJu0YxKQp1zNnW144Xnuyd2FHrO5dufSpVF8ZFPUuhBG3rDWRuj6yIT
	S6TPW6Y0tCiJ/jAZ830cEwUs8zsH9lq5meBxDuT/Ha9yphZBw52mqwaUOqZmJQ==
X-Gm-Gg: ASbGncvVH63E2AfjlYy7+4FYSga40/51xQMfff+ywy6YwniPPWXOxxtlaEE7PAX85hL
	QS4Wep0uF0oPzfFQBZTU1SKxJFl3X0YewH4iBbv6sgSzm9f9iLbaC1QN2a3fM2J4GrIe7ylzm7i
	qg6dZiIPDzz3J8j2USJml8lwpaYEdI2zJRpuGq6kLU+kDhVQrT3ATCPp1Hwk+5iGXEHG4xRimN5
	xyxPnTniSJb6LqdXMgeavugrrn3URdea1cH9ILBcrnvDY2xn1mvcLz9nHLWaTC5WN1gGU2mwzsO
	yuMccSf4lbv6Sf65Rqvm2+RgxtChz7EXgu/5opQP4Uu6RilH2zKwpOj/mSqBpkgHa90=
X-Google-Smtp-Source: AGHT+IGaIVNShpv8cFyz/y8A9+i0Coa38P7mOhZUvH0kOCG+Iekn4eV1rdRYMg5dthG9bYmHOeZnEg==
X-Received: by 2002:ac8:5788:0:b0:4a7:d7a:9fc0 with SMTP id d75a77b69052e-4a7fcd3a556mr259773751cf.17.1751359915627;
        Tue, 01 Jul 2025 01:51:55 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.192.87])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a7fc57d81asm72077311cf.65.2025.07.01.01.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 01:51:55 -0700 (PDT)
Message-ID: <6863a1ab.050a0220.2e7849.5a36@mx.google.com>
Date: Tue, 01 Jul 2025 01:51:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7964366805782543869=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yang.li@amlogic.com
Subject: RE: Bluetooth: Fix spelling mistakes
In-Reply-To: <20250701-fix_typos-v1-1-090f06fdfaea@amlogic.com>
References: <20250701-fix_typos-v1-1-090f06fdfaea@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7964366805782543869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: include/net/bluetooth/hci.h:2767
error: include/net/bluetooth/hci.h: patch does not apply
error: patch failed: net/bluetooth/hci_event.c:6875
error: net/bluetooth/hci_event.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7964366805782543869==--
