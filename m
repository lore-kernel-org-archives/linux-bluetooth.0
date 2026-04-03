Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D3D314A9F
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Apr 2026 15:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775231194; cv=none; b=ny85iT0qgQXPcUt9C/NI+N6yDOejTPVfthPnmwt2W+kezMvD5dq0OUrnmgI6xzjMEl4fnAnxmWL9B0oZUBR6TVXv65yhtFSD4DdX/+g/2l0xh4RPx7+vW0YOUNLxA8+sWj0jWpwHwLGW3Sq/cDN+TmzNZ44+g7EsZWFt75IOPG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775231194; c=relaxed/simple;
	bh=nq7voKYvjpT/1T5WayWEDX29cg0BwTBq9PLENkgSeK8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pPssXbx2NHzY257VaVAoK6ODlSOY1X3InYQ3QigNuBeZPI0QKi4G7s67Mmn8JwsU9C+k7e1U/cNNRV2EFPQ64x9MkJBkFZj4BZ40GGuYctbcHHqMKE4jQ/3N1/15psyyBZUGKw9j8uB0PH3kzw3dz/rUZ6vj5z5E8nYFXuKDxz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OiraBp/T; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OiraBp/T"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8cfc085395fso182220285a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Apr 2026 08:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775231191; x=1775835991; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C53ndA7faAK8ZdIiMbUy9A8UHZgx8Dxs8TpbrAwTO30=;
        b=OiraBp/TTeVpXfm5TYKDcli+qtQx02BoekcZ2HJPnw9hECHC/qejaLuPWhjIeNAiY4
         qzJbIKyOSd+KvhLcBGPZYodZVC0zgOldWTS58hMeyUG15ePYlWyCD5bCyks+StL1pulz
         CiP0a66FMkTFv5fuj5mi8uG6Ymoi8ZtGWtVL9wucxuxqJScYKMQ1HB823YGQONyjcd0/
         +QW2gt+9gh8/8bDMGTW1Y92SgeOMjDvFIKdgvzM8jVEgv/fLeTvbWGonutByxY43ajuR
         moV2Q81aRIAfkfmrtffDFxsYUNvXTnKKfFbqr7AN5jBcvTchP6sI7wKuGtwFbqhFZTt9
         sz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775231191; x=1775835991;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C53ndA7faAK8ZdIiMbUy9A8UHZgx8Dxs8TpbrAwTO30=;
        b=f0TiO0r6QL/BCH9VnF0UhL8SxxHeiCzHcMtMvJZdfThsJn/EYdbUl1y2m6E4ImJnmO
         3XKXeI84ANRXSGFMezjfbBLa98psyiBx2z4eFGG+GC8ponUydy3NR0PIKQ2NvAGghZ/H
         tOi6HUy8rzcnFDj2fbMERyFc5NUzMDt44aUXvHF/mhQU7UxRt40m3lLqoMFZpVAX4mNP
         b1iiYLrGQ/TzKVcppGrAhK8fd4srAhmmD7CYddjdMmC/qfDAGw1CM0AXj03bitnEUWcY
         HjM/RvI2X32+Rn+8IW0hoZDJR7ksyjj7V/BJAYmF3G4lL2Hmb31dmdvEtT4ggJkoqgE+
         teQw==
X-Gm-Message-State: AOJu0Yzkw2cLo7Jr9EF37tJN2OdDgq2P412CZNnyGbSQLOVyUYLoejJ+
	oU7ZLlPgryVFaKSu2T5xdNET//+3F5dc53UmUQjMNq+g6OyE/3fZMBGErj/BqA==
X-Gm-Gg: ATEYQzxQBuDGu4hHmcSROGXJY7H37vNHtnhi0orn5CLDhnsrWNkSZRCxrKVtOyBh76y
	rwHaWw18J7I33zpNK8wWMCNEYJsHReUv22nJJocifDdDl3IeKLgYjwULYcsYtpg6Bq2eOBVZmfe
	//BY2y5tavs2ifEFCucrOBBLe++7zPcoy6NnhEuCfX3wkUnl7QWCQddYjyVmK9coPVNv3aTEoka
	sNrUZF4qdJraBoNrwxFq0ud6n+IyKpBizSDS+qrvSdEn/rO2QsWe7soYDyeH5XcDD7QK4QQy7Dl
	xR3HKqA9xvjzDTe1s4C+MALhi2SMrA1eSip1yShOnuMH+JzgjCecKCbbu8LOsFSH1zZFbsCx+rD
	M6AjR3AT5Anb8T1VIkM+xPoQywy2tiZCx6Kpym1kEu+elV9KYxrCFs90B+yrkS71W/RXHFsKeC+
	YKW+PHolYqWaVvEMWCzf+gW1sRJnsOnfzK
X-Received: by 2002:a05:620a:19a2:b0:8c7:eb5:8528 with SMTP id af79cd13be357-8d4185cd9dcmr538056685a.1.1775231191440;
        Fri, 03 Apr 2026 08:46:31 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.208.132])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a5f47b3bsm447116785a.20.2026.04.03.08.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 08:46:31 -0700 (PDT)
Message-ID: <69cfe0d7.050a0220.2ff6f7.bfd3@mx.google.com>
Date: Fri, 03 Apr 2026 08:46:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4104380602319194859=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] client/btpclient: Add GATT read and write value supports
In-Reply-To: <20260403143631.545312-1-frederic.danis@collabora.com>
References: <20260403143631.545312-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4104380602319194859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1077051

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      20.44 seconds
BluezMake                     PASS      655.61 seconds
MakeCheck                     PASS      18.65 seconds
MakeDistcheck                 PASS      246.54 seconds
CheckValgrind                 PASS      297.48 seconds
CheckSmatch                   WARNING   354.92 seconds
bluezmakeextell               PASS      188.74 seconds
IncrementalBuild              PENDING   0.31 seconds
ScanBuild                     PASS      1047.20 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
client/btpclient/gatt.c: note: in included file:./src/shared/btp.h:322:42: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluez/pull/2012/checks

---
Regards,
Linux Bluetooth


--===============4104380602319194859==--
