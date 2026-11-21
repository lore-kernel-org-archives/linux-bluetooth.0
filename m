Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795256360;
	b=INtHMVIcCQDVTOzTyrMhTSrurBwc9m2Y9wg3j6aki3yDZKaQUiHaz82zEFNecYTiPKLA
	 AoXkbup0ajS1Q+rvOgxj7SlgFQOdZeQSdCzNdas//Xw/Kw6MthCmZc8kzZBbl/3bA6QEQ
	 OyK2S/E3TkrkS55HwZDXNyjNHVHuUnBgBp3O5veDG5BZ9SLAFiDqATo5fHr5Oj/n8vHiL
	 B2kiOX0J+svU1mLgM4lZhHDrfZJ9CtqDjuFrjkuKpsiSrHsMptpqxQv0wfW2AocJBbwTt
	 DQoJeiGqVGS0HwuF7Lo7qU5fezM+Z2xroVzL8v8LVRPnFL3lD6PI3o3q7TCOROgrdog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795256360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=S47jcI7CGruiIFEssmRP7mrUIFJ7aMgECt+/LHc+L60=;
	b=hXXrqIba/G9I5baFvZUIAX+SkC+pS5RvEl4gZ03T2YkUXxACitQRfmcltmdoUAxbD/gJ
	 PCi1tqp7hPTjZcAOlp8C7ycUl5+cpFiTQ+QxkSJo8nwR5DpsKay9ZkwqKtaPi7R5J9l50
	 FvA+3miPjKcCkqvcIv8cLshl99DZOatrpuMF0n+OinLezXDe1HMGroWMD6NXXuPo5z4In
	 HWIFOzt5LasLdbzMTw/MOT0ULrPZa1FFs/GFKigX38VLbZQCgkGRdzUBWXk9e2qh8r3z7
	 oemCaql0AB2oBpUdh9pwF9gFZN6AmkdLPlwhai41MY841g8tzQYdIojVvD44nR1+nTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qlHys8LU;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD8A606A325
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 10:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FD8A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qlHys8LU
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-55d360ca878so15386511cf.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 02:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795256359; x=1795861159; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=S47jcI7CGruiIFEssmRP7mrUIFJ7aMgECt+/LHc+L60=;
        b=qlHys8LUAHr+FhGf9ucVoyKfKQOGuDC2134gFNGNDWr7MkETsatcrqlBa6IiDofgep
         IQE4LDu7JmkFfDcIijT2vXtiKkLKQ8+Gqt7LxiTYc9+7qGVVrPH4OY3jXeEhv05F7Lju
         Lb4w1h1o7IgZMA33O0Jj/QN6E5MjAvDrbBMoBogWCL15+gYsjR7cXnj+IBBkDI4CnB4/
         39v5kzmckdWG95Bb4hPhy3GgNIh0yD4hnehP5/87FYT1t79drJ/TYfD64olZs3coFG6S
         8noU46FxNNOYMPCbLirvSsemEGCXI2w4gBzu2v/LWbo0lH6226jhtQgjZcXpRxziOkXV
         pagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795256359; x=1795861159;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=S47jcI7CGruiIFEssmRP7mrUIFJ7aMgECt+/LHc+L60=;
        b=OXquYqXypXd3tYd2wVuD4kkSsZ65R5n7Dr5s5XF3NV7uwUK/KT9iwQpd7ictMVRtZB
         5r/PCV+OtcVcWOjRfEUJlNudfaneLg293LIKA5yog6GI5J7p2Iv/In9mHox1mpK2l7qv
         gpJrTQyxu7wsAHyrKmuVihHVZ9mfUJlaCZwmxSIZyHeTO851H5H5lLFb2XNJijweUi/u
         /VTagfN/+3ikxz3wdE3bPDXAAnNylwmLSm1nkn1azg3gSK7v3mHNnmQ5R/zjn0viHFst
         qeGVTFh4CHjS8djl6ymEFSrDVEJ9zRFujAHxS7FXiPhVkokSEd14cr8SG5ESJgnMwppw
         WC4g==
X-Gm-Message-State: APuU4Z8CQ+qgvhCZDx3vOY5WDmD6eVHR8HZNo0vme9QhyaAdMUxXbXqO
	b4DIXueVcjd7F8R2Wu2TrWhstMwk2Tgf93aX1/xB3GnX10qYN2GkFSZ5eJ8x9w==
X-Gm-Gg: AZFdTZeNbfL5inFk3BiK+5u0KcSv64ctvBl+PPjGyr7qQRSrooYXaH3WIrecHka/31P
	wNJu0sdHwRALSxHxqRxbOyhUDltUP2m1zRtc5EaPtkVL0L7JiNEn58rv81dLl3IksA471BVlnWt
	+wIUZqGSBslLNwNUN/6hNpTpigSvyb8sqr/9sKY2AyQtVWTk4qkRYcLXdStlPHuqFFsm408Iqh5
	shqKDgaTXMTkruNiEPFn3RMZgOOLpHziJVNFYuo8CUZu9t6oYfo3likUGXvhHdA8Co/65Y/31FT
	fmd5MHTVKH6z53PvSBVIdAym3mUtRnB0WrddL0XYjdu4tz6KDUdWZrRogqpR04m2WFJD140hJcQ
	34uNQopQBRghxfp3Ihi3ApOjvPJs8FpTtHtYeR4uaL6efyGm2t5ktQ40uV8GuchKdgXJI/W4ecL
	KCqf5Aq4nX18ZNsmv5NSih3LHtymxBbNe+4Q1NsnyxtetCj5e+5Odjm12baYL2Z6xRyESaauM2W
	E3KdWg8sMbRt+1txsepZfEbbmJ2+h1ZqHF8L7PorTESaP7q0BrFEYrf4CSIJww=
X-Received: by 2002:a05:622a:64f:b0:536:c00a:b7a2 with SMTP id d75a77b69052e-55d76ae7fbcmr100912761cf.46.1795256359246;
        Sat, 21 Nov 2026 02:19:19 -0800 (PST)
Received: from [172.17.0.2] ([20.15.103.117])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb3cb882sm393853385a.27.2026.11.21.02.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 02:19:18 -0800 (PST)
Message-ID: <6b017026.5179eb23.1c41fa.0163@mx.google.com>
Date: Sat, 21 Nov 2026 02:19:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2269498838729303923=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kaichuan.hsieh@canonical.com
Subject: RE: mpris-proxy: Fix possible crash on OBEX transfer
In-Reply-To: <20261106080515.2296-2-kaichuan.hsieh@canonical.com>
References: <20261106080515.2296-2-kaichuan.hsieh@canonical.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2269498838729303923==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       mpris-proxy: Fix possible crash on OBEX transfer
   Pull Request: https://github.com/bluez/bluez/pull/2770
   Created:      2026-11-06 09:57:21+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============2269498838729303923==--
