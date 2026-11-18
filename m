Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794970279;
	b=RCC6dGTF6QAA0lF9tmvbUY5quiUGZ9pzOm7lkgzJkCX0R7VxMtxZlUx4IvV9fs0avMp2
	 +vWOotAwZxtxmIQlKHTUjbfG1nnuuxQBGtdDIs9zBmRpJ8YmCxg+wTGqgYi2bqnWuxx3H
	 RcGuvF0dOlvvZuqsEqVgLX5b0mWHd4BRRBExubJo0VJQLTX3UkJ7+X3NeCqXLX5oyaDFF
	 yAKRwhUpirbGSNzgiaehsHgWEv5VfdAhIvCjJplN4zswSzWuhnG596ah/h7ZDpq1muv85
	 /WhcKbAZvPCQeALh4bwNq5cr/FUslVIM58X5wkMOEjYcgf7KhXZEDrzgSuWtRMvYuAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794970279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=u6w94EaGigWshKq+C5tx7rOPRJiisbsAqE18yR5A+u0=;
	b=zwKafAeXtUG4sFipjnGMTMHAe+wYr5TNj5KOw6DM9YNriVYr8TKR1YGxYXsNshsnxu5Y
	 ZFiRmY02saV6dl3BQmeGz1VQhOtd/KW/EsjzGP94+zgymR7CmHoLM2g8NX+B2lu8jGIj/
	 3JBJ8fIGDeOu7FPmjMMQ+4zDRl4iAsZrPWmtluFTcEpTVu8PM7DHpQJRmFU5Ypd5TwB3R
	 hpKJ0mgOeitnnMBbRDd2x8NPS3j9hhG5J6MmRrui3PTGY8e+c035FMKgNN1SU17Fe0Wed
	 uDw6zMzECgTOeOABS+fv/XoHlw5ELBrFL89pgkflOrGDGphM05ZbHh+/6wUAD9tZsoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o+H9Pfg7;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BAB606A31C
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 02:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55BAB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o+H9Pfg7
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-55c48582654so4989071cf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 18:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794970278; x=1795575078; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=u6w94EaGigWshKq+C5tx7rOPRJiisbsAqE18yR5A+u0=;
        b=o+H9Pfg7AxClsTJ9ZZVcY59Z16OLMFOgXXfSafC8ava0prgUPktYwtb4luZlj9qez8
         F1r8kT1fHxUPi9WZOk27gR8DQpS3SaukCDT0juk+BW0tv8VjW+kfsdiyZnuUajK7aIrT
         KaPgIe9E+JFNbeUglv4k9sfJvzr45t0ZKwWfP8EEywxXt775qWI7PjNz7U7I9o3a+0Dr
         41xkVhfUGXsbrb/h3zwQNTmxXd3usnmILgg4EjU6lu3qcGMRdEJn9z7WxNd6lMQS2VC6
         q/OrIot/gBX0R1k8p5p7YkcI+RAdwaB9NcG7fo+TXMjij8A7khTnYRnmx+J7io9KEH4t
         biJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794970278; x=1795575078;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u6w94EaGigWshKq+C5tx7rOPRJiisbsAqE18yR5A+u0=;
        b=pzpOsZUxQCRLng1AtZI5K74g4Eeo5fDvihIcGJSeAtfPvauhXVt8np+5ZelSi6dR9p
         m7C13jQAgQlrt3q1VY/S3a6bcqQ3lhykauySB3gQ/ntvBtQmLMGNMHtEBaaTrEHKfOkW
         V0EQXfBo9d5QZ/fX5WKHoLhI7gBZdiuzscwfwVu8daBfvQLf2WyqrElt3nvZUT8PjQfV
         uhOXvnWf3QL3mK/rknf/l88X0FRA5I0QGSB2b1uxSPfihHlvp5zPh2sUcOhgPcc+Y34D
         4CVcwmZiqtQcy9Nrx44M/hq3f6PVBKompsKvJtbtJxSLY49/Ix3xai9v/Oo45izZwK7a
         ok3A==
X-Gm-Message-State: APuU4Z/KLFTiIPXWNZfiILoSar9B4jwzBEI7S0I4qR++l1kq4BE+2Gox
	n6ykYiL400l8Td0D5AxE1pbjNWXvFlxBiKzbBk/ntBpcqpeGzz8XGwl8SO1DfQ==
X-Gm-Gg: AYBFou0VPSCdqhiTRaBUY6i9W9q3bj4G8SGAG6s4uk+TnQYfyHDz5VnEvH/Ve7lFdAA
	vqJhPgodLcjB+ZkTAl8zGwear6G5GjT50w9bIDGgH1+vJB/lmiRDEiRcmSQhI7Zt+qYiZ8SLpkD
	QGGWtJDRupnlAEJVZ9zvok3Fl+JdN2TOm3O1dUOifdxDXILQlyOQhLKP4owxPBwa+eBTVuComDa
	WlI1DOYYUQNFjgzxRxSu8VMpSnaTJdL82ori7vD/zzJ/i3n5JHoYI/9GqqfyLNZ5KFZtk6n/l1j
	L5dNQ0WTWbd3MafoPNiJWvxpYds4YTDARM4uGyTbdp57u2CpvXvoZIGHQc5KlZZyoCMoUKQV4SV
	XZBJMOSt86bVT2/aZGPSy5uXic0ZbmA4CXvSLlP46Rwlz2Koh42x/0R8WvkzURK9jSLhryBcqPG
	Yq70X2kJB4KcGTqhv8ULtpCayxA0r6N0X8PKgahLnWk0LS0p3YI+E3ALrRJpw2kYi3VN6zVfq7V
	5gz6Oaa45c1uI1Gyj1BhiDZHKZ5Q1arAyyQGEr6WYhiSZEJ/FpGflCG6O3/dGI=
X-Received: by 2002:ac8:598b:0:b0:53e:35dc:9bd7 with SMTP id d75a77b69052e-55d5a6a26cbmr20887661cf.61.1794970277995;
        Tue, 17 Nov 2026 18:51:17 -0800 (PST)
Received: from [172.17.0.2] ([20.161.70.215])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d590c44c4sm11505011cf.24.2026.11.17.18.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 18:51:17 -0800 (PST)
Message-ID: <6afd12a5.a1ee243c.5b59c.61e7@mx.google.com>
Date: Tue, 17 Nov 2026 18:51:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4838295938945403308=="
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
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Fix linked transports of an ASE not enabled yet
In-Reply-To: <20261102215457.2553416-2-luiz.dentz@gmail.com>
References: <20261102215457.2553416-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4838295938945403308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       Fix linked transports of an ASE not enabled yet
   Pull Request: https://github.com/bluez/bluez/pull/2749
   Created:      2026-11-03 01:14:44+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============4838295938945403308==--
