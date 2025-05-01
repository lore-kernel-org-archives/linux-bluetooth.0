Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F71C1F1524
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 May 2025 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746117354; cv=none; b=SwcQm4KBOzhX0EWDTi05kRt9Ee5VZEwLBHLP0S4gOxZYNGUk7NyHmxvtJ7X47WoEAi6kDq41S1ZM9YnwVghcmzGCNP97FvuB2N+q0XQZSgb5sgDoa1z0+Eo6lNKqD+UVkc8/lJoD3VdpT8ECkpsUn6lFaulKT7+hUSnuRdfepSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746117354; c=relaxed/simple;
	bh=xe5by/pxMm2zMte2NOLefojYXeIAI11URlPOz3SyPb0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OJ/om7wlV2Yst2rDDCXjmGa6Lk7j9DDtuWyGPInQpjicTYq4LCperWhiPAStHpiiE5qB074Jj8mhPRSMofEHqCBSzf/hZTFnPEDegFDJqeCC4dPXT/LzZ5ML/qfwJTsAsjmZeNk5P9OWobYQidCf7jyzJazv3n1y9rBJU1VrwpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mind.be; spf=pass smtp.mailfrom=essensium.com; dkim=pass (2048-bit key) header.d=mind.be header.i=@mind.be header.b=JStn4n8t; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mind.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=essensium.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mind.be header.i=@mind.be header.b="JStn4n8t"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-39c0e0bc733so1015724f8f.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 May 2025 09:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google; t=1746117348; x=1746722148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=17ZcKKZIeQAo5hQ22NjjkwLbJs1DzeHhqh4tn8+9g2s=;
        b=JStn4n8tzgKtdHvlFOnqqBuiiCGzKex6RqAZmCsfqITkQtaR4KfB07wa8GRgrC26PW
         Mb2F5RTYwnkW2eBi04bA7hTKzbjnY7R74uSxQPgPK4e7Xj10FwymuYqTzsoQk8LtQHmY
         e1wn79bZMUsklH9UV0w5hKLkIMItUjX676Uynh81UQ9r6T49ZYHfET0iuH5ks5xvmnyK
         /YA3JjQ2yB/PaCRdUvCba5BopMZkBXqBXiNZB5u+2cxdLcNtk4/hcF7pQGTayYoqW0Kq
         eFP9Zmhqi5AJCT6dZpI7eOaCzjhtseFe7d8aWt9sanzC7cCoxmrmsjG7Gv91ETnBYYZ3
         qBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746117348; x=1746722148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=17ZcKKZIeQAo5hQ22NjjkwLbJs1DzeHhqh4tn8+9g2s=;
        b=JdcYb5MceECKBBYbT1VdDCM+bG+WYxqA3oSP//ulIeWa3u4YdPTvR8q+Ei6D5kRVNu
         lMIXRn6dzM7gQqRPcc7FGL1sLreR2xDuo6IE5ApF/eqnrJUjU89zwISXVo132ZoWb3SH
         7mk85NcJYEyJF68qN+00WJgKXIpEgI3vrUkDBWR00YDC+ivQqN+Ca4VGB8Jl0MFrB3X7
         hyrWHZlPxtiPJqMhW5MP6ou5sQIa09gKu7pQHuZKDtgB7dWDN1MQoJPId5nYgdTTqvnQ
         Oc83GbnqMDdJY30grqYsPIMMnEl0Q8W5riKjaEq28MfHN+V9vsnilP09HTWCn0ZYeV5H
         q+Lw==
X-Gm-Message-State: AOJu0YwPcGXK+QX6+sUtJQtWkDi43lbRKQJngLUz2MvD+V/45jJcwboC
	EYnpWz2TY2/dS847smzDq3/2fo5Q4tXJ8sShccCoCwj6k43PeS9kU2wOrlVIF1GZZ2EsuK+6AxK
	rdfA=
X-Gm-Gg: ASbGncsukVkfPIUlnJgYCIFPvv6JL/VJnD/fphz8OkOakBh4ybm62otgRGHVSctO/Y0
	UVmuBkJh+qQ/ZbOiFN+DT32qqITxPvQKULPvvU/J2tttyDrCJ3qxGdzfFhzyAEsZ3lRr1VopWlm
	ODANmkalnNg7BMwDWdQm52/KZm7Q67rBYMEGUvZuOvOZBTKL4uD1olFSne5TVcub06UYm0p+/7J
	YkumiYeBzXhMJhF2zvd2A1Rdj5adrIPmpJmvdySqwsXJOtF7WEwC/RquPQWN/SbXncezJk19Y8l
	VjoqDuSFigMBfuxjhxVICZ1agj8oFQdb2H5YBHSTtETty5x7uW8FoW8xhCCRWwc+KQ==
X-Google-Smtp-Source: AGHT+IFIVHXTgf0MtnyNeJe3YXKVzbk0lWF84meiU82huFp/dc6/oRfq0zSIV3rDt/Ijdw9xpKQpGw==
X-Received: by 2002:a05:6000:178d:b0:39e:e438:8e32 with SMTP id ffacd0b85a97d-3a08ff50934mr5877658f8f.55.1746117348454;
        Thu, 01 May 2025 09:35:48 -0700 (PDT)
Received: from localhost.localdomain ([79.132.233.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a095a8f8ddsm1235312f8f.91.2025.05.01.09.35.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 09:35:48 -0700 (PDT)
From: Thomas Perale <thomas.perale@mind.be>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/2] fix build error with --enable-hid and --enable-hog options
Date: Thu,  1 May 2025 18:35:34 +0200
Message-ID: <20250501163536.1283827-1-thomas.perale@mind.be>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fixes build failures when --enable-hid and --enable-hog
are not enabled together. The issue is documented in the following ticket:

https://github.com/bluez/bluez/issues/1228.

Compiling with the --enable-hid --disable-hog option would give an
error because the HID plugin relied on functions defined in the HoG
plugin:

```
> ./configure --enable-hid --disable-hog
...
> make
...
  CCLD     src/bluetoothd
/usr/bin/ld: profiles/input/bluetoothd-manager.o: in function `input_init':
/home/../bluez/profiles/input/manager.c:122:(.text.input_init+0x1c8): undefined reference to `input_set_auto_sec'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:6376: src/bluetoothd] Error 1
```

Compiling with the --disable-hid --enable-hog option would give an
error because the HID plugin relied on functions defined in the HoG
plugin:

```
> ./configure --disable-hid --enable-hog
> make
...
/usr/bin/ld: profiles/input/bluetoothd-hog.o: in function `hog_disconnect':
/home/../bluez-5.79/profiles/input/hog.c:211:(.text.hog_disconnect+0x12): undefined reference to `input_get_userspace_hid'
collect2: error: ld returned 1 exit status
```

This patch series follows the indication gave by Vudentz to make both
plugins independents of each other.

[changes in v2]

Following the review of Luiz Augusto von Dentz, the reading of the
LEAutoSecurity config entry is moved to the HoG files and the reading of
UserspaceHID entry is duplicated in the HoG file.

Thomas Perale (2):
  input: fix HID compilation w/o HoG
  input: fix HoG compilation w/o HID

 configure.ac            |  3 +++
 profiles/input/device.c | 11 +++++++++++
 profiles/input/device.h |  1 +
 profiles/input/hog.c    | 19 +++++++++++--------
 4 files changed, 26 insertions(+), 8 deletions(-)

-- 
2.49.0

