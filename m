Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21821474A8
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jul 2024 10:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720174507; cv=none; b=nvS1TINfwXgidrHEVYw3buTexP//H0qQ6VDLWuSakWK2KuEI4q9oHbUinfqEwL+cgNIjiDFgdVF7zL+bgLd0YNxaw3Ena2QSsegFj3GmoTWLXJJtlyH4gkOai+Q6xDMeqexZSb3Mfp/wLtJh15FCNLZNDWv+nsihr4mObNjkaiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720174507; c=relaxed/simple;
	bh=Ebe+yjSQd3ytHdQOB09O1N9l8lTKPaL1EGOvdLWpcvY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=plyBckjeD4EC4vJdkpZXQaXa1E6Un5Y0vx+fY9mmuN89sgtr/+kJgRqdCZa8g1dcfmqok915Hnnz2POp2FgZmcoFM+fKZQ8xE8g3FNMpHFrEOfpKyB3GzzPFWiKYHWlMiG6+3T8S5IhEWe/AAb3OQikd1d9pVY4IWec26OkfxyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lynp6w6k; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lynp6w6k"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-79c0e7ec66dso108049585a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jul 2024 03:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720174504; x=1720779304; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ebe+yjSQd3ytHdQOB09O1N9l8lTKPaL1EGOvdLWpcvY=;
        b=lynp6w6k6ItG8JEUZcDt7fYt6mfVCNxXO12s9fm2arxbrekJ5N3qKMXf2z+ZJJbXDA
         iAD8bGCzFaSHl8ktSfmQCR/xGIPAxppKh34vSn0xIOGObrzrJJJDqOVdsGVz/fySJz1y
         WEeLIlxKtMi/+QKB3BrZaa6MQI0pnfvc6qTYoZd7zDy61dcPL6LjIoM4Kmx4TjaITlPq
         JUYkm/x2sKpbVrMiYHX9d1GV3vRkb2a64kntM62TP4+hM9S8AZ26cYEzoa9n5x+rPBKC
         wJQrYski5NpzCRtNA57R4W6Bh9tftTTmczG6FWzbckbuaHHvjEde1T77R+S9eO8fvIju
         Tk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720174504; x=1720779304;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ebe+yjSQd3ytHdQOB09O1N9l8lTKPaL1EGOvdLWpcvY=;
        b=pQUkcFIqdmr2hN/cEAKwdBxBa4V4hhY4RhSEsj8rzqRo8P1oIJOWNaHDxQIodOJiu7
         g7gJ+7/QSuoJ35HX69klxR/BTcVFFiako4l3Ha5049iWMjndN9O839Uj+W4WlQUUVM2u
         nk8nIc2hM5e2HKJ9enpOZh1QvASLe6JMdJw8N7GD+NdDSO/PrNwwcqzD76w6MkKRXX0t
         wdES14s5LTSeoPpEQxRapZDm3iocrGRV/bkf0hdYMZXBMNkJn1si16G5xyrBE7CsKVXk
         Ak3F6Y7Y0o0s/DrietVtOKWXRXN+J81vaJYHWqJwjmS0i/WVIbQd+bpSER1vopQUo7+a
         FZZg==
X-Gm-Message-State: AOJu0YwmS8bOmH8N7Lwvwi1oUXNMQF0DJZM68p1wKkkYFdqEJk8nI7wg
	l13AMh+fsnQ4Kl7SRZCQ9F60fAF44c0lNXKrIRh8mQzDRxWjaVBqYkYqrg==
X-Google-Smtp-Source: AGHT+IHDJbWY7EAePyGuaXGC6GYwGLIw1n3dCPk7e4d4TT+yR7SXX6rNicA0KVb74qDM7592sXK9Qw==
X-Received: by 2002:a05:620a:6113:b0:79d:93a7:8c36 with SMTP id af79cd13be357-79eee1dfbd8mr420889885a.45.1720174504341;
        Fri, 05 Jul 2024 03:15:04 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.47.96])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5bfcce25esm51526576d6.78.2024.07.05.03.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 03:15:04 -0700 (PDT)
Message-ID: <6687c7a8.050a0220.f29b7.33d1@mx.google.com>
Date: Fri, 05 Jul 2024 03:15:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6985061534781963563=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, guanwentao@uniontech.com
Subject: RE: [4.19] Bluetooth: Fix incorrect pointer arithmatic in ext_adv_report_evt
In-Reply-To: <20240705100106.25403-1-guanwentao@uniontech.com>
References: <20240705100106.25403-1-guanwentao@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6985061534781963563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_event.c:5402
error: net/bluetooth/hci_event.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6985061534781963563==--
