Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794393853;
	b=ozoLq0sYWPvkW75J7BUCf1wuw04zkIsfoXLRGKjYLRwvfyl/h5+pjLc9FqqgZUX/Ir7B
	 fxC817L689LV86aCYhysRxeOf0OPTlecJL12VuItbJyS+xnIRnTMYEQg14jPsFfsk/Fg4
	 NYhikMrLLWZk1GREZcAJkgavVA/u7rCXLUIu4szirx1sMzjj0Ay126+g7LUXpXxz77IPq
	 QapYkTUfPpu3fcG0ruvK34e+MRaV7VF4leEIn1dHVXbZEOkoyS1dm233allpERM/sR5em
	 zWcbmX+6yv65yfkRD3gq8w9OgWwSe/zTjKhAe3HvGJYGbASelIcEz6I/8bl/kKbsgag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794393853;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=1ndBUtA+QdL4D76NH7jAIYZfoMRmvQ12HD1VEyIFJ+Q=;
	b=uwz/qPUuOqZPHfD0UCDqBh6zJoTuWzgKN9zDx9BVb3V10NtzxnJ5DnfKlroLKcmw4mG5
	 EdNl827f9BXg8frd2nG8W5GMK5kBvaUjU2PXVrWFxyVt3NMC7W4+SJp3c0tomVPnWjVw6
	 8y09pANlBdaoQtRie8dSv7jvytpF8Po/y7kwjHpkGPMANcQ9YGTJI5aECGwaFDfV1Mv6N
	 ioMh5xb/V52lGa1fO+B6axSsb/zOOS83YGMZIk/yccaVJtN608Df8nu7a0cBgcH/PtSUX
	 Tlts93XPJp1/mzDn16dqlkrpDWb9eBV96ik0PjplnGOF2jawx1h60PVjH9E+NoL9dcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KZCgjYx5;
	arc=none smtp.remote-ip=209.85.160.53
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE06B606A326
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 10:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE06B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KZCgjYx5
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4ad4072943dso1044631fac.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 02:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794393852; x=1794998652; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1ndBUtA+QdL4D76NH7jAIYZfoMRmvQ12HD1VEyIFJ+Q=;
        b=KZCgjYx5AOiXo7+NZvg7guR6+rbtSuqngwvmUlxwRM6p/QlDdvCd6CeqRl7CAkyPUz
         CKEbZkZuYgQ7aHPTUpkcsaDQV6BCWPFgz9Qjmou0jEmO4CpVXr9CtU1oj7i1OwuNAYR6
         1VAJGKV1sI1U7jyH6rXQTYvru6+lDHaWk7zG6A2hfjd9L9WhjU3AawD3IQAmQ/Lx3vuz
         Hl8yS6fO6YtIWhTJ7fJnBtAht8fUzJZ0EshckSVRvDqXpX6VOcQ08OQ3rGg1vkkTMioE
         9eH40lRE27zikaiW6DT7gFWBMk/fRLZrJQSWvwz2nJBtoNmdUGjemkFQiE4LTBSY6jkH
         ogHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794393852; x=1794998652;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1ndBUtA+QdL4D76NH7jAIYZfoMRmvQ12HD1VEyIFJ+Q=;
        b=rLqjA4/0haxD3fb8yzl/I+4gFWaM0PbLmezhg881tE1MCob4gFVyhbRYubIJpd0lGs
         a8iaU1Y04Bd47m/FCTX0qpTQlPDNDrBQXJYNIM5UriE7SR+iAgJTcZwj0O/gdb0f1m4u
         ZmWdHX7opACeA90bvHqdREFHs86J2pq6Fch+31GgP1B49ZUGqOR6B7wQLsM+ffQ9gZB8
         krxm+tadlUQ5oBNkgjheowjzgNX9rbbSfGZVcJHvTJBddsKHU+96ezXJV9YYrZqqthBU
         nOex09K3KG/IVxfjmaSqycZAUHoC2ffU8txmr22bn5oGyuJaVxfDU5ZtxUriGLDuHxra
         G04Q==
X-Gm-Message-State: APuU4Z/bUBH0vcGANiIJCPUKyBqG7QQfrDqXXgOtdEXIvHOnj3QMQEPF
	k6nQcwkCmCb0gtadjgVKo5mhnxPCxTL8yKPdWd1ftH8RMHde25grcOum9eN06w==
X-Gm-Gg: AYBFou187TSAKPZnVA6obIc8+GhVpi2rjtHn5rn9xXTrREHWwHXUK8lu0A/CX5Dlt8r
	Y+meQS7PyCmK85eV5zR3VXjWdYL6O71p3qQ8FPqKpqLodYWuJFXJ3mtE2xh7zyX+yg7qkTe8o32
	0aj8YQeQWEx/D6ggg/lVJd442PEM+xpNZcurcVtQ28thosHOyOsSvdrBUNwC6qzFQbuNETjdHbM
	HFKBfGkXIV9gFqecH3yDTMme9yNlbVsaFvv5hcggfCzyniUiHxapsqgS5jux/coK0et4LHcswfD
	FsO6e/SZy5OP3pn/O1V/Nl1/2Rzgkz6dWFmNGLzJOqj8jCrL66uIw1OF03uJCMMnUdgZNCIQ632
	pK/CAixNrmbFIyDe6Gni+1e7eA/7ih619fLjp9TKELPi3JbIxEL7RqFzdgXvUE4snYzp2Q6cDV0
	jtAJAhlbw11yKRlQAr2Gok+irRlPKBA82wKG3DjLnhI1MZ8ZaQFsw3dMOuudWTgYirBhcbDK3VE
	Y6fxUsXM2zai97BA0n8hLqGWXZ7iE7imFbxRzSDmALYehkehyw87oCjyaNXzGpzUDrwsz+AhQNA
	/h7QXg==
X-Received: by 2002:a05:6871:7408:b0:4a7:455a:b1a7 with SMTP id 586e51a60fabf-4ae46c35b19mr1695310fac.37.1794393851498;
        Wed, 11 Nov 2026 02:44:11 -0800 (PST)
Received: from [172.17.0.2] ([20.64.8.154])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae22f6b225sm2876127fac.3.2026.11.11.02.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 02:44:10 -0800 (PST)
Message-ID: <6af446fa.efea58c9.2455ee.dfc1@mx.google.com>
Date: Wed, 11 Nov 2026 02:44:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1858836179233665252=="
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
To: linux-bluetooth@vger.kernel.org, joeyli.kernel@gmail.com
Subject: RE: Bluetooth: SMP: Fail if local and remote public key X coords match
In-Reply-To: <20261111094518.1359684-1-jlee@suse.com>
References: <20261111094518.1359684-1-jlee@suse.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1858836179233665252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1208171/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.84 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      1.15 seconds
GitLint                       FAIL      0.33 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      31.36 seconds
CheckAllWarning               PASS      35.88 seconds
CheckSparse                   PASS      37.99 seconds
BuildKernel32                 PASS      31.27 seconds
CheckKernelLLVM               PASS      41.46 seconds
TestRunnerSetup               PASS      748.56 seconds
TestRunner_smp-tester         PASS      6.42 seconds
IncrementalBuild              PASS      29.14 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: SMP: Fail if local and remote public key X coords match
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#122: 
The commit 6d19628f539f ("Bluetooth: SMP: Fail if remote and local public keys are identical")

total: 0 errors, 1 warnings, 0 checks, 25 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14971828.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: SMP: Fail if local and remote public key X coords match

5: B1 Line exceeds max length (94>80): "The commit 6d19628f539f ("Bluetooth: SMP: Fail if remote and local public keys are identical")"


https://github.com/bluez/bluetooth-next/pull/1109

---
Regards,
Linux Bluetooth


--===============1858836179233665252==--
