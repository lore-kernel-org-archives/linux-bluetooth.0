Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CCD846F
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 12:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720096899; cv=none; b=knmqQcAOlsm1QRa5/dMVZhCsqnzEmmsQ7YbtU0tfrS+gMCpF60uHeBK6Zjth9EYpOT5TbR9gePiFLairrdh1tOu6O6I92NxDK8x9Y3be4jG0zyglyoW+TZt40b73MKCFBwOgG0vdXNoCIE2Onh1Pv9rW5gcqsnotJftRAP2jKoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720096899; c=relaxed/simple;
	bh=gCHt8RHSPYNS6NKONWNGaS/w6kwBIHIz1W3Rps/dIPI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=L5XsqkHb4SppEWO3wLRManzalZyE0WIhY303c5v7NqCyB3eBOyaO7vdiGQg6WgGPUj2xolNomdDHtBfllH5DJAoYeImHX24g5WWQ5hw+fzxq2zEb+PGzt/ErVh8xKUZ8MKGr3GELi2g+EIkWugNT/H2n6Nr/eV5KmCZ5Y0fM9u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYI2Ma6u; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYI2Ma6u"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f70c457823so2962595ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jul 2024 05:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720096897; x=1720701697; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQbJzgTDBMCbbI2g7TIuC6vLyDQNpRmtXn4O1GDPF7k=;
        b=YYI2Ma6uBdrOnwCi0z6rHRoIXPPtsDIWPF5SOOYjbI+DPTVW0H++Dd4MeIV940sTbd
         raUgWRAZGBqSFMprcnAwmaI0EB0licQT+pQe/2gHVHGoYtcrsR5IK8Ax4qE23HibiLEp
         S9Gbs2VWgLdM50++Im2RjY7mw56c+MQthLvQ/AntU8BsxEHFBrUNmRd4bh3u4yw2A9AE
         0Cbzi5Wh+VI1WX68jVO3+ZWuOrBmvcLrkwEUs/4FAQk7tfArKOYW/Spz+aqpoEipKA4C
         NzqO4y97C+2KhQK+aqqliJMZP8tpLwrXZnIsukXGQNsVdAqp1y97I4A2orpl6dOrxGm7
         QUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720096897; x=1720701697;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZQbJzgTDBMCbbI2g7TIuC6vLyDQNpRmtXn4O1GDPF7k=;
        b=kspaEYARpuCwKYwcSu/+f2bQo17ztjJladLoEdNfMbyN40TtCjJTh6zgi5RbVupkuh
         mIBXzvZR4NMy2sHCU6K3/nCbP/sCxPSxFVukGtyAvP4aFnTHta7is3ORHocrmYL1ocrY
         BWSFwiK24IyLSPfCnk848yDFmuDw50C+98kIdwjRfoA6XahOukz734qFgoCxaUXlX7dL
         r1rDs5CwM2X2thB7G31R+zWIwPTHQIVUTwRksqKdAe0s8f0sZOuppDepIClFaFS7aRT/
         NoyuklTAATy6UvqOC2Rryl8o6lPFb9ZHVc3lWcFXYNXAe0qyjDDj/Ev1RBsmww7KNacd
         DIjA==
X-Gm-Message-State: AOJu0YzY3TmvfIvax6qWRmC13Ns+6IVdL3VdFqSOynarvHNUAz1C1jCr
	n6lQhIq+Cu0Hn3yYfvxM4DhrpJGZrvu8ue1fHvNg96SPJqBnUYYRMiAp2Q==
X-Google-Smtp-Source: AGHT+IEpNzrWZucTps8CfQ8hOF3+YfJoH1XdTGAScgtxQH6N1f687l5GvZ2xf6CVka6BO6TyXDyNQw==
X-Received: by 2002:a17:902:e892:b0:1fb:2318:d157 with SMTP id d9443c01a7336-1fb33df606bmr12147345ad.9.1720096896928;
        Thu, 04 Jul 2024 05:41:36 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.100.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10d1b61sm122029675ad.57.2024.07.04.05.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 05:41:36 -0700 (PDT)
Message-ID: <66869880.170a0220.876da.c47e@mx.google.com>
Date: Thu, 04 Jul 2024 05:41:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3070850849891686089=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v2] client/player: add error code handling to transport_recv()
In-Reply-To: <20240704104928.43336-1-r.smirnov@omp.ru>
References: <20240704104928.43336-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3070850849891686089==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=868404

---Test result---

Test Summary:
CheckPatch                    PASS      0.26 seconds
GitLint                       PASS      0.19 seconds
BuildEll                      PASS      24.36 seconds
BluezMake                     PASS      1651.77 seconds
MakeCheck                     PASS      12.94 seconds
MakeDistcheck                 PASS      180.39 seconds
CheckValgrind                 PASS      255.77 seconds
CheckSmatch                   PASS      360.05 seconds
bluezmakeextell               PASS      120.85 seconds
IncrementalBuild              PASS      1441.50 seconds
ScanBuild                     PASS      1030.93 seconds



---
Regards,
Linux Bluetooth


--===============3070850849891686089==--
