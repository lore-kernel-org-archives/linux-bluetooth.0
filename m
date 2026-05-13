Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E146E3AEF43
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 21:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778707593; cv=none; b=ZlgH9Ty+TmROjBXB9U0qothKnBblWb+FA61NMu8uVmn6zpZFjp939oj6WKIrnUUfonnYkhiTZ8dg/B/rIMfbh79nG1IBSGaiZB9yj1hwb37OHUyh6yRb3n5x1tevIfcQ5KIBk7hBjobtXW1NJHWI+z65yoMoEk5MLF6yJF9UPnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778707593; c=relaxed/simple;
	bh=uQup3kn6EXMOKVOv3qGFUzUCQWUynQgKO87reGSSgJM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lAdKE4iu+JXgaUWI/boqTyvSUGCH6jh9o2uoz49bxNxVABYSZolDjbO0qGaU1+ZNV6T+T+oBOMYCjRyBRejNafJtl73Vq9cfyYcP67UhlQta0TWNeMrKv8bQYK46FuRM9BNaotDq/5e0BDYy9po2A2sz5DRovvImzC1YOqzLuw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcMR6jkR; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcMR6jkR"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8c7154725easo19843156d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 14:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778707591; x=1779312391; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PCTMRQEUZVdCCHPQi4/eIw+VfsEFu8x2G8RrUJojoqE=;
        b=WcMR6jkRhwK7njLIeRaneGa0vaS93th23mwx06J1dfCRl8Y3XUNvQQKkdybiUmPmgV
         OGvJAvDTa+pPmz9Y8mrtnVhTATdkbMfTip+dOHCV0beUYQQ8rKZqyL4oarEWAFCIml9S
         WwBvPuiRHHkm/ezoyXl6bta4/XnttO4tWX4+ffuSygARHsPDKkB2SeuUakF6eQ3qp6fq
         AnHoT/p8YIenHSxUkLVBIDBphioEmU7rkEtTxjBKOgkM8DI5LB9vU+CXgKRPsfiID8HU
         /K+o7t2f9GtdRDaLoHsiESt28gVdWeC+prFpsvyqo20LsolfZ6QRwrfrwxd1ReV6TtHa
         N6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778707591; x=1779312391;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PCTMRQEUZVdCCHPQi4/eIw+VfsEFu8x2G8RrUJojoqE=;
        b=rV8nWrR8yIzTAfuAIcIATJe8hReUl3z7yyHiqUNgY8RmoWc6e7vf5vi41duVX4It4E
         ZAgyyUE5/9isgbEGWMJg8hSVG/0euJookXu3hjGHxQeQKFKFYjclzIGlRQ0wMlvORtx8
         mzm8jYrYqx4S5ITE446vMcp6bAyvBUwQt4J7JQy5L501wm00VMNrC5lufJmVMVFOOXiB
         2j+4kiqTiJN1jiRIZhDgirPdkgezj5ncvepoRiWyEJx/to6R1QINGNrlDvnjLuPERYDj
         pVHLXdp83+VK7gS7YCUY6z+awMpjnn+wzGqltOQYookAgP2WA0lmQrpCiu4PngZMFJgs
         Hjtg==
X-Gm-Message-State: AOJu0Yw54GzSzOOCkEDWFdJkNp/IcfFaX5CalbDgCr3JnYRKmWW92KXC
	5krUnM6OCK7Y5di9T5JnnYjXqRRVnkTJWeklFDi54THf+Tf+WsZ2XvrSIZyzfg==
X-Gm-Gg: Acq92OETwySLVR+dlLwBCebk1mLVwJ7PnwLmXZv5PEvZjOagEcllmUkoAS8h4re5gzO
	/hHvnhXxUnPP02hzZMY5f1w1eE2NAbFSf+FQskbxv0ZnBALONo+p6kQtB9PWj+phZa4DwpNL/g4
	KPuTKH364ZcOCz5h/Fx3ggwt5ejbFyhxa8ulUOloW5jcUxU1T23IE7QHpi3p2WsVh5N9qAHmKCp
	fFjbv814Dh0l9ezlnc4tEn1U8aVQAFwsfOAS9++ISp5iO9mzS2nZRjMurDCKiT0PUOuY8xoYm4W
	K/3veOI3ni0Az5ih3caADD3omon4m7U5QQXPGa3QS3s+7IoyI14YqIe39sZ8DzDs5hsG2AIgPyU
	9fCddrDmzjVimlPDtwcTHjicvTLjN0vLwrUeI0WJZj+UNJNS5WeYiIImrO0geuhE0t+m1SPsDKk
	QeZIV7FUgO/gjBQ6cCe9jx5izC/J2LIA==
X-Received: by 2002:a05:6214:4804:b0:8ac:bb62:fe5a with SMTP id 6a1803df08f44-8c7bcc02a0emr82759206d6.33.1778707590699;
        Wed, 13 May 2026 14:26:30 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.135.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90874e5e4sm6869826d6.6.2026.05.13.14.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 14:26:30 -0700 (PDT)
Message-ID: <6a04ec86.9f9a8404.7b276.9c46@mx.google.com>
Date: Wed, 13 May 2026 14:26:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1109056351548637993=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sean@starlabs.systems
Subject: RE: [v2] Bluetooth: btusb: clear remote wake on idle Intel ACPI paths
In-Reply-To: <19a2b7d308f5cdfa651fee727c1423833380ea1b.1778700929.git.sean@starlabs.systems>
References: <19a2b7d308f5cdfa651fee727c1423833380ea1b.1778700929.git.sean@starlabs.systems>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1109056351548637993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1094450

---Test result---

Test Summary:
CheckPatch                    PASS      0.78 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.45 seconds
CheckAllWarning               PASS      29.11 seconds
CheckSparse                   PASS      27.53 seconds
BuildKernel32                 PASS      25.45 seconds
TestRunnerSetup               PASS      564.10 seconds
IncrementalBuild              PASS      24.76 seconds



https://github.com/bluez/bluetooth-next/pull/186

---
Regards,
Linux Bluetooth


--===============1109056351548637993==--
