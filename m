Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B26385529
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 20:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775076351; cv=none; b=UjvRQO3+L04Jmj33B4R1oCvA0jUDLEfTKpluIcGGFJDQVVltGu6oEPNA58haYwsFyUL53m9IRiP00rcmQWFyArNrmKMBYuCMObgX7mzMojwQLuNFOATl96XgZeXs/JojjaD+XrLdericsh6fU3bT3nTcGAveX5nRF7W17EO97ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775076351; c=relaxed/simple;
	bh=tDnpfbCQI/EgOmiOYUFllUeOnEovNYMswW+Qy2+lrzs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=t404/yvk+FmY266LRY9iefP82MfjTIRCKOqqSnFiIWdD1ggexIHd6zT5euBEEC6TLxqfrBYCGkJlBS4sJZJQYEQqZMa3AiaA+t665QISG5zbvQuAsYXyFMHmW2ffkGxX01/G2KHuW/mKgPPWw7E+j/hfm9SdFDUBm49I4HILIQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hB+5AznJ; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hB+5AznJ"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d91f82d819so197561a34.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2026 13:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775076349; x=1775681149; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VQ6lvIpi5ZlwVGQg7hNXVBi5+da4YBYAYj1GHPqKAwY=;
        b=hB+5AznJL6xQQWROkOphSe+bzvmioYi4RkUiCPNfqtvyMO6Ptz44+7vSE/0v08M5vt
         Md+u9jVJMESFat/b3nfYetgHOZPNO8m7Mm18+697IZDxFcUSQ2WfALpGFoy+IYf7U9MF
         8eQA+W+6QpNZlu/1gCGIJRlrVf1smg827p+1okbI5JgwwESC8xapkznplcHKm/ntdJ/7
         4J4Bc4xkjYvHNX93gQ+gEADXuT322kOFtKynuEjLo/svodfNwCYvl28wjawrFoFH5s83
         20+FpD+sZijJFkGlMgqYTpSf5ElC0FgbqpNt1fy216XDeeh1fpIit/Ya+h04viPYYimP
         aqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775076349; x=1775681149;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQ6lvIpi5ZlwVGQg7hNXVBi5+da4YBYAYj1GHPqKAwY=;
        b=mDk4MSH/vS4AfeCxAREFPm9A4VAgYeEp0P6U3WqPAXq4ypuZ2MrQGQz9Xz1jY8SJMw
         UqCO0PpCQ2ueZibaRizLW+gpcTKgAYXBU/9MhjVQGdnrpILy8JxISLF5AtGCcroRZOuX
         n3i/u9/4VMQh/HQ0na1ef4ntOu12ojg+7nhiZdmPyyp1asF+s7Pk3Nm+dl74jOwaWav0
         V3/ssnu2wrseJEIICwId6wnrpvV7DLONCVPBeJhjp+xRVjBy31LsjygAidmbExDW0lS5
         hqSVKeW/2madmDSvd0/vKa1ucAOsUPuj2jWjpk9KhldB41DXg/I3c8uUtAOO0HvWKURb
         Km+Q==
X-Gm-Message-State: AOJu0YzM2Bu5emoESKTIb7/7SxlO6XjGnduhYmJuq5/3Ac9IAoblcvMD
	OB5IJ7ZPvHRqXO22iC8bUsgTkU7tfnvNwEAJoaMX67hqaJzb2j2U88siLEv5PQ==
X-Gm-Gg: ATEYQzyKSqx7CPgO29FtLGp52OgKTfJJ9Wmj+lKw0Cej1lW8hCM7iIZIvLk630iBRj9
	ewtLlPjM8CnzV42uPg/i9hNbc0VAs9R2hLZHrPxHxLHzBGzoYnU1uykSnDbmhBaLQfAv09wJPyG
	WnrBFUJUQ29WMeUK3QqbM53tcyKT0UMqBdkEb53XfIlXQ8nUhqH7ntiRGJ3gglD57WbhMV5vJ7G
	Ymgdd93S8+L/IJPWR9N1yV70yDUxDkxjV84v47M37m8kHaP1wpHBQSdCxB9Nq/VMaJ74zeFUmdU
	nSyGNwiGuS1WWy360RLyYsOAVxKefO1NqW+e78nGEGdKkKSgJgGw6zlawqK31r/u2SjpbtrVHy/
	KI34i05kMNxSCBsoarDdV7BYs6Y0/YpQ6QlI2lWv+jeHtWXmCelhMPZCkVMwW2/V2cYmZ8LvywQ
	3m2Z/FaUwwHWWYRGvv/Jc62u8mvC3gxqGws2qd5Y++xQ==
X-Received: by 2002:a05:6820:f006:b0:67e:eb4:238f with SMTP id 006d021491bc7-67fabc27c98mr2818256eaf.18.1775076348944;
        Wed, 01 Apr 2026 13:45:48 -0700 (PDT)
Received: from [172.17.0.2] ([52.176.124.180])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eaf94eccsm628358fac.8.2026.04.01.13.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 13:45:48 -0700 (PDT)
Message-ID: <69cd83fc.050a0220.1c1bab.8d1a@mx.google.com>
Date: Wed, 01 Apr 2026 13:45:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2436210647029768163=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC,BlueZ,v1] doc/btmon: Add Channel Sounding protocol flow documentation
In-Reply-To: <20260401190625.2100332-1-luiz.dentz@gmail.com>
References: <20260401190625.2100332-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2436210647029768163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1076017

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.39 seconds
BuildEll                      PASS      20.39 seconds
BluezMake                     PASS      646.49 seconds
MakeCheck                     PASS      18.74 seconds
MakeDistcheck                 PASS      249.98 seconds
CheckValgrind                 PASS      299.41 seconds
CheckSmatch                   PASS      359.62 seconds
bluezmakeextell               PASS      184.58 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      1051.69 seconds

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



https://github.com/bluez/bluez/pull/2002/checks

---
Regards,
Linux Bluetooth


--===============2436210647029768163==--
