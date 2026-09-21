Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B693C47ECF4
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 23:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790032853; cv=none; b=cL5kZnqL9X5h9dcE2LjlO7lBKGlEzfZBAj6h+VMZORzYk6pabgUlSarp27s+VYx+uIe0WOT7TwzCAFOkkgS/r07Vt1zlBy/uuFZU3yulqpuo2PiujIdMufHTh2nIyGuotmPqm41EhwH2z545KDHv2DkK186yeQBxTZ3rnCSuL+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790032853; c=relaxed/simple;
	bh=lxHxX2+0pNLwu4kTqG02YwGY4tUKI3HJ75WUBSFS+FA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ov1/wknzE9j3PrlGKAT8lTxpW5eP68QbDpCDYoDwDKl7mp2J/8HZP0u+j45BFzml1FlgLN8taa4vW/8lNilFYUZtnvoPs7zCIMOIfFNpighia3s/CH9WWSsl0z1G1v/D9UCzREn49HZiULkPRxo2hnZ7tA/wVlSxo9cxn8ULurg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKp/vGak; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKp/vGak"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-804f7045f3eso1332329a34.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 16:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790032850; x=1790637650; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2qYmUB3BcI3dF3y4Sz4/SJhYuonRTlQgOIwcabUGjos=;
        b=OKp/vGakLxEAPtVPthzd8ZfnJXH3OZfGgot6zGaAHEhweTW6iKH4vKRvWbnMB1jBjm
         oqkLsjrc207uCMEVoE9ttgp2b3hvjYaiHiY005nJO9BDYZeC5XMZt8B9ZZay6GWAf7mm
         OfIdCObPOBBuYk3hk6qEFU+Bs/OUeaWePC7g1NfB7aVSy4zSFyRvQWxe5o7yk9qpZP5h
         pxRb2UcNLhmS5mLHNDZB7AMOu4CnM2SwBHpNfGYR5bGMbJkPSMmy+Zqe0WGZ+KngDBME
         xzhWowmojXBiSuaYnuJg/vStohWse6doHsxOlPpHMruFw5DAQzwn0yGih9uyfyTbLmTV
         IWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790032850; x=1790637650;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2qYmUB3BcI3dF3y4Sz4/SJhYuonRTlQgOIwcabUGjos=;
        b=CDX1V6uL6R1I8wi2r/tygRNmI/s3HSw/Eer0quoTCsRGldLsz/NJfvcK+QByfb763D
         Lsep4j296r3ZjbHqvvEC/thRD64E7sTiPMvMNcUdZ3VhnzKBZMt18rxqh6xHuGU7MP57
         JxV2a74IXJF/g7yqZ0hQhaiX1QBoCzFzQZJYfHZBupuFWqQGPwst33z13j+NyeLkcz89
         SWzNUsZqMR6VaqwMqbne/emt4NCXgBuwQ7WZ6XgeE9pvdGoxsSSEJDHhFYe2t3xuMHVt
         FxPcmY4feyd5SXdapM98w5XsQaMPAK5Xr+PtIHOz5P3vD8P2a3w7hd+/yB12hCLoPI+F
         PHGw==
X-Gm-Message-State: AFuF++mxnEmITuLinY0C7bmKDEKnh1G8UgvkXHwiEYGA2qFfaDOlyiBz
	c+DnOpXwkA6+UoYtuiiURIS9JEgdYN1by7Flg/yju5WAKPFswQH6pGcPrAYElg==
X-Gm-Gg: AYBFou2ThE7wJEvCzqMeByZ/dnfqEtUxNZFEki5/YuWjjv4K5xbJJXEyhKC8iYiT9Ls
	uvQYpA6Mqlyf8ufNJG23MlQuSe+qnXMlvcoG6MToJETKLMbe+k/MqwjvDUdZJcggCU0jgZZgpSD
	kHVT1PST93R7HkJMsimG1ajtWBdYpXVeA8Fn/stOAMVmCWR6fDXdAI7nKgAj9rrg21hkRgHPouE
	MMwpsprKBnoILKRfgKp/gUahpW/IcfFQGZmQh0WQuzPxZGCzNveGW4WukllXBsoM59Ckw4wnnrr
	ArMpyE7MxOzKjnyTn3NXJK5HdGSFV4+gQ4d6lOjz+Oz/0sowIu/UFvUuAxqj8tbeHs8yrDDZD4t
	Sq1XdE8CIWjXcjoki5feqJZWjrVYIc5lK8MWwiCRdgSc+oB3tTE5Iy5Uuw4TDukj+z3WD5MhMpE
	EZgF8MFZsCHhHsKfgYlQSywSPm2nvIG00HxeC5oIleXSIX30U7ARm8cOA0RBlA/d/mRBgYbebyh
	Ee4
X-Received: by 2002:a05:6830:6415:b0:7fa:ab72:9e04 with SMTP id 46e09a7af769-80de41f6f9cmr13276652a34.28.1790032850400;
        Mon, 21 Sep 2026 16:20:50 -0700 (PDT)
Received: from [172.17.0.2] ([40.86.29.172])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-814e5f87f50sm251529a34.10.2026.09.21.16.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 16:20:49 -0700 (PDT)
Message-ID: <6ab1bbd1.33fd30c6.e22ea.a460@mx.google.com>
Date: Mon, 21 Sep 2026 16:20:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2719783206643215704=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yaroslav.voytovych@gmail.com
Subject: RE: [BlueZ,v2] a2dp: Fix crash on NULL stream in transport_cb
In-Reply-To: <20260921204711.211409-1-yaroslav.voytovych@gmail.com>
References: <20260921204711.211409-1-yaroslav.voytovych@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2719783206643215704==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1170691/

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      12.38 seconds
BluezMake                     PASS      219.43 seconds
MakeCheck                     PASS      2.79 seconds
MakeDistcheck                 PASS      95.13 seconds
CheckValgrind                 PASS      95.24 seconds
CheckSmatch                   PASS      158.03 seconds
bluezmakeextell               PASS      59.00 seconds
TestFunctional                PASS      745.80 seconds
IncrementalBuild              PASS      220.35 seconds
ScanBuild                     PASS      596.49 seconds



https://github.com/bluez/bluez/pull/2559

---
Regards,
Linux Bluetooth


--===============2719783206643215704==--
