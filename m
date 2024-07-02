Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D76158D64
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 10:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719916876; cv=none; b=FjQ/ORPjTfJ7aOH7JY/DdOU4i6+Vbjyzkpq5Pi8iLZFnmOSrksJmUknfM5X745RIC7ZidY/6eatt3SKlMyVGMX98dnVQZpbVkolQEVOikPDoC/oP64lmk1YruK8xraks948U4nAkXRzPmlktcntB7JxPvBA+FNo2qmo30o4+i/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719916876; c=relaxed/simple;
	bh=W9tbU4JVV+1NHUhsUwNmW6cFXb0pHhxFIrn4WMv7GsM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aBOV9Xm0eM9MNPCloI27wzS9PPLzl35/C+dRGsAV973P96R0vXOrHsFJ0pllythAM7TEZc5/b/bNynNHAdqMddW2P/9ztYX2tRQEZ79KH2ZGaL/KNXHpjMcTYt0GgVCbYDe3qCO4mmsH4BuMRhOa0A0pYyZpeLkoel2+C6mhiys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWmQGo+s; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWmQGo+s"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-79c06169e9cso278667185a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Jul 2024 03:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719916874; x=1720521674; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L6iZHDcSrtlUW68gLVO57g6xFCD/NgCeetC8tu7p2m4=;
        b=dWmQGo+suF87fWYf4RVwP4Rpsgcny4ytA7XqBnUqzjrd74aJtDLQK6Jw/+ZgC6Gjck
         7cS/4L3CoSyw296sJBnfWmy9VGe1d/XUINuhdebU7ErNu/qypn5HXSarYsSJlZvFqJia
         wo6BYti4j39WutvHg9AUL3Df1L7M3vhKpa/qQ4Tygd63veH0PBrvjoy1YBxi2H6dVQVw
         MhkIHBBiUXvvxzUJz5oiQQGOwkMF7Z6qoVSvDVvQW3Z4DwbA8XchtbdMkb6zIdwOGkrm
         IK4OGNkRdhwKtrOkKt9p9DWs4ms5+eZ/0bSB+y8a4izZ3c5FlsifwttktupFuOvPEfC9
         yKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719916874; x=1720521674;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L6iZHDcSrtlUW68gLVO57g6xFCD/NgCeetC8tu7p2m4=;
        b=sbfFAXs4W7EOZXoxzXz9Ic1K9m2bq8+N1OOyWXMl08vlh9D5Rid0479XGtWVW/TZTI
         8ubXk4G4NIsgwwreZ2efRWK5KsoZloUl2Y2hgeV2OzYaihz2RiSm6kkDpaNaP9gR92qy
         cL85wAnK8lyX1zDhTHaCibA2cwYFg91SMvzADBf9I72D6HupTAmuytXbAYUQyiD4vs7k
         vIPotB1D+b7Nplm48HupM9Tnfg8xiH0pJ5ENdaEJsDjJeCA6mfC64iS6c2L+2dC31XrZ
         TsyTHsKDfScsGcFTng28FW0tdeRxsDTLeCqhB2uCGZhVlMOVVVvq/W1ixlPsusgzE1v3
         8zGA==
X-Gm-Message-State: AOJu0YwoUjHThdk/pxoaGfRl5W28NWU0/2Fn9mT+/I1mX/Lldqm3i8Lm
	e1/o17CY4ipB9/+UbyKDH2VX3rnQGWC5RxlBujCGnuGX/ihXbUWznIcJSg==
X-Google-Smtp-Source: AGHT+IET+4SDrvL+dlnUiLRtyMtew4B5mODjCPmA0FZ8RV2hM586qx/WuBk+K0uJC0BIM3XSGB6qRA==
X-Received: by 2002:a05:620a:4441:b0:79d:71e5:4de3 with SMTP id af79cd13be357-79d7b987c63mr1292992785a.3.1719916874236;
        Tue, 02 Jul 2024 03:41:14 -0700 (PDT)
Received: from [172.17.0.2] ([172.200.199.175])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69279476sm441447785a.34.2024.07.02.03.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 03:41:13 -0700 (PDT)
Message-ID: <6683d949.050a0220.496de.072e@mx.google.com>
Date: Tue, 02 Jul 2024 03:41:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6139331509695434500=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v1] shared/vcp: add NULL checks to foreach_aics_service()
In-Reply-To: <20240702085508.30513-1-r.smirnov@omp.ru>
References: <20240702085508.30513-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6139331509695434500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=867451

---Test result---

Test Summary:
CheckPatch                    PASS      0.44 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      25.07 seconds
BluezMake                     PASS      1697.26 seconds
MakeCheck                     PASS      13.52 seconds
MakeDistcheck                 PASS      176.92 seconds
CheckValgrind                 PASS      253.95 seconds
CheckSmatch                   PASS      354.89 seconds
bluezmakeextell               PASS      120.31 seconds
IncrementalBuild              PASS      1450.21 seconds
ScanBuild                     PASS      1008.57 seconds



---
Regards,
Linux Bluetooth


--===============6139331509695434500==--
