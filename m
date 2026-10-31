Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793460999;
	b=VttLZbiytG5J1K/4mCTvZjYpX6cGJFphnn+WmSoZakqNjFxTeIb35ivb/aS0GUomHOGY
	 Tn86wX7+GTuWdwnE4unZw3RUvLcIfycMiaiHErS44U6NGOFdYKQDDc9/KvggM7o/Ym3a8
	 r+l2aG1V/PLfdXuZXkU9NcUnRbvT/43kpJ9nX1Js2SCdaFoXLmGTjafnRDesnMlYr0Hw8
	 DSkVYu/MnG+x0cdX5uhGJk1KeZGy6sQdCzTWZNC6OvF1rjt9URw1lrfXTwgVAgpkVg4WH
	 HcOtFGzp0sAmSWnZC/NxZkAM6fxKfIcVdKDHn1MNUs1PoCUYisiikkBOoRFKcLwdF2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793460999;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=zakYeD1X69FL8y6cmDfWEkzdjEtn35WSaqiNhTlUEnQ=;
	b=vD1nIjoikKxzQK/XQLejx290sTYoDZat4ombB99Xr29Fm1Z0XoskKzJ7DH9nva6jeVf+
	 RJ7CPOgCrYZORSd2M38L8EjDDYJ6CiU8FYlqDejBSaI2TiSnRSDdjOGe2MPMAzHXvvh0J
	 ejfFzmYUEyiEBJRC9Uf3II0SmJVxjV74DBj1IWs//QX/B4gvzladolAwB9p3JhW5zF5IF
	 vN179KUI1Q0SYoFKUjYDDG+lFvHCZUb3sOCO9H508VTwZaAtcJkNmmBHz29uuGsFTjKLb
	 W6waNTpcQ3YcOqyJLRojPQkAgX7VwEqc0lAjQ2CIcL8HzN+XzhE38Vrr+Gh8C1/BlNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uTRDPxmi;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECBD606A31A
	for <linux-bluetooth@vger.kernel.org>; Sat, 31 Oct 2026 15:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4ECBD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uTRDPxmi
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-35c76e9614aso2427020eec.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 31 Oct 2026 08:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793460998; x=1794065798; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zakYeD1X69FL8y6cmDfWEkzdjEtn35WSaqiNhTlUEnQ=;
        b=uTRDPxmiMYDlk2WBb0h4KDbdPI246vnIWO3IXb4BNu2iT/9VJsxFkPAQiePBJH9o3d
         tgDFIv8l/pXPSNDEF5nZBvW13TLpJfNkYwDm7UR/RcsmRHxuMtjzrkZ6Pe13Wjio8Rlu
         FgXUO0OQRY4BH2zxS/FUf7tBcVfzYHsXK8mr8c+JE3Kq0B6Uiqj6yafslzpPlVQEJ0XU
         AHeMwTtENYJK3msMfvX6up7jVdocO5Baj39sFf1+qLNVtE4kCLIsR10WTFvDlr5opSIs
         nfIT6XDMUrl0WO7zpg6YJnoDx5NqRF6hqPRPIlqEV1ptQ6E8qsFBrZVbH5o7qWuQfyED
         wdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793460998; x=1794065798;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zakYeD1X69FL8y6cmDfWEkzdjEtn35WSaqiNhTlUEnQ=;
        b=lAb0KXXFvNeDddsxaUVi+PlJ1qP4lvqe9/a7UNjuW+8O3bKdNMaJ8N+RC4LE/tv/Rn
         kyCorBlnOwp6Q0B+lwPYZ/WBcdyHaatcZUkCNmglWFraZUCoNVHNW38HP3nGB3ehIAgO
         slEUoGx5hSd+ufegCEYK4nh2j1z8/+eLz3ASpUadb/u6Dwdmkn5Vi210z0a6IQuq8IBr
         AUzklXerV8TWEUinnoNERFc1qmGvlhwrTQU01VCUC0l+9iICNni2EWT9J1tjrWlrMu/S
         MFI2DnDvUlSrFcK40tAsIbICchxS3qoMt7235nmFUJL/ER4bIiAWuqybiWVT+iXIEu3+
         0Zww==
X-Gm-Message-State: AFq9FYJGAXkcOXA9yJtU/xLB/ITbXaLS28GZb4dFd1oNI4wpC2uJoU0t
	NueR8p/DfkQBAtWe2UEEt7VFfAssv5JqAkIMhyZwtG2OEm7FjHfv4qoqszPaaQ==
X-Gm-Gg: AYBFou2YNC0/J+PVNC9TfsURgsIp414XgU0x8Sta2wfD7Xuasg+/a48ost869/w8VYr
	EqIBVwvB90SfYKgvwroy1ZmRs8w+jfuzsHOLyptjuxPqhko8lnJskaU7+71L3Ski81AVWX+Vd3y
	AJTZ2ltbiiA/RvVnlLQxbK96m62eq7vDnRO3x35O59n73ksDhbIwLIlfgeWAHaDrSaQhLkSoGFU
	fykk8w7+Q2S2lQfwxVmIsB8g24Boi9PAqLJ6CoAcImHLPIKUhJjgtIVULSXVG5md9aULtygHu57
	N/l5mwfldToGWTD4LwQXW9zZV+YlyzQLhhkGqPNhAjWnylOVEZ4gQtpFzQfDNiM7RuclGLkv4iT
	kPOBCe4t7DpWDkIU56Rf2JeDx5zt6CEWoiRk7YSV0kGzU42PLqdPdzQ4FLEnsMsjUs6+66UTWc7
	/4q36IuMULicgiNXztLnzJlagxEyuai6+Pb/cSu537bH0uAV4U6eucOHYe8l9PQ/JJwj42fuUK3
	OR6oL7Tdz1GFafT/MIkbUZ6VzRBIXey6Y4/zzmEBLDvt6iyj89r3Jx3P/W8rc6i
X-Received: by 2002:a05:693c:8386:10b0:351:202c:c7a5 with SMTP id 5a478bee46e88-36a4205895cmr8211113eec.0.1793460998061;
        Sat, 31 Oct 2026 08:36:38 -0700 (PDT)
Received: from [172.17.0.2] ([52.161.180.146])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a77c0dsm21323282eec.26.2026.10.31.08.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 08:36:37 -0700 (PDT)
Message-ID: <6ae60b05.ec2c7a27.3152a9.9aa2@mx.google.com>
Date: Sat, 31 Oct 2026 08:36:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4835068987998328602=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] monitor: Fix Conn Interval rsp group decode
In-Reply-To: <3265e8c3d6e7628b82422ff9cad96eb0db9e7ef7.1793456788.git.pav@iki.fi>
References: <3265e8c3d6e7628b82422ff9cad96eb0db9e7ef7.1793456788.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4835068987998328602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1197782/

---Test result---

Test Summary:
CheckPatch                    PASS      0.34 seconds
GitLint                       PASS      0.23 seconds
BuildEll                      PASS      16.16 seconds
BluezMake                     PASS      223.97 seconds
MakeCheck                     PASS      0.78 seconds
MakeDistcheck                 PASS      115.82 seconds
CheckValgrind                 PASS      114.18 seconds
CheckSmatch                   WARNING   219.03 seconds
bluezmakeextell               PASS      74.34 seconds
TestFunctional                PASS      935.71 seconds
IncrementalBuild              PASS      226.46 seconds
ScanBuild                     PASS      806.57 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2289:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3925:52: warning: array of flexible structuresmonitor/bt.h:3913:40: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2741

---
Regards,
Linux Bluetooth


--===============4835068987998328602==--
