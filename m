Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E4F33B951
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783936981; cv=none; b=N2mwVKO9Uh9sgVqBkwVwADWiy/6cK0e4W53O7/eA/Q4tOYjtY26/6U1eojOgSlMIVmJl0RR+eWh1gWIL8EiIEhEEleJzTcYksfHGd8orBZ5eRw1nS2L+C1r8o9MNCuTgfeLUT/+iG71AWTxAqXJLWt0MNrQM++HKhdGsibDGdOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783936981; c=relaxed/simple;
	bh=+39Ki4qDUj+GEqgoJeQgJ1rBqMF6ALjRvnVbQJ5YrKk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CagIpWJgQxIZITPAnRoWIJK6cXUh3HRMBfSXCfh78vg0tLs/QMjS1J4nRAR82ir8DKu8jT60NomMIoz4VjuebYuclf4DHdPkCVQOstBDkp1SrznUYHQoAxevMpipEt0v8EbswDnqK53AaK5+RPbzB7G7eewSovJNHBL+cBauYTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uf7mMT9p; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uf7mMT9p"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-9061a795d76so10319046d6.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jul 2026 03:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783936979; x=1784541779; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+39Ki4qDUj+GEqgoJeQgJ1rBqMF6ALjRvnVbQJ5YrKk=;
        b=Uf7mMT9p3oLejaXbWBvN1STMBDV8kZIy/atXwcCy1GM/TNFPZDQg2tAnS44SM446iY
         jJzwntOkUsjGkvsHHCFfjrUcUEUnV4EhQWoG0okAzkIsywsIA2sHdn32WWjMbHQ/2uay
         QeLF5TJRmtvmDk3bmWEEhhePCda8zpY9W7a2pArtNbjsQF7Pn525+KLqQf1nKNPK5qr2
         UiFbiyR0qqhK+hk34yjqhFdRzFZIzqYkXZVTzqPVySEILnhGpkVwfCEmc9qhvHb1Q1rE
         rY/ThMy78WKjoBQBDuKtqkGA/2+1St2eoqDbeyz1RpnpGxIgtdl0phwb1D8bBi3yXSbw
         TS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783936979; x=1784541779;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+39Ki4qDUj+GEqgoJeQgJ1rBqMF6ALjRvnVbQJ5YrKk=;
        b=qpzc3tgsAoCEiienkWCKHlb/TT9AbVscuK7dxOweu2vMQyMxnhseVDglQimt7BUoaw
         UQpoaCN6xw+xzbGTXmUXqnI3dNJGOK7mBBWrswIvQqhdTrQcjmA4Uan5WLQYpQgvnEEw
         VvBQBhkBL4zgX6NiKVEm7hQC+9sH2rhtGYp3+z22Kk/yzVaLJVjflNAQqKfA+rEepQt3
         vXwRp/fhc5TBDqikuF9c13NwBuYbav7kw2b4vy3cLMIrUNhAbXvmhC10V7XvWD165KEk
         ryr5fQ5ce3TAwpVj8R74AEtjORLHsRCyjUG7qsSTX0H+Pcjw6eSwIgS14VCl88vtCfuM
         r8eQ==
X-Gm-Message-State: AOJu0Yxr9aNBZqjs9llpVwfd+19Tk5qC1GAMBCgWpy3GvWhc8h6cL1r7
	HSbg3XGfh8XAdn7Vk3PJJCqUjFdVddzR4S5jBmjiFWKVNwhp4gfcRgkDi4GDKg==
X-Gm-Gg: AfdE7ck8RVOSXNb5eHHq5/DmpW73Ww5G80c8hFR/21pKmtmZCjClf6/W8plPOrglBh9
	qcphSPuQ3kpJR4/1bqMsfL7kYEsrHbhdnGRkM6/cxM5eavuVV84BqggwldUQ45FyFnNlkfK0sMa
	xvM6isx+hHNX5+0o6ntqkGkwS37Ku5DmPEkInriLp7qPEPvMtDyoIXDrhj/KlTcr4U06XvfhuNG
	dfaPpR4Qdd3dft3xXaqoZWbO7tMw6O+IFCLh2BPKg65dtWsfDrNkEoEiTLBdl1LaRpJ6zcVvCt5
	8LsAoc+kUCpt3XjzGffxzJ5aVvEe6Sl4QfePdioIYQJ9ExbprYMcrhXrxSZ1PjvOEYkaKHqQ9bV
	Me/do4A2v+wKgPvF7++ZXdMae2cO9CMt1lzFUMQUuKdbmZ3+MoVwOjVy/ledXjlWAvCHsiS8ipm
	nhv14+GedaeKZ3l6YU1ZZCqjWoQxIgAA==
X-Received: by 2002:a05:6214:2f8c:b0:8f0:b75:c4ae with SMTP id 6a1803df08f44-90400b8ac10mr94810936d6.9.1783936978663;
        Mon, 13 Jul 2026 03:02:58 -0700 (PDT)
Received: from [172.17.0.2] ([20.102.102.64])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9063df4319asm24399266d6.38.2026.07.13.03.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 03:02:57 -0700 (PDT)
Message-ID: <6a54b7d1.8426f43d.10fd16.1f50@mx.google.com>
Date: Mon, 13 Jul 2026 03:02:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5827930641074182914=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: Bluetooth: btusb: Add support for Qualcomm QCC2072
In-Reply-To: <20260713-btusb_qcom-v1-1-39cabc0dd601@oss.qualcomm.com>
References: <20260713-btusb_qcom-v1-1-39cabc0dd601@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5827930641074182914==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/Makefile:52
error: drivers/bluetooth/Makefile: patch does not apply
error: drivers/bluetooth/btusb_main.c: does not exist in index
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5827930641074182914==--
