Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C656429E11A
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764668092; cv=none; b=fjjTmwHqXdO4Nur4Dm6J8sFCNeZS/dZZmiD4nN6IKYc1K83hogqe3+PPVs73fyDGVt5biRcUmRrwUJUOkbXeaCIKU2h73PLhjo1QerYvti25ySjiVBirAKtNFjAD+YRK/PYxemjuXV4ud49CO6CIXiyHZHmawa7nD1f02UY9gvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764668092; c=relaxed/simple;
	bh=EF+F1pFqj3lxyOMNCslbBpkfwWNRYZtpHtuxcJHx9Yo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DXJp22oC0WTHGw+bU1FfH+BzxOK/R83xypxbXP/eKrTAmZK+JK74OqrAVBUFoxwgHwcMySbtnwIW+Da1gmzan/GtYMLiZ5j3WIIR/CryoakJELQRiUf39QZWgU8w7fdX/ZzjHwdGylCxe+W1sGTym7e+lu17K35qh6ksno/pfPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+cjxdea; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+cjxdea"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-3e7e57450ceso1594103fac.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Dec 2025 01:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764668089; x=1765272889; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wxsBTPNQfGRiatvA0bvXJ+j+YhYrc2kxSFLw+B//BT8=;
        b=a+cjxdeahjIQZ5PslBeDNvqq0uQX3GXdcNPoSuUtRLy7INscrZ0Nfq/ZcFxQHNp1wC
         pd7aU+F/CgFeljOLgz36GA5KS0tjl22zvIuOc3q5Wws6pjOHvzSNyZa2PMHex4cSafba
         aGLA8h3SR4xyj3jKbGMYGWhUJNUff85UmRNGznbXdmNcVspW9ayZC3IocxbZRxEk5Ykj
         1sXPMAevTMvgmWKC+tEfUjdrhE8sUWUgz2+fYXxfaVHhj0Ti+40JJDOGnyWBdW3eG2aN
         dBcImcSlgOw0VWlmrcC61Wdjl3TEbczpt9KXjNJ6zh5/jhZAYqmQ262wZH3LhoRxFj5p
         EGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764668089; x=1765272889;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxsBTPNQfGRiatvA0bvXJ+j+YhYrc2kxSFLw+B//BT8=;
        b=sx8ZzPg/DOd/TviO5u5sg6minVtvxVHdagYOiDaUe3z4mSf3P1RPCzUk/umUTtvmYY
         gHkarJQv5BUaO+sBNNtDClP47V3+viaZZaQXwKA2veA8owpCIHnE6Ws/uEnWaQx4m2q8
         DYodzjrL+OBux4ldFf6xGxtmrvtC9AU7Ey3HrRjV8WIX4ea5L2Gx4l0w48Y/Fcce4x1/
         7TyuxwRGWCeP7QgP4vTsOaaD2fUZ/MqCnaCa2ZqkVN7NlQVkSBur2XuJYTwqsDJgcPL3
         Bslq6ntY4YdnCliB9Hl8/8Tp+Me6Ca0Ib2m9NGkrjz6rOuCaGrRUP4IXIzgiQpFDtEPs
         3r3w==
X-Gm-Message-State: AOJu0Yz1MEZsNUX4FMsk9OpEl8AwKaJpYdMAHqYwwHbksBxahZL8uJX3
	1MM1141tZwHsoHHam0cM+XQ9wTfawuayM5uyM7jH39TfOxfU9sSJdNSPN9371A==
X-Gm-Gg: ASbGnctK5dvMVPmVOnqZjKVSyLWnByJchSEQJRZiSvVDtWCx+jtmtpL3FnTfQt8KdQl
	zdYFXKIP4d3oJ+zfaZCPx5foAeBHxvMH/IgbhXrY20m/HeKQNEpxkGCqPAgd/0d9fWIKIFI6Sx0
	fMSZuJU58q3YDjvP4J4hhRtvMEdf9lZ/0sGfRjZXLcMqEcDS4j2rNBtF9/5YKr9LNggHUIxlrDv
	nU5X73Qsl19qw2RY7mwnu5l5bCv9i7/33qm74IPB6cgYpLhIH0g3jPd3Xy96oAqGhHUMJHpRqbg
	ZPhrFP464gRAGl5u2jmBuwXEbpmxuAZJ8YUPr9AlQIV+7XEiYb6ibloA9UqirsdZQ3pySOmqd93
	Dm/uElaL/yv0b8wJ1mA4WQG9S7vP7o53eRsu77iXhI74Vu0Ob9X64vWJym/eAr7Hbt6tP+gENCW
	5XBxBvBGKccqcJpeHNXQ==
X-Google-Smtp-Source: AGHT+IGRqRgvrIb+xPWV6RshApOR9ZKdHUtAlcOVStMtsKGAx91UkCTBY3iIBHtcl683A89VsfVlkA==
X-Received: by 2002:a05:6870:31a1:b0:3e7:d91d:2545 with SMTP id 586e51a60fabf-3ecbe2e6a26mr19150746fac.20.1764668089567;
        Tue, 02 Dec 2025 01:34:49 -0800 (PST)
Received: from [172.17.0.2] ([52.176.125.114])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f0dc766dc3sm7285605fac.0.2025.12.02.01.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 01:34:49 -0800 (PST)
Message-ID: <692eb2b9.050a0220.32cdb8.dc6f@mx.google.com>
Date: Tue, 02 Dec 2025 01:34:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1961787064029214380=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ye.he@amlogic.com
Subject: RE: Add implementation of bearer connect/disconnect
In-Reply-To: <20251202-bearer-impl-v9-1-21602a82ad7c@amlogic.com>
References: <20251202-bearer-impl-v9-1-21602a82ad7c@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1961787064029214380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1029637

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.38 seconds
BuildEll                      PASS      20.45 seconds
BluezMake                     PASS      641.65 seconds
MakeCheck                     PASS      21.83 seconds
MakeDistcheck                 PASS      244.18 seconds
CheckValgrind                 PASS      300.76 seconds
CheckSmatch                   PASS      348.83 seconds
bluezmakeextell               PASS      184.79 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      998.00 seconds

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



---
Regards,
Linux Bluetooth


--===============1961787064029214380==--
