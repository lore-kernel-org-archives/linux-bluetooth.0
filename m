Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9E41FD4
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 02:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551239; cv=pass; b=o23IFKgvajtnkI6CqflzapG98RNBYb3LVK044O+iI2sAtcxJH6LZ7+KJq5V+ga/X5Wcd0NTjf3HGcGHdnAZpEAxdNgq5BsZMTGcovncL/Z7n7Q6eV1U2Vt/V/fLe7RVkMoQIA952SQQhCKxVwKE8mwHBj5vaEbDrubJribRDCJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551239; c=relaxed/simple;
	bh=SpwwXacXJonEOu72OwiSzV2ErCVrduQLCkUL8LuSyyE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ZrEscFdPlzTvS0s2sAqQv0zA3trQ2BwVSWJi/13IOsGsHaVA3YfRFtm5Y9/E/DPXszSyF3EiDp2wFDvGyZzsxYqB7xgkp6xZGpz2fmuWHdJZQCMI9QhJN7lmgheTbjxGHl93dO/qMng7PpY8o7eDYu4eiGgxnAJEyA2T7EVbb6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tyg2iqoA; arc=pass smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tyg2iqoA"
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-65dd1e59e08so126683d50.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 19:00:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778551237; cv=none;
        d=google.com; s=arc-20240605;
        b=Kt1yVbaD46sss7Qu0yIX0VfWiu6gE/5+tVJNNPiT7iG7XCZwla9jv/cqlJ/XzZN6zM
         wpBDpktS1Z8gWtHBzDLCi05upDHUvQbjt7YFSjJ87JaBDZ1H8NgbVDMZvyUJ7XsGjQ4l
         XlDgZ30FQPpoPbPxfSBfCva8lkg7CJHoQwIV2DGAoUo6NdILOVCEcBP6DtRRMDVSpQ07
         KWRI5Qm25I4HqjdUdtXxeBOcWKKeZlJwcDk5wt4ZViJp4aD1BDZK2+/7n3RSoaoeHwld
         19vfOK6FnxyRulX7VtFJvhDu78tAkfIWRE8WFoQMnG9qHp3aZm4Sm+tRl0N5M7wHGv7/
         3Qbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=SpwwXacXJonEOu72OwiSzV2ErCVrduQLCkUL8LuSyyE=;
        fh=4lGQI6056MBa4/oovMyIYaKLn+Wz/24RGvUivMmQP8E=;
        b=f/ahGrLscxppsree5GjkD33NHjQMh7EAEWHi1JIOoOwmP9M130PO/whnZletnkB4+9
         IQvK8yQh49ug0y+8pLpBb2ytTTbxwvgg7DPPaQaXB9XXWZ5OdBuYHbH+CcNlR4tUmNof
         oXexNi61XFNibTn2M4fA6jhzK7j9jqosu0/mfTzQ4uWuYtr/vgnrgOG8eClfLwoFQqfF
         kpS9wKr24iFG88OFfm+9A0uk+6YVLJPamdh1UZ8YcwPqPYUjPrMznyxwLYz95UOUs3Rp
         m7uxICtXUcxU7FCxudLOTnt9kLQhxqAYIOeT2fwcpkaZSatJOKpzsRjxFPe6p9PoSylD
         qxAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778551237; x=1779156037; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SpwwXacXJonEOu72OwiSzV2ErCVrduQLCkUL8LuSyyE=;
        b=Tyg2iqoAvig7a8H4nPLKCgeMqH1ZvlGuPI8qddMfdK7bCGMlyREV8NnRKQHxRNwcqo
         wT6CCyJmSeSuoFxLwefNXuYnILmQ/Hs2y5JjlFsJqlmNQTHcLBc8LMo2N/9Mpdafv1en
         dd1JaeZWCNKx/9N1DvKRMIHTWwMbyezzxxCathLlwKvVeKw7Al5CiEAREZaRezG3b0U8
         Ii635wfdu9NcsqDL/+wbh9B7sDSzJLAd+/ZxhyOWpMIm8EJJ3DHIBq8x+WDbpdRV4gTh
         o3XFOLTTPg2LwK7gEUTqBgMZESZo4j23Dnsnwyp30L6rvQ9TOj2yxKtkPsVPZwR2/Ttg
         G/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778551237; x=1779156037;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SpwwXacXJonEOu72OwiSzV2ErCVrduQLCkUL8LuSyyE=;
        b=cwRttcervyHugpbhi+7fZg/hUhzplCczIusoYCMzjF8hTcuCjsOxQrm79Ltft0QGId
         DUNxzIgaGX41sr4Yr9nSE6lLEBZTCKUIRH0eZmJuTbT7bba5qT499+4VqPHmWYuOB7w1
         NWkOEOBqy0hxuzal0sfwBgC/g9yCLndnkrzOPUoV4fWKM6L12i6K5L5z6qSVxUqQWdWC
         5rP5lWkR9MZzXcPe311dp0sYsjBciOUh94/LA6kaudbJHUD4bpPL1CSH+ivkRM/7u/wM
         x4DDk79GHFlKmLSoWtMIqIEd99F6wlxrO8qTjEcI0cIBPP9MuzeX7/Ou7yyMJkK8zW7H
         QZzw==
X-Gm-Message-State: AOJu0YzNu+xbeMrxu/4W30R8wQQfeSkKkOAurIzbpN+cA11+Rp6jBZSD
	vHBC4A5wMOwDPpBrQEoIrRZGvqnaAVBJ6Nx4qRfQ1R3XawoLlBXzsIG4MCuBX2aTaZB3gFrcPbN
	tEmclwxpZ8J4X16sIbtwM9IR7lsVKtwBKQdk1NqeHn+ROz0C0cA==
X-Gm-Gg: Acq92OG4Ahb1Dsk8zhx9K1gA+VbPp0bMkOBTxoKYKhWkqmmHoVFbA56SIwil1fmAZqd
	P4EFGQWhhdmFmGAcWwRS7E2gIpLaMGD0QMkq5Pry8oVaGhqgN6KQ8OlWoQ8EkkwCDaHZ4/jY5Ll
	WZhjOFHBI6jo/lo2JY1pvkvz2ZT9roc0G1/umfuXFntsMMGuIuFNM3ZyudanVL2WlDheA5NoAcU
	OkVNiqPhp5a1PkuF0TWLr5I5g9QI2x/OsU6C1+p363K9br6qvJWqw1sBUFP+n5kfCWb
X-Received: by 2002:a05:690e:4284:20b0:64e:c1fb:c2de with SMTP id
 956f58d0204a3-65c7b9efaa2mr12066883d50.6.1778551236775; Mon, 11 May 2026
 19:00:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tomoka Kimura <tkimura.dev@gmail.com>
Date: Tue, 12 May 2026 11:00:25 +0900
X-Gm-Features: AVHnY4K3PsQUPWNY3okmRFY1qxqBtBV8282m0Ch3LXpsx3tolOe5Yo0iEqWKNrE
Message-ID: <CALC1NsyNYQM0NMFmfqG6sg8fqoKhHUBoH7dcQCeQ0MXN3NkpFw@mail.gmail.com>
Subject: Question: recommended way to detect re-pairing completion over D-Bus
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm developing an embedded device using BlueZ and need to update the
UI when pairing has fully completed.

For initial pairing, I can use the `PropertiesChanged` signal for
`org.bluez.Device1.Paired`, which works well.

However, during re-pairing, if the remote device deletes its pairing
information while my device keeps the existing bond, I cannot detect
when the new pairing has actually completed. In this case, the
`org.bluez.Device1` object already exists, and `Paired`/`Bonded` are
already `true`, so no `PropertiesChanged` signal is emitted.

Environment:
- BlueZ 5.72
- BR/EDR peripheral + BLE peripheral
- Agent capability: NoInputNoOutput
- `JustWorksRepairing=confirm`

What I observed:
- `RequestAuthorization` is called before LTK storage completes, so it
appears too early to treat as pairing completion
- `Connected` also becomes true too early
- `ServicesResolved` does not seem suitable because it is tied to
service discovery rather than pairing/bond persistence, and its timing
can vary depending on the device. In some cases it may be emitted
noticeably after pairing has already completed

What I need is a reliable indication that pairing/bonding has fully
completed and all keys have been stored, including during re-pairing.

My questions are:

1. Is there an official D-Bus API/signal/property for detecting this
completion point?
2. If not, what is the recommended approach for applications that need
to update UI at the correct timing?

I also checked the source up to 5.86 and it looks like
`device_set_paired()` / `device_set_bonded()` still do not emit
`PropertiesChanged` if both bearers are already paired/bonded.

Any guidance would be appreciated.

Best regards,
Tomoka Kimura
