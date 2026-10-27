Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793099003;
	b=uOx9e+ulFIYvMgT5Z87hMxjYmBCU3thy/L4RHA05h4aZVnViQvbF3/fdt/VxMSARwMid
	 MUX8HT/sd5fIJxeFjgB8wQHRwmiiGagXw3hdF8pijQ126MpE0h+lHmdhF2nN/WWkKf+Wr
	 fu8RORJZLB7IR7YTxll9vy+dxRofsTUynHYm9lL79yUwCHzK6ghiOHnKH0siXgG2tZx7P
	 ukcpgPvClFvNFDGG5TAWqBM/sA8s4bnpKan2jEPbletLvcRkXHAe0IGuWRq5zmIRqVjUs
	 JaasZGUQc7+POfUBozsdmTutxRQ6ZzE34rPJCLwURL00RA1BcQYJRUrHvp5hYcYBDpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793099003;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=bReMnuJuSQrfJqS4XcR4yG330QUIZjFgZJEKMEnlACQ=;
	b=Eri7V2FhFKb+RpORWwZwpne0OOTXCcEDeyEtoz+xxTlkSphg3sBu3R6LU6so4NjZOOlE
	 rOdh/Qv1wcugEeNCy84dYJ6heoHdLG5uzKrpnl6zpAn/KLxzFYTLR+cvYk+/jZM+nTVHB
	 Sm5HrgLPBTNMx8QD454GocxUX6sxaAfk0mLiiN+Qn4V6zcGWgKcw/zA6//kyrABFvfDif
	 XVVQrF8oyzvtIb/Yo718+vxOnEfrrtIlsNBut1djoNhrQKqVVZ6ATTh5uiu//LkiftwjF
	 uhxRQEmVtWhHWviuC/K4CwPpE3QTd2hJ87Qo23aE/h1Rrt7ipMWOe7CxPPorZOknl/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qiCCp4tu;
	arc=none smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6BF606A31B
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 11:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF6BF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qiCCp4tu
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93f079a63b8so374188685a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 04:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793099001; x=1793703801; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bReMnuJuSQrfJqS4XcR4yG330QUIZjFgZJEKMEnlACQ=;
        b=qiCCp4tuahf5uWL2ec7IxqD2ZiqfQJin/ZZIJUEw9ygK7n8D8IB5GDpN+c4lqRlNOJ
         FJWeSDpOthnqDRIR2EPsIjc8/Gwqbf260P51Uy7CIuO8YT9KmgufC/2n7aLruTF8bCpQ
         S0EklWVjlnqgohNc7fttJdthhxgY9sPx/zKXfBYjsPuih5wYTFESjg8OC7baddQrLk8n
         SKGNrwRYD1f7WZg2Hi3BzGKyjZGZeZjxRnmt9j3L4PNFRM4svHewZFY7q3bSgCQ9bU48
         758Q63m9688BFTwvlMIiiMsq0CemMWASgQjrGhJRqa6WLqpynWYQoqT64+ET32XVL8xc
         c9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793099001; x=1793703801;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bReMnuJuSQrfJqS4XcR4yG330QUIZjFgZJEKMEnlACQ=;
        b=bAxc66RDfRz3rniu2ZhnpQrSweA9xhSTkmdoYAngPFCJVOQgat/cvstYMRMpZoQ4Pk
         Gc+NGW8pnNK7WfnF3X4e3Z9YNAFGQfYypy0xjx6XwUHhTvrRHDwWQbVtq46UBPa5+TZU
         0JZN/3lJfXzxEnVKzdNbGt+KAzssW/9bwYSWkMEr3k8dRmCfoZFq3bPIk06byUPitL4b
         zb4ZKNLVSS+AyOuigMzCSzyhUHsP5RTm+x014fOzB7YBoYRDKnymTZD0JKjusRW7DiFs
         /UUPQ7VBM8W0xbIxXeInAa4FHX8hcHWKHKD0IbBjPrz61wF50GgFMN5CPeLDz0dv6ixx
         WB9g==
X-Gm-Message-State: AFq9FYKVGKHoxhqp3m31+8UUsn9jHpEws+RU4bkkuTAnIabKGItQuZHD
	SCftzwwT14NxHcI1JVe6FzTd3UX93RA4hUtuBXRebNRLVqxhxBTYlF7YlWl0QA==
X-Gm-Gg: AYBFou37r3ehEixWmA2RITyv2vXZ9hiaJz2dd4Sy5qhtfXo1THgamvgsJcsw57WbP3h
	PQGYLlg/o4BJkzIu2UIKls3sEkCm3VivlkyLLd+uQuRDh3Kh8JiaKWrnaN/Luc8mGww6B2jyJzJ
	6rjOp2h4dksrCF40G5DszCQmEZvPGVPenaqLA/8EsC4aa+e6kZMQyRoYx4diYXXen/AbWFa3ZD4
	zqiFxcr/VsFpF/l7H+8CdkwsWKeXgKHKxT1azCLHdYYt0dKy0Ph13YbDYrYvt40nkgU/sZxRHf9
	S6hQKfAB0jriBlrS/rY3jWr9q+bqRqIJEsaOf/reOQ8Oda/A9Pp/jVv7qV1P0ZqKNoYm4l2Tfeu
	Ao3nZA/OKhL0G33MZSMDlSUXeqZATMONti8QKJTCPVyoPz+S84yojrV1FtCPRaOS7dJUvewj5oR
	2yQTvPsWEtnEWDDp8tfPGwR2vnCwF+XrDfPkfwmIdict3/q9p4ZlTlbzumCaKoQuR+gKuzV7bgt
	kfdSfaLP/Q9JWDkJxWTb4/CgWJngi100AVRNAsbul+dOdHC4Gy7lMOTZoZSyjB6gwlocdRp/ohI
	VgOGhE0x
X-Received: by 2002:a05:620a:2984:b0:93f:571b:c733 with SMTP id af79cd13be357-940ef901d8bmr1474693385a.13.1793099001580;
        Tue, 27 Oct 2026 04:03:21 -0700 (PDT)
Received: from [172.17.0.2] ([145.132.99.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-940f0787fe4sm962275785a.27.2026.10.27.04.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 04:03:20 -0700 (PDT)
Message-ID: <6ae084f8.5179eb23.3a0850.c2b3@mx.google.com>
Date: Tue, 27 Oct 2026 04:03:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4756855193196978449=="
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
To: linux-bluetooth@vger.kernel.org, lee@kernel.org
Subject: RE: Bluetooth: L2CAP: Follow-up fixes for b66774b48dd9 (v6.1-v5.10)
In-Reply-To: <20261027100242.2886699-2-lee@kernel.org>
References: <20261027100242.2886699-2-lee@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4756855193196978449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/l2cap_sock.c:437
error: net/bluetooth/l2cap_sock.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4756855193196978449==--
