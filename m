Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7D44078E9
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 11:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789818550; cv=none; b=GNert3qhphQRYsWqSkoUZ9JVNlOqeccMrM6GJkOaEi4xvrQcfnc/BQm4W9Kb4tzwlObY1EGkpETeyd5sOMg2ZkVKmbwIQNA9aC32Ym3aS4Whs4b1qldSRyReMm9RE8X04XQY0LMx8CmFzBkiFXl//YiFzSq+eI59WD4roHRBwXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789818550; c=relaxed/simple;
	bh=pjsidj9m0prL6vE/XSVQUcfiP/pGnx78DnqB7NpNcp8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=L6pRHUy8AzO8KUT4e3B2rlSLqlhq8MX1WCqXDXK8EUqdaEH259IS2FVpIC3ZiG3h7WoCmWUt3DV9xql50ocFpwsH15/MyjnCNEImnlFg5kvjuGhy8YH8hHc7rI37wIwavpFcE1x2W/C7nxNuH5c/WbBC3fVUB69tZRR0d14vrsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtALczw/; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtALczw/"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d91a931f66so10476995ad.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Sep 2026 04:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789818545; x=1790423345; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pjsidj9m0prL6vE/XSVQUcfiP/pGnx78DnqB7NpNcp8=;
        b=MtALczw/k0UTLF2Jj0xzXqSPtN2tUlxA/Ga5V9+j1n1NxkkgeGGcw4CQLzbFxX/uLt
         LO7tPCag4CadFPgNy77hwRWrjpHRRQiibm9BnqMuVig7wAo21iQ1vRSvFSFYqYv2H8SV
         MDoCUwZhuNp9vI105xLmSTd10L42dIZaCPGUXLqyUKVpW49OuH3NYkb2H1h56w0kHEnM
         ZeFhOUIGBSaapR8ExCm7ofDPii92jUIrLdHXJzq8CSbWMB5fsIFTyuFdXAqI3BFZEPP4
         xBE/ePUwSaVhy7eDiKiA08nu/jnlakIGBScMux0kS2wCZGYmNwNt9EQ7psUTDgiSO57Q
         BlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789818545; x=1790423345;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pjsidj9m0prL6vE/XSVQUcfiP/pGnx78DnqB7NpNcp8=;
        b=Zf6T3Jr78BiqBrkHIr65r1ivxG35e1+thLV8mMR66tNZRi6+O+OP1/jMernvkNYolz
         POrDnez+g8a/FaBCtE2xuel6JhStGS2+a7OQjzAeHAszAEe0dNre2p5+q4rpdkf6yag3
         pMdWPExMA359y6pE207GTUIq8RW/EIi7z9x0jSnMmg/IlRTxhjduKX2zRmMbd/mH89mk
         8kRmIC11xMlyViASBGt2WZggM9ob1u3sL0rAT0Bxm0H9JR961DsvRD0yoFE7+97lbu3c
         CyDGFCnygdCuZFyNnZtWSeOlidz4umPSvThIN9xkk6Vr+IQzGBS7figISGnk8lov7fnj
         NZ8Q==
X-Gm-Message-State: AFuF++kO1bKbPDMTeRV+YH4E0aXtW+5lsS9gssHlgenMYdUgIIKcraBK
	/ppM9LD5CH1gfEwDo2dIR+B+/bQ9vZJJCFF7RomztAug+I/XFZGFgBQ2qL30iA==
X-Gm-Gg: AYBFou32wiXO7H1ORgEPmvV4tNFHksHM0r5O9l4ATxRq2ymQv4SPU7lWkjmBaiIxvfD
	2SPt1tYQbCxGKQriaxl5KsBip7rBe62HWi+o5N10RupHVQM/ljkYTsLeoGIhGN8bEq/Uq5mtNLq
	NXhmTj3Q711Za5GX52eq38mFhBjZNRVpwLOMaWyupCfsyLVxIGgdLP31Dwt1DnAK75dfLjsC3u5
	Ze5fdeJ7oGOcr3qqBlZmvD5jB6SWuGzuzBsv9arf+plAthbQTGkiJLC5XvOaCII89srfi4voOx8
	kKcTcurIJ2WUmHxizPdz/ki06xaTSFRvK2qFZmdywLdb/CplnjcfDK0DXfad3l29cTF6ttsnPvO
	xVYDEKvwSPxRw1YKDbSQSFkh1oWKxvPOZ5IXXoXICtVUvCTjP0FMfNPb9ncpUsb/nQv9vnwZJEO
	JvI4S1uhwePOuRemCX4Cpr3FQkeE7FZYDVkmzw0Q9oKwMNlAc49J71qEiBPJg+YDnIZ85iwe/Ua
	rNB
X-Received: by 2002:a17:902:f542:b0:2d7:2edd:d140 with SMTP id d9443c01a7336-2ddb1aac6e0mr95460475ad.3.1789818545202;
        Sat, 19 Sep 2026 04:49:05 -0700 (PDT)
Received: from [172.17.0.2] ([52.157.2.243])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331aeeddsm5433888eec.24.2026.09.19.04.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 04:49:04 -0700 (PDT)
Message-ID: <6aae76b0.ed8a271b.1811f0.0a2a@mx.google.com>
Date: Sat, 19 Sep 2026 04:49:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6791446515394249226=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, benquike@gmail.com
Subject: RE: [v3] Bluetooth: MGMT: Fix mesh_tx Use-After-Free and leak in mesh_send()
In-Reply-To: <20260919112517.3871992-1-benquike@gmail.com>
References: <20260919112517.3871992-1-benquike@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6791446515394249226==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/mgmt.c:2306
error: net/bluetooth/mgmt.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6791446515394249226==--
