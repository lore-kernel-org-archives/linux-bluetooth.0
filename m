Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBD11BAED6
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 07:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729063705; cv=none; b=EIoOYytw0voGycuqNuqjMmnOgZtaD7mXAolHPkrw48rqhNGHTVD4gU7MjI6H6MH80dpLmG8vLHT9aPre1PgY4gQ6xn7cno8jgudYlOQpwt3MbvqPn+MhjZ3yxP4u7kM9qjq0B3PdEwlmgHfYU327hhWbAcbRymTa207KpdQksAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729063705; c=relaxed/simple;
	bh=Ji09vYD2wb25yOeOBrqhHqmSxpKp6LPrUX1EF1h+t9I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qkwI/xnMKggMebaKcAHC9xG9D31vY3uFTPnL7RoVMu7e5FhJUFeKcBWNHFzP1457io6bPvZoKTd3T2PfVUIvda0NRcgV+E5Pqo5NGdR0rlgoxatVIn3CAOAyZ6hg+PeUB98lJKsF2/U47Dme9IANKG5NcAs3BbyIbH/AlAnP1EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMqz+ao+; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMqz+ao+"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e31413a196so50965047b3.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 00:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729063703; x=1729668503; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HBJhXhYSpRv0qpL9jdBJs/67kVQG6DUo/iukW04ivKg=;
        b=VMqz+ao+mIMqWs+8arKlZSnqLBsMMpwr7u43b1ch2Ji909xymI3guadyBPLyCVy11i
         R+6LjzmW9mAVRQvJTDDR/trliQ/elWLhqz8m1WOhbzEYchYE67FLa2RkCuw+qur9OpVK
         /CgFKwEvqoGjnAPjnRTkpZ5NQB6wjnAu7F9aHfDPCAjmOl4mRKZy7rpFOEIU2rU87Qy9
         iWSNmV76zfIiQf+1JUVhP+Jt/3rSItJmBgwQzK/Y6KnYuIHXIxInE7HLpuyKMXJkoeGJ
         wG58b7jiFHtbOUpb6y2vUiluTOf5DpmZjq919+kXU/OH1TWOA78W8dKr4t8ACqvxmx7a
         OS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729063703; x=1729668503;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBJhXhYSpRv0qpL9jdBJs/67kVQG6DUo/iukW04ivKg=;
        b=lGt28V/ltQ3dc+PzG/giCUk4i0ynqObxgWC5y7czVM6YtuQLbCBSap8kX8if8Hopw+
         5yACnxbJ6fSOJMbQltiHvnmqTyZaLrD23eoylNT28f5nZu0v/K5rZc7mEwfp8ansyquE
         Vy1meukbOjO1xRHw/R7QLSpMV6WYoSPYSvTgLjdxJ3tq7qaj3zY7B1Yzxfe/NhVwpZSy
         p6XW2IbSazlZkC3rKBkIjed4R06XQh83JYwOJ9qppWSN+7aMEzRMMP7Gm5vWOR1xIACR
         qBMG2nMO/GLleUSqX1DEvadlyn/WfNZTzqa+mCdNQWDgYDj5R2oiZ5Mvq3rPbaEY5t6K
         6mgw==
X-Gm-Message-State: AOJu0YzDLjNhcy6gyPPBo/s5CP+aHLM/JZJNPM6zfMviHGzr5pI98iOo
	+0QTc/fpKHZI0RIhzqBhTsCETr/wBLJFA6FwgywoabtaritFD7+B/QxbQrPPelQADL8eyAqfvTM
	YFLsXQaQmJeudRYfqN6w/c2jlUtqqnQbgLs8=
X-Google-Smtp-Source: AGHT+IGYwcHgiDzVj7QncT97JyGjSd1xIxbKtM7m6w5fTM2Ldz986lymgddqe19U730RxmT1Y0hommXUU5v4PAmlwvE=
X-Received: by 2002:a05:690c:9685:b0:6e3:3007:249d with SMTP id
 00721157ae682-6e36434e5a3mr115142617b3.25.1729063702997; Wed, 16 Oct 2024
 00:28:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Grimoire April <aprilgrimoire@gmail.com>
Date: Wed, 16 Oct 2024 15:28:12 +0800
Message-ID: <CAAhaqxrW=0g9E2qWdEXTGkjv5cxZLAu-6UGDO5tGLxZDdQXvJg@mail.gmail.com>
Subject: Bluetooth not working on 13d3:3585 IMC Networks Wireless_Device
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi. I have a laptop with an integrated bluetooth adaptor recognized as
a usb device. However, it fails to initialize properly. Searching for
other instances on bugzilla, it seems others had success with
13d3:3585 adaptors.

(base) =E2=9E=9C  ~ sudo dmesg | grep Bluetooth
[    0.422244] Bluetooth: Core ver 2.22
[    0.422254] Bluetooth: HCI device and connection manager initialized
[    0.422257] Bluetooth: HCI socket layer initialized
[    0.422261] Bluetooth: L2CAP socket layer initialized
[    0.422265] Bluetooth: SCO socket layer initialized
[    0.530052] Bluetooth: HCI UART driver ver 2.3
[    0.535346] Bluetooth: HIDP (Human Interface Emulation) ver 1.2
[    0.535355] Bluetooth: HIDP socket layer initialized
[    3.556068] Bluetooth: hci0: Opcode 0x0c03 failed: -110

https://bugzilla.kernel.org/show_bug.cgi?id=3D218472

I updated to 6.11.1 and the issue persists.

Thank you.
