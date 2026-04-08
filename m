Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EA82153EA
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Apr 2026 21:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775682559; cv=none; b=FnZzvZ32RbVMJtm08vNTUshGjJB0yTUUMtqbW43jYnsfkvpO5c6a1/4Qj2V8kjeR3l8cp2Ljpt3DUnQnqmN2EmlTyKiaBRAlww3TnxtRZE3bo0CtAxsGxE5QHwxrWn3uyZtpV3L1/T79SVw25+V9yhPoMf9Ns+X4lIJHXu11JvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775682559; c=relaxed/simple;
	bh=o1YOYcCOrNoDbhcaBsEBZhbK9rhMDlOLeGlv345Nm+4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VsxZm13QdVQvHN9sQKeknVfPbTn0JrQRUYQbYXfP37YAT/dEgdw3RM7P2EBLKAjX4oyWk4a6Zp1V+xqmWdx0HByYxfPXKYxwG0iP5pkwPFi0T/ZBrrEUo/sxweYA9tg5S5DBcuripNO186vV0yQgvTIWGJhlYmhfxzum/NNAB6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxbsC/L7; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxbsC/L7"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50babbce85fso2352811cf.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Apr 2026 14:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775682557; x=1776287357; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0zCvgKiF7+8BlvSB0LYNVVqg4aMqdz/f3zYzPKfGrGU=;
        b=mxbsC/L7zCFoL/H35nwzoDsNDDV4iemCy3/LKAcn/9hJ2ysHcv1j2a9IMiqQB+ZyA0
         Rb8L5OeGE/KKwM+5cgznIQAMFyvvnnbvRcgm/oVNwZ7cLzFUPo7yptoDZMZQCp4A3jiQ
         MCp32dFeyjqypjJypF3CdA3ufwJbdUtnba8lYAoTbS2qHQO1Dts8SN3wVqYtGOIv2Pd9
         Tv62fGvNKf9NWRg7xNkgIAuqVvAgKoUrWUHFtn+d4RMEN/2xe+FlLXNYGCTn6FjsXuOZ
         AcZOtl/5nKFA+1n8+gNn4ULO1AcXxcjnCCQJL2vXoCA8RhSf2uFMYKptsebUaKqZAGe2
         JWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775682557; x=1776287357;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zCvgKiF7+8BlvSB0LYNVVqg4aMqdz/f3zYzPKfGrGU=;
        b=KHAkskZ5bPkWKsJvGu4SkzEFpyxdHc68cf9IBa4FzdQvTTUblF4LPObuvFJID+ZC16
         XE2AmPRaxOlKhuz6XReyvjlit84USqhbXmHz/yzREz3+Cwe4eVR0lRa7aTEDIwEZqHqx
         REN0J6aCuta2AicimOO9k8Vth3M4Eo62CqqOtquwx8XuI554fhIzoGmvPHuzX0VMVNlD
         H2hxTE5wkMNX5FigweXVarP1x4kKkjCcnii5DM0U6BNpRtFnJUV7hXjOyLWE9Va0JScM
         dp8YzT+pAfL7I1DBAyPobm9kgq/ShdgQ/UJ1AHtGKeeRdFKzOBY3RyeUN/ErESZ2cy0y
         6wGA==
X-Gm-Message-State: AOJu0Yy3H/31unfJ2AX2B3G6vk02YV8VPClvSwRmg+MvWCoDPOFRKqqy
	JKRXVmwjdDyXlyzxjhWdkzia/kv7aR39wBfM235ogqTkUxGrrTVnhrvvTWfwDg==
X-Gm-Gg: AeBDietE8DoJDldTA6KpeeI5+1S0uN77BmPRnw1Uo7P1lFLedvUhPiNPSTtH6hVyh+e
	FMShcS8tyo5zBVzwIdvlFDdpxQlKF0/BMlEhsPmeQApj/ZRyNTINw7cytyyOpXxHFQdBMFRMGZA
	AMUDMi59Q88omPkLZ481+y0MxyBNdIGO5bIM0zptWqURXowxSWtnna7l0/XBJ9HXzZPGHKt+EaI
	s92fTGBZag2Cm/klBUKL3+OQeN5N5/2Ag8Ceag1j+b4s3He9PmyxUiJLmGbcI14+Tmrlt0I+cO0
	6Lchven8tEzFqihJ4zQFLJy7dh82aF1BLrB6AUK8vYdQ9PJ3x5vcM1rGb6A1TbsuC9Awov3EzGz
	xOt4iBwmeknin7C/kGvcwQO1vq0sGJ1by5rINThh2cxh2kzLrID8TssiKboqe1ORCX/EDlX1r6B
	BefYxgMN39VAy/iebFs04txLAj+0b+XrPB
X-Received: by 2002:a05:622a:1cce:b0:50d:7666:b54c with SMTP id d75a77b69052e-50dc22f63b3mr14023711cf.51.1775682557124;
        Wed, 08 Apr 2026 14:09:17 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.176.180])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50db0ba229csm29603571cf.3.2026.04.08.14.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 14:09:16 -0700 (PDT)
Message-ID: <69d6c3fc.050a0220.39fe6.850d@mx.google.com>
Date: Wed, 08 Apr 2026 14:09:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3482062029414221609=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/2] shared/gatt-server: Add bt_gatt_server_set_permissions
In-Reply-To: <20260408201318.483799-1-luiz.dentz@gmail.com>
References: <20260408201318.483799-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3482062029414221609==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1078903

---Test result---

Test Summary:
CheckPatch                    PENDING   0.37 seconds
GitLint                       PENDING   0.36 seconds
BuildEll                      PASS      19.88 seconds
BluezMake                     PASS      620.11 seconds
MakeCheck                     PASS      18.19 seconds
MakeDistcheck                 PASS      239.32 seconds
CheckValgrind                 PASS      286.41 seconds
CheckSmatch                   WARNING   341.71 seconds
bluezmakeextell               PASS      177.17 seconds
IncrementalBuild              PENDING   0.34 seconds
ScanBuild                     PASS      990.84 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/gatt-server.c:279:25: warning: Variable length array is used.src/shared/gatt-server.c:622:25: warning: Variable length array is used.src/shared/gatt-server.c:720:25: warning: Variable length array is used.src/shared/gatt-server.c:279:25: warning: Variable length array is used.src/shared/gatt-server.c:622:25: warning: Variable length array is used.src/shared/gatt-server.c:720:25: warning: Variable length array is used.src/shared/gatt-server.c:279:25: warning: Variable length array is used.src/shared/gatt-server.c:622:25: warning: Variable length array is used.src/shared/gatt-server.c:720:25: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluez/pull/2025/checks

---
Regards,
Linux Bluetooth


--===============3482062029414221609==--
