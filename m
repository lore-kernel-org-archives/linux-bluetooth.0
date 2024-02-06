Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0319B12E1FB
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Feb 2024 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707219047; cv=none; b=nxZcyENIIB3XBnIX48OeBdG9dytTyXdzMyk92HGcnVsdJZoSZbs3C4IEoHiSUKsZ8cCrhPUsSqIDG/VX+ctaMw2e8pHTPG19FK7AzQzaZGZWhhG5W6VF8jjf17z5LYxOFChWRR/hsZpawUr/GJKb3q0rcQNAohMs60G4Fo4YdK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707219047; c=relaxed/simple;
	bh=lujMjl/djX9uD0tKYENU5tyk1dzuNX7qXUIqMym23wA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AWFmPUbydo3fuW/Nggl07qCBSDCcfxgUKv8ztsI6YmZNymnh0ZmZKEAb+raE0QHzww/7t0vXALre9Nn2JCpq0HuAqsNbHU++bMisbCWEcoPs4hLC1PSDT4q+MtkH4hUD4lWVgXCePMkZqjiKFvFncDsSdxod8787q8AMItki/dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0YUYrsh; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0YUYrsh"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc6d5206e96so5035756276.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Feb 2024 03:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707219045; x=1707823845; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nhKZ7d2lHsWqzqDom6gNTdgbCRnCw7jE/qREsvvM+XM=;
        b=F0YUYrshcMefDvf0L8Y4Prqn28Ib3yVQ2zGYcoI0vJoMmHqCOpnuEcEaGwOQkmN7CP
         6w5t6myGGhan0N6OqXcAcOKwGQpSDxQc5YHeexg7GWSdvahnpZ61WkPyBM9G8KZqpav6
         uJ7Tq7L5vjG4HocQq3azqusBCxdoYzm4fVGp/U3QVng/o50EepAVDSCf0EK+k63Wm2sX
         7FSdEYva6dRz9Y1QN3OWp93z4NDdfieKA6Jb+5QGbGt+gjW8GLWBlPzSRjj+yDAHIlC8
         kKjsEsYvZOC8jnU3FfxT2HVh6aRe2hVma7OFHjP1TGfP5nRQMPlMnzCJfZmvRK+iGEw0
         PF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707219045; x=1707823845;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nhKZ7d2lHsWqzqDom6gNTdgbCRnCw7jE/qREsvvM+XM=;
        b=uyvJKEpTOdBvLs3vKlO6/GCHpI8ngjgBaVKrx7SRqCtXRWk6p7VEL0p8/hS0V6tpS3
         4681XmlSq/f8SNsHQJ8IXYyq6lp6RH0j/AREf4BimldOTA+gKXgMWDP1D1aprkh0BAU2
         ikHrjuVJIBaSHN4S7B79SssqlH55bkprSJ+HEtDyObhou+ya7fyjFD7UTKs0XQjmAwUI
         zdBOiFupZhEbmgwapw1vqs2166LzC4ZxKv898i4/4HFj/wgkSdCE0jRbYpVQxHhmKGDf
         uAwGs5Od1GKznRkj5XYXazfAgDhDDgtX2lMt4dhaAlPukYt+A0QxpaCku9nNyj5IXInN
         BaBw==
X-Gm-Message-State: AOJu0Yzxu12iB9QbDafWHyclirgla67OgpsuhgzeKlR/fpkVBJav7vad
	Rg5RRrT40Vxe2ZJS5VIOHiLjxRI/mYGwelPogk3+hWjpX2c0UoWdWWk1OkVm
X-Google-Smtp-Source: AGHT+IF+F6Dml9UnGAsstAB4/tWUJikDcGm9EbZD57Br6R9HGoC0yOv4SbmLIYxYFvGm2furXDInFA==
X-Received: by 2002:a25:2e0d:0:b0:dc6:194e:8474 with SMTP id u13-20020a252e0d000000b00dc6194e8474mr1131407ybu.50.1707219043320;
        Tue, 06 Feb 2024 03:30:43 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUkQjxADljKM1DSeQdoLB4Nl6uG5u6sYqXAXHjlTQub6am55SQuP0eF9kp1QHfl7gQOPa0JDscOmOZMbmD9Fw==
Received: from [172.17.0.2] ([20.81.46.156])
        by smtp.gmail.com with ESMTPSA id t34-20020a252d22000000b00dbd9eee633dsm468042ybt.59.2024.02.06.03.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 03:30:42 -0800 (PST)
Message-ID: <65c21862.250a0220.bf5c8.2054@mx.google.com>
Date: Tue, 06 Feb 2024 03:30:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5274042061611699627=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, verdre@v0yd.nl
Subject: RE: [BlueZ,v2] mgmt-tester: Ensure rfkilling HCI disconnects devices
In-Reply-To: <20240206101415.46505-1-verdre@v0yd.nl>
References: <20240206101415.46505-1-verdre@v0yd.nl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5274042061611699627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=823512

---Test result---

Test Summary:
CheckPatch                    PASS      0.53 seconds
GitLint                       FAIL      0.49 seconds
BuildEll                      PASS      24.02 seconds
BluezMake                     PASS      713.96 seconds
MakeCheck                     PASS      11.79 seconds
MakeDistcheck                 PASS      161.79 seconds
CheckValgrind                 PASS      225.85 seconds
CheckSmatch                   PASS      326.21 seconds
bluezmakeextell               PASS      106.89 seconds
IncrementalBuild              PASS      663.62 seconds
ScanBuild                     PASS      919.83 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2] mgmt-tester: Ensure rfkilling HCI disconnects devices

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
20: B1 Line exceeds max length (82>80): "v1: https://lore.kernel.org/linux-bluetooth/20240128210547.16141-1-verdre@v0yd.nl/"


---
Regards,
Linux Bluetooth


--===============5274042061611699627==--
