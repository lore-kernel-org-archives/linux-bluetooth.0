Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73EE2DEA95
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 20:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788120688; cv=none; b=ELTDV+i9eW4X3mw8d/1s6zBqTBJFSF5PBYYWo2pJDYGWU9Lyovry1OCmATjbjCauArAm+/HzUHNcmc/baXArb7zDPrEVFS0oZ+MyW7SsPr9P0mE1cUPZidD2iM3ZlMJ0qP0nzYRMHz96kS2hAwiUD+a1UKXxq9WkvZzAt07k3kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788120688; c=relaxed/simple;
	bh=vYQLnD8dBF3OI1rfjdj4z/lysgnQqB3/y9JMCeYApoM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=n027I6qMX/7J4fLlh22HPLVwvoocrb7hR+EdfVH46C6HU4hQLDG8oyw5sd3cobc12jLIhf0D37WuJgKTRVpoW3502jBU+IKwEqKn4m68qJs7Dw0/2gnvA316MGOVFIP6OqJUsYLrDUD7YkxgpW6cRNBsztooWX9sX8Cs2IB1pJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTvEVjd5; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTvEVjd5"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e58034d05so2253823a91.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 13:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788120686; x=1788725486; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vfE6ap7G/WUJOJPD0xPqhpf7dbDRBDfGWaRHKDwN5iU=;
        b=VTvEVjd56MiORm5JyKL89fQp6PWe4kyB35+v2vWQmUzT0H5UdylNtYRtbUVsxs0cnU
         TVa46PObJ1RAnusINl3hrfmCT/SO1rW9Nb0OR4QWrSpf4Of/jHoqI6ow1G05DWLXyj2N
         eAt/AnhFla9paX1fYEt2MGhrKErKUoajDMrz5GCXwkqmJKXIsoqMbmXn3hv8TZ9rh1mF
         pJSnah1Hi1kCS3Im1fVDBZz/BzlJjiCzwDn7E+S+bqzZ+Z16aUCxKTMad9703lpzEgDh
         9LroqsM5bMQTAHLUm+sOEO0e+TfRKK1FtVtDksh1muK0jfu2BaaVtdrXQHwqqtlzqic5
         FWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788120686; x=1788725486;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vfE6ap7G/WUJOJPD0xPqhpf7dbDRBDfGWaRHKDwN5iU=;
        b=j00OuJU0CSK8Ri7sbBaXJlIuiv8dP64QBhKNCCYuoav1EkYjfyHM7nVHPJPclHm/xo
         zUGwKTJVWLeR545jq7C6H/hWC+XOrBAqzswBYSpG/gCmBBMx5WOXXr6XKgv9yWbjychQ
         FmLVaYIqSTuERM8ekbWidAEDhY2IyKoeOdOGHh6mijOF7dYuxDbULKeH3+PPXh21lXV4
         HoxsUBZW9KuReH/LCQ+tQ860iif9yuLkA2tC3E1bwYrnYwxgk8VdjRFnUeKkD5XMQ1I9
         FJRC1d8e+5rRRTqaSo1DqyN517lJb7LWkpGJJgPWPd5mUbDdaGz7bWq3qVXpc1kLZ9F5
         Zm0g==
X-Gm-Message-State: AFuF++kkPfE8Y3nrTvvYXMVI7mkRLvATkDKx58dfaUT0IZyWWgXGeoEM
	/p4IiSQBpTzsXCsyGx86QwGX+E4oB88Cqzuq5s3JYE5MbnWaOaC8KfFKoqTcNA==
X-Gm-Gg: AYBFou39EpsqQxGhkeZjualqgF+WDE8SAoq8BiAq50ysws46OJxkMaBSJX4ybGZ+oDk
	B4/OXT0fD6SnEQiIGtQ4gkAevGcbLMI9BkuV83qj2xDzGIdBtzrwaGFcH72qR0Ob8h0wFXIRbUl
	5kZmrSQM8ydHrdU8iV8OPuGuF/8hqMeggkMp0QBnX/pcRynKFURrZsgcMc2aHjIGJBbhQBg0D+x
	rOCaoKZnwi6yJhD8Lz//KIIdeD5NY5QU6rJcNZ03JGMSvNeZ5we2jdfea3PwS9tP1cD6wRCXHaR
	ye8W4/jZ+HLx6z6nqHtBtB0jr5EbXSTL1CJegvexKIzkcKEz05elQoUc7/1T4ckoMKYOnoNH68x
	r6Pu6TYvJs44oe2ZUAYOkTFPyCH9GX1fzjzg28B4vylDyZg9OCbH5Mz9jpWlXSrv2B3KO2WMi5C
	F3lKqKhgK9Ap7hW5Tyyk0O7OR3nmQX9MCYM7Zyx/i0KVWGt9JcodHf1IpdDNojYLfY
X-Received: by 2002:a17:90a:da83:b0:396:5cdc:4bea with SMTP id 98e67ed59e1d1-396d0e7cd03mr32960381a91.5.1788120686115;
        Sun, 30 Aug 2026 13:11:26 -0700 (PDT)
Received: from [172.17.0.2] ([4.242.27.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396dda7eb6bsm13409232a91.8.2026.08.30.13.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 13:11:25 -0700 (PDT)
Message-ID: <6a948e6d.e59e62a9.19fe5.4965@mx.google.com>
Date: Sun, 30 Aug 2026 13:11:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6455864965902826920=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: L2CAP: fix chan mode for LE_CONN_REQ + EXT_FLOWCTL pchan
In-Reply-To: <b30626af1ee0165d56dbfc15e5d16ae6efbd726b.1788109840.git.pav@iki.fi>
References: <b30626af1ee0165d56dbfc15e5d16ae6efbd726b.1788109840.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6455864965902826920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1153957

---Test result---

Test Summary:
CheckPatch                    PASS      0.56 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.21 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      27.19 seconds
CheckAllWarning               PASS      29.96 seconds
CheckSparse                   PASS      28.45 seconds
BuildKernel32                 PASS      26.03 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      496.64 seconds
TestRunner_l2cap-tester       PASS      63.92 seconds
IncrementalBuild              PASS      24.93 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/668

---
Regards,
Linux Bluetooth


--===============6455864965902826920==--
