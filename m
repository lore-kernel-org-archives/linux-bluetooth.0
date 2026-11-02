Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793647545;
	b=ychFQ6lnYzJORtdvRpxWITXAQ8TsI0upPAqMlPzimq26Vb5NIJbE23HhP2d3na3Ztb7s
	 JGCDx5rqX2PbtuTAoKyzm00y8XIpP/g3WM8l6irPeF2eF6daMbyhzQR1/m/z/q8OWDEDc
	 Jkb+iGTH3WY5jSM3VWCWIAnrE+y1x4Uk4uXf+jiE5YNcFyuowfpD/Kh9oFW5d37fwt5Ea
	 5gUP613yvPwDwqbkVYzwTVFBwGG73BI6vxkVeVmzm5Xic2UjLhUeteM//ogAZYHyABmgO
	 Lbwc0cwb8YH1ZiQjyhoiTZCmrzetkNQ3xhq2d2DSvs2oYZijN6bGRMj4aXJXNKwZqyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647545;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=6w6sn5JYAGmxUi8RE3njYRVgf8/GJ6F/YPK9DkLAad8=;
	b=4jUFL+TBe/btjNlK0qUY5iljrppbMq9b7pZjuXXdC2yZuORbOqUjCClEUg4KY0MrLFGf
	 /4blqEHmkuyPby+Mbv92UyoD212O/A3ImChEE1dP3bO5tv8YjCEueN6hBf0gZjBc/Zawc
	 vhgsQ5BSy8pRnMXBplxikPaPbwv6vSOFD0rQh/Pmd/+ded4XskkGlOBop9S81nRb1Lu7w
	 2pwEhK3Q3j2B+iEll7tit/3zx+7mv/gL4GbjQiGzv0D7hS2lN+gzMueySJBW1NPpc1apj
	 fUQD6oQvwDQPQSStdamPSmkSt9tzLdshDynPLtMN30HegmfXGRi3q85Hdo24dLhTipg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bigVPW5i;
	arc=none smtp.remote-ip=209.85.160.41
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E05606A326
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 19:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48E05606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bigVPW5i
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-48ed188ee81so1724850fac.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 11:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793647544; x=1794252344; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6w6sn5JYAGmxUi8RE3njYRVgf8/GJ6F/YPK9DkLAad8=;
        b=bigVPW5iLet0xQ7uk2d0Wu1/HB4lFkUfUNIfk+fMahB/iD818onvfBpaC4xqhPutk3
         lVKVHNgP1fl9Y1aHaFu0x+dEm9hJZjzFjlfekz9D2Y14OztFoHWb6dYcK/DncTaPGcT3
         L9KA5SYaedT3EOpnyF5y3XcLsKmDXKOAE0GKvnMXP6CRwYesQ9D5XgzE87DbHnSX5ytD
         rJba7Rk9F7rbF8+67N0WcSum6u3IZTEI6yrrgC/7OzPMoaZ/pa+jX/VewCqSPEiOoAyy
         4ZFYqsUpwyOPeXSIK9ceFKhxp+rUz/JFFtWF1th0QRciVv9SZadCmQsbrlqI3KTkNyiS
         e7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793647544; x=1794252344;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6w6sn5JYAGmxUi8RE3njYRVgf8/GJ6F/YPK9DkLAad8=;
        b=VK7aHy1+YpAWRlxeUccT6/Sxk9QSpiWFC8RnPu3PWWAxu6+GOGJmKS1VV1JB0yM6gb
         MUcXtKsVDhc+zuoGHUdTx4kUnIRwEbD9soG0thLVdbD/KzwenUw3EPBOEEB6kpTuRpdE
         fCQAr6AMBXtEcFWUlqAl4YCYHLuesv4y1kD/O9h523a3nm8MCkiICFe9vm0tzhKA8VFx
         C7OCGbzcDcdXC9wNmIPe774qX2apKJrB0Ew072uOOWjEj0dl4cxwSBX+P8UJTbHaljwS
         Fo51l+SEzc5ZXyP1B5McjuCpJRTbXFyVHytg1+hRKPmkNgkEOLnfGo0FkyJqdtlHoSsU
         D1pw==
X-Gm-Message-State: AFq9FYKflppcpMOqZM7CqhrctZDtl363rYEN5RhbxZN7egTsbYUb/Wz/
	t7F5lbTnbE/C56DH4siQzra1bYB0wGzXFnTBUbbSyWAFD0UCZfoD9xim2Vjxqg==
X-Gm-Gg: AYBFou38Hr8ZTQIdW13tZm/WaJzhACDLfuyI2Q1mvsrVz0B+xPPTsKjtxMs49YyB9+w
	Weoi8KB0QKR3la7TLF4d8Tq3/UOsdlgFjIIcf3ouNeTXVQfeEOtC8MH3fSv2HX0k/1ywVRooQLp
	Ou/rALU4tHNkoJGMY4z2oD+CXgAYA5uYeCjc/vd/TWJcuJz1eXreYtHQ+Zhd+AjVpphS+Y6ZH6v
	Jxit6+6tYMOT0V0w2MTgyK+JpW+vaDfHAOUY1t6zqFnEnFNuue0eTXo/2Alj20pt2+FA5chOVV3
	ElVlNSib4h4+WBcZSYojXdVkf/ldlxNyy+Z2cIjFYMyruzMJ55hIX4OCaLTsH0GEPVK430iccEw
	g2xgbnoEu6AwqjO9xxn7W1vJNJh6HwTjd3aq/RFthBVb/XHq50+DptqBh4P0dr6m62tjs0+8KRH
	Sd82AXgrxnuHLuRTgO4+qYjKh3cN1t0lxNmnpeic323BoopBmIBUKXMZqfHxcMW8aCDfAdHbEaB
	XI61GGp4Hf/AUKPE4VvkWfMwwA64xp7y2HGswQ8uxe6SWFxgt/QUnuwoqaspEFiJ7VJW4nWclFM
	aQVXID0BBA==
X-Received: by 2002:a05:6871:470f:b0:44c:5514:4e7b with SMTP id 586e51a60fabf-4a9072fbaeemr7095024fac.2.1793647544111;
        Mon, 02 Nov 2026 11:25:44 -0800 (PST)
Received: from [172.17.0.2] ([132.196.84.238])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a9219f2d77sm7098438fac.13.2026.11.02.11.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:25:43 -0800 (PST)
Message-ID: <6ae8e3b7.318e7587.2a4e66.bdee@mx.google.com>
Date: Mon, 02 Nov 2026 11:25:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0995662690331111015=="
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
To: linux-bluetooth@vger.kernel.org, aluvala.sai.teja@intel.com
Subject: RE: Bluetooth: btintel_pcie: debug INI rework and fatal error injection
In-Reply-To: <20261102173730.2626329-2-aluvala.sai.teja@intel.com>
References: <20261102173730.2626329-2-aluvala.sai.teja@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0995662690331111015==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1199339/

---Test result---

Test Summary:
CheckPatch                    PASS      2.28 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      12.99 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      22.11 seconds
CheckAllWarning               PASS      24.47 seconds
CheckSparse                   PASS      26.05 seconds
BuildKernel32                 PASS      20.65 seconds
CheckKernelLLVM               PASS      22.09 seconds
TestRunnerSetup               PASS      466.78 seconds
IncrementalBuild              PASS      23.00 seconds



https://github.com/bluez/bluetooth-next/pull/1048

---
Regards,
Linux Bluetooth


--===============0995662690331111015==--
