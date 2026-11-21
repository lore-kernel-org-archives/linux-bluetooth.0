Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795303100;
	b=3/dCLm74x0ERStAlf1mwTPDOQRqTpXii+cgUGak9AL5u+ctH7L4umaOabRrQmjrzDMVB
	 WYkiIDXgQAmADb3YxCLmYI9bHngS7gsHMQYu+vhW6ceGq0ZiNYSgZVUqlngTj+XiLJPwF
	 6qiTqiJb7lo4Clokg51wtE9f6afyjY2fLBfHvGmOB1jNOa1MI7t+QHnqSfkLtN6vyVaQD
	 o0VuyqfUzLRYEsDFpEzAYOb8FI6TiG2aBPTH+HufvvJQZiBiv8O5JKt9azCmTXvJQMWEz
	 Zx+u+vROHTSqBo1HpJxOTWUliUnVNuX/xN59iu7EHbotsGoTLTePGdj+a4akYyWtOrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795303100;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=5bbhW2CR7Lzke4R3jc9MGvm3IbZUWqwlC8MCNxVHB9k=;
	b=nKjCBzRfFJ68S1728DTfI2rCK1hKSx//HgZGmA4aMfCFj+4YCet4RS96P8AG8kS1UbGh
	 MizXQBpDAePM+ELSzliMdhQXHCDwRAHuojqDeqtGqEQBHk4j/3g22bVoGH9BVRNwt2Xic
	 oukRX6ubxtNHmDXW+rejQZGfw5sg6wa+CNgjieq74UKrUEFeQrqtcyNfwTKmQeXP5Grdc
	 WgDydmRMGpE5Urmaa8fC2aONnk+a+jbhSo2o4RXzIRmFH3oszC9Xu0MRVucMkgKPv9wAa
	 oP8ROz7V1zJImcq0W0o1oHHYiZlcgyHYPDH+kFrtOIPycudyZJmq7Nfw40c4acCMEsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zs40KFVm;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2DD606A320
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 23:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A2DD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zs40KFVm
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3863db981d4so2514331eec.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 15:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795303099; x=1795907899; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5bbhW2CR7Lzke4R3jc9MGvm3IbZUWqwlC8MCNxVHB9k=;
        b=zs40KFVmcjRZ7yw/9e6gaikWUthwXvTKjeUad+cEnyHJMlkuk4IcQBHE17PcZz7YNk
         hK0/lCeYxvwal3zSWSSWZsphWoWkuiJVfBUufaf5jfiwpQyxwbGQZ3upvphftCVAK1dN
         kzOu8P+aFy78s6OTAHvHUJdibtwVJ0u8Nbp2483CFwyXDkob0/1Eo0pGJMq9o4ym2U7b
         58nsj+7CTvKmcNTIVe5ahKIYsJTLDL7P0zSE3AqOswYZq5oMJJcU3QtR/VwD//itWTj6
         k9HWzaYfasOOXgAPxm2C66TkWzP1wsSlreojvKVA7OPtS4ct1/HXwvPblSYwJTr0B4vA
         /aAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795303099; x=1795907899;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5bbhW2CR7Lzke4R3jc9MGvm3IbZUWqwlC8MCNxVHB9k=;
        b=2CdC9qTg/XvVrRPDwZYWsdv65yT+3IpJqsYxwKWDC86u8hSVYcYsg1ZEd+V2uouLdD
         SECCtrB4Hl9Iga4yw+FTknHWkHfWttQoNo/8Re/hjbxJnhG8cw1jzPzYn7LlW15YLCn0
         QmFPGdyR9F1uxvicgi3iZVy4LDB7mAU+LjAPH+1kIlfglnQQF+QFi0E2vGWY5ldf5LFl
         DBptBexXqGiIPU9Rk5WQL65CkZkGgP8a3WIxci48GnkBUtqkuq+1PHauqebfsCANnm+m
         IlyxzLuJIFbcPoy/4TUWB/9euN7qJd+kEegiHEWrP1jZqzAB2RR0f57OVaSkFd4z905m
         4uvw==
X-Gm-Message-State: APuU4Z8kyf3RQT6ixPEkAklPugqOil7BK5cjNjZ9EH1NPXwlLMz78ZER
	yNjwFnAUnlpogXxs7fzRl2coyT3u1CeUQUPEEcIkhLFiPfvikJijejkiOZyC6A==
X-Gm-Gg: AZFdTZf65EdnbfWQDyOXosRYMNXf02CK8WPCA0caI0R3ySmS9OsReC8BCSmslZO5nxH
	aOfNYDLjMEFLgALHgl6lz/RXgj9xP3ciwIYMf6AgW59vK8rILHqI1PLHv/XSaURKwFm00B1fgxR
	SOkQwVL5w3s8Q/+PRYj5ZpMCOV/CN/Pf9/fVCXkwXXsyMNOyf04EiL3q0BhF49gyvo7IRPQpANd
	GzXwk7H48mVPpSmEKNfgsRDuV0il9n5Z76fGSo7PDAwljPpJwZ9iZ7+EXJO15CSezqJWkHJCFaL
	Dwky69JGukbppo6X0/D4gC6o0Nr0aM7JbVTWwkpwf4IdAsjENj8pO8N+aRrESmDPHpv5kkJK7Ve
	9hxoNJYGGMQ1VPXnWCyVZAZahm02jHpsH1d/IOnJpCtb2msaIDOqcVRVJfD5h5MJ5uBVG9TEIXs
	5Uhx+T22d/434W8MtyfoxZJIObnTNfs+TFWxiQcjZ7Zr7yfjIF7mHlXnhwpdegxNn9/cq+j3mDw
	cm90c6nYsTXvtHFHyKnm3KJ8CDmkHKN9S58RnZIhOAiWEqXsi3BuHIwlqIs
X-Received: by 2002:a05:7300:430a:b0:379:7bb6:9c4b with SMTP id 5a478bee46e88-385717083eamr9449204eec.39.1795303099497;
        Sat, 21 Nov 2026 15:18:19 -0800 (PST)
Received: from [172.17.0.2] ([57.154.3.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566fdce48sm23638207eec.14.2026.11.21.15.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 15:18:18 -0800 (PST)
Message-ID: <6b0226ba.f2313814.3bef54.59b0@mx.google.com>
Date: Sat, 21 Nov 2026 15:18:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5635440136863983990=="
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
To: linux-bluetooth@vger.kernel.org, ecstaticmorse@gmail.com
Subject: RE: input: Do not re-page HID devices that disconnected on purpose
In-Reply-To: <20261121205835.381239-2-ecstaticmorse@gmail.com>
References: <20261121205835.381239-2-ecstaticmorse@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5635440136863983990==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218301/

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
GitLint                       PASS      0.50 seconds
BuildEll                      PASS      17.21 seconds
BluezMake                     PASS      257.03 seconds
MakeCheck                     PASS      0.95 seconds
MakeDistcheck                 PASS      129.88 seconds
CheckValgrind                 PASS      134.93 seconds
CheckSmatch                   PASS      233.08 seconds
bluezmakeextell               PASS      85.62 seconds
TestFunctional                PASS      1069.87 seconds
IncrementalBuild              PASS      259.98 seconds
ScanBuild                     PASS      908.77 seconds



https://github.com/bluez/bluez/pull/2864

---
Regards,
Linux Bluetooth


--===============5635440136863983990==--
