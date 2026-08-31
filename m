Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECAA3CB574
	for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 08:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163518; cv=none; b=AVABgz8+KtWF/DkSn1m//1EqnWfIyiZf3sct4JIrIFFOFFL4yAbwdz1ukVhsSMEQYJn03DORdaMqsJia5taCi3G7y+xotpOOC2UG10vzPhJ1sonTWX6mvyeZcngcMNmMrZwgPnREvO3V1RITaBssxesWodq0H96htne575k61Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163518; c=relaxed/simple;
	bh=0j6NzGaE9JQVIfSUS1ZVpPxiu/v55+T+D8gzebmGdXY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jeL+e7hfwsobuQ4tcV9VmZHVGBypkcQ48SuKSXxhqw2rq7ngxXcw0+X0YL0aZANu/uN+VTrzf3VnsEXU8GCli/1jaVupG/ycZHV1oZWVsvAHG92pmRn2uf08gQo9CgyzKNMUFZJgGYuSsdxxMJFkgXqWT1Rl6pDRsy8cT9qhMTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPDO0Ghx; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPDO0Ghx"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-97ca74bd6e0so925346241.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Aug 2026 01:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788163515; x=1788768315; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0LhY7OJ6y3CegKIrl71V9h0SqVAb4M3zwXibwj9CUIY=;
        b=aPDO0GhxCyQCdb/a/bTrQQLSGumwYA61lSrQDKf4AXe+hhVT+Zu4X56IZSDVhz9CCX
         HrR7gWHpOjANqGHU0+zJNJBip9dh1UI/H7E9bR08STP8B84+HD0FlUSvNCIRd/tLE5YR
         vWPh1Eoh+npXAen7I25OFYB1AqXnLQRKKa8wV8L6Wy55fy8AUHh8PvN6bBG3rg7IayCz
         AVpdujAbvImIppol+Mm+1Rsf5+GAsX3QvY5eQiy3TqOYc4zzGQUzTNKG1zzZKSaNK8jS
         XStjZuPXlNgbystDLz2CNnFihXZuDzJIAx6eI+ifiY0oSTgbxRn52RXjw5ldCZuF6H9K
         FWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788163515; x=1788768315;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0LhY7OJ6y3CegKIrl71V9h0SqVAb4M3zwXibwj9CUIY=;
        b=IU/TtU1hWA7uRBYZLeWSRu7WbRPT3TwjdF24Y8MhqoqpNsL3lNmDfyfD7nEK/t/yjh
         xyL90H6tDSWOUdnadDTIMXAtANxSsgnwUUsFF4dmfNhI9GVfr/XyO5kYsnEVIPVVSZno
         oeGa1zIfDSPs2GtUtcDpRfNz/lpt47Kejv3M8FYl1gkSad6RgB15QNztP5bc09zpzw/e
         hkRltJ0P7KVX3WO1lZEISBuCvxfo8Yw9I0VO9wWvB2tuFchIIJGmhcLmFGZTIgPTsqJe
         TzbiO4NcM0DhnBq8+PYE2SJJ30IcTuhK/EMYRMV66SEDQm7vII3eiclGgxSRW+BKK+EP
         UmxQ==
X-Gm-Message-State: AFuF++ldbDwROmrJwQHwWn2KGWCTHcG2nCK+lKlD0CUpfUaJmk2wbFdH
	5wMOKK2EFWhOo+qbNBz0KGd1kjq+Cq/K0n+QNZcOpUxW4MYwRnYDLkNN5nbBP0i3
X-Gm-Gg: AR+sD12LoW7+LYiSnuKdfYTmhXjFNNVKR1JeUCt+vslbkJsPHvIXGBzBNq/4EFp7ETm
	jXC2A3dqn1TdYB4rPd6PoLdnZqeKD2xu9KA8tfEcD33kMGQUcs7cn4B0F5ckvL2eGVYX1LYq+qB
	bFag+QCwEU6KxbaKwJJjMtkW7D8IL9ISsMTqPO14fKuADggrIWv/89NwAHO+LYnB1FyGjZW+3lk
	pakfFBPzTaeWvpovNRjQ2tr6G6LcPUsanmwu7IEanXvJcZz/mOXx+OEWz6os5SJ6kDRiFHLxwyQ
	79wv6Pwk67pJQ2tJuLYrxjSyywmJftktvJO3AAecuxVBL3Z9P+bEGPc5F+r/WwEdQxqLXny6O5f
	UQ82s25hpqc/b7ozOW89USb8mZaIHUqb8rD3DrSlCMx3eXy+wrkKLfD3H5TNo0c7DbmFCHXD85v
	HVUc4blYYqi9fFQVg6gWhgTLmz18GHz5tssT+9tz+XpJThXjFRdoEOqMq1neJ/XJOdK7A=
X-Received: by 2002:a05:6102:c52:b0:784:4d38:ef58 with SMTP id ada2fe7eead31-78593d543admr6636503137.0.1788163515232;
        Mon, 31 Aug 2026 01:05:15 -0700 (PDT)
Received: from [172.17.0.2] ([68.211.146.17])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97e84c0e3e4sm7241004241.12.2026.08.31.01.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 01:05:14 -0700 (PDT)
Message-ID: <6a9535ba.7988b9f0.18ac4b.89b1@mx.google.com>
Date: Mon, 31 Aug 2026 01:05:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3376568860136214797=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zijun.hu@oss.qualcomm.com
Subject: RE: BlueZ: Support vendor HCI packets
In-Reply-To: <20260830-vendor_hci-v2-1-9903760957ab@oss.qualcomm.com>
References: <20260830-vendor_hci-v2-1-9903760957ab@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3376568860136214797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1154126

---Test result---

Test Summary:
CheckPatch                    PASS      2.55 seconds
GitLint                       FAIL      2.95 seconds
BuildEll                      PASS      20.61 seconds
BluezMake                     PASS      590.58 seconds
MakeCheck                     PASS      19.55 seconds
MakeDistcheck                 PASS      167.40 seconds
CheckValgrind                 PASS      249.65 seconds
CheckSmatch                   WARNING   336.70 seconds
bluezmakeextell               PASS      102.99 seconds
IncrementalBuild              PASS      626.78 seconds
ScanBuild                     PASS      970.59 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,1/3] doc/hci-protocol: Fix missing & on mtu argument in BT_RCVMTU example

1: T1 Title exceeds max length (83>80): "[BlueZ,v2,1/3] doc/hci-protocol: Fix missing & on mtu argument in BT_RCVMTU example"
[BlueZ,v2,2/3] doc/hci-protocol: Add BT_RECV_VENDOR_PKT socket option for HCI_CHANNEL_USER

1: T1 Title exceeds max length (90>80): "[BlueZ,v2,2/3] doc/hci-protocol: Add BT_RECV_VENDOR_PKT socket option for HCI_CHANNEL_USER"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2003:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3924:52: warning: array of flexible structuresmonitor/bt.h:3912:40: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2459

---
Regards,
Linux Bluetooth


--===============3376568860136214797==--
