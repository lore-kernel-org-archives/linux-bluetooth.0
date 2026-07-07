Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536B8364028
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 09:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416254; cv=none; b=pkSHRBAqff4dP7Wx+6GzWb1MQlhr+gcYiVSO+Bj1UA8LyWDO9tPNdhx87XRqP+Iq3Ekonbdxw7lFaQkokHPYq7RP3kQlr5ks5zUI+UCDs3k0YNvlM2dvSbvC2EwOsLmNpRL7pa+Feyn1KFctMLMUdIlm26hf53oNBHfxLiU66ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416254; c=relaxed/simple;
	bh=/HTk55SRNBub7u4AzPs0vswlJ5B2CVLAYBoySNI0Dc0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=j2c0Wlxngbs28hXj74XSesCGYo9pqHv8pBUr6JsdJ3zjoZcefzeFleWABCc8Y/LkH4xqCNcqV39Qn6qKzKKp3eNiTFSoIieCFwo9udjINwfne/oWzvm7UccEhqO8sH915uQr+7Qbq9/8xSnmedh+n0FJRcLPYJK+zpWCq0Rqgpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qHqx/Oru; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHqx/Oru"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8482074a000so1259879b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2026 02:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783416252; x=1784021052; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/IP+A/fCCrrwTCUOVCNAnxI00WOhNf2cBMm1jAP34zQ=;
        b=qHqx/OrugKijnOybgS8cJhFBhW+6gD1XaMJJ4T+aha4H1eP2bHMyZCuB7+hBanFKA5
         mDAI/+HJ/PUGxgaP+hnNj+loS+C7/cqN73iq1tsNRLpti7M5/fgjf5PiK0me3NLB4F1e
         n/GRSZ+t0lrjtHYhCtgYZ3b+Z5ES9USa3K1zC4UqLRd9+pJP1r5I4yT2qnTbUkeiK5Vo
         spoez/D7spJTppINPTs0QLM2usHND/mx7gKkutMN4TKmkE1hTuWp/0VQZe5R5CGbb+jE
         ayYgGjzTeAOzoNHMk1UkRXtR+KIifdKsu3vKaumsiFQtUVlzZZE4+MVl88q/YYP3zP8g
         Bsgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783416252; x=1784021052;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/IP+A/fCCrrwTCUOVCNAnxI00WOhNf2cBMm1jAP34zQ=;
        b=fMJ2IiApfeQQ7exnPCChlzai1fsFLP68Uoc9LK0tDsmgJ17MnvjRgw1UXS6DTxHZq4
         XqWY/pFUu25xR9NX3cz3oT72u9ZgBCiq7o9E/TbvVn8RZzayRaPzWdJTu3G3t7saeNRQ
         jBhKB9krJZLYWkQOjVYgRAdc7XYuIhQoUP9ZrXFSghTMOGqtbo2HSzGN1hSKC3Qnd6dN
         e09c3AGuZZef+VksKRqDHaGkdJB7yGWnwnNepU0CBxhOuazxLectBZImgpmH3GpVV/ZA
         rOrsMK8HC2Ut8PruRTjkCAqVAHs3benkPt9iDSiSvg0nKwgHeLMTIxMUT0BjIZfcK4yB
         UBRg==
X-Gm-Message-State: AOJu0YwUiQIrxhtrl0UH84z2Gi4CW4dB0x+nNDUhIIJcncZFi6PNQly2
	tWI2dHBD1eqyDF410b8PlRlRbipoj0q8TrjHbHPP/9vVlZxcykWSUWdQ75x2jA==
X-Gm-Gg: AfdE7ckm5NlZ0OWoOA4r3RzW29m8LB81dJtNfchjbGD+wH8l+Z2msOFWiDHn/fC02nA
	AoVx0v0aKrK+GEJomndUSYLnCB9+EYZ+aTtmeBXrdZWKMpQ9FZPfwYMY2gL+VLtaznoc9Uaae6z
	91469JnuC9TJckMQYZNc2wAN/k4RUII0FP8Ft5yy52FWHMkA3PFvcVHpOEJqQfbF5KfUi7ELpei
	4SOwslC/7bMqCUi9WxXZg1lB70PETr10qPapvpItxL/1v4E1Mmzbsa8YYrAuKvjmgnmlA4SLhSQ
	npyo9ShHcsefPrqDB1jiD/DguHzBYy/9zBv6wkeTp4xRcUTpOILw6mqyAc6fNsYbkvnmdPdxmkH
	IgIxiKQXvMkkMwNhzFe9vuI6wWEiNo3JYjV/auw3S/gS4t80wBdt1TwozJ6pmXCgGidBeulgryB
	eq5JYwGkum1Hxfz2tLevw3bGrgQZq2
X-Received: by 2002:a05:6a00:1816:b0:848:2f74:1d5f with SMTP id d2e1a72fcca58-8482f74208amr1844301b3a.69.1783416252466;
        Tue, 07 Jul 2026 02:24:12 -0700 (PDT)
Received: from [172.17.0.2] ([4.246.117.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b60571sm5103224b3a.9.2026.07.07.02.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:24:12 -0700 (PDT)
Message-ID: <6a4cc5bc.96731870.320808.04d2@mx.google.com>
Date: Tue, 07 Jul 2026 02:24:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1615799665775849242=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, rahul.samana@oss.qualcomm.com
Subject: RE: [v1] gobex: Fix use-after-free when cancelling SRM PUT transfer
In-Reply-To: <20260707063543.80320-1-rahul.samana@oss.qualcomm.com>
References: <20260707063543.80320-1-rahul.samana@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1615799665775849242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1122826

---Test result---

Test Summary:
CheckPatch                    PASS      0.26 seconds
GitLint                       PASS      0.17 seconds
BuildEll                      PASS      17.73 seconds
BluezMake                     PASS      606.95 seconds
MakeCheck                     PASS      2.51 seconds
MakeDistcheck                 PASS      140.04 seconds
CheckValgrind                 PASS      143.74 seconds
CheckSmatch                   PASS      263.18 seconds
bluezmakeextell               PASS      91.87 seconds
IncrementalBuild              PASS      622.59 seconds
ScanBuild                     PASS      834.49 seconds



https://github.com/bluez/bluez/pull/2275

---
Regards,
Linux Bluetooth


--===============1615799665775849242==--
