Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B5B3FE35A
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 14:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778509167; cv=none; b=kzf0ojjOv/vuhrNNVXgNmVMAHbAe90NUr8d3cJQQS/vNjCGgpFtaEwCrYlTPuSb7sm3vUY+pxwYaW1i/mAu2uiXR4oiw7ECQaa4orbxlMaOh6oBb3MdfSgltkH0ILehyXYBUiWVMKiH3mklu9Rz+EbKckCtSP0pKy4jKTd9VNDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778509167; c=relaxed/simple;
	bh=MoADk9TNmZyY+7pOEAs+l+ACFRh1Uxfxv7/v3oVVDJA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EyVD1Fk61XB0e5ro1Z3EvrPdGcbVPq7EpnpS5h8b+AWV6zEcSXGOWuhOxBLEOKycIq5J3xKJT9k4VV7fzT0qRlYfPQCNbYozqXTkVCggP1cP0a5yuWQMcz3HXO108v4S+AwSqkSCo4nZIcemqtOLc8FwtMccccNOW9ByHp9OFOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvNUcjRH; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvNUcjRH"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8acb3dab8dfso28459336d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 07:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778509163; x=1779113963; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1nKE3zWJZj/kJb/GCcgMCu0PnJ3kRbZgRW/MtxIg5u0=;
        b=gvNUcjRH8qRCD0Z9g5EhGQLZ09zztiFiBtdIy+yQ1NVIdr23g01ZyoPnq8tXK12Fdu
         psaZLaicyNnrM1eDNyDJ/SMZ57HC7KbINJxT0pcekMVr7Alm2gH5VprX+RQgfWuAc6Eu
         A3GIobHuE87psybG/BXYxRNmnoe1fDEp+hLx1WE3WE+8dD6MwlNXvG6EzyKzQdQuNOrc
         rhYtZHX4vd74oi6bos/d2eiuwSRxuqnZ2xRVSzpFG+oO6DdO7dSgJsG2fHwEe7ZakxO/
         8u+6oYJMlDPUYH7tWYXwFPxaS44aKZorUQ7D5T6uauHqTyitRn9EUkmH6QFHEHPvmHHc
         lhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778509163; x=1779113963;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nKE3zWJZj/kJb/GCcgMCu0PnJ3kRbZgRW/MtxIg5u0=;
        b=g2IcvtxIibgG9lPBDJm+/K6Fj1Y9SiT2eQvxCvquUunU2ExxwmU++MDLp09PBle8rG
         Zv9aWP+JIoPJt2pojIiFySAAV/jwpEmQ89EGBJyNNCN6seW1a4JsOQcf6cdjfqUe4QRw
         866cTdvfwqxIWabeeK3FtFlLBlq+SA14/hZ2tIXr14c+fR4ZupTQ5xWFrrJZG9Uw/xqw
         L6C0vzSwoi2PY7/BVdfu1YD73oPa78TYgB9YzlBD90ra/NZrcZhEm/C9PKe4us1LXfHM
         ia2YWp+QERORSNfPvmO1PxSjXc2tOJQlaTxYX9aijoTn8NW9ZQxl6YOwMCmV53k6KVXZ
         RG6g==
X-Gm-Message-State: AOJu0YyLI27kEIUtvhBakbUSVvYPWYJ8rjSCqPpEWHKIXWysCPtozMDI
	FkNmKDIJlWQcT8N3aK1w25yVwdjOUw0IRC0LitJQH1LiuSjXHALRgQfNsqi7Zw==
X-Gm-Gg: Acq92OHROGOB3SX8COi2qWjgpwHTYah2Z2w3T26vYmWmg+c+RaOGCWE39AypFJUPxYW
	WrCmbiy5MFQJjHD7ZoGAu2mnGlHpVcmfDFfjP3rSKpmqD4hbA+IxBU0ujOtOy9VCE4zq46oYPVO
	3OCaBZZGKFnjU4xCYQ/DW6ju4Qucuz+mk9GXKiLkya7nNgnNxM0nuuVFwQBTBLUodW+g+zUkIf0
	FpnXCvKDJGKzRLoXp/EHi7xCrcFxHPsVsl5RWa73ZlbmCHNLAAKuSLAyPiayULZzwJkm8/lfVHY
	RMe9hFw3Rm4FIt17pZzLhvmC9nZX9DBtIsDFgkfde0BuDaVa/HyNxlh6KBdjFNeQEizs3AJ1SjC
	ZGXIDWht/t1eBjfzSCgqmWlQKTCJidQ1+AFdXdCsa33lV/sxpP/8E+AZF4Fr40ditUm/aAMbaqK
	BYMROg6TsYifnP+bJCbLfvGbPX14jB
X-Received: by 2002:a05:6214:5b87:b0:8a4:db54:b3a4 with SMTP id 6a1803df08f44-8bc4249d7bamr379888766d6.7.1778509162922;
        Mon, 11 May 2026 07:19:22 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.87.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53c7accddsm311856176d6.36.2026.05.11.07.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:19:22 -0700 (PDT)
Message-ID: <6a01e56a.050a0220.2e4b54.9ab9@mx.google.com>
Date: Mon, 11 May 2026 07:19:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0743748408946739537=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: btintel_pcie: Simplify MAC access request/release
In-Reply-To: <20260511133932.1217624-1-kiran.k@intel.com>
References: <20260511133932.1217624-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0743748408946739537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1092797

---Test result---

Test Summary:
CheckPatch                    PASS      0.94 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.55 seconds
CheckAllWarning               PASS      29.35 seconds
CheckSparse                   PASS      27.82 seconds
BuildKernel32                 PASS      25.85 seconds
TestRunnerSetup               PASS      570.86 seconds
IncrementalBuild              PASS      25.18 seconds



https://github.com/bluez/bluetooth-next/pull/167

---
Regards,
Linux Bluetooth


--===============0743748408946739537==--
