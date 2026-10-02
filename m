Received: from mail-oo2-f35.google.com (mail-oo2-f35.google.com [74.125.231.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E672923BD02
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 00:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790902398; cv=none; b=SGtqkvFO7p0p1ggDXqhX/7Po7xmuIHcIGZmCiXLcUaWQocjf26yJHDZt/ZzGERBkn9eIxQI8j207ryjZCYdzpzmV2Z0O71NYmYPdReeW/oyyz5GIctCAjuEzNLpebtsjZIf+yZ8Diwfe+xjPQRHhCtajAGu07/YwfZ3Tk/bAKNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790902398; c=relaxed/simple;
	bh=QLivXmT0Z3MC1dxMTm41nsgslJSHrOokG8jxk0m8iTw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Svjk+zk5y2VGQCUJpp58bgbNDamgsXAD06uiwzTwjVYVKQx14ErM1sLGDre26vCJTXDeaYpSvvJ7jtef9YsDTw9Ji0w/vNiPSZUmS/U1sO1E1UIk941FxrVi8h4/T5l45D8E6C89TgF4ANCJ98RwnULkriE3TbLKRah+R3BLGMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXfUFl9C; arc=none smtp.client-ip=74.125.231.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXfUFl9C"
Received: by mail-oo2-f35.google.com with SMTP id 006d021491bc7-6de2a648ec3so606751eaf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 17:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790902395; x=1791507195; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=r+P9fQoxdj6H27sptbqITSeD/Mdx187JgW5WrzZp2f4=;
        b=ZXfUFl9CShGpL5uTMBJNTcOnJs6V8IuX6O+VX3f1PLhwLPPiRpOeALtb+PBSHEtTgW
         3lsV5QuqEGqPiW5OkC5yYFE1zhnqMoPtgbRfnu5EUZhXmdj+j19wEpz5GZ2UgZYvO0ue
         TKPUg73GQhnFtJ9v0amjRzTM4tjdStMlEIh8TMYP2RmzGtA8KB0Osli5J2/czfJg4ABe
         YSM1P05OifHFupLDQa91YGKNNmRExwFnLoEJtWdN7T9Nu/HA926LD9pg8Nb7iX442HFC
         /T9IsV3L/swzdsSid0aygGV+8WSLku/LnlMBXqw+sIpIQmkGC+W+f4XTgFoW35vH1jpE
         6LMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790902395; x=1791507195;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=r+P9fQoxdj6H27sptbqITSeD/Mdx187JgW5WrzZp2f4=;
        b=xuyoNJJxLCqrKe8AJDK1MGfy3ItEJTIVm+RG0bJgJyZudfMAglDDvgNVLbhGmsI+6p
         Tj++SgEjNEQdAQ9drXoMF/ERiSa3ibqRWS8CGhKXpn/aj/CRiebAZxjmETtuZAkaPc02
         60NMz54IvbUvhMkexJIhF/9MtnJKZwUGDGDyo0aBqgN1uZwsdIAu1F11CATnPi7APkXF
         A88EjzMY5ljNToMAVH22sgCYR3rdXoq9J7IpysNdpjYDZz/pEIrRdsmqkKww2pReT9eX
         A6w6z98Bg5q3LkC7xlzFqk0PdiKOtz6GhSFixtjDYWB2yRHnGBwiWAxG6DgyeYvNotnJ
         roMQ==
X-Gm-Message-State: AFuF++kcqhOO8i0eAe/ORyizcqANVVIWO/1bgdP5Vv5FI6yplRgOGTMt
	copqdgqAQxREL/5eobgOSX7toAxOhYFOqwk4lPWiEmSZVTS5aGB1USIftk/BIw==
X-Gm-Gg: AYBFou28g1B3vHJd+XIH/IcNbOcPBpfLAoKS0L7xggH9luJgPy6FN2BlTJKg2CIkVEv
	wXO8kO3WtT2OsFa9jTmnikY++kj99hPLyN84UEsEE+L4uIUnRGSUXSYlxKStwi8VJ8qHXNP5WFs
	V8JJg7aukU0TGrDTPg7oua7Eh1FqrcXQQzhh4l4motm97llu48oz40wSJLt9tK4pYFEv7mABD14
	IBEVTholSdrmo0yMiYYmpv/klOaiTN8Yv+kIgJvukFX4iJA54ZHihhmz+Is/8h4Nh94yLkqkAbI
	Sa9/uGjJ1lT5XuPyxNsRlA8q2g7R34S/jfRszcMb68G8Nbs3iug3J40fv7J9d12i2NOKYyYBpRy
	ZkkyWJ/PWUarNPca9FkPmu8Gsz8ttp4bvuNshBUgZ/3EZOrZXGTpH2gfrxIwukebRhp+vFi9TXV
	YVRrtBTXwjmVdLigSwBzNxMqzICG2qIzz8wid6TwW26Fwj2+3dUFAxHS3iUu3mIFNLTRiusmZAK
	jqB5w==
X-Received: by 2002:a05:6820:1c8e:b0:6ae:8fc0:dbaf with SMTP id 006d021491bc7-6df2f404781mr1031739eaf.1.1790902395339;
        Thu, 01 Oct 2026 17:53:15 -0700 (PDT)
Received: from [172.17.0.2] ([52.165.101.50])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6df3ada56ddsm1015688eaf.8.2026.10.01.17.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 17:53:14 -0700 (PDT)
Message-ID: <6abf007a.10f94e07.3010d7.52ff@mx.google.com>
Date: Thu, 01 Oct 2026 17:53:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3109230692124612401=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: hfp-hf: Enhance HFP Hands-Free profile support
In-Reply-To: <20261001211036.1760396-2-frederic.danis@collabora.com>
References: <20261001211036.1760396-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3109230692124612401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1177946/

---Test result---

Test Summary:
CheckPatch                    PASS      6.04 seconds
GitLint                       PASS      5.44 seconds
BuildEll                      PASS      13.26 seconds
BluezMake                     PASS      226.43 seconds
MakeCheck                     PASS      12.83 seconds
MakeDistcheck                 PASS      98.56 seconds
CheckValgrind                 PASS      156.38 seconds
CheckSmatch                   PASS      162.70 seconds
bluezmakeextell               PASS      59.86 seconds
TestFunctional                PASS      795.43 seconds
IncrementalBuild              PASS      297.94 seconds
ScanBuild                     PASS      622.94 seconds



https://github.com/bluez/bluez/pull/2620

---
Regards,
Linux Bluetooth


--===============3109230692124612401==--
