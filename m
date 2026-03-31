Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295CD1A682B
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 22:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774997247; cv=none; b=pUtRoFembdOXW0LaI3NHZsKfFTz1q0c/M4JLdQ1dLyx1C/jGyGXYUuJ38xBfG/+WoplBjWgF/K85M+RkThDq/gzIe8TctDJe1Ov7obzgkPXadc7fyodono8mjjlivRWTNH3B9Gv0guIydh+6LwKqGACz5hqBUTA2j3rjbOXIxB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774997247; c=relaxed/simple;
	bh=ldqiwtsx6KwhXpHboG6WytxUOhGQejNd5yzdkpuAb+Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RcKvsQobKImNa/eTE4S+zsoVz2pSbIiW5f4aMvDH72rtyN2mx8P7wZOfiP6pOkT3FoVoNhkwXYG7NbGRZEZTrRCkPPhdPT55EQjkzoCPa8iTvkSf/+N5JECokVMV8fIuL3Fvnsf8lZYnWVBTbQFvklQdiRRbtnQPR1O/04mUC8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rYgw/z1y; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYgw/z1y"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2c56aa62931so3068506eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 15:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774997245; x=1775602045; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GD9s5+i4dNfNtKo6jV1EZmRUPIvyH1H8QQwsjpO1GtU=;
        b=rYgw/z1yHVyZ1y+Rau5R9723CP+5nmDhqV6Lq2ayISgsSKULrixgZcOdnfzihZMvBd
         a3ToAn/OdU7PI/24AjUmMCa/Bv6qX6zrQ+sr06jLuaULALs0VQGMk5Ni1IM5wlcxQ4gp
         oXX3lhAw9m0URc1Nme3b9aKQY71KaCHs3zI2TGS/xrULmsZiUPSoU5DKPdz/icCI7dLN
         8pMT2cOkDA27UcRcuNT+mzfR5HUqSHu3VCZYCvZ7CloIS8yZeEM8NBm2b8ovWmRf/n5Q
         FjRQ5pT+H5sWkQn7WSzSKKqngxlrHbMn5Lc5I8/QEt36q2+synYlg85u8VApt7VSLk2g
         cQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774997245; x=1775602045;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GD9s5+i4dNfNtKo6jV1EZmRUPIvyH1H8QQwsjpO1GtU=;
        b=EmSG3ZJ2XlASE1ZjOD6+jrL48XaFn6CqGWyViSqoTV6pWkvEFtJ+DZgFO891M0zNz1
         /YGi8HNEziVrhEGMqIPQJRBBljlIlntA+TIAtlO4HUqI5Z00fRLbP0lgWFDebjnKY8LQ
         AaKkHjrVJRwt4i1qCoGad7Ty2XgYVnZt/XOVnRaDDWUr1W3S7zy/w+/3WJx7IXGaY/Hc
         GqODIgnn48RCGvNVzsf/O2nJxkNqlHXBpb6YCsidP7iiQsN8kMKX6Rm5NYoa6QjpaVSM
         uKy4FjFjR3B3av5xqYsXGUM9hH2y6NWz5TIldze+7YcUHbm0RnuxpacgDEdPxDMvawyi
         DmQw==
X-Gm-Message-State: AOJu0Yxlf+Yvp9mPkxYEi0mIuvXn5fPoggGASAYC71YCoox4zAzQ2v3c
	nzWC4JV/EeKruMIQYS4+cTfLZQjr6u8tgfEOTtDJ4O/3LrWk0P+EX2UCNKaTuQ==
X-Gm-Gg: ATEYQzz7BNyQY0+qqs5+dl1i7y7XXAEbUe5mwB9SWU6oKgm03QSvDM+7SbSgF0RTalL
	cEeMm/yeiAUltQyVaGU17ZPkNaeFp/+69FI3deErLT+kWM7tgCEaAGwg9qJ/SQ+I0w5JnqgacNJ
	aevrGESlgUz2GJIuMARdNV7T4yS2rpntI9lmwaPJ0SA85yTGGmqBGzyLreZYGevsvBx4uhaKoHW
	HjdMCMScNxD+BvxyC7IaYjy0C0GwO8syin+prznJdMu2N+DKZfhNUIxcspdlO6k2RB6WSKRLsmv
	SoIOjn+qERKxOCfbvENd6ganyjCfp3bgkINMJpU62uy4DDAejbClbC39FOx0DqmjpOy7b1Ap+PT
	E2aiy3tzoJ1+mD62hSQyriWRGXX7OjdcCchYlC80wr1NhPGWkacI86NnL68BoKXZJK2fGeprdUh
	MddFOzpI7MeBrCh5E0tOeSiATmjXWQXli3
X-Received: by 2002:a05:7300:2213:b0:2c8:6361:ab38 with SMTP id 5a478bee46e88-2c9313894f7mr820176eec.15.1774997244857;
        Tue, 31 Mar 2026 15:47:24 -0700 (PDT)
Received: from [172.17.0.2] ([172.182.225.169])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c886656fccsm2058587eec.11.2026.03.31.15.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 15:47:24 -0700 (PDT)
Message-ID: <69cc4efc.050a0220.2dba59.6837@mx.google.com>
Date: Tue, 31 Mar 2026 15:47:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2407571787260958711=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: shared/util: Add MIN/MAX implementations
In-Reply-To: <20260331213731.3895736-2-hadess@hadess.net>
References: <20260331213731.3895736-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2407571787260958711==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1075447

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.33 seconds
BuildEll                      PASS      20.71 seconds
BluezMake                     PASS      651.49 seconds
MakeCheck                     PASS      18.40 seconds
MakeDistcheck                 PASS      247.42 seconds
CheckValgrind                 PASS      296.12 seconds
CheckSmatch                   WARNING   357.45 seconds
bluezmakeextell               PASS      184.81 seconds
IncrementalBuild              PENDING   0.64 seconds
ScanBuild                     PASS      1027.89 seconds

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
emulator/btdev.c:468:29: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluez/pull/1996/checks

---
Regards,
Linux Bluetooth


--===============2407571787260958711==--
