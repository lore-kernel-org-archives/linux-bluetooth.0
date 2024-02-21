Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CE280050
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Feb 2024 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708528399; cv=none; b=FCuUR3Wkp0CVVJ7041GOwXcqaKHX+ubzjEzubf9h1NlU4ICnDmfZMPUGzQuwiujf81iNxlUtb/Wpp55Y8JGz3aG9xrGldw1uEkaXcF55WiHXGWfQeR7tp6txK3b5PvAMEL/2rgerdlHwt/GRHYtI5edfgnXwEPXhKl0T8ZKF8Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708528399; c=relaxed/simple;
	bh=JhgJKuuNgCD/13vNz2kqC+auN/NKcpDK/GC88sheZow=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gZv6vZHewXqAVDGuql2H3ngf+qsm7aDItnJY1P7jRDBAMvilSwsvcdiW0+GdEOwpcBDduVQj8aBh4pnaQguJoBPeUGmsWYwOXb2kSp6ziez+J+2ufBYCh9HU7UAbQVu/kf5qs4AAEKUMI+/2Z1ABWCJKxesx0dqYL2TrqCQwB7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVRdYgHz; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVRdYgHz"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-785d954b236so46741585a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Feb 2024 07:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708528391; x=1709133191; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JhgJKuuNgCD/13vNz2kqC+auN/NKcpDK/GC88sheZow=;
        b=FVRdYgHzxHQlJodKLXJ9nGvViI94zkvm7Jk5HblcdZtkY5/XX05CXGHtLXGJXCzMBI
         Z+NGPDs+vmN9QrvqWbVZvckq5V7fRNAxhAM5t4JkbSm5T3broiMHVtCN+WmiHaGnGIZu
         IAJKNk1iP++6uMDwsFez/6oXdndcswKcqyoCqGasoMcYzlgKGEri1nWILRy9mAa2lysm
         olUz+yzqbcZPcM+PpfWXMuGAOaamg5e8fkiyDGChDgDQpBT8YfYX68SlArQ/tLi/lVnf
         W42oR9Sz4sWTqoJnMcaSzhRobDkTJTYaDbQi4k6mKg/VoEGuem+AHagcqnr8XBARaeEL
         eUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708528391; x=1709133191;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JhgJKuuNgCD/13vNz2kqC+auN/NKcpDK/GC88sheZow=;
        b=ehaZp5zcrHqr2Ky5jRo9RGgivdX/9pgRMvWOhOfEmw11WwtpssJu7r9SIAqIgLHejq
         gqivs4WSeO8RQPvXvLt71UhA66zT2EaR+g3qwnZyvJtm2H9YP5FhmqJR+IGUjaQChNRd
         vEJMBj2tdVOHCy+pgaSotF0y9r1OMjyP1uHhUwrLqcJIhKMJytTqy7imoiFRjp3qc7MT
         nPIJ35NyjNdV9qDYnmOd1wiH45OaZwRsZeuvK+C3uqMS2NgX/8ja5xiqIph2gsGMPwwR
         O6hoKComaRMVJzTaimXcObS4v/MDunWUUFN6oLG0OZnqQ9ZYbEhBk+AgBLPxXHTOaoa1
         n/2Q==
X-Gm-Message-State: AOJu0YwhD9aVgkb61j3vOt7oEDvqYerhMbJuUhcCoa6scl1wZO/sAirW
	+xXERzCce3CbM2OO/dRd9HtTTyciK5Q7miX/U3mKy46oXv0XfP4fUVW6VtTr
X-Google-Smtp-Source: AGHT+IHgsAq3p6CCs05L4SR3vJNnvxT30spT2bJYkVFuy7ge9mQMs78PrTdAsxM0g9uNi1bwQHLP1w==
X-Received: by 2002:ae9:e01a:0:b0:787:3d8a:5bc2 with SMTP id m26-20020ae9e01a000000b007873d8a5bc2mr16180502qkk.47.1708528390935;
        Wed, 21 Feb 2024 07:13:10 -0800 (PST)
Received: from [172.17.0.2] ([20.55.126.34])
        by smtp.gmail.com with ESMTPSA id d9-20020a05620a240900b00785d710f4e4sm4392232qkn.104.2024.02.21.07.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 07:13:10 -0800 (PST)
Message-ID: <65d61306.050a0220.42224.42ff@mx.google.com>
Date: Wed, 21 Feb 2024 07:13:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8009694726635191434=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, d.dulov@aladdin.ru
Subject: RE: Bluetooth: Fix deadlock in vhci_send_frame
In-Reply-To: <20240221145744.27895-2-d.dulov@aladdin.ru>
References: <20240221145744.27895-2-d.dulov@aladdin.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8009694726635191434==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/hci_vhci.c:11
error: drivers/bluetooth/hci_vhci.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8009694726635191434==--
