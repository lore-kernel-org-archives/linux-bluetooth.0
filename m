Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8744716EB54
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Aug 2024 10:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724321774; cv=none; b=WjS7p10ZzbX2HOjGo+1tWGTWk59IgoGviYVex8eOE8OC+y0vCY/YyrhojOSO9mwrnPojVwT/FSaX5961byWSilN53srYgjh8A6TAliCgXm5NHoSM7ZXwzwVcbasrVLxgI96pbLpscrrQCmn/YrT8X3kVk3DBcPz29J9yys3QYHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724321774; c=relaxed/simple;
	bh=y14t/HkgbbSVR7fTdnF/xOxsiaSavGkQBYuutU5Ho/U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=WjVnEJ/KbR2jN1Tq+DhzDpevNkbOvwp0h3NQUrWkcJ9PUtBCmeCaJRbw/5GIiNIEqZMK6RvpcFKyNMn+pnbalM+QMme+EHqRC9Umv4MSDCKNf8F7PfYcqL7maIm7D+7+MJJnWs7L8MRs0dko2eeZyOfW82V7sgQWtXYgDg0w/2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mz0Jt/HD; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mz0Jt/HD"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20223b5c1c0so4948535ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Aug 2024 03:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724321772; x=1724926572; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y14t/HkgbbSVR7fTdnF/xOxsiaSavGkQBYuutU5Ho/U=;
        b=Mz0Jt/HD0fy4cZzaz9Oy4RxSjwVD1F33GM74aChqHpk+k5V2NIX0qGuQksssGYml01
         wzTmCW/jxol17KdgbFQHmqPUtpEpBH4m1bmYywNvoy943jcLwi7BOhc38fGAR8oaWVm+
         1IOxogBnH95PNBF19A3VcH3vIm74qLt7Jo1Jx3by07Uyk1L4e82zt6SP8gTTC6TGbT1M
         1Xg6cy2j+IlR9N1UicRVuFawRoPfWt9eQROZfdLDpaBvCDhA1T9xaVnRSQ1ZaKVsm4yV
         917oAE8EzwYrhpm26pLIor21IFdvwLKEoK24jhCIecreYwBgjUG3Ev61tNXsZvWhxSlQ
         euRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724321772; x=1724926572;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y14t/HkgbbSVR7fTdnF/xOxsiaSavGkQBYuutU5Ho/U=;
        b=d+jzuLgLnk1cFzkbKpIcLIB0Mm77kX6VT0Nwog98d+xclMxEO/ar/l/IQtuZ4EjeX2
         lxfYPpiES42thNbrqgIN+IKls7g6fa7SxmtFFbcMVivHbUpqzJgzd2Xv5nyWV5BGJDvU
         HgYkQVFHPYmShJ44Ty47sc8HaqcGk4c+VepmLhIZEnd0yxnog5d0zDn2GDlSlQCIqDIt
         l1n+RmIhLfSgvWJGt2H1e1Ot/KbE3NHgYXnP8XjzQ+yaPGrCklDFwWLKGRoX+PxlSncp
         zDc2CRbjqCMG5XC3n88Zwg7c7IVl3D+oObeZnixF5+vcNXx+peFvtm8sebJDAVpjMLy6
         +Zlg==
X-Gm-Message-State: AOJu0YzOdReZBW2MurE3IK715aaK3v5ttCVSoHOjCPBMHw0yhcZ5ox1H
	PDONbcCak01Gr+mDJXG8EEo9Po9TFMY0NDpUHG2Lj4lj67Dhvwa1Yd4K2g==
X-Google-Smtp-Source: AGHT+IFhHCBqlXr+FUlD/8vxAEUkhnzwS6uPPL87RpmvvpazxqBB6QNEaqtSrGdUf4NFgZqlezZBjg==
X-Received: by 2002:a17:903:234a:b0:1fb:1cc3:6482 with SMTP id d9443c01a7336-2036818cc00mr68507345ad.45.1724321772500;
        Thu, 22 Aug 2024 03:16:12 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.70.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557f68dsm9493155ad.98.2024.08.22.03.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 03:16:12 -0700 (PDT)
Message-ID: <66c70fec.170a0220.36aec3.2545@mx.google.com>
Date: Thu, 22 Aug 2024 03:16:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7234103580560251697=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, benedek.kupper@epitome.inc
Subject: RE: [BlueZ] gatt-client: allow AcquireNotify when characteristic has indicate flag
In-Reply-To: <AS1P189MB1963A74490BC265D1B4E9FDA9E8F2@AS1P189MB1963.EURP189.PROD.OUTLOOK.COM>
References: <AS1P189MB1963A74490BC265D1B4E9FDA9E8F2@AS1P189MB1963.EURP189.PROD.OUTLOOK.COM>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7234103580560251697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7234103580560251697==--
