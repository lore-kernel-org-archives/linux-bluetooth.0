Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6FB2356BE
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Aug 2026 08:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785745442; cv=none; b=sfKKVNM42h4ev06qywtezm6Dyi32ihGOwF24eSi0BPHD85bAwBKIIaTE7GE4j5SCcT7CMlPntSyaBbef8LbhAmA94WwX+RbxeNvNq2M9A/pccoWQBI0hvDDf6awwnKJNJS5b8yvQD00CvNErdG+HjiwU1L3yaLEFLyZ4EaUBpS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785745442; c=relaxed/simple;
	bh=n0X/waPIPIowDmIXFchKPTJpHffvKjgWxvLahHA2jxs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Rpm/g0SobbTva8Y6LjQG5VtFRoAZ02OEbrbZXbfe2d+a1O5gKxbYoF+Y363Y53l4QNTemoblPT75DQynoNPSuAsr3Uh4bfyFX/iOYCnvwp63wgRj1EC3rpIzXt7XvdIHEvUlsUQicWXVmAjsdBc4DiSuVhMPAuPvwpwXleuIZP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFo6pcGb; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFo6pcGb"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3811f512167so3111698a91.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Aug 2026 01:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785745440; x=1786350240; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=n0X/waPIPIowDmIXFchKPTJpHffvKjgWxvLahHA2jxs=;
        b=NFo6pcGbRH0/VwmOkJQ7Hasba/hUw2VO8DWGyq5rvLb8WoKLv3aZkhIIxeS9A++4wO
         NCRlqL+nk2q+9k3fAYwbtX7pgrh9MkfUcio5olOxUNVHzhkwFDaffTcUwjwTQr+Sr5YN
         2i7KggSr0PGL6JltiOgCRufi26MbIJHEIJOMtD35QIZD7pY76ELpTbp3mC4GE9oYssVb
         tdlcswk+9SthzGhRGfSfefoUdEt854gYiK09B7ii4opoCfAZNrpHqMs/jU3bGQY3+gYe
         THtSfUt+fNcj1aeW6k4AYQL4AXYE+vGqygvi2cr1jIgeGo49Op8ZybRAEU6oPnLRrPAM
         HK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785745440; x=1786350240;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n0X/waPIPIowDmIXFchKPTJpHffvKjgWxvLahHA2jxs=;
        b=ftR4OOd9LluH6vXlm61X8v1soWddaOAE+PGPQe7ymV17lR3eUP1UK65rPlvwQ/Lqs8
         Qsqde5GY4W/mVrj2uLZp8uqbEZKBsw5qFfq55WMaAoXbDJPAVEfmofrnH+UhSiFCviy/
         AnMy3b6omh2eZw76A3trTloDRnB09yFcLyIGRGoMptMsEiunpqxXyRXEjOmG3CXoBrC7
         swBAuQawnG2AlXK0lV3+tfFIKpDtC++PFgPLJJPgBabxM3aIDHnoDYp4Cfe5GRQSnxIQ
         MoUbOrMUHEZVQ207zs6/peB7xkuG6IT786lddThR5qdKal4q4V6DOgnqSPjifmj7AG75
         dlRQ==
X-Gm-Message-State: AOJu0YxODTdc4C/MV1ZrmhZmK2a7Av5pvcGRsfyGc3TcvmBcz7cHMIwY
	UNxS/1DlyEkcq89nm8bGkaTkfcT4MNKkdXDQFay0THuPbqg7xVeDgl9T+Pz2TA==
X-Gm-Gg: AR+sD10Jr+hEwnx5fLDjiUg/ap4Zu7C0MKuifbDG02yAsI92XjiBZINxLhdMx4YCOHB
	h1V3x3n8rId+ttpINUipOmGPRgWmjgHo5wTtN1/4fqXYdqjegaIb9EQ7tJYimXI7dR5HJnWprk3
	CcISaDU/X9PjfNQ6xcGqakLNw6U5jo+HiVSOY6gH3MXam2J74m1fAdTDAzhQPLXE2MMu4MHKzeQ
	E+1MMYXI0Krz3AsaU5jgAoboCHb9g+Ufmrn/a2++xXTMr92vXAR1Qax7q1DM8gwBN+eg2AKSwBe
	xLLaCmxKVYUVgRw9LjN2ihWtD+YZ1tzFTp2Kh1vgom/XK2PI4gS/Hd0WxA/cVTEl2Aj1Of1W0Pp
	MCKCZPdELI4+LtkFU5bsaK6ERSaeyQXrlvEfiDaLXToqEFdDvsY27+HbHupf84UN+f2i3DpsGuw
	lm3X1elb2r36i5k5rVE/eTrn5Cx3gvN605fmi4c7qBOHMKLxX7lcG4h5TKIIXWVx1CRXGBy0pbt
	9IBQA8=
X-Received: by 2002:a17:90b:58c7:b0:381:a766:efcb with SMTP id 98e67ed59e1d1-38fbc409439mr8353344a91.4.1785745440009;
        Mon, 03 Aug 2026 01:24:00 -0700 (PDT)
Received: from [172.17.0.2] ([172.185.31.209])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153dd9be04sm33104028eec.9.2026.08.03.01.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 01:23:59 -0700 (PDT)
Message-ID: <6a70501f.c56fb102.15e4aa.65c8@mx.google.com>
Date: Mon, 03 Aug 2026 01:23:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8124376982185064121=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, alexevgmart@gmail.com
Subject: RE: [5.10/5.15] Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_new_connection_cb()
In-Reply-To: <20260803081414.729798-1-alexevgmart@gmail.com>
References: <20260803081414.729798-1-alexevgmart@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8124376982185064121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: include/net/bluetooth/l2cap.h:653
error: include/net/bluetooth/l2cap.h: patch does not apply
error: patch failed: net/bluetooth/6lowpan.c:631
error: net/bluetooth/6lowpan.c: patch does not apply
error: patch failed: net/bluetooth/l2cap_core.c:540
error: net/bluetooth/l2cap_core.c: patch does not apply
error: patch failed: net/bluetooth/l2cap_sock.c:44
error: net/bluetooth/l2cap_sock.c: patch does not apply
error: patch failed: net/bluetooth/smp.c:3228
error: net/bluetooth/smp.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8124376982185064121==--
