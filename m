Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0933518A93F
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720086746; cv=none; b=nCMn6NaJvzbdsOd4QvK0q1cwYuvE8K/SbEqR4ZUL2aBolQ7dN0cW77SLMZsaZFYhvjxxZUMvMMHGTjx3a9kBZDcTmlrEbHR2Zor7usfIsRKgktNe1gDIUmwJN+sFCQFjEWHgfwm3Ay3uTcae8Gcq8PfBfi30Z9BYNMwxlCYzlFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720086746; c=relaxed/simple;
	bh=YPjW8vzhN4k02S3k2VlT4q3agyhFgFUUFSwXwX2XOVs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=TGQZUPwW2MdfJyDJEfO+wencA9ERXCTnKVhOrUHkq6n/9AqayGTZ26ZScoNhLcQOZtKVFFzLXFg+7my6nIDQ39YJG1JtDCoQbDkBzJ/iMet9YFehoU6vEEOKO2VyUcKLaRjAAtSOyIxrKa6Vn22jSCB0BllX5MA2xsfBn+AY1sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2KXjOfP; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2KXjOfP"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-447bfa828f9so2299901cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jul 2024 02:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720086744; x=1720691544; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7X5/dMN3qvoKIXMR/Vh5ndY61qnHBLQwdYZUludv2bc=;
        b=F2KXjOfPDEkva8cfFt8GqIQcI/4ks9mYqa56qaPNSg6tizbXYM96QqVlPwsclvX5xe
         M4+dG9NiXlxBOp4wU8pWiEzMVlP2AxQGhwtLlImoc98QuXNGAenqpsALExSNbWNZ2byS
         VfoBL5xYWvyPZOVZiw1HFzsv4yzmKzfbmqFRFhnQ4QL+x52zEYVGKJ0JFtg1ka/SB90k
         RC/fP5MmWPJyUVyrty5unINrFQDK3hJmBqzFJs9GiBp4tcqeEphWiPFA9XRX6T+EWpMy
         ZTwu4DyjkKhrtS1N0PjQJsK7IUObFiFeSP9NsyCxW9V7XhOM54WedkAO0EypbKoCfILL
         0xFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720086744; x=1720691544;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7X5/dMN3qvoKIXMR/Vh5ndY61qnHBLQwdYZUludv2bc=;
        b=P0j+bHmT4136L8L0AuuJ7gIdQpyCpX29DXc2FcrG/tpfY9IPeMpjqkbbPVO6IX5nbs
         8HNMh2dVVbmfrH+VXEIZsIE2C0s+Ek1Et+qIq/GT/hO6AmBbMntHpUK00q7nD3G7hv67
         oVoaKz2Z7KwVfp4O32Xilr9FMDZ+VEESVNzl6BcL1xWLi9Kimo2i7Tio9hHV0MpC+6gG
         QnHgSQvUfa/Ab1tvMcNyJSx65CuACjwdkxOT34xbBR0TaeLjROGwFUq9+Pp1vYGPte+r
         lRgqdHf+ZnN/6DNMi9AZ/EORJG3uPfPDmHQiPn44SRMBVPPPMBwja6OjdhxGK3nR4mY3
         PsQg==
X-Gm-Message-State: AOJu0Yx1VYz7mCysRJ4IbtqEnttmqhArtfYOZMJe2Ufe9zs2ZBfUmqHv
	at+O91BX7BAoz5mnqqJOMW+Bmm6XxzTwpmCPNMAqXgV18Wlhy9JTLUPRoQ==
X-Google-Smtp-Source: AGHT+IGm9vVDU7sFJGAGgtI3suu4J/ppaNLmaZydAat3P1tmyzMOD/CoAGCf4Ov5zr6dMbPHVo0hKg==
X-Received: by 2002:ac8:7c53:0:b0:444:f877:18aa with SMTP id d75a77b69052e-447cbf89bbfmr14623231cf.60.1720086743619;
        Thu, 04 Jul 2024 02:52:23 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.46.176])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44651404042sm59154971cf.30.2024.07.04.02.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 02:52:23 -0700 (PDT)
Message-ID: <668670d7.050a0220.36da7.8ff4@mx.google.com>
Date: Thu, 04 Jul 2024 02:52:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1147091522354830415=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v2] client/player: add error code handling to transport_recv()
In-Reply-To: <20240704074759.15844-1-r.smirnov@omp.ru>
References: <20240704074759.15844-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1147091522354830415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=868334

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       FAIL      0.49 seconds
BuildEll                      PASS      25.33 seconds
BluezMake                     PASS      1897.59 seconds
MakeCheck                     PASS      13.34 seconds
MakeDistcheck                 PASS      180.67 seconds
CheckValgrind                 PASS      253.61 seconds
CheckSmatch                   PASS      359.52 seconds
bluezmakeextell               PASS      127.39 seconds
IncrementalBuild              PASS      1666.22 seconds
ScanBuild                     PASS      1035.74 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2] client/player: add error code handling to transport_recv()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
7: B2 Line has trailing whitespace: " V1 -> V2: the name of the patch has been shortened "


---
Regards,
Linux Bluetooth


--===============1147091522354830415==--
