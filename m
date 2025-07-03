Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56798157E99
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 16:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751559678; cv=none; b=Ui5KvS4rM/L80gOY562X3OUzWEKvYHh0j+wf9UsRQVhbWuisZMB3Mk6xrrm5HJayEP5vnJxFH6RGfTKRUWHz6b6rpXoxK0tLjao2VbyfE0uDPeoNLb0n8VAz/GSFwjG/BiREuFWJkazI4Td6zKoH8uFmr7GUwn4BdeELeHBNho4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751559678; c=relaxed/simple;
	bh=wRBxpG39WUVrHqcTPvV9xbGHze6Q8q/Kx3SjlFYED8w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Zv/dkAG5EHVoDo/Xsu0JCcoKzX+D+qEPSRXVEFpV32xDPcd1jUJxKcJ83I0b8nHUsp+rXttZ2tC3IBIgYqJnAch+IoGuf+K5dvS8eFOLcWYOxDy9mGVt8pSwibWcHp/x9XqmAw47fcJ0F4pT6GBlvB1kD1NZ8w2s1hMQxVaJWC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBVALS2p; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBVALS2p"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7d098f7bd77so14634085a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Jul 2025 09:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751559676; x=1752164476; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wRBxpG39WUVrHqcTPvV9xbGHze6Q8q/Kx3SjlFYED8w=;
        b=EBVALS2pKR7+tkIYck6zmKCArfm/tLsjRRAuZFETAd4Pz8MlISQ0sZazoO8VP3dy/w
         DH3rpIdnpSHONP6KVo/U9KmN4D5mJwHFc7IqR/rdYcJsQ9PZn3uBVsu/1XSRp9cDSqzE
         6tMrMkz22L179J8AUt15A1PWMnQHMpAnGLkCZ8RNmB1he9O8Oxk6pDzcO1oEh/HpylvW
         FVKzKHAsFh5ssWTLCh9QcPkJZNWoLEFVzKBHguK0jEI4qyMzekoSVwcy/iuAoBRHn0LI
         j2qwHm0XDLlCBDKsGs4mfQuwCM2LzPaOEqtsLTerRCIZhCHLiLGpyF18YXjXcGLOQu/+
         na9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751559676; x=1752164476;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wRBxpG39WUVrHqcTPvV9xbGHze6Q8q/Kx3SjlFYED8w=;
        b=tot8H3DY9WloJUIGcS5YwaCT2jcKLH/va7zNfAzuMlqgU1tSpaoHrFG8PAOr6jY5j/
         +uW0FLmtXlsjHfpEcHP25Zy9ShkY2/+M0bitwz0kzSCL65A9NlFgEPlwiA/pVkKd0g4r
         7BxJR/AEbRuDjvHdf36osPxbMVwltEmsWMdoLui/Wao+i+dwjk0Lh4Z7eQjjkgpYwhNM
         4wU3ygyGEhFPTBbXUpShOwWfGKEWAqkAUMv4ovvoXmna/WLBDyBnGesAovqbI0TMB+ay
         A++TlPIUhCSmHNNhEfAZVVCS+HfVUwWr6DTzFvbvDfhnEi9xOZYCln364uD4KixWFOiP
         yjjQ==
X-Gm-Message-State: AOJu0Ywj5sV1JK0kUK7sPOf3gJC9kNupoBK2BkrO5s0NNtMqZd45rDMG
	0H3EtZkK87zzzqNZ1cqV27Hgk6N6eaHc14mmGR6DuR3CLZxgihrRHzEQ+LZEbBq0
X-Gm-Gg: ASbGncuHD2TmaFygakMnBNHK0nYP/sYQqaMOgchsI2PD3b/rs7nv9fo9PfdN7+n/rTg
	41Lhf+Gh/liddgv11J/pyGmRLkVsMqy23ITG5J+IgTEdYuLhKiqKbGPQqqABdTJ3klSyy1T0OeR
	/1A368XbYn22cTV6PCXC/Zb1mYH/+IJKxQVGABxYHKr33DlHTA0V6Q4yUOzL3vsK4PygzQCcc3G
	AlIP39JDuExPP05jHIPt9ZJGIHkb7J59tmq970RLzIgI5eUqx6xLfqeObVMpaQzNprMLXDMNhbu
	+YpiOq3pDlt2vFkV7s0G7iwLd/68lA8FfzWK5kSMpEs0iLSmh5tGg3Xp7nUwOslhX2k=
X-Google-Smtp-Source: AGHT+IHa229+i39Vt8zDk98imPUjvZ2VgcnQbeXGlHuGYuwx2C119AAs14SiTKwXs7ADUiACc00LFg==
X-Received: by 2002:a05:620a:2590:b0:7d4:67f1:df8d with SMTP id af79cd13be357-7d5d440e910mr392613985a.21.1751559675973;
        Thu, 03 Jul 2025 09:21:15 -0700 (PDT)
Received: from [172.17.0.2] ([52.254.13.51])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbdbd172sm13854985a.42.2025.07.03.09.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 09:21:15 -0700 (PDT)
Message-ID: <6866adfb.050a0220.160f2a.1673@mx.google.com>
Date: Thu, 03 Jul 2025 09:21:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5224832857445195001=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, abelova@astralinux.ru
Subject: RE: [5.10] Bluetooth: btmtksdio: fix use-after-free at btmtksdio_recv_event
In-Reply-To: <20250703155657.32865-1-abelova@astralinux.ru>
References: <20250703155657.32865-1-abelova@astralinux.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5224832857445195001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btmtksdio.c:331
error: drivers/bluetooth/btmtksdio.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5224832857445195001==--
