Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795502267;
	b=UkTKgdxcRbigs3gt0zaQ9qjS/BFfwbKdNBwQNUAV0dJyPVp7LuYnUdz9XXp7P7kOegWs
	 +Hs6cYZfJQaEevCj4TXvwTFij/EyBpgGLv0c9/NLZGzFEXtxGciMaucdH30huOHvLwIVg
	 dpG2xIT0GmlnDeAbK2P1YmFhOKL54GLqOI2yKljQr0RuUN5D0LvkcUGMXHFZLeBDorFYk
	 nuO0q3vASvhUn/tpqQjgWFyBlwn1mKmf0MoNXwpnjDZ0L6iOOB64w5/5mUMBAWhYrdUvL
	 dg1UcMLuJ7b6GqwRGH3uWdzR7TKpxChQKev1DwK4BVEDzVthn8v9v6lwWVpPegTtxIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795502267;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=2Id++rAHtGP/+D5y3s4+T35ImfaWbACKTTN2CHguGPA=;
	b=QoMT4b41NNL8lMvHA5xKSwPxwwWl8KoOhmhu7ufo9Yct4WBjYNVyGT7xbBQKdRt518al
	 Mufpc/WmSW0gVWP+HFBgO//E9NaumdZKZZH8fXNEzN2qishfK6ZNaj1xGx0KJcR7lp3aq
	 9y1abfBsxlqquiVe2dStYSJdQaoQLnkAEwfMW1MNNYgoi7kG+tMrnqaynEq20PntBx7+T
	 gJA7E2aB8ZnBqmjAVT+7P1bRLggyCz1O3gtPRFiH6Wd0ZPGKmGNYXKYq4Ce3Vf7HCV6tP
	 nObw0UXkaAjSTQSYTYt4uIsGejE1rS9aSK1GHtpXOjSccXdvFFgbUP3ywEIb97eiUag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0w0Reyj9;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829DD606A33B
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 06:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 829DD606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0w0Reyj9
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2f02ee04378so32742855ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 22:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795502267; x=1796107067; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2Id++rAHtGP/+D5y3s4+T35ImfaWbACKTTN2CHguGPA=;
        b=0w0Reyj9JXgx47Qh+DBeLCybzgRElieZ9NA3MrKTZSXQ6e5rHIW1jS/gVd7bM5AmNM
         D+xwG7hbMs3671n3bPXfOKuI7rep+IVgzbchj6DiHiZxLZMwIx92HIfIoYGUq8hfhyn5
         Ww2ExyXEH6yh1a+5AAsPZPUE2OTX28CkLRTBc7LwJYZEdBSHA9BQ5JBiv9Wbr14Askpu
         3gyfKghJMp5SJDDPV4Lg7mec0iK2W2nlnhKXfv+mbnM+qQZpm4iqP5Ls0f/eKTJ4DF+N
         2NbocVuZjoxtB5kfFapeYSwvfo1h2vP+Js6SJ0I1dJWWfhZ1JBRh5R2k/KRo8V0Mh/Bx
         r5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795502267; x=1796107067;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2Id++rAHtGP/+D5y3s4+T35ImfaWbACKTTN2CHguGPA=;
        b=aunMqnx0EyeXWjYZbVpcd9K/Gtnv+ouwhnXoKzEk9py/oWhn+fYnCiTVTA/D8pOAUd
         6pCwCTEr1tbsXmcZiZm4/VsTThF1SwgCr34WE2XQ9uywqxOrMFkOCQzXHVp8pZJQ5yYp
         opHJZAyzoXGZdCH2exXUw/+S8nhvzb4isSoQm88q1B/4jICCy5c5McyoufrMmNLX5vwE
         oI6n02NU+P4mxpj3PCnSu72QNQHDCCyu3ajI8ZVnj1mMkPywdgw9FI1+j3/4rL+67yFS
         kPPbDiXmw/Sxb+GQK9vO2fmpla0YEAxmkrSCqjPY5ApFfeZrEu5H7fciQMpQrChDtlJR
         bniA==
X-Gm-Message-State: APuU4Z9ux83kTpFM37VHkrRE+CmXwXzeoPfOG6rhm8EDK/fvYLO7iS9Q
	aiNDpgJOIkOGRZPcUvHiS1CnvophVdn741+w6uTpBLI44lLG3VlkI80vZ4w/dA==
X-Gm-Gg: AZFdTZfnTFP1ivmLGKh1/BB7WRwPLlREbKNYfsGFJIloTWta2gpJymV1Y+L37H4SU/s
	Ex9OxXIiH/BnJWAs/+nz5WxwtqYot4K/VSvyhJVN3NuWStB1SkTqpF/ZFEhRfBs1ZNLm9iOWx3b
	Jv5hQz/MVbug/YM+s/GDtc8d9NOOprKV8Xwmcl4/S+VROWNIFdJLULQmDzU/dVGnxq7w1nv+810
	+t43vpKd1OVjJo2IhN5+5eO5itmE6rWjgmI+il5x6PL0v2VMwB2UukOR8KRQ4DoM/sUkJ0RImPV
	kNkd6eivLI0WOGDY+P5S03h84fQDrwjuQS88DSynca8ZaW3dkPT2DZyMyyoLb/K9TzyretOIlUe
	V2w2xM5qAwtP1FfE9MYpAAt9WEAgoBfxxiLXyUjmUhiNZw8yjJUQmooIOEy7clYYTwOGybG7+0z
	tmvkNx2uMe70sVRHaHmBPNf5LVKP8Nyu4/nRi2f05j+O1snnV1h6wXUJh3aAv2qNxKNMEL88YgF
	lzuzIKVbokaUzQGdVYS3IKKS68vMUA1Wjzev4+iYazZ5bbr6TlziaMM6oqzF4w4DSgsP/JzHFzx
	hrmhIt0Wn4oJP9A1JUbS3m8ImaGI6E8k419eZ8a2
X-Received: by 2002:a17:902:cecb:b0:2f0:45a7:5d10 with SMTP id d9443c01a7336-2f045a76530mr132059665ad.8.1795502266727;
        Mon, 23 Nov 2026 22:37:46 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-42-157-192.us-west-2.compute.amazonaws.com. [3.42.157.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f147a9esm63375545ad.72.2026.11.23.22.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 22:37:45 -0800 (PST)
Message-ID: <6b0530b9.8aebd4a1.31c350.3ea5@mx.google.com>
Date: Mon, 23 Nov 2026 22:37:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5272588276961988603=="
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
To: linux-bluetooth@vger.kernel.org, goonsomeway@gmail.com
Subject: RE: Bluetooth: RFCOMM: serialize RFCOMM_CONNINFO dlc->session dereference
In-Reply-To: <CA+OT+OO6R-qQc0L9YE1ktBtzWCpFcQ2MbSG63sH4--gk3E5LjA@mail.gmail.com>
References: <CA+OT+OO6R-qQc0L9YE1ktBtzWCpFcQ2MbSG63sH4--gk3E5LjA@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5272588276961988603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch fragment without header at line 8: @@ -786,20 +785,21 @@ static int rfcomm_sock_getsockopt_old(struct
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5272588276961988603==--
