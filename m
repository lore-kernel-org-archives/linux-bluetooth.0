Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F773AE188
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 10:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775818324; cv=none; b=VnPeGIx/1ezcAHLOgYcfG09ZIaC7kfe/kqXxd/ITh7rjLyVSC+uViY04kvUcdKFoA8EwYQ8DWG/An3YqpN/SVFfVdeN8ii50JleCSIpnPbCI84yGNFC38QeYoIikWx0ngE89SnKtPNGrIPTa0X59WeFQeGewYvejzgtxEeI922s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775818324; c=relaxed/simple;
	bh=Cxz1qCPx/lC5bKi3NVA/dyPwOzDhLgr7HMSvC9rvTzU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=grpZi1FVWbl+wWv4MI/6hS3VPpcA7Hab5zbxmbpf5+u8usMz0OrCuNJ6sA68lDtB7KzHZFEm51VOQIiCTsdOih5jfwiQi9w6cPvh52W2aaBHMxZNPdPD4b1f6fgkz3ubu1fMYO7qmSpsoPZ2jib4DubUGmUx21Oi0Q04SWSYulw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkEfbTCE; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkEfbTCE"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cfd122d78fso260946785a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Apr 2026 03:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775818318; x=1776423118; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5VL9tNQIKKCukXUFqKbMMOCYv1SbXr/GgcxXVB8c7Uk=;
        b=QkEfbTCEZM7XExOL+Ewueir1mvEvxQbGqc5g86c455d46QouqYFspu2Zwz3aA7h8zb
         mDXunpuSJpX7G725aSVJ4eWABnX0JjOSuJSQnc5eWg/H2Q8knc2da+aJ8/FYXPu1cGFf
         9zy9o2QWafFmOSeyx3n0d9tlS7TLBPEgmL/HM1/rp9CWU9I+aFJeeewfxsxGnAgDiAkq
         ou8Z8jPj2CsjetWx6GmJddWtfqVJ7wGXKIYNpBvaflXLaI08NzRwOGJlwWyCsX1dcjPk
         0kkHAwB2JGh9km3Df7+au3t3mU2gLfdD4fdfuOfiTzLQrqAPatXaHfWDlLfiVuE7uQGF
         o7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775818318; x=1776423118;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VL9tNQIKKCukXUFqKbMMOCYv1SbXr/GgcxXVB8c7Uk=;
        b=sHR/OJciyMQ4ZEF3YGOjPCAffhdsGiX9Nqhrt4oKf11O+26XvkWSObSBD65+5Ko6Qx
         /BVtwBUxIBbxh6w2rwTwpcvlOFwkXDbCjYNeBzPpnYUpwFGWki4NqnnccBiKxTQmBV+w
         4p+CqwZZoHCWG3dGr0xWZey2epDJzDODTPcLJXxClCHYbuclEW2GYtr7Lhw6iS7xUDyp
         YdM6gqyif7xwAp58o6I9PcBjFxqBG972hWcNcrjt8P/DQkRk+rhATuqdTrHZRfCroP3U
         atO+XKUSG8OSALxmy8tRkpAm5sPHfLeUhWwd+Jf+dmTKRWqqWKsbyUvfX1lUxOnezteB
         DE5w==
X-Gm-Message-State: AOJu0YxezylHGpaSjRGhbIDLUkgETn1dXHODJA6rH5kjDLcE1TcHuay6
	m/S7dHmH3RMZ9RbTso0QjHhAfmLkD/GvL/pq7XZ6NrpnMgXC5SZYxL5Hb56+hYRf
X-Gm-Gg: AeBDievJoWEYHQGKQWuoOOrFNFibJfuw2c2op0DyX7oUqhtippQ/OD7s1GEAZ/Orv8W
	J2eURPjxGg6ToRNbqDM/6EXsxmqFEInJYM9uJ8mFo4Qct+4Hrv9WkWf4vk95pM0pp8b9I6lRYr3
	m8zDwlFPfJpu0cKeFLOcbJCrB80AtVmbdrY2pMu+Gg4lk8w8zVYkXerYgJs+2bEqInERldmJFgM
	mypApHcBhkOh5rcwrYW/4k7sUMUtD5CidusndjexqVSushhp6xjKXEs/i6ibJsOlvhWATJHTZzh
	n4i58v/ieg0ozWnw7UWPNYwaUY03kDUQ9QsxiumyCphzACMX1JtlH/o9mfKCityIfPo5a03lV3j
	oBwzaMGwwIgw2Cu9uoR7XiSXtTa+ockBNJJ1sW34LJlD1jTVyJjQwI49wEbBcxxDlsOVf09qJul
	y7MLzP9imBiCOIkwPPixeSVmeied6I
X-Received: by 2002:a05:6214:4807:b0:89c:da2b:4905 with SMTP id 6a1803df08f44-8ac86157c5emr39968536d6.8.1775818317756;
        Fri, 10 Apr 2026 03:51:57 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.222.81])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84a3452fsm25019566d6.17.2026.04.10.03.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:51:57 -0700 (PDT)
Message-ID: <69d8d64d.050a0220.3a23ec.10b6@mx.google.com>
Date: Fri, 10 Apr 2026 03:51:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6102886096991899115=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 294305068@qq.com
Subject: RE: [BlueZ] src/device: Add ConnectedUUIDs property
In-Reply-To: <tencent_8CF6DCCE00806DF68DB0363D6A1E68340707@qq.com>
References: <tencent_8CF6DCCE00806DF68DB0363D6A1E68340707@qq.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6102886096991899115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1079646

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.34 seconds
BuildEll                      PASS      20.02 seconds
BluezMake                     PASS      633.80 seconds
MakeCheck                     PASS      19.08 seconds
MakeDistcheck                 PASS      243.43 seconds
CheckValgrind                 PASS      290.97 seconds
CheckSmatch                   PASS      344.92 seconds
bluezmakeextell               PASS      179.46 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      996.34 seconds

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
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluez/pull/2028

---
Regards,
Linux Bluetooth


--===============6102886096991899115==--
