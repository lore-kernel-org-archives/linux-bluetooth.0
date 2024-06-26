Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FAA17D356
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jun 2024 11:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719400381; cv=none; b=js21gLXBi/7eqKhH2hHH1KxEkdso6v9Hg97+NzzmjNxCoC+G05tWt1JAxlfAgu5VLgbAA1sFaKCdIO5md1y/LL3kbp8QJfz70X8ap5KC9bEGJssyaNATHawWMxTSHLp8t96K6jaX6+nrwG0myPmAivvw+Wb9Ejj1N6zOvsdgsj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719400381; c=relaxed/simple;
	bh=ueq9slypc2sY6GiJnwF5qk4jYm/9eOlKGv0CpEaXszY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DYmy++E0PHSdEiJin6eEPUHgmByLPMKPA8kbl9XF8xOySFU/puC+TXiU2Wr5KNAGazI81aQ19AtixNg1Mc6gmxxbH59ShpNJ+BOh2z9lftkzL42QBc9UEV9DTN3hSdEpKqszPU78zhvJlRSduC6Ap/bLkHFT18tx2IKzDPUw9us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfhxGTuZ; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfhxGTuZ"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6f9398390fcso2165909a34.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jun 2024 04:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719400379; x=1720005179; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ueq9slypc2sY6GiJnwF5qk4jYm/9eOlKGv0CpEaXszY=;
        b=QfhxGTuZejMK9rhx6ysPUG2P1cas92r0qhv2kCUG/biPb0WeRP6CSENGlkA6Dcce7P
         hBJ8OaLgqwXDovKXiVf7cutpP4O7B6fm9K78dl5vSs5QDSPmDBRLljPsHCQ51o7D5u0F
         mM7n5KgoAFqnwGedQqc3HgicqJtfsnm/u7EJvtRu0tZt012tHHDrx1kFH240LYiVYt5X
         DuZOahrZ1H3HZPQ8qZW/zo+tpXoTfgQTNqWjp9Oi73M/sm0u5G++IWOxjikswqVkB3NY
         0xWeW4BCDbK19q1mvItiEWWjxebNyUgt0KKvHVyMGET2jOt6bK1B9KKo4JfXaK29Uk01
         PwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719400379; x=1720005179;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ueq9slypc2sY6GiJnwF5qk4jYm/9eOlKGv0CpEaXszY=;
        b=PDVuf+pj5QHWLJvkifQYjK5BfRO7BBYRwxtPUCkadbzXyIwaXC/abnrG0b3uoixmXi
         BHZcyCZuXZTiOBg8WIxQkNHNI5jmDI33PPYx6+AjrDnpC1AQG6AA3Jonnu9agV11BQxw
         2ioxf2PJbfPVsyBNF2FTxQb5yNpbIzY3C5Fr1faSM9tBPuuE629JE8TCqh06lCg9GGr0
         Ra3a5VisgBRmKLAq6kO+vjDWn5ZfBuJ6eUNY+2QNs2i7eG4DKVIYeRG+DV5n7TvpPAba
         7P+hkRvi7RVpF9w5zm5CUkc6rGVjpQ6yfPEr6U2qUCixBjFil4HwweY2H/wKJmYJ5+hc
         kB1Q==
X-Gm-Message-State: AOJu0Yz1vaRbRy6VLbnqc0OLMK2GnInOcyGgw9zrswn2EVMsXbYMJ2PZ
	H6vpvwtUGzWqhcJqSdn8rwFVlGCbdA7gia841iseC7EGPAjfeqhV4ml+Vg==
X-Google-Smtp-Source: AGHT+IEORcAfpynO80g3BjDzAdrfsXGYV2w4QRZzccwzM9sj83rdW1B7HB2hvQcYGPpAhntpoTfWIg==
X-Received: by 2002:a9d:6b0e:0:b0:6f9:923d:f2ea with SMTP id 46e09a7af769-700b124a9ffmr10290604a34.25.1719400378584;
        Wed, 26 Jun 2024 04:12:58 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.111.194])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ed6dca8sm53135146d6.63.2024.06.26.04.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 04:12:58 -0700 (PDT)
Message-ID: <667bf7ba.050a0220.a82d2.1720@mx.google.com>
Date: Wed, 26 Jun 2024 04:12:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9097359295295953853=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kevin.courdesses@beacon.bio
Subject: RE: [bug,report] GATT server crash after client disconnect (UAF)
In-Reply-To: <CAH4xE45xkoHOY6kgYLf=HVVrMPrgqDZzRfEwGi3Ozi1MW4e+dg@mail.gmail.com>
References: <CAH4xE45xkoHOY6kgYLf=HVVrMPrgqDZzRfEwGi3Ozi1MW4e+dg@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9097359295295953853==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: corrupt patch at line 22
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============9097359295295953853==--
