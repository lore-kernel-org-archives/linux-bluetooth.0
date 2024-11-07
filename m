Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBAA1EC01E
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Nov 2024 10:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730976042; cv=none; b=WYK93TPxPUKKAcNi1ouM2iaNmGNaPDKk4pOKQ9YIlwufPm6HdDZUoSlF/6fqEiSiIgaAD/0HZvaE2QpsADA+DUYF75tTQ9ZnMIYZYsJtIgjt4EQaVruBihvamzQUnJu72X6UtjfB+1enSm/+H5tu2I8f4cGUv8MWkWGLbVjg0rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730976042; c=relaxed/simple;
	bh=u7aRKUt+VRW04X+i7rBRzNFrOIasndwYScd/OIDGSL8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FNBkA6Dsld5WqZNseaU8iReepJfTH3OG5gQthM6SNhDIMjRLBVrGaYjFur08mL7HgKbJrtnVlXNu2wBtq7kfoZ/+F7JF9oeL5UnLvEU/kOx6vhn3TLH3SHEcimAEpAu2dDWG7/1xgKFEEyq681/LAyrnf6PNgL8jeTQPi/DBfik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHedY08K; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHedY08K"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e79f73aaeso527198b3a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Nov 2024 02:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730976038; x=1731580838; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u7aRKUt+VRW04X+i7rBRzNFrOIasndwYScd/OIDGSL8=;
        b=dHedY08K6An95JlMJaiP2ngGvcCP0IUMMPq4yVWxcowHv8Y9Do+SUGXjuOZ4nz2+pr
         weUYpMLqNHvkEr84/wUMPOb35//5JFV0NkWaM7H1ygIILeJlomjEjBX0ovC2UbdLDsyU
         3lhigvJiewGRS+O42vzUjnISSG+a16MfhthexqEmzcQIz2pHgJOQyKs6oZjNZZgnfJNU
         Sgg1O1JcfTYLM4dPGFgiBMcn3FjXEPe1qhIczbNDxD7usS0OGPK3R3GQr/1n0p0u84Vi
         wDOvHJdym2MXMTdoxr6sc6w4Z5gPb/ZuA3TeEs8a1XaNNwCSlXfjEJUpgw9j3APsu+YF
         bf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730976038; x=1731580838;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u7aRKUt+VRW04X+i7rBRzNFrOIasndwYScd/OIDGSL8=;
        b=cCiPPCkBqwdj+xcpzdVeDU7E8uhXuNk4lQG5IQwW5FXHLGvvjvXTJC+o1pvpteltxU
         oshzEIRFW+M1DlS8ex2Raz+OI8pN7s8dpv0JVA/aBrhOiv8yAzLBOUsnJ19v9YOFecri
         fhGZXJrRRleuvtSULUQ/vi9cRUWIKi+OSFzPggPeu97LgHbMW0zz98iq4K3yj+Tea0+s
         dPNIXshqQtv3dGyteGJxhIouM8rPX0WS3ozR8oX/Azom2OBxF8H4pSXqw5mqC0GNt06F
         kZZOWq4JwjhD+iN3ezRjI/CQQnQHvesNbuaz7v3VUElPu2CmVQAcrmy/4psyWFZh74Zg
         SFNA==
X-Gm-Message-State: AOJu0Yyi7JRmD4pPMpb3DoAak6EqKxKDhyXAv52tbNutNvOmuZrVTeJZ
	6WxQ6f8UEQ72lmC4lziX9qE2MpQM1zyN7XGtzbXhNs6aKI0SBOHr/8KRmg==
X-Google-Smtp-Source: AGHT+IFuvXssmUU3IpB/te906BWvB4YBZjP3fr3hI0S+YqB1rzGFS0fMZe+IRJfgHAOz/EMsCoYdzg==
X-Received: by 2002:a05:6a00:3cc8:b0:71e:780e:9c1 with SMTP id d2e1a72fcca58-7206306ecf4mr60836939b3a.18.1730976038179;
        Thu, 07 Nov 2024 02:40:38 -0800 (PST)
Received: from [172.17.0.2] ([52.159.142.100])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a571eesm1160325b3a.178.2024.11.07.02.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 02:40:37 -0800 (PST)
Message-ID: <672c9925.620a0220.6fccb.2907@mx.google.com>
Date: Thu, 07 Nov 2024 02:40:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8990072032009591046=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_dgangire@quicinc.com
Subject: RE: [BlueZ,v6] obexd: Add system bus support for obexd
In-Reply-To: <20241107102628.537015-1-quic_dgangire@quicinc.com>
References: <20241107102628.537015-1-quic_dgangire@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8990072032009591046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: Makefile.am:39
error: Makefile.am: patch does not apply
error: patch failed: obexd/client/ftp.c:19
error: obexd/client/ftp.c: patch does not apply
error: patch failed: obexd/client/map.c:27
error: obexd/client/map.c: patch does not apply
error: patch failed: obexd/client/opp.c:17
error: obexd/client/opp.c: patch does not apply
error: patch failed: obexd/client/pbap.c:27
error: obexd/client/pbap.c: patch does not apply
error: patch failed: obexd/client/session.c:27
error: obexd/client/session.c: patch does not apply
error: patch failed: obexd/client/sync.c:21
error: obexd/client/sync.c: patch does not apply
error: patch failed: obexd/plugins/pcsuite.c:322
error: obexd/plugins/pcsuite.c: patch does not apply
error: patch failed: obexd/src/main.c:41
error: obexd/src/main.c: patch does not apply
error: patch failed: obexd/src/manager.c:488
error: obexd/src/manager.c: patch does not apply
error: obexd/src/obex.conf: already exists in index
error: patch failed: obexd/src/obexd.h:8
error: obexd/src/obexd.h: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8990072032009591046==--
