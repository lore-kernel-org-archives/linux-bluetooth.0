Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F5B446BEF
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396503; cv=none; b=XrxQcF5Sk4P43P9gZ6OxLGLOINP4/g1ovtCzaIpXIcSla71rH2y0A/Xaog66TlzHn4Jd9FWfvM5LAxZTiGMckUHk16LGKq8qNceB2fswOhe4QeAEK39WmaHK2isaTElBZ2GW7/Uz61SqJAEFTFaP86mCMVHRkfodU2S5xqxr/mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396503; c=relaxed/simple;
	bh=nCIP0DdBCQBOGhJwVPQXme04JG/aGdw3DpmmzCc5DCs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eS5zSmkdQXhgBmJzerk6JPUhDEfUTwrpwsGqOY0rusX8cMFTs7HSJgcDZ7DqX4Ew01jna+PgOaMZijo4QyhJiWzFbpTMF8LVaQi4aeH3osajFKTGtKbR0peZzYY8nsLBQ8sB1Hj1fvTUfEawxlfTsYhM0V952hTGklC3DOVWYNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTuRJDLc; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTuRJDLc"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb76c9deeso34731051cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 07:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789396501; x=1790001301; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CAUzAH/ly30jW+Zci9RoLpipgs9k9+kqA1dW+JCYuIA=;
        b=jTuRJDLcYl+eIkuLDxz+iEiN5l6llc9MDBMBN3X3GODHnnq+W5L+EEMJb+v3xvhoY7
         s3oRLqQCPV4iT+8lPKLYqozoezWv5ZfPZHj/7RCqdTkUSeCgQLKdyvMA1kcv4mUnF0Ob
         +tx40XvgG5m98fft881R9dok1RQv3xnrl3YgM55Dv/3ueWA1eaiJq5mvjh6lNi/BJUdr
         EYl2K7t/VPj96psFqkJnJf2UC9H23VoODLJczM/GtJT1eAiwlAM8WpOoSfCIeXPfcZ3y
         04O+ujWp4Q6ibMw3e2AEzw1llyFy4FL1tngWXeFgiKZNwL6xcZEvZLx2rkLi3juMSy4i
         +ZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789396501; x=1790001301;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CAUzAH/ly30jW+Zci9RoLpipgs9k9+kqA1dW+JCYuIA=;
        b=gu5aw5vRroHZJHQkdw66pt1HR58kmkllosmQ5EPlphJzT0ET4DvpA+lf25X0+OInzo
         hK81mQE2qQMD2iUs5jpfUwMbL8XHhuslLINadzd6WpQ71oSiFT43QSXlKaQOPQuQJmmo
         mqSNeb4vlgOQ/rJ7yDYq5oZPCTwckmLC67xD2PkYo+hQQ1BGhIOagazvc2MSRWo7Hs3G
         vMO32ugFjGdA0z3QGK4UfZ5BckcnVybY5te0GDQbZbhx5ZWIZPkQSOQ1FeFOfjxMKKQE
         BjI+S5bFmIhZR4BBk2jjtthvZ3RhpHtbPTnL4SOrE5bAWUOxfpjynd5hELqS8+q0CDM2
         ZGAw==
X-Gm-Message-State: AFuF++k0j+cRXduLGFuLwbsnII4lnTD3vThwVzIhhNsU+PZAbYtKA14C
	SNFhTZagNVMXLGItsZV4Lpl39B9oK+uxdRfFFj/F8bAAC4klHJl0usYsRQZpxA==
X-Gm-Gg: AYBFou02PMOE/NzO4FFilx+SjCRiWzyW0W3Wbw/Y68Ju89dAs9eVYZsKrXTiUKJzjYh
	dxn+RcH6HiykZYW0iGOguHhPNQdJ8Bh7XDJK8trkS8/aU2rytQS/TdEisANqaR4aXO/K+oygwSf
	r4YmcxZW+2f/ggcQWLJRlqGmIIL0ROCAgRU+AXiZ745qj3S6cWSHUHJ4P1yEWOGUwhJrHkUIfRd
	RnsiKvCsUd9budT/q2KB0AzxmUdJ/DUcmlmTcIsyhsGggvagYcdWyRp2nOCp6OgtZSyxILofKZ1
	pM9bWb5LqUMIF50+KONBFnHTbzNGfc416F8Ot2HuMGgPmTxqML8z5ZQdQh8xD1vYKaFtAlCPALO
	EtRralz478FqoS+J46N5f8ng9lS/yRWtwoNFH27P2W5v4lkmAqeRUJt7yC3vFq5+Di8DVef2wfz
	SHN4g4P76AQt44VcVk/ODfQgfaZ9H7OgCSG1d7L/c/2dUUNsBCxbUCrt25+oUHgQquNCqD0YoMy
	EtKX5HA
X-Received: by 2002:a05:622a:48d:b0:530:aae3:2421 with SMTP id d75a77b69052e-5310cf173femr41270201cf.1.1789396500987;
        Mon, 14 Sep 2026 07:35:00 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.133.245])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530ca3098easm100531941cf.3.2026.09.14.07.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 07:35:00 -0700 (PDT)
Message-ID: <6aa80614.0298835c.1b2797.1d5c@mx.google.com>
Date: Mon, 14 Sep 2026 07:35:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8521005342738342154=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, aurelienrivet@hotmail.fr
Subject: RE: mesh: Fix Command Disallowed on random address change in generic IO
In-Reply-To: <PAXP250MB0544B307EB9802855B711F71CBBB2@PAXP250MB0544.EURP250.PROD.OUTLOOK.COM>
References: <PAXP250MB0544B307EB9802855B711F71CBBB2@PAXP250MB0544.EURP250.PROD.OUTLOOK.COM>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8521005342738342154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1164346/

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      18.17 seconds
BluezMake                     PASS      311.80 seconds
MakeCheck                     PASS      0.88 seconds
MakeDistcheck                 PASS      134.21 seconds
CheckValgrind                 PASS      137.30 seconds
CheckSmatch                   PASS      233.12 seconds
bluezmakeextell               PASS      88.27 seconds
IncrementalBuild              PASS      312.79 seconds
ScanBuild                     PASS      927.70 seconds



https://github.com/bluez/bluez/pull/2527

---
Regards,
Linux Bluetooth


--===============8521005342738342154==--
