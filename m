Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C42547ECFB
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 17:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787248355; cv=pass; b=G9VciRrrr21hUe0bEd8ZxuCiOQOpdDVhL7UH54iu6BlfX1TFwCAlDFeTBjApbFK//4hf1/cCgoOyTjgsSB3OXCVDkciXkdufsZV+5K1+Cb+WEep6uQzImvWhSdUnHz0FNZIv2Of7imlc5vce4d6TNIizsG/CECYCY4OH1oDGtwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787248355; c=relaxed/simple;
	bh=F+lriP63UGpT0RnCU0Bf5LtqnK68x2rsQLoxMjSXyGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T0Y3YRxvag9QDkVXgy3ZHqXr4u4iDDRR4kC8+8Z/TavEJpzG/hLmpUnKXRlye9xb1t96zc2JVmnTVZg7QVizuB+llBVhG9MjKQW08OSRZd8djBNNI6GhN3eCnDjnwTNvemp8EiTiiw3HKWaQlX3lsJc6/hhud3829LpxwijxVnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at; spf=pass smtp.mailfrom=irregular.at; dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b=DoAqXxbl; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irregular.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b="DoAqXxbl"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-836cde02992so2297477b3.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 10:52:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787248352; cv=none;
        d=google.com; s=arc-20260327;
        b=T2PaL2in5Vlpwdq3lyWzcC3t9olAP0Pout5jRuTMTz3OzeCD2Lk6xVnRCa1lY9qsSC
         SUZ39ZhoXY89oGA29CMTzSeXhBrrM9O0RWm9ettheXtoHU+r+8LgaTn978UsYQrdEpvu
         Le2+/ivi+0pytyaoc/faN2Bpt/aOV4I59mbsWGCC80gMAv81kSJ8I2eFdPP/pufzgwid
         uqqeEDJv1ypQGtXLOl1iAObLVnM9Odn28gnf9fLtl5Et5M93/vtoju0elP4rp4+H/BS1
         F1adPw2mK3Zcm8W3pYFkgXzYt37gFjiMaPU4zKztgJ2z3sNXvbUkMmoLfEiKnzQmaU56
         GKgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VG98eHCypGPFRnDp4s+5BVnx7ftuu/kh9EWoKuRUhjk=;
        fh=DBIRJP4DvnAE+M31BcQ50XI3CAn/idN52/MNTtsfw9E=;
        b=PouaPLrHT89tOL5hjjAd+BZe/sniHOeYaEgMxsVWp/l2L11wXBToKav3iXYy5OEjK3
         ZS/F3JJqvT5FxpHBK4+PDNxBnFBmHpyJHkX7yoYLPZd2zsH1AUaScxems6RxmrAodhIC
         mRP7sE4XHo8wn43dYroH00P7r8kCHBU9SIBQy3bDQ6jXhUqWye3Cw8DiWg0bXGudmyNT
         l0j9CJRFy9EDfB1jIUVec42YDIDy37WQtyUfNFIKajeoy0HAkhkgzf63cWCntNO9UmOn
         k+QFlf0IklW1FsDrfwQ/HdGd6g4+RtA9DC0232qn6hoGio7hn2Z1++KvYzdAXJzF6uTF
         t2CQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=irregular.at; s=google; t=1787248352; x=1787853152; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VG98eHCypGPFRnDp4s+5BVnx7ftuu/kh9EWoKuRUhjk=;
        b=DoAqXxbl8DJw/ByAnwUEh67O247W4mP51M/YnuQmjzbfeJgs3x6aY6U0e8GGM5xpCl
         iG3+kt3Ovuf2XnI3PkQcayaMAKVGw8HxPoMvuLfiK5UtHcBTWm5MtHFFIB/BPhKXtOn4
         fwNEqJqdevTSkNmS0D6ehsegcYklauEWYCaNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787248352; x=1787853152;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VG98eHCypGPFRnDp4s+5BVnx7ftuu/kh9EWoKuRUhjk=;
        b=Dr2uatJdzBtK2HMAPqy7/VFS4tLD2B9jq7TDeQvFwnkt0xMK6KFCTyvyk3vEUM6D8+
         EX+WyslFF3LJAhY7dPp72H6SJHPEznfjy2XZeZnx3auolGsv4mzUcPPkMmD6Gr4czx7p
         XHbPQVrev9H+Nq1IAEt6OoGl+2GRIUkDMohSEvQRxDhuXZwDERKKhP40V9kOSkFY+w/O
         22dP0Vm1edBDpK0RaUPVJyPeFv3DL8tr0G+LmMEfEFTms0tOGYMSk3AGlteuciRiuZVW
         xIBr3ZSB99GGOwJDm2qEn5+1SqZoDXYFp5jwQ7o+lm/SsRMYrgPKeQRlXZ1+0GTFkLUa
         sRlA==
X-Gm-Message-State: AFuF++mi9vyeVpIg97SaMczREdBs3Hgbsyydfp2s5G+5LiCcvqp7vGd/
	upLiCLfOFl7qjcu9/7HGncTICynoUIFAkKVi8IRBLcZiPJD12zZZ2CHqctUdNYotSIMgV+ROdXp
	8uPh7/IjNBhzUwgkQEfvjF3uPnGTBfq6JQ0cetdDQoA==
X-Gm-Gg: AR+sD12smsx0vCVLxYsvNKLjjSFB9b58+B+DOtlEns8UpVrEvF6JQkGMRMaCfga/BW+
	NfD0cNwaY5+lOU/u0vNePbl8l+L4ADKmnDVC/UlUBsp5lEkypPkJrIZwz51qHWzEZBhcA+fVfwP
	KaJFAmo6Fp/uWMvD/9s0PamQWuwjNYrmQWf6kCMGo8kDVEOpQTZGCfnzGuBPmUVQNT/F87wVSAX
	b7bK+Fs1Mdj4wRqcJkRqfZpAYlzn7L24EG4kY4W8Prtw7QEVWDRmQU318X5fqsbkE+a+ObkBZ2B
	acmVVB50B0mVwqdQogg9Xtgg/qnYAhrrUjEeKjh8os7wpjbRpP3R1c8PhKhWiEOJ+tGhGNhwI+D
	JoGqud+d9b0eZAR277VIAgeNM4dmqF3MjDtFaVJTSijp8KZ+/Cwzm5aPijKnnYHJf9aqykbUk4H
	Q7F0o4CwjUjLvK4x9yw3XI
X-Received: by 2002:a05:690c:e1d6:10b0:836:e0bf:e86e with SMTP id
 00721157ae682-849f3dc1068mr437267b3.13.1787248352314; Thu, 20 Aug 2026
 10:52:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819223144.82045-1-m.kurz@irregular.at> <4131b2bc92a81467d11ce8bdf8748ace7e146514.camel@hadess.net>
In-Reply-To: <4131b2bc92a81467d11ce8bdf8748ace7e146514.camel@hadess.net>
From: Matthias Kurz <m.kurz@irregular.at>
Date: Thu, 20 Aug 2026 19:52:20 +0200
X-Gm-Features: AcwNN1UbgQbVY_dhW9JwVkZPofHB2iMUagdJNxTGRWiUW62YNK8vGt7bqlYc-l8
Message-ID: <CAO=2mx4Vaj2E=Kzf7MY=SeOBvdApmggL9kEyudein2WeE1xMzg@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/4] Add component batteries and Fast Pair Message Stream
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Bastien,

Thanks for the review.

Existing UPower releases continue to use org.bluez.Battery1 on the
Device1 object path. This series does not change that aggregate object's
API or behaviour. The component objects and their new properties are
experimental.

With experimental BlueZ enabled, current UPower does not understand the
child Battery1 objects. It may log a coldplug warning because it expects
Device1 on the same path, and then ignores that component. The existing
aggregate battery remains available, so this does not regress the
currently displayed value.

I have working UPower support for the component objects here:

https://gitlab.freedesktop.org/mkurz/upower/-/commits/fastpair-multi-battery

The branch is currently based on:

https://gitlab.freedesktop.org/upower/upower/-/merge_requests/337

It creates one UPower device for every component, handles optional and
invalidated Percentage and Charging properties, and falls back to the
aggregate battery when no components are present. It extends UPower's
python-dbusmock-based BlueZ integration tests. I have not opened an
UPower MR yet while the BlueZ API is still under review.

The object layout observed with Pixel Buds Pro was, with the address
anonymised:

  /org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF/battery_left
  /org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF/battery_right
  /org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF/battery_case

Each child implements org.bluez.Battery1. A GetAll snapshot was:

  battery_left:
    Percentage = 92
    Source = "Fast Pair Message Stream"
    Device = /org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF
    Identifier = "left"
    Charging = false

  battery_right:
    Percentage = 90
    Source = "Fast Pair Message Stream"
    Device = /org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF
    Identifier = "right"
    Charging = false

  battery_case:
    Source = "Fast Pair Message Stream"
    Device = /org/bluez/hci0/dev_AA_BB_CC_DD_EE_FF
    Identifier = "case"
    Charging = false

Percentage was absent from the case object because its reported level was
unknown. I will include this layout in the v2 cover letter so consumers
can reproduce it with python-dbusmock.

For v2 I have also moved the Message Stream layout, battery masks,
sentinels and component indexes into the shared header used by the C
unit test. The Python diagnostic tool uses corresponding named
constants.

unit/test-fastpair contains seven cases covering complete, fragmented,
coalesced/partial, zero-length and maximum-length frames, invalid input,
and the battery decoding rules. GCC/gcov reports 100% line coverage
(55/55 lines) and 95.83% branch-direction coverage (46/48 outcomes) for
profiles/fastpair/message-stream.c. I also added test-fastpair to
doc/test-coverage.txt. The complete BlueZ make check suite passes all
40 test programs.

The daemon/profile lifecycle and D-Bus integration are not fully
unit-covered, but were exercised under ASan with real Pixel Buds Pro
hardware.

I also tested the complete path through patched BlueZ, UPower, Solid,
PowerDevil, BlueZQt and BlueDevil. KDE Plasma's Power & Battery applet
displayed separate left, right and case batteries, including an unknown
case level, and the Bluetooth applet displayed all three components.

The related independent KDE changes are:

https://invent.kde.org/frameworks/solid/-/merge_requests/264
https://invent.kde.org/plasma/powerdevil/-/merge_requests/666

The BlueZQt and BlueDevil component-display changes remain local while
the BlueZ component API is under review.

Regards,
Matthias
