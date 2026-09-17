Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688AA3D47A3
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 07:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628584; cv=none; b=iENXPEm+JJIgZeJxdFRDMoQ3acaEGqakqMhWaTY4rDD6j8Qq9DsJmaxQt9NzPiOYgfuxjy1KUT9Co1KmCJRiefUVl9eo1G25Vz3+tqzOVA7+QUihS2kwciO8W3QE49d8Ak8t2xvlnTjHwrdmomSQNViUdejTm1FKoRBuICpWCPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628584; c=relaxed/simple;
	bh=Nan6GXy5qsSLK/WBkEKKignRvOyH6Fcw67d7N3pGZys=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kzIiyt339TYf+prAc/uwoeRm9HoPXfiFZjuWUKZFn/jkaYtntrsF3fGg1aQZBJSHHFVR/5/Vsdapir0hoxYSw/SrHLgSUOlLa2xWk+/nq58TQ86gcpkvsLAA1uSOr8AJ6noGQF3y43uon3sFtj4KMWGkMB5LHL123PHCSduDXyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mb1RqTWG; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mb1RqTWG"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd53691be5so4847385ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 00:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789628582; x=1790233382; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Nan6GXy5qsSLK/WBkEKKignRvOyH6Fcw67d7N3pGZys=;
        b=Mb1RqTWGzDFFQFtG1zrp3M4IskyR31E+4+OpiSoH5yL58TufqAckHKVxGz9Ylcqnfi
         e050w7lvxXQnmWeX8cFqVsHmaDvH89KNUl6nTV3I2r4VFqtZ74Nq45edc4sawHdYC5RZ
         h9dL9fwGW/DMIpdcQpPBp0EdW5P/ohsRFMVEUdRvlRBQTCqsBSC/8+7JNERHte0c1d16
         8/kjUVib14amOACK1wPdaWmcEPIYCuhpiGawuiX7TiLcvdKiEGC7FRPDKPnuIP+Mpx0+
         VrB2P9M1vDjLnVFR/VRVs9br0uLsTaonOOWtUBSI8PnrDnsqecFw7wd6FxsXjFhqE4lL
         j/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789628582; x=1790233382;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Nan6GXy5qsSLK/WBkEKKignRvOyH6Fcw67d7N3pGZys=;
        b=w9oZCJD7gFA0pMUeS9X7kmPyliJOuxZ6DHfSY+5KLpY/EUB9DWCoj2JYNSF/D2bXlw
         dumMqei0e7XHI2O5d5vKev2Qm77hi9Ahdi556JExp6Fpez1qO0YVTFNbDzn2f0+Qby7P
         86gFnAQNOQ+p7C9FVa2CZjQ3QvzT3Weh0AYgBobQqaiK7pHV/+HFl6/+IOpticqo8uH0
         sZOlFjDPlq28chMGGaYh8hmITkjGnFtzVVJV97PKb0iYCaysjH2OLWVdKXu0lmL6HUcq
         hSVBGaczFsSKT+hH3yQMTXwS40ATbV3XzCCn93HSTjC1SxkmlEVP2HgvV0oH/zqXfe8D
         AcHA==
X-Gm-Message-State: AFuF++k5/5fqkOCOnqWzXhD6wFB+DclLRQSVWXtL7g5D6bk0KSuesqRL
	9EKalL/4974DzrMDLjSkXdgnNuV1EXfON010uq/wRAK9g9GVGBxguqKtYa5iFRv2mYA=
X-Gm-Gg: AYBFou2ZnnobabI6PzPtDs80/5uzJcrd0ul2T28R0NKyBOQElcGBUFP1mqOhQHrFRMs
	IT3iXSsjR3wBE91pDvqzI2sK5UBK6lvUqEEGNd0cGxJzGdXGS4Lxs1wC0oIDIXPrZgfVxx4Rcb2
	14BVSgb0eGDe9EFoHMMz2CSMVG2pEwa5owR0vQIJ8uK364VAMxYXzPqb0b57uz4x0j1AVqGb9yX
	kjdRKULAkOjWLRvHOAqnIJ2lEWDrLe7tXDnGiW1YKimAABU230HAxB6k2tAfKdtTRNezA7IY2E6
	wugdXHzUFk5g7x40P75C4lItcvx1FDTiMe4enj/lNyVOSuGiig00I4nO5713hJN/EukfV9d5/Qe
	aIo3Jf5w32Mid/6XpNRph4/K+ODt6ufuVBOdJavXmaFNazRaSSWzZ8OsOOxketvW/Fgoonjg0zL
	+e4NwSsqywlXt1baOlFwAXr6cbcxA6ixYK/lywfxJmMJRIzd2+23IlNvOJcXQu3nN8AVMNbDy36
	t8PGqrY6ZLUJRY=
X-Received: by 2002:a17:902:e54b:b0:2d8:d4ce:7e3d with SMTP id d9443c01a7336-2dd8e7454c9mr117636225ad.18.1789628582265;
        Thu, 17 Sep 2026 00:03:02 -0700 (PDT)
Received: from [172.17.0.2] ([52.183.7.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89edf43bsm21883945ad.47.2026.09.17.00.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 00:03:01 -0700 (PDT)
Message-ID: <6aab90a5.e9195a19.23de1b.7055@mx.google.com>
Date: Thu, 17 Sep 2026 00:03:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7988599702088314992=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kmehltretter@gmail.com
Subject: RE: [5.15.y,1/2] Bluetooth: L2CAP: Fix deadlock
In-Reply-To: <20260917040004.21041-2-kmehltretter@gmail.com>
References: <20260917040004.21041-2-kmehltretter@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7988599702088314992==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/l2cap_core.c:7992
error: net/bluetooth/l2cap_core.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7988599702088314992==--
