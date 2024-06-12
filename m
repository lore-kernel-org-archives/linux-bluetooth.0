Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB2121360
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jun 2024 21:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718227891; cv=none; b=b7a1JGMEitv8RJPaMy+S8VcwSJzFAiF7OFZ/ILnhV4/yEszgDJATb9Nhbug9NCAtgWW22yqB275RZcF/LOFIohouyRvpV4AmSCQQN9dD0NISO6XymCxTvn+yJo+kg0CW3FclajJY6WLClNM9wojtX0svAlYVg9xUs8AKVcDI3wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718227891; c=relaxed/simple;
	bh=2SzJLAFjMWzl02XPBm4+rbc/BNyMesH3P/ybkZo/hv0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dJRChWzBuexrHtp3G3ZgHqsCZx8jG+4URntAYN+8aarGtARHr1p/tUMcF7lMeQzZ4Hf8ZPXXL/xnfL4xeb/YIOcMfC/wPKza32pvxLUKQpzEnA4/+BIKz/XSkU4aGI1WAHTBHxQbYln8ruVuItBXDg38tT0eoke8r6ws/7xqWSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Un9yhcFo; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Un9yhcFo"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-797a8cfc4ecso15683785a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jun 2024 14:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718227889; x=1718832689; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cF3YnopgqdZSdnA/53fMhjRku28zUuwCQEyTqjHyaEw=;
        b=Un9yhcFoXunMxEw/v2sHrbFKs+RrL/f4QJET3AWGKzswkqZgAdb+FaVT6xzXn9hW0p
         vXNjISY254xYTWewGG50XSvQc58qnEUR7uBsV3mt4ZzFmpbtyxvVagv1Hd1OYO8VNFle
         SgtA3gFd1l1+ueryjWd7thpC6MTrZNso9btc1Wlwpjq0FHYNhrdlrrgh+LXcGSwa96a8
         HidO5CYoHexMYqzJfDsTaa3IK67/KmSdcBtaNLJYxJPzVcgBH6Qa1G/XdaTRblBIWLDD
         ejV9cZK63/OzfX0wXPOGMHYtPWg5BnC1Pam+EpRP1WU6ETK2+n+e1kE3UPGA2xizqFGo
         ynDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718227889; x=1718832689;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cF3YnopgqdZSdnA/53fMhjRku28zUuwCQEyTqjHyaEw=;
        b=uFkSqKh+WNwHVMnTROD7ZFOurae2WKmvJN0QNrrS74Ml8aOb9Fum2j4QXBOAoIvEd6
         wC91jhn28LLBNzjmPOa2D7p575Oq0srozn6oJzx0Lou+/AEFU1E8Hk1v6l8FBnW2HtE9
         Yzal2AWvL5MnUTtJpEgaRBnYwwTQ2iUMH+zZPSuMl6Tob7eOWyNho7tJed4z3VyLHMtv
         zlzbQ1qCqBTWDp34zoITu7ipvFkK7MVSoDYIJBHxjzdu0qhJiD958zVlLuIOAOxlaseN
         30CF/mAVuXPk2A4nuOatvnT1WUeCeQTWSLTH1Q0kFPPzoethfdOPi4sT4LXO+VuYvxSW
         kDTw==
X-Gm-Message-State: AOJu0YxskUBL07POuD4qhkxNRS64Kl+nMIzskSpJbK75RXT5IEAX6Wml
	pf0QOW4gb//FA3CWhY9RjWRpg9z6bjBFFZCCSj5rBLA2nnxNXMJYWFGHNw==
X-Google-Smtp-Source: AGHT+IGxQXxQ275KADcltwWj9g6IR4JYrHnywMDTaIhGrq9jMrZSkmm5+r0CTQF5yFtcBvuU2UgkDQ==
X-Received: by 2002:a05:620a:4688:b0:795:5d8a:2473 with SMTP id af79cd13be357-797f6056e77mr308875285a.32.1718227888806;
        Wed, 12 Jun 2024 14:31:28 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.14.227])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795fb1494easm309253385a.60.2024.06.12.14.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 14:31:28 -0700 (PDT)
Message-ID: <666a13b0.050a0220.a23a.e138@mx.google.com>
Date: Wed, 12 Jun 2024 14:31:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7198858905534170448=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] device: Fix storing conn parameters without first attempting to use them
In-Reply-To: <20240612191145.1379415-1-luiz.dentz@gmail.com>
References: <20240612191145.1379415-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7198858905534170448==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=861326

---Test result---

Test Summary:
CheckPatch                    PASS      0.95 seconds
GitLint                       FAIL      0.89 seconds
BuildEll                      PASS      26.16 seconds
BluezMake                     PASS      1733.63 seconds
MakeCheck                     PASS      13.45 seconds
MakeDistcheck                 PASS      179.58 seconds
CheckValgrind                 PASS      254.32 seconds
CheckSmatch                   PASS      358.12 seconds
bluezmakeextell               PASS      120.42 seconds
IncrementalBuild              PASS      3141.96 seconds
ScanBuild                     PASS      1014.64 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v1,1/2] device: Fix storing conn parameters without first attempting to use them

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (87>80): "[BlueZ,v1,1/2] device: Fix storing conn parameters without first attempting to use them"


---
Regards,
Linux Bluetooth


--===============7198858905534170448==--
