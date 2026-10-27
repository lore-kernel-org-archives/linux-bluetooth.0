Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793132206;
	b=IA8dFBdK0LleTC3VrNo/urO/vjj8XqltPQkz2IRisAt4nYoNJj5nvnkzYS63kLKyA1Ov
	 uUch0vc7vhIjVK5Knc4/vFQjDmOAGjyxp+vx7+pBgJpAm21PaH6oQpeLJyAiwYi4gCcbU
	 5KTxrB6tgdan2Nu3LShI1XULZMOTuPkglt3IQOSyaLbGib7YvasXdIMrydATbCQerwk+q
	 Kht/BwJF8qu8Plw8VJwtXrOQVuc1vrmBvxlLyov++PORkqjxriwSJSztgXUntI43nkmCN
	 gkk/GIlC0cyXGjTxDbs03uFtjgv8hkQxlH+T2qhzEiNcVfJ7ycwhzOEip9diqRog8+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132206;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=+efvmZnvzsK14Fbmq2c0w9l335DOeDaN3q4hQQpSLHE=;
	b=MoBelusLSJQ1+n4R+oYn9Zz20UcpeqvXXC5RVd2r6GFr9/64uUyl2WCHY2YvQyQdYWYt
	 IygMl7cfU9P52gHe4Nz7tJPXVKBL8sMi8v7AHwsyXOhLovdGv4um8/SLpWcKRHQISISak
	 oyLUi1GXXsi0Rr2IUMpRM7NkakEVLqJU9AEwJfdISxjohY/dTtio0vggLFPWCYepx3h+S
	 B+7ZT378/66f/ybyBJ7fIlkmcrYuZ2Cvzp/4/oZrkQabgGveow6mNOy1jlolAp6vuVkLF
	 tl86LM3P1fyEBUqVAKQo2XkrxwweXDIpYNCyGWLSYm/j25WCBmiKO8pu0xVl0QicvGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=drV7cDHD;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B90606A31A
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 20:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16B90606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=drV7cDHD
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso480378eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 13:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793132205; x=1793737005; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+efvmZnvzsK14Fbmq2c0w9l335DOeDaN3q4hQQpSLHE=;
        b=drV7cDHDqWZVkewyidrX4Nx5x4NE4Y7gks1pRghXKwtLA6bKdIHVlFfnjUxoWHli50
         4rAswbNRg2WCv/yUe7oXC/wXggPhV45bhDq1Q4jQYuUBAbUrOXRhktAtzv4eXvOBL3iD
         8rU8Yjx5dQkyH4r0pMjQPMkvEvLYU+KKcfqcAxaHUiDLpQecVjXg6N+GzHhKo/Lldtwj
         eAzydr3XZdHFKr17TtMPNq+lwIOSBErKgpagyHJwQsdJrR/P1ipk78TNs9yfvVtpQSWA
         ZE26tcIXSUsRKs4WdNaBqBCIZz6Ta2oKZkIdAnx4fXgCObPBDwT/4Rc/Qg2TmMoWZmLk
         57wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793132205; x=1793737005;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+efvmZnvzsK14Fbmq2c0w9l335DOeDaN3q4hQQpSLHE=;
        b=xd5T6I1SgKtZWtITzKVJ2C444dSZnwqvYG9t9KRHMFedKPmab2A2XfKsawF5HL5I1h
         Ppgmya7dTwQ2xngVPJKoGZ2O6AL9AO42TWBAh0UfTnLgFP4h2BVxKn1H/z4n8b0ZHyOe
         5xZiWPWzVXbeXQBo20zouy9XQzYH+o2NTnNWhiMh/3fnLXGTdK2S1eWk31L4FCjBZ7zp
         2+vJ0+Lv4m3jXcuzCRoiOaZJdxU+UvMJk/zaiQw7o6dguYTGHN1KRjU+3hq0BSgMwaG0
         fBXIh2+B52h++rZBmXclDIYTJrYpSZaVjuOjYEHc1dTWO3BcJ0M1e1q+mv6CU19c9suj
         SQIQ==
X-Gm-Message-State: AFq9FYI/SxLNhHZpSfCiNFrcZT9Huaaw9lLSUvc5xZiOPeZg7uIPC2vo
	UKekfOTL6/S+F4r+iA02OMOX9A9lqbIe9H8NmMECgVEsGz0Zcjj5yXNZPdmpZw==
X-Gm-Gg: AYBFou3G9HGuD4kGwjwuIYULdiniHIrMW72q36k8tlxT7I+HH2lzHWGgV2Kuttn0oGo
	mTlxZulQJL3Eop0bITVPPV2ISkL9OKO6n9iIM+INNNWlZRlqTXFpmXuyLIsje71zLps/yvsoTR8
	//QyHzoeQT6HXsOPWkYjqd95Ngig51MJQEJWVhfpNM8VuK8N5bCvw0b7jtT0drrtojVoaWPlQqO
	4l5o3nSG5FhIrxkx1Br6ibl0HXPMK7nt1ztG6ZYszuNInW/Dy5WBVV+fcukK7zIzLXWwkFkD13s
	hNJcrv2SS09g0E2ihNhr0qCB6+fyNqR5ahGAwLFF4sHkH7GWD2iVQA2UE/uY43/Wy2+t8DJUR/5
	ZHCLBw/WWKg+P2vWM1H7bO3RVJW9p0lD1BS73/GwNqc3azo44LXlVHjPnYRZTaFgNlWllOZOPh+
	IITWQHLDG1drsE20MLN2zqM/bAVHaon9FGtJfORcVDTONN6R5laGCq5IqCGLHM6oiVu1/zluddF
	cOwbO2z8BXu8DOmkSvvhCj+dSqyWp3+pcD3R9roNtf4Gb6ltNWbL0vbrPhng58=
X-Received: by 2002:a05:693c:62d2:b0:368:40c6:3a01 with SMTP id 5a478bee46e88-36a1ffc5574mr890282eec.2.1793132205104;
        Tue, 27 Oct 2026 13:16:45 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.101.185])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a14383b02sm9363457eec.14.2026.10.27.13.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 13:16:44 -0700 (PDT)
Message-ID: <6ae106ac.f2313814.61d9d.c411@mx.google.com>
Date: Tue, 27 Oct 2026 13:16:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5950158586238967200=="
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
To: linux-bluetooth@vger.kernel.org, yaroslav.voytovych@gmail.com
Subject: RE: [BlueZ] tools/sco-tester: Add SCO reconnect tests
In-Reply-To: <20261027165059.2402360-1-yaroslav.voytovych@gmail.com>
References: <20261027165059.2402360-1-yaroslav.voytovych@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5950158586238967200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1194814/

---Test result---

Test Summary:
CheckPatch                    PASS      0.72 seconds
GitLint                       PASS      0.25 seconds
BuildEll                      PASS      17.30 seconds
BluezMake                     PASS      236.13 seconds
CheckSmatch                   WARNING   224.68 seconds
bluezmakeextell               PASS      75.25 seconds
TestFunctional                PASS      958.60 seconds
IncrementalBuild              PASS      228.24 seconds
ScanBuild                     PASS      822.15 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
tools/sco-tester.c: note: in included file:./lib/bluetooth/bluetooth.h:232:15: warning: array of flexible structures./lib/bluetooth/bluetooth.h:237:31: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2724

---
Regards,
Linux Bluetooth


--===============5950158586238967200==--
