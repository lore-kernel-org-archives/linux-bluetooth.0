Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795387822;
	b=R9hI4782nbyLNTBWOmLYaKHnNN2boBULvIm/qZWejgWxId0KoeCbu6f78jjRdzYLqPYX
	 WZ/kkL5HM2QCYXUaJRyP7lb1qxmxh/J510Wdw1F6dnhHd3xvOEHeJ+PUyqim4SvNNggBw
	 abq0E7FmipwUA4cBVQNp8X7LEUrIX2E9ORknc3PoS1DcMTe1RiKODxY2kLy21YiR/fUt1
	 EYJ4Px979QKPrsp15nM/br3A7L/w2axAddTu9sVMms8f2+ovJVhK6F4SisccWCrjln79/
	 bzH0BMwciAmt6F59clZGKSdqMV4vFRRLdvotWe/TqprYyKqusI6uj+OiGGAgf3gBcfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795387822;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=Gy8bi1GgCThc+IjA1uxqwHSqWF06clSBp6miYTYTRGI=;
	b=iVq/6dYno7tquHiqUHZHxmtuvo1e+l3/t1rknwG23OVOSB1Dz4mUq23q/YGbKmNVoyr7
	 oaPhaxIXIKay4/vD4h6Xx3ZUlHiV7SJmpiGYDdcvrtrsXzF//cAFaKDDeW/kQK34XmPzG
	 hjnolaMm5hXkkxoXA7cqQtGz7GLwnN4VWjUNMLzj5OQi9DNn/wUB8GRsI0LAgXtpgtBkx
	 XBkRJ2udtkdFCSOtKg33kHPECe/ePG+76iVI1MfMWeKAsgF0BHxM6FXKF0zdi8755gjSR
	 7WhqNTFgc/CFHA5vOESZC6+QBm8kZQRH7+FE0wo7AgzWwxt0y2jtyKT65SPsR/kWVGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oSA4NghE;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACF0606A31A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 22:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ACF0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oSA4NghE
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-8629c7cc36eso1583389a34.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 14:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795387821; x=1795992621; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Gy8bi1GgCThc+IjA1uxqwHSqWF06clSBp6miYTYTRGI=;
        b=oSA4NghEK3+w8F942g3DX366FARB+nmcueVPlRmT9Cl6Tzsnre/EEp9Kakkprfp1kY
         sbcbrQs/uU8cfIY2D4ZVln32OdGNdV8t/KbOJ96mphq8I118rEcjH1DS6YEC8SKszt5r
         jmrKpZA/80Be0Z4anfRRqExTVJDU/6zQs4Xt8LBnY0bo3LyEJ5ELbYs7zRwO83gMok8B
         ElAx899iFOX0SzjMUzWeJikb5CZyVsN+RiwFaXTmd9q6VNw+WiLT1cBcnSO5VMiOK4+x
         i6wV8hrTsJzI73fLVgpl0U/tZe/7seS9r9Qkgns9rd2x3pLpKchlEMef4XXMwApXXuU5
         Cl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795387821; x=1795992621;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Gy8bi1GgCThc+IjA1uxqwHSqWF06clSBp6miYTYTRGI=;
        b=zAdwJ5wbKrcpYiL6T/agyOY6Ov6nGJxv/yeagSdPk9Hxa4BL8dym60eYxnCcsPin1u
         eOhETiMuf78nLRRGS5HnmAXKLRbSei7mW9gSy5qZXldWmV57rbx7MJvCa8GNPMP2OOcx
         4ghPYEYelqu2RqUYMOoH5hGY2PjzrNLOcDe9DVHPWRO4Wr1M43jBWNrNSIwdesyNNC7P
         MMQk2paTHvadNGhcv6boZscnfxOtmDyjSUq+Q41ggOO6Hy2DgnFxCDbdOJnBf3mRYflR
         uVjyfN8YsgH8VIVMhXThIRO3Q7cTnQAI889lK/DjepjsQ7l+lUbwyP7+xQ9oqRPo0SKK
         JgXg==
X-Gm-Message-State: APuU4Z+8lxRgFiVOlO5BMmUqvOj7hxaD5s7vOatXM1lcJUSzKdokK3Aj
	X3M6Gn8TO+K3IDlE4TBjh22KC/+b2bP0zL7tN5px4C9VCkGDQ31ak9xjZOlOqHID9tE=
X-Gm-Gg: AZFdTZedfg6B/a+JmC7Kl0NvXh4MfXj8WIB4utufVmWGZWN9r0Yl7YdiK+8SiYn+G2m
	locw+ARC0rdk3MZ8qLcRICpki+kSxbO2r3dUwae8gs8nkhtncnnOIXYBL+ABxI/LG36smRBrKmp
	I1glyl1ZHajnrA6l0SvLd6U0UO/CxxdnKOkdGQUMnl1lzkb+lDM897RJZuBiuVQKWqm0eQ7Hkge
	TXBRuGeH7gx97Vjy6+MzlLE0Usv0CC9rh9Yz/cO5jCzPtQeSJGp2nYxqy2QCIEe7KqM9Usjt8Aq
	ZJCHTyVrrMCpvYCmarCzqzkZNNHcfQUMTUFM0Wt1mwPEO0nCTukaoPSWKJA3Mb5B6uarbitA+Zp
	DxFz+/bDfaex67S6nKp25eVqrFsg7VVmvxxGyud4WvS/7QOi1VBvY0bZ+y9Q3L0dSDdtj3sTgX4
	g54YETOKLP6zA1+F+HXcSmvC0KNc739+/IG7u5ucht5/6jlLQuHa4V09syepbtnvT2y8La15gdi
	xv+9uWJrU9/Siow4NF+0WKr91MZfw1eoOBPaeMOjwxNb2/vFfZOQPAK5e9JgVO85qkHOLhYKL42
	fuuBVJ4=
X-Received: by 2002:a05:6830:4487:b0:85c:4897:f2ff with SMTP id 46e09a7af769-863159b1ebamr10168771a34.25.1795387821452;
        Sun, 22 Nov 2026 14:50:21 -0800 (PST)
Received: from [172.17.0.2] ([9.234.23.160])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863169105b7sm7647846a34.22.2026.11.22.14.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 14:50:21 -0800 (PST)
Message-ID: <6b0371ad.ab442ca8.2c1f56.6229@mx.google.com>
Date: Sun, 22 Nov 2026 14:50:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0054738122810894411=="
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
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: Bluetooth: hci_sync: Sync to an RPA broadcaster without its IRK
In-Reply-To: <20261122201333.2853192-1-simon.mikuda@streamunlimited.com>
References: <20261122201333.2853192-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0054738122810894411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218949/

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      24.76 seconds
CheckAllWarning               PASS      28.36 seconds
CheckSparse                   PASS      29.69 seconds
BuildKernel32                 PASS      24.72 seconds
CheckKernelLLVM               PASS      24.63 seconds
TestRunnerSetup               PASS      584.80 seconds
TestRunner_l2cap-tester       PASS      15.48 seconds
TestRunner_iso-tester         PASS      13.71 seconds
TestRunner_bnep-tester        PASS      2.89 seconds
TestRunner_mgmt-tester        PASS      85.66 seconds
TestRunner_rfcomm-tester      PASS      4.13 seconds
TestRunner_sco-tester         PASS      5.19 seconds
TestRunner_ioctl-tester       PASS      4.27 seconds
TestRunner_mesh-tester        PASS      4.18 seconds
TestRunner_smp-tester         PASS      4.04 seconds
TestRunner_userchan-tester    PASS      2.95 seconds
TestRunner_6lowpan-tester     PASS      4.11 seconds
IncrementalBuild              PASS      22.65 seconds



https://github.com/bluez/bluetooth-next/pull/1194

---
Regards,
Linux Bluetooth


--===============0054738122810894411==--
