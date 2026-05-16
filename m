Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E983A7F5E
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778926722; cv=none; b=aESS4Ytrs0mpuiXzqM+VGQs/6KWKSAvDCKXCPPGAbAGcjK7alvjKAEooKaVIQfrM9xYibg+SQsOSJLcBDjtvK/rS/GXRKvh2OfMuN4CN+A8UJqJTKJE7qmmptHYi9YsVkRWHy62ieiYr9USNC3W6QSR5VjV2HZLgRoEu8AyxOjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778926722; c=relaxed/simple;
	bh=KFrzxTcvsdr6oCP9zCK8cuZFKjC0etS2W17CHcYJN0M=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=HY1/n8LGBQCjacA97fA5bFOtz7nlgted7NGtf+vtFHXi0eZTPx/meT6bZNpAFyTX68JYgEcIz/tgafGTTd3a+DdpiX2+OqdhxLkTCNAKcn1uZMdzbMovF1Za4nW19i09wqN0VQd3dOu+vLQoCxZbYIoAKV7m1ULrtvOckawvfa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p/vvvxAH; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/vvvxAH"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50e97863425so10369781cf.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 03:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778926720; x=1779531520; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KFrzxTcvsdr6oCP9zCK8cuZFKjC0etS2W17CHcYJN0M=;
        b=p/vvvxAH7aP/HfY4G9/GvBwIb3GO+GVyMydST7O5byTaNJ4bLSHMzDgkCeyccpyaRz
         HGK3nmc91aglPwax3Bt0jlDc8dghJ3d1FPXHNIEm/f7WZLVeBtKIU6CsHVkd9eGRCccR
         9OrDOYQ5pVNGAfz0MpEqv0RE7i6VqEK/46dRsHvCRtUbENU5wn9USlcHP6NFrvVE07Df
         mqp5ZilOI9Tfh6s6qOPULHmPMknCz8Ivk8VC/9wvOxhrq1ilUdtGrXMwRoatdiR0DlO8
         9vm92VAu3gZx8z59edpropIyQQFlTrSuCSFwqXS2p6W0ABCtfjvLwA6g+UWglztquReH
         X7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778926720; x=1779531520;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFrzxTcvsdr6oCP9zCK8cuZFKjC0etS2W17CHcYJN0M=;
        b=jlCSD/iG0OYiw0OPivGGHO/3iem5D4PYCmN8p74Tf84/YPSIdno33pcZ8zJ2nIn+vK
         U1VY26xlqTS59z+Z0Bpe+otaw+H1Gp5oAdAmzvjJsAVCeHpsCdpw61RNJUrjWTAVesob
         S3wZ4kTDABzOiO2unnZV60zJyfoM+MOxfDwtLM4cXeTsL7DFUcNU/flv4VY85/uvrc4O
         kEZwmFaKkPdFWTZBTeykFRQw6jm/Su8kkZT+qPZfl529x5B3ulqbl9CixygJAZ7a3Lpa
         1Cn59LOefbTnqmzsCt7gw8n/fj/fVPMBjG/KsI6Q2tMisQzVi0I8V71inbUiMOaIh0qz
         8VsQ==
X-Gm-Message-State: AOJu0Yz+wanj18pthPy5+RypG5Wn2TGe7KKySXOC1A2WDcNxAA9CTMUX
	fjnuv4pKJ7sLewfZmxVzFBjNBJTwpWKC0oDzRdh+MFVdoUFo3lNu39oRUtJPBw==
X-Gm-Gg: Acq92OGBb3O8jUyZGXlvDKVNvfimbywNp0KKBHu7PtP/CHlOsH9EnUEh/ii1aqiJE6B
	bfkTmzmxLnxHNZyjvJKBJklaWRLoInVoCRo4Z5Y8O82AdEavRd1VthwtvHW7+SjWH2GVNxh/8Yq
	qw8Arnte8NF8xY8oTgIaQ46fmg224XNR+QLUe5VyfU69PZJT9k94uVzruxCOGqJ+dGlEFX8pF3H
	d1RChtb2751InjHMpatcw7Pj7pvF7YYLe2dvrNrriMc7BtBxqlyHbQzne02CbBTUFyPdv7K02zH
	h0Iklbyb7HOOzl/8szxtZgAuaC54ClTlahBcHqEYsl52Luxnaard+K/FfLKDmJJgDR96nIVLcyS
	NPAn2gkomvyoyx9nKbNxXl5XE6fOM0V5CXHA0qh2Jawf6vFDYGJpdrO3cex2cL9qijhDvMW2OZ4
	a2JMgBqz+c25CV1TsGd8NgJifVANs=
X-Received: by 2002:a05:622a:19a2:b0:50f:783d:8cb2 with SMTP id d75a77b69052e-5165a0683camr100597531cf.26.1778926720443;
        Sat, 16 May 2026 03:18:40 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.34.38])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456b6856sm70208341cf.7.2026.05.16.03.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 03:18:40 -0700 (PDT)
Message-ID: <6a084480.23765db7.988e1.9e39@mx.google.com>
Date: Sat, 16 May 2026 03:18:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1270937625525934897=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, safa.karakus@secunnix.com
Subject: RE: [v3] Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del()
In-Reply-To: <20260516092139.2618159-1-safa.karakus@secunnix.com>
References: <20260516092139.2618159-1-safa.karakus@secunnix.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1270937625525934897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/af_bluetooth.c:309
error: net/bluetooth/af_bluetooth.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1270937625525934897==--
