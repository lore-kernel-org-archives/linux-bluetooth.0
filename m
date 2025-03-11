Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57261E4928
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 06:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741674214; cv=none; b=QA4wHMQghS5M8Zc1b2uHkO+BkjwZebxG1HBDIz+i4xojpEGc939D5YS2JuhE9MMfYVWJWdLGcHtQcoW6CHk37qECYhI4diQ90kUCZE/Hof7BsKYl+yqY1IeIz1ylQFztoVXMDfJgkCZqSUj4r1eiA40849Q5P2/eAfCeo537GI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741674214; c=relaxed/simple;
	bh=etREQzhfwnGD3qPqqOx1l+juTx9A0waUprs9e6NhdnE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JygqCiBmYSUnp7mYxRotLvO6bEO7O3Un9bkOg9eXvGn8ZBQSyyzAT8+IUzy1MuC0ji8UwzGgJT6o+RCgtc2QcJp42aCK9LwJEYX1jetKiABFhyd5tHe/0fwM3gCyNklLqXIViSY6YrE0ptZQcW+064/hl/v5EKm+nFDTcYsNaVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzGLnocm; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzGLnocm"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7be6fdeee35so982552085a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Mar 2025 23:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741674211; x=1742279011; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=etREQzhfwnGD3qPqqOx1l+juTx9A0waUprs9e6NhdnE=;
        b=BzGLnocmdE9OronuCA7ejvXORC0Fs6C/VZ5eN8JvvVwX5R6WWO+6HQ99rK41szeduD
         MahGYZpdFhHH4KuM13KT+5sQmQlerZHTfS67WcQNK02fIlT3uSkcDpUFKQhfnnEWaV7q
         KOvVFDAhFin8R/UCrw1SUR5AJYA9pr4mhJ8SwmqhvcdeshYYUklQ4ktuvtrYO4XtmrtS
         NVUo1OzB38xBtsfFFQlu9aJ2DX4dQbmNhWCuti1vNMAUfJA+gA8yms5vrJo8lzYaNGGT
         N+P24vWOQxIoW8Sf4RmcYuPSR29eoCvvWp/sQniF8aZOPtSnljN7pTriX5aaSpn7ss2E
         9+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741674211; x=1742279011;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=etREQzhfwnGD3qPqqOx1l+juTx9A0waUprs9e6NhdnE=;
        b=PgWgEM8IO8Bbjy1eeGbngQoUsFXz/fNHeRzFuhJ5PCDuToogolxvH9lVR/hXdyVy66
         Gnkcz22RoiLfrYfDCrLTaJyhgqirsPoprYVUncw3qG3eciP4HXypkcrj1ND3ykKmayT8
         e0gz0ncS4tw8zMNeqgcSnmw8KhZdtk5Vl+3St6hPI5PAItWeUgB0B/BJDE89tjOrJEYG
         JAn6HHGIY+EcqD0bmAvN1lv6LJbAEQnbNRzd1l3LQrkryeYouPYxWuExHzVBzUrWDKlL
         OMXoymHtkK5p5nMtFfmUN0PLmzDUK2eP0+e/gzjbnxRwpLrOTuQZLnfVjINvxYBX1rO8
         8kqA==
X-Gm-Message-State: AOJu0Yx//4wjhlom35GkaRMV1vp3JHL+i0oQoh3ZGHNI0/YtQOD947FQ
	dbFT8mWaRjTFlnj0i2MBlr4+PASg6mSqKOiK9zy+B3Sg/3KQu1VDRAzmmw==
X-Gm-Gg: ASbGncuMLzSWddSuoyeRnZamo5Krqa4LRB/HHCjESRQFxj27w9IhVPZssUtmgyelOHC
	BTbiLDZNM8P3E10eK2rnhI0/LgGdnYVV98rLLxPakq0GRbX+wbyePcr9X6YqMnaDlSrL0bLOXTU
	HEdPVhOUHSVGDrSxi3V2zJZueT6K+D6EBICUM+CFaugQBJQ6UifGymMF/JOj0UzQVOibVhHGqAW
	eJ4jf3HecvZBP6PuNwy4ltSUshn4JJSWEoC4EQKNU1AMjqTIrVvr3dgQGw5glkcuCKgUIa/LyAT
	5PompYZ5BXjU8Wg/TQD/Xa2uX9aLZ9mBmFn9MdunwQJJ90j5lA==
X-Google-Smtp-Source: AGHT+IFTDvmRTZYyLjFv02mGvym0ehdqxBU5pWZQMT+RS8T024mo6KTtsn5URok/AKDkDchfrPEKlA==
X-Received: by 2002:a05:620a:838c:b0:7c0:b7eb:4427 with SMTP id af79cd13be357-7c4e1677872mr2058491685a.11.1741674211300;
        Mon, 10 Mar 2025 23:23:31 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.192.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5477d9df8sm433619185a.73.2025.03.10.23.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 23:23:30 -0700 (PDT)
Message-ID: <67cfd6e2.050a0220.2ab63e.c64e@mx.google.com>
Date: Mon, 10 Mar 2025 23:23:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4294915418507386868=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kx960506@163.com
Subject: RE: [BlueZ] Fix data type in bt_hci_send_data
In-Reply-To: <72fe471.4f65.19583bc77c9.Coremail.kx960506@163.com>
References: <72fe471.4f65.19583bc77c9.Coremail.kx960506@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4294915418507386868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: corrupt patch at line 14
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4294915418507386868==--
