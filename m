Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795484375;
	b=Uo73EAltyU/dBX4WmkdJjGQmp3Uaao6BgaR+lRu7lMVhOv2xlMtbqbW4M1Ec1LbierG8
	 cJyp/iTKeC7LDSO8962em35dGkBHPkWla2Cc5yDuR4e/hPVMMGKrDg1lDuOpK3hcVN8r5
	 WoxkDa8ig8e3GvK/4trbVFJ5gpydE0cNs1tUGgYkvK7sqcEF/7wmd/5NXx/4e2YXgvpVf
	 MdJ6rK2XETICPqjMYYOAT6Y9k9DDKh+Kzx94skaVFSvAfdb8YV/YsxMERrI9TvPJFW7mX
	 Fj8kLvgfvlm1DgK0bFFCr62KVMP/zKc+9+sJGCi9IH4EFq/9pylKnZdu96grqrxIkBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795484375;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=e3v67bPhlLbZsnoKZe7e5txVSRzl+UNsC+FidbeelYM=;
	b=ig239EJSC+W7UbIQsqCsYYK61bP8j4iWQiERyGEqOuu07C2/R7+uZZ72ns+Tm+Wle/Oq
	 aJPdLvoKe/+nUe38L/mLG0MtKlW2Hn4SEtoQ+u0aRV30nCN5ogb/hVU0Vo8b9QBqP1uZN
	 087OLfLC6yuf76G7dWrkGu0Tw8xr7KrZin08BFM/Bm6cSYroNgRlIEVbc8kFawtEiYAIT
	 SMlg/4WXEWJWCIf+BFosanuU0VKlB21j9+Sba4vZgGgxqNRFSsl5FswXldoUzzHTWLVCm
	 cMiZc5/RAXBjrYhZXTjrLVLPduyOpwZp4+yIhpc+7Rlw+PPfhI2rMb/8Df7c+DeDK0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mdHcZPK1;
	arc=none smtp.remote-ip=209.85.161.53
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50AA606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 01:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E50AA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mdHcZPK1
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-71b0d330acfso2990556eaf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 17:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795484374; x=1796089174; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=e3v67bPhlLbZsnoKZe7e5txVSRzl+UNsC+FidbeelYM=;
        b=mdHcZPK121xUupSehS4w7xT3vEcQUhJGdA3PDZjgp9k2h5H4CQXqivJqyKEtkgC4T2
         dYDeM6sjrSlVEoEG9PnhgbMfsWJAkUMPeXUDpVIZOqgPMVvygqx2Tpp4e0+F8ylEfYKz
         yw00luanF7qyd2MuDUJNHcHi6kt12Dp0yakaaMPucGG9n+UqKBo0U2P+i2GkfLsoJJSN
         JmZb2wGRHBPYdmvhiC4qLeGFWftqCFE3xRjUVsI9xSuHqGn+b34z2Z7djMpe+F4va/cJ
         rTw4PKCjf/liDBpMKxTEoMsZjhHbLQbbq2/ZUa4U+hbNCEN4ryTW1l8MdNg8Auow2rQH
         0QEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795484374; x=1796089174;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e3v67bPhlLbZsnoKZe7e5txVSRzl+UNsC+FidbeelYM=;
        b=u11BQn90E+FOaznxZgszZ7TgqyDAwHiXghskJMu9E1FJ93BgzTaqffG8VCwM2hvAPT
         eX9IosI8NQy0nSLi3Mf1juQ7k1ueM37rG5mwBLQX/M7Xu3dDZhRWjVC5dCnkDa2CioJc
         rLTZ0FoSQW8aDqMSt53Q+L/JxI+ufpMzrY8hN+5pDAMCe+3TW8kOe7zsrGVk93MlXUn2
         XPJ+DVC8DsaOuM3Zs8ImNn0Fko/QkWRrPtqqeYHDv2/tj0DwPrJvHPjn4f7JiyYZhTVx
         J9mSbIkowAr7/1mzDU8GnbaoQY5VEmG4mNpPKozv9xLwlEYXvNU/npHh+mdaRcyVAueX
         GYVw==
X-Gm-Message-State: APuU4Z+3UooAz9pvWKLiZ7F1/VOHU1hAqN68fU/dbn0muoALxO6qHuRE
	H0SY4UjqLnvqOdBWNMGiyt/5kTtKsNR3oAIxz1r/g0tqg6+QUBMBVKt5HRXCZ9Y+
X-Gm-Gg: AZFdTZecv4CP6JNDxJKQ2y7i+HFiFuffB9ER5hKn6XQjZPWGpA46pDRNjMMYRetIRmy
	qwgEfSjA7VZrr+a0vVHlvck6JagVv/jB7uRWFB6d01+PuKTYhMhdVg1bv6QNUVsqATuhkZMWAbT
	lgIinXiPRc4hz+T9ReMR25Ym8XcpbzTYmkZ5M0dai/xbZMRo86X5Nwvzgadv7UsXBrfGcF7xIlU
	txI9AIa7oW3Sal36w1xqrP99dHMrlycaOiBswwPLYCi3JMNXbubx+bikr+cZs5BoxwjzzzxhFDe
	BZzMY5Ch1KLQGcdwC/5COB3kUeZuIXHPixwjyjoDVAY3PvxWghWec0SzNWT9kZGsGIXxZjfncXg
	iRMV/XTlOJmPQCj10cI+lYJYL9NbBDuLEWPmc46VSMunAQvyrsIyOP/ailUD66v9W7VLoq9QgXI
	O0aTJH2JHo6h9Vu1Jbinc7SlB+E/hnRTguQ+b0pD4wfqK1mrDgd5McqLdLci09pvuhZ3wNnCs2H
	rddsktUzErqJuqKXTYtgFXIC6G4q1izIMwJHEsWlCYQI2pNNbPf3bw0JEmCTk8=
X-Received: by 2002:a05:6820:520b:b0:71a:de33:9235 with SMTP id 006d021491bc7-71b3960c7d4mr6390149eaf.42.1795484373866;
        Mon, 23 Nov 2026 17:39:33 -0800 (PST)
Received: from [172.17.0.2] ([20.98.135.152])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b380e5472sm8846223eaf.14.2026.11.23.17.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 17:39:33 -0800 (PST)
Message-ID: <6b04ead5.2feceb42.2a8e0f.1327@mx.google.com>
Date: Mon, 23 Nov 2026 17:39:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1397498940904375427=="
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
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: client/btpclient: Security Level reporting
In-Reply-To: <20261123153117.135583-2-frederic.danis@collabora.com>
References: <20261123153117.135583-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1397498940904375427==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1219788/

---Test result---

Test Summary:
CheckPatch                    PASS      1.05 seconds
GitLint                       FAIL      0.79 seconds
BuildEll                      PASS      14.55 seconds
BluezMake                     PASS      189.74 seconds
MakeCheck                     PASS      13.19 seconds
MakeDistcheck                 PASS      110.42 seconds
CheckValgrind                 PASS      248.65 seconds
CheckSmatch                   PASS      185.91 seconds
bluezmakeextell               PASS      61.42 seconds
TestFunctional                PASS      880.53 seconds
IncrementalBuild              PASS      186.63 seconds
ScanBuild                     PASS      606.65 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,1/3] device: Provide Security Level related props when supported by kernel

1: T1 Title exceeds max length (81>80): "[BlueZ,1/3] device: Provide Security Level related props when supported by kernel"


https://github.com/bluez/bluez/pull/2884

---
Regards,
Linux Bluetooth


--===============1397498940904375427==--
