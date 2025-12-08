Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAECB20ED
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Dec 2025 03:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765165599; cv=none; b=QsKXSsj53VFrelH72TyIJFuUcMFxASvfoQxhQOV+NPKDW33ODb2G7TlgO9fpXEspr+hYumhV0cH76md99uQLVZZl77dnCb92rCdhR+0ELFYATAq0Ho5k/nMDAU8Z4jbvEMcvQRe6pKE0C5XydFCnXgr9tIEce7H/f9SWlJ9mN6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765165599; c=relaxed/simple;
	bh=6mXMsnSypP/9JdXJSCisRcYfbBs7XSD4Vm72nGusSDM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VqAFbQd89NshR9Kogxb+UOkY6T7+iOl42kyV3Hepio7sx2UO/8BIB5Ui6fEeSyK+rgCfrVhe/bzA8a15LIb8cul1jUuTs8Vm4N63s//Oy+XcUcWmQ7oObVIT6u7V1k7Q23bjMuBZRmf82xtlBMTrLKrxxIQ6W9Xxm8tGL1+5dBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNQ7bgyy; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNQ7bgyy"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-bc8198fbaf8so3594958a12.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 07 Dec 2025 19:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765165597; x=1765770397; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7LZyGkehOc08yW1Ya9mUa13/RImIBNMAOjPKdT/SEpg=;
        b=GNQ7bgyyKoQ7+v1vx+eqEG2LAEgmDIjGxy34jM8OVakhkZ7Y+9cJC3k5l0lQ96MirC
         EjId/BLhfC7khhIPBnZIXeTPArPqiPorIp4/ewXjNXJ39gyWeXJU4ZW/sTHSI532Y4dw
         dgPGEduPMLxzvPW9XL2+lDos2cmwtJ0NRZIDpeUrx36v4MYhBS9tursokg3sJ5t6AmaM
         TI1CXHWR20NCFnkMgC0FQ/87EsWULQ0TklqK/GCxaa+yI+BhDvgxEj3sn6QD+01Y0dpE
         RpIkC8XH806JLd6nMmX+qlU99mGecwAEjEXP5f4RInnXjc3omF/hWWpLIJycYfLtAK5v
         +2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765165597; x=1765770397;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LZyGkehOc08yW1Ya9mUa13/RImIBNMAOjPKdT/SEpg=;
        b=sHZR2J7G90+N4Wgmi4Vx9sJxmjbSS3L0f3h9rXyDg8bYxNLD5xMQ2kOMTqYD+W+Tle
         5aHDL1UD5JubNgDWLRczOX6/KriIu/0imebDo+/L8gu8vYTujCEdnNCTO8SXy+UGstnq
         6HZYcq05Awr/m24ewyEk7B81Yhmy6/Atl6ImvUzvtNUEtdeE4YsV8DYz5Wt1U8mtd/nE
         lus38d8L66adaP4j3hj/vADGRquOkG+H7NCov0EuNdsvCWk6gMjoYTrNMvkb0Xm9nseS
         8vlyw6onDA6YZUmNTf/yXXv/+NTFQE6ZfA+5vsn6sS3vAaQUnTsJYsVPVbdWQ+9yD3qU
         o9aA==
X-Gm-Message-State: AOJu0YyVZBX5Un2VQRKIAKZH8yQP0ICAfysHOf3wStikSJP1GcXc9wo0
	gkuHuAkIhCqJyiC5BfLpMHtfSrpC+0xavMltFW1WroESnUnFDQ1FGB9c0YDKng==
X-Gm-Gg: ASbGncsEa9gEVduxArDBengsyVOWVm9osqU5PpQ9Px4oxZIbud0fnHMzsFtt/+MfU4k
	qmls0TMmfLKga07DhpCl0xkk0uWKUwBcePUsq0PgNssW3NWHskBTfdI4BUNSeZXfrFr4onfQhvr
	6FDafIQZhAyGZMKTx9750b/mgvZI1ti8Pg+Tz72rbrL9ofpbQmZlegfN1cUTz3Y6f7eDs1wsSEU
	IThwtUqPRkl0VRbA7h5acIWMYrNCaYNOBIi4gSNn1G60NT0tC+uOmVK2egkVI/144IKUBgPTLZS
	WUnfSnXH5WT0WoJHbiOvOAWiaCzKrr/qHNbkrVAZt2V0T6zmyp+iVGZP+NahCed+1HoVDPKZT24
	sYpMcfWuSHtfH9ms7n4wQOM4SIjbg24xM552cZvLrfZ47tIaibxfGkxf1WAzogGYAdHTMykzWYR
	+tohRJGG01qRYkAEQ=
X-Google-Smtp-Source: AGHT+IEM3SdPiVsHpnG3LcS1diBT9h85+pI4yGNguB4ub0xOeQGuuPjWtVM6l8f7OAdxrabArE9QGg==
X-Received: by 2002:a05:693c:810f:b0:2a4:3593:968d with SMTP id 5a478bee46e88-2abc7163901mr3001632eec.10.1765165596707;
        Sun, 07 Dec 2025 19:46:36 -0800 (PST)
Received: from [172.17.0.2] ([52.159.229.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba87aa5fcsm32222887eec.3.2025.12.07.19.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 19:46:36 -0800 (PST)
Message-ID: <69364a1c.050a0220.3d34e4.f5ac@mx.google.com>
Date: Sun, 07 Dec 2025 19:46:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3879889303520140214=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, achill@achill.org
Subject: RE: [BlueZ] build: Allow systemd unit build without libsystemd
In-Reply-To: <20251208012421.838601-1-achill@achill.org>
References: <20251208012421.838601-1-achill@achill.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3879889303520140214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1031211

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.34 seconds
BuildEll                      PASS      20.27 seconds
BluezMake                     PASS      629.09 seconds
MakeCheck                     PASS      21.85 seconds
MakeDistcheck                 PASS      243.05 seconds
CheckValgrind                 PASS      305.13 seconds
CheckSmatch                   PASS      365.47 seconds
bluezmakeextell               PASS      185.64 seconds
IncrementalBuild              PENDING   0.36 seconds
ScanBuild                     PASS      1063.33 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3879889303520140214==--
