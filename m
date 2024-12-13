Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9010C1A8F85
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Dec 2024 12:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734093305; cv=none; b=QUZM9xd2xow5/LtAaPsDhqSO7YSoOGwUR/s0fHGpI1iyyO7FzcH8MC1zhgrFBKtLSYSBHdrPynKjhnc4pdd0yWZ4UC3phLZgitJgxNb3hpppHJuVF6PmazFlLJ72OAL9wA5C7pRCSyqF8jgQvwlG7vmqnhbe2NClLmrV/i7uHNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734093305; c=relaxed/simple;
	bh=5+efanJ05ct6V9GDrqxhLKflH+DuqZXrbh5lsLoyBNw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=eTnH+EgayDA/bLA8RH08iT8Cl4rD5rtNE5AzNqaQZ2JB8XwdTlw1p0NjIYQ/TvWJI48N+cTKFFCLNNud9TJPBwJMDUUastM06yn5SwQq9fXjxW2kqLagMjtMMg8vjVT7hMMr3rDrqVwkCVvMOxpWJpo/xBMNB9iWlAoD8YcaL1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7PitbvZ; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7PitbvZ"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-46741855f9bso13739961cf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Dec 2024 04:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734093302; x=1734698102; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u+5JAOBIuMN0jU+vFmVOmIIT0dzUxlKW2ojx67Al0X0=;
        b=a7PitbvZ0Z4Cv3W9+3ab957TJwVatYBVEoeCfExxYvbmdCkP2KKhsofkqIYxF/bZ+c
         K44kTf1PmHShhHQp8n7j5aWQkK3cQxI7BJWONCukOmyjEYWA27/Scsm6BhrhGPvx/iSD
         iN71JMbX7U802FNCY8TuLi7c8UMShXhBGIapaC1OzOtMcwT5/u/KwLPkP1elX3cVcTqz
         HPTShvfv1bsYO2FTu6y0cD0daG51Thi8ng0/zzEJ9kfxv/9Vh/IhRqRUEaz51Q2x1yub
         GRWd2UJuDPRQybPLqCSohof/hvDVw0WK8t7oTs+k19mtDSiBq654fzekbVTyjr42itde
         bmBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734093302; x=1734698102;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u+5JAOBIuMN0jU+vFmVOmIIT0dzUxlKW2ojx67Al0X0=;
        b=CgCYgz9YLDcirPQeMEL/DM+OFaWWtGK3AeW/jLfcdRYHJDQKXt359SZyhU7za9+5l8
         MEHQldQ+ES5HAS/Iz8Mjdy0d83TTxYVEy0qrqvwZBC8sRyzuHIcm2wZOklcIHs/TOK1L
         j1fJs22JwFau8rz1a/nCBHl2TUgCZjLvcPnmzRNkYfJeNZ9T7DU5txlsM+bH6yInBNy4
         VxdjU/3go992vaRMrco2OT7bh4mvsC++ZqetGvyZS3a5i7VN+K9iTZMDyiqm29JEUSkt
         X1GHbmBlrGQz9Go1kefr/dJ5U7UmQcbUk5kP67Gmt7GkTVCZUQSAIVF2ygJTLkwNkFyf
         MKug==
X-Gm-Message-State: AOJu0Yy4iicnow9UGVI3FBHowcvbJvtOmB7Ys47ScBQ3posYMGHpwFly
	8IsLZAXv5IZ8oho/tr5V2djqz9SHg1LomasqzGvyEZ9sUe7YD5xv/Kk55g==
X-Gm-Gg: ASbGnctVI81qXjztk6fAjxlJJJrxE0iWp8ASmOExrVmgIc1P/TsF2KPzQZhwAPDEqtL
	llSOtxvd2WIm0Ni1VtJ8doi7Jxw0sp5ZQ1AvwHclR4KnPxfsUZ8M7JNmnqaMOFDGmGSNIg7Yd84
	Kzsi9UjZJFkYZhcmo40Pydgx8SQIH7dM0f+yO+F+hPAKTFkEwieszpCWK0WvF6ADFOnq/v70Q7r
	56V3Jt9gcsQjctdnY74LoI6yuxE6mT7r0RVYg8WdWdR5BeuIFOMiYvH61lVQJU=
X-Google-Smtp-Source: AGHT+IGBToUloisACxiPgyf3xpzn/dWGuEwmkrFEPbKJiBxSls4xPOsFj6jzkfqnwIw44MqXISLjfQ==
X-Received: by 2002:a05:622a:4d43:b0:467:5ad8:a042 with SMTP id d75a77b69052e-467a5799f53mr48976591cf.26.1734093302287;
        Fri, 13 Dec 2024 04:35:02 -0800 (PST)
Received: from [172.17.0.2] ([74.249.14.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4678afaaffesm28574621cf.85.2024.12.13.04.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 04:35:01 -0800 (PST)
Message-ID: <675c29f5.c80a0220.1483d7.b8d2@mx.google.com>
Date: Fri, 13 Dec 2024 04:35:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0492516920073644191=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: client/player: Make QoS sync_factor configurable
In-Reply-To: <20241213113113.64818-2-iulia.tanasescu@nxp.com>
References: <20241213113113.64818-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0492516920073644191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=917572

---Test result---

Test Summary:
CheckPatch                    PENDING   0.22 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      21.38 seconds
BluezMake                     PASS      1682.22 seconds
MakeCheck                     PASS      15.38 seconds
MakeDistcheck                 PASS      169.82 seconds
CheckValgrind                 PASS      226.42 seconds
CheckSmatch                   PASS      289.94 seconds
bluezmakeextell               PASS      103.76 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      907.43 seconds

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


--===============0492516920073644191==--
