Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686CC14F12C
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Sep 2024 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725975651; cv=none; b=d/lyjRWBx/Kjk6uAxxoYq+Q44uDKfelvAy2X753P25O1TdvW6c1k3Tvt72099sP8t5Qaiq0wh1tW2mkPypZaU3Fs03a1EFoAfyqLLO8zHnuZGIF34MtVoWEmlgFr5hzOu/yjnF9SThxUgXfI6Wn4lZrLzHMmYS9A7zXEEWxF5Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725975651; c=relaxed/simple;
	bh=ua3CNj7QXZmWPjFqqHq73Jkfl7HTZy6CpyvJQrXC6u8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Dp50z3vyIae8Ji9natZaDKInsPLYusVi6GKZkO8PakirVlKfv7kzC5UT7zZBsEtfXfXty94PoP4IMPEZIX1Qzmy3xPvMlPxj+lqegCVE8XFIynncNUNJF4jzAh2FQGN/v52qzKE01ZwbPi3NU/Lw6a/Q3DzzbR9TgvE7uYonurA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiMtOYRi; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiMtOYRi"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6db9f7969fdso3994117b3.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Sep 2024 06:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725975649; x=1726580449; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ua3CNj7QXZmWPjFqqHq73Jkfl7HTZy6CpyvJQrXC6u8=;
        b=KiMtOYRiuh0nk0Zm0y6qbZfTKTb+Glxa+ZMo6NQI/Rn5zlVZPNu4dh0Bhvk3Jm1Ggt
         bJ6l9qQ5GZvq2YFuiZ3z2gh6WjOQ+2VMItYT5DAlIB9HJRWWo6A9cwBOE6zOlzrK6ucx
         bVrV7T7k0JhN3I2zMZjVhBtQjef3CLYaahHhF/mwsRzi19LAzVNqY/lsBTATIUJci7ZZ
         5A7zsqzjpzQIuJ8ncj8PX5V9BBmqAPy/XefmDwTfQfINbBsi0qem2dMcXyGQTPn1vcJW
         cpmswksILX34wDGEANHC8M3lM1k10CU0RoMiq2xOAi16Kn3GWtk4BjmtyC2styNfSoGP
         Kv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725975649; x=1726580449;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ua3CNj7QXZmWPjFqqHq73Jkfl7HTZy6CpyvJQrXC6u8=;
        b=lJSA0dX+Zi8Cceh+Y8eqJukPkQVf3EutScgP1g9S1JION2TC9IrtKzarNUl6bWAHEW
         FjfOT3xoFAvS1NJacy+aNc1xf4c9tcPQZUHC1tZQOxr9/5FWcL8uSzEYP8fsJHmYhNEV
         CoF6bujJtJYubzhhOTwjw3OR1ab20zue3ISfeXGbRietqouF6O+bjydEBpmi1GrArvPu
         JESDx90jVTsDmgxv+xHSo7ou1hcUvdGKseLBCYAy38aEg1VDZmd2ORQI0wZHlqhRwTUq
         eHx9ltxtCd0BNm4bCTePkVxwvYo0n5ptyC5jNJDAeru/xj5YD0BulzRgKRrXYptLg4I6
         ejug==
X-Gm-Message-State: AOJu0Yzw3I4NEK0omrLyIS7ohaF0EGfzH4Qv+nqjbCA7MTR7/MBPBVzV
	wzLr3ivsmAXoZCOQ+GFkvJA33TXSvnSWCbSSj9VUsaNokJp4tStW8S3aag==
X-Google-Smtp-Source: AGHT+IHz9nR1uVfEvhdL8jqD9SuI8xpyj9oxlPiSurj78caV7B2C5KtFRk0Oph/pDvK444Qj9mNHCg==
X-Received: by 2002:a05:690c:6d84:b0:6d5:ccc5:e2f4 with SMTP id 00721157ae682-6db9531acedmr26754927b3.2.1725975649023;
        Tue, 10 Sep 2024 06:40:49 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.107.249])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6db964281bbsm2955317b3.26.2024.09.10.06.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 06:40:48 -0700 (PDT)
Message-ID: <66e04c60.050a0220.cb158.19b1@mx.google.com>
Date: Tue, 10 Sep 2024 06:40:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3984606948732716607=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pchelkin@ispras.ru
Subject: RE: [5.10/5.15] Bluetooth: hci_core: Fix unbalanced unlock in set_device_flags()
In-Reply-To: <20240910131503.146688-1-pchelkin@ispras.ru>
References: <20240910131503.146688-1-pchelkin@ispras.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3984606948732716607==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/mgmt.c:4138
error: net/bluetooth/mgmt.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3984606948732716607==--
