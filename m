Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A070620DD52
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773764522; cv=none; b=r64JdfaNj7OdTnz5ivQaMFmSvDs/LurpUaQdztX94wPnc0oI/PuhBUBW/86t1B/DVRtGHgC0ghiyf64+ixURvLC+0TbBsMqUt+9nTFd/58uagm/z2R12ijoNA5tDupZy6lawGir24rSCaIYR+wBj50XznfzCRpozuPlyZcly4p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773764522; c=relaxed/simple;
	bh=BR71fNf0mKH2cLLFW2Y0qkjgOkvvpGRegjylNGpuny4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=iyazjFBSQWKPG8H03tCb/6JiMbXJDwYuZBRkz1/plDwz2RnkTQEOYYG59E4XjqGbYz0gR8H9t3KKu6JqlHhdLtBeRCQqe0lYBajdmwyrRU7TzZBmBcezds+jbE1vg2rW2zPZfuIjNLxQuPk0/FqSDBLVurZC6L421IDeHXjfpXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSgxBbS7; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSgxBbS7"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-128e4d0cc48so6854471c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 09:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773764520; x=1774369320; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OmC9okkh52D7P5fygQ12WnkKeqwTo5x/a7hgpApwYwQ=;
        b=hSgxBbS7btRZxCxj7PojHgUF05qeCJCAOHiJTlcT1Sz5Ur2ySWjjokis0EYS/RiYsk
         pbRAFnBpmXu7cDkRaidh9/QzQfNYw0LnkQpPXN5YAD30/HSGvK1E/otrRivRRc5dQ/IE
         eQmjJzvOhiwiHZJUaDvYxceIEMvW1WjsvMZgAs7Y1rmCh+A5ISJ5QpZNql1QH8SoDb+e
         N4L1GeYu3lCfZw2m9yfHnX491D5DFDfG0mtrzZFabAEJWp6Bxfgtx+oHZ3fTU1Aie9VQ
         lXuBUjiAjmS6KJJVei4BaOcggHCS8bYH0XUmhGG6SNUuq4wh5k88vdRd9livj1p/E9iI
         eL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773764520; x=1774369320;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmC9okkh52D7P5fygQ12WnkKeqwTo5x/a7hgpApwYwQ=;
        b=kHVdPHh02dZPuOMvdBC0nrHwYEZlMfSGd1fa5re+wseMoDyxlgixJZ1x0hXxLoSqZu
         ge9apXB2s4wYyAMWFF2q1dzgNJrbTHClC+3IGCD/5j1djtUeWcr+fyQxnNmf8WKsoBbq
         Gkpr/BZ/YFvillYUWl6UWv+riuWyTRdSJ4zzqDNSTeIGQTRUryDgp3TvLkp95Wt/P4mi
         XAWjXzm9/pOCkRtGPBxzlaA+6RWETaNyMySZtKx15GacoBIzha5szYo1JKXVpY7jWAK/
         lLbJ9larjPoz898+tS33HsvJVTC4MkYkdh5K/0bzIw6N4NoBzuyMNcmLd6AU+IW1kp11
         O4LA==
X-Gm-Message-State: AOJu0YwqaHCiD3fDvKYun2I012HI4qlB5a54fNpjiKQq/HdYHi66aKiu
	jrFVsPf3/xIML8dE9cjvRJwKsyrBqVB7XWXhYWGSQStC93BhvmeV6mq95RZBWw==
X-Gm-Gg: ATEYQzwH2ZPQkkko44KtFBj4SwRWj5wE7u13e827Ep+U8pwFeSkE0efmnGDKEBhZb8C
	w1wwAlSNszNn6B8Sx0utbI01YhtvkzLOlVM/pjYofrz7mOwmtFN3WbBjTtpam8gavnN3mgHnoHY
	cCJUtaA7uqHIn6dDSL4ueKvPwbp7atTqxY1JC/1N76Qdhjo6UdvuHOMCTgKUYajoWver2K/dPSW
	yNT19t65UKtH642sWgcKY74kfcB1pKdzUTYeHCMqKfZ/a/C8YAvVTvzestdiLLJTsb/cUQ6lwh9
	K30+Mah9hsmREMZCCVpkImOFmhk5xXWHZWTLVEcPrvMd3PXLkLz2BbXzUWIUM1rHrsHdLFEGIqq
	FRPtVg/T2F9ome3sUi83B2i1m9u4uYHksapxkKG/YQwXclVIdbzKtiecjIwcEVrBO+3LxpVyKlq
	TmE/FOQIhENUPkw/lZpWHK27uv7Pae
X-Received: by 2002:a05:7301:9e41:b0:2be:f9d:2cbe with SMTP id 5a478bee46e88-2bea551d714mr7932115eec.31.1773764519847;
        Tue, 17 Mar 2026 09:21:59 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.128.99])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0c546923bsm9376530eec.1.2026.03.17.09.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 09:21:59 -0700 (PDT)
Message-ID: <69b97fa7.050a0220.91f67.ac3a@mx.google.com>
Date: Tue, 17 Mar 2026 09:21:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7771546381796881373=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, raghavendra.rao@collabora.com
Subject: RE: client: add public-broadcast advertise helper
In-Reply-To: <20260317142645.6332-2-raghavendra.rao@collabora.com>
References: <20260317142645.6332-2-raghavendra.rao@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7771546381796881373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1068070

---Test result---

Test Summary:
CheckPatch                    PENDING   0.53 seconds
GitLint                       PENDING   0.56 seconds
BuildEll                      PASS      21.05 seconds
BluezMake                     PASS      643.60 seconds
MakeCheck                     PASS      19.19 seconds
MakeDistcheck                 PASS      248.59 seconds
CheckValgrind                 PASS      300.93 seconds
CheckSmatch                   PASS      366.26 seconds
bluezmakeextell               PASS      191.21 seconds
IncrementalBuild              PENDING   0.48 seconds
ScanBuild                     PASS      1029.10 seconds

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



https://github.com/bluez/bluez/pull/1967/checks

---
Regards,
Linux Bluetooth


--===============7771546381796881373==--
