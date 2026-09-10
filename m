Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DE454A7CE
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065035; cv=none; b=WV2DVYCK0sZ6DkdhxmHnDwii6FtHMJlMlOtNssss8AInCdtheyMZjZLj2r9/g6gDHzYFWhm2rwogO8nyQxODTNL7gZ2ByRpsj4p3tVq7CoCiLKddxTLa+h2La0OQHWB1WboNHksqMDdmi6TOP2YeR6qhwV69gjbVEDNxV2PF/cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065035; c=relaxed/simple;
	bh=kpvA9W/U1CMIz/g4uiqVfRbUJk1jTXt9giNYEcbpipg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FedU70l8gp5OrDAFrOO4miAMtrbMTSQBvKkcmMiz/yHBoRFnftAv1hueVWcxnkagLIjsAkGTzEStycn726sV0pxQ7bDXm0oENLO0nuOlSZ1PVo1EdP4zw5cD1dLJyAR04iPuw3rb1+b/auwY8f2jkuYGTmhH0p2zmOKIOGCc47o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRrJ2ray; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRrJ2ray"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-97e76cabd96so92985241.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789065028; x=1789669828; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=j4F16m40R+x7NxmxGktWXslQTjiwcw2sNNGf7yL2c5I=;
        b=QRrJ2rayTZUgWuMcyATp+aIuG0HdmdCTwMIkr8fPZkF5aFhua2qNmav11z8m4yZuWN
         Ogi9ziqtfNu9TvoPBwgnmVRtE+zDaoKtPg4JoAspTvAVIth8bl5Q0oHURRxI3ZVSXGBQ
         +af/DdikesiGaC7ZjgN2K0Yhezz/KXMeBNBE/kCCrhXfw2vgFtdIMGL2oOIvwFDBuKYx
         WnMs0L9ffAYPPfgz1CPw+uYNS0v1BPNG0BWWAhtcdcnThaT/mhbpZTJLTkbC49DPcwTd
         P2n1CvBZyfFbk1gnhCbsW0tziD/ztY+8OxPKgaa/HICZReMMV5lh9J20Fz3VVE10E7xz
         eFzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789065028; x=1789669828;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j4F16m40R+x7NxmxGktWXslQTjiwcw2sNNGf7yL2c5I=;
        b=BEVDdS4nhaJm3z4pf8YcELogKF4A7ELgGcAz7ahvRdYX8M38V94nmuhMfgHUP+52Ph
         RcDaQAvAzLqgLrIrjVUPRac9deUqOdPVqpHLTiv8mvxUqRZOqAT9trgrLoOcp8eOYXl0
         nN5ESlCxR8YkSyjAF1STqAw8wH3J1THIQlNA6JyZgu3SUNaftv7Q8ZMWgpj2rL9iDZIh
         4xGr9z1K0N3RbRMt8KHveDARCLcKvI3m+BCf+XCabQk2YUFhSvrrZcY+Bg3kzCq6Pk/k
         5uEBNE9rkA5xhRfIysrOFTtBZdwwi2rzDlTloeE/Qswy07z86MFd/u02W+3d4Jn9/ElZ
         gtcg==
X-Gm-Message-State: AFuF++naRoR6uq6ShlPeLy70kNlPgFrvLVAQNr6v1Ros+BavkNZA2qMX
	82x0avdRrS/qE1vfZotkqtpqh/sviHsPC5BcC4OQmRKkE4rpRBX6ax+krwD8eg==
X-Gm-Gg: AYBFou2RGabCocMkQt44voEMrwLdQaAZ4pHBAV3wtjiRj9xzxV0bN0Q6g3CfUoLAgdQ
	sgzGl3A6pHO65qoxsycr6/L0w1/wPKeJ5RE2ei81PSvwFYp22lGm7jdazmzbUbnfdeUqARGPsoV
	elOpFPPOWtB+iRxMrQdOVDdg/M2yRJF2f8Wf6Eeb5+umoJwcwQaAJFY7GAd6+/gyudqCC6Yrjk6
	J6GxVplWOx8yEa5gzXaf+kbjgH5lWBCQj8oXzUfzb3icFkc6fOqay/e6yq9P2g2fY9mjgxd8OJ0
	d/Sxgeu/ge6po+ACzxKauiPPSal68k11Dw+45UnVvySBB04QgnnDADSD6+/8O8+ckqgUk1Y2/De
	W6ZTVyGnUz3STAyT2A8vX3BmEHmb/NSyUf5WNqhQbAM2W6N/llwUuKhM6j+nHdQwfFwZN5ss18c
	8p4acSDPX4ykBfBdOa/qN2Pw/KkZPmWmBkeK3IxYVczqbuYGY0xji4bXEqN1SGSrJbpeXmSPK4g
	JvwkA==
X-Received: by 2002:a05:6102:8683:10b0:785:eb33:8794 with SMTP id ada2fe7eead31-792a96a8ae6mr885921137.10.1789065027522;
        Thu, 10 Sep 2026 11:30:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.119.41.203])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4787eesm2127116d6.21.2026.09.10.11.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:30:23 -0700 (PDT)
Message-ID: <6aa2f73f.ffb7a56b.175ec9.e20b@mx.google.com>
Date: Thu, 10 Sep 2026 11:30:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6978927714862920212=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zuohongsheng@kylinos.cn
Subject: RE: [v3] gatt-server: Fix integer overflow and 3 CI VLA wanings
In-Reply-To: <20260821104213.131920-1-zuohongsheng@kylinos.cn>
References: <20260821104213.131920-1-zuohongsheng@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6978927714862920212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1149710/

---Test result---

Test Summary:
CheckPatch                    PASS      0.49 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      19.99 seconds
BluezMake                     PASS      380.68 seconds
MakeCheck                     PASS      1.03 seconds
MakeDistcheck                 PASS      143.04 seconds
CheckValgrind                 PASS      155.70 seconds
CheckSmatch                   PASS      299.00 seconds
bluezmakeextell               PASS      97.45 seconds
IncrementalBuild              PASS      407.23 seconds
ScanBuild                     PASS      1160.13 seconds



https://github.com/bluez/bluez/pull/2514

---
Regards,
Linux Bluetooth


--===============6978927714862920212==--
