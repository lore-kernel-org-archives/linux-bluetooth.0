Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795575306;
	b=5CZ4pkljNYltIIqhS1io1YobTN7rABeVo/Y1Z/keg1w8WOql76lLljM/c55bhIp52OWN
	 wdgWM17D1HvqDJm3+Ztwj8onDWjbJonExogwzMMVOJIHF195dH3erOG59OWy8yVo6UmuZ
	 DTprHvReW+izBwWfwvNWELhlXdeAlegyFjhc6Q0GXi+r5mC77tBO4WXGGVUV5jCJTj3Ca
	 Zw2btVnNCfkL/ZBcaRCa6ZwOsITu3Jn7qWLpoC7evDYXM4awNbtmGa+NbMCWwpNp6s8Kl
	 j9ctZpFaw9Iv2wTQh8qGy0X+Dth6wHe9XP83PkKhyHLR4CKhfLWIDiFSx7el3WxHXxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795575306;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=2KCvQCecR2RzkHM6npxhRjPcS+/0CRBbHKxJYuhwg60=;
	b=ZBPnr+/xUNukvldDkp8aWfjBrxSKGDPqNLTRG3B5cQqa2qZwDFIBoOR13hPuYHr4K1BU
	 am+6dWYBAD5jesTnsSouhnv/nC7fiGM/MrDa6wV/1D3Mhkj8X79uFyHJCmVyDvovta3d8
	 RIvWy7Uk2OS1YH7obVWVnCS57wQyhuQSOBZaveXfviWguOnAmnDgYmtL+fT0cMUe+vee8
	 HYm2LElIWPzAySAnmPdSz4kxPHVC5aA1LVhB6WI/nr0IZ8Gut9lslzvibzM+PGmlWbSmA
	 glIKK3vu2o3RA5SndpBM2Wz1ZtB0W+mqGvlDUAUz6iPORyhBATN7wfK/m3h1CizkGMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lZAOb8Na;
	arc=none smtp.remote-ip=209.85.219.50
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0D2606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 02:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA0D2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lZAOb8Na
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-9213f004a14so64228736d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 18:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795575305; x=1796180105; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2KCvQCecR2RzkHM6npxhRjPcS+/0CRBbHKxJYuhwg60=;
        b=lZAOb8NaqceC6SdIEBhnkO6W/1+lNnQT20Q5817YQz1nkSYGqh1HQVD/VC1v9Ta0un
         UgdObGJAOdqgCdFxO1GA57752x5+gUaMceKAC9mfTWLTTk0SH/rmieQblqyDB0xZ3fz1
         zOdTx3p2z4WW4LzT3tA02vjrkUePTdRuMS2sov0sq1DVsnkOdWkL/0P8wuSQ+v1qZOOn
         4VefU380yvpQcTBacAKbt6PrnjprLS+rse7BU+H3Ou2Frzn4RshlTTBhN6IbwQ2FGE5H
         SDybFO5RbUyPh1Z73OZVVCnAXlx80GcNLH3fRp7CJFaTB1WPdSbdZmTCPgDPalrYr3G2
         681g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795575305; x=1796180105;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2KCvQCecR2RzkHM6npxhRjPcS+/0CRBbHKxJYuhwg60=;
        b=kCZMdYBh5KmebUK0tw4kZwO8tyWVo6a2IZUR6+0mf3MVTbjnzzJo0Fz1+fBQXFQ6Fs
         7oBLai+LseP+B1sd7xvr2G6VpdY3aNwlFtSYo+PX0y4bcV3V29LO2f6RswCCWbBcEJHv
         RQs7w4Z9MtEEGZzf5CLiU4cdJxgOh71cUmLRnSvXPkvps9Z86euwM6XcbXcak2r54N8o
         aEmCNiFIwOKs/tbMz1KOyEcOWLNaeLQl3hW1IQphyb1I9hOD8RtJ0ztOMcQ3s46v2ydE
         miMfhyty3NkRtIfo7z0+u+ZDN+xmjPV7oo/EHAJwRFsVhs4Cg7k0ZFl9nzTh07gPfMTy
         VQaw==
X-Gm-Message-State: APuU4Z+H+EjHn5nH5uFZmcfbB2HH3tVPZHS7hQAz73/YH5WQFq2UnVDK
	royyF4LEyitKq+Sk5Za99MUF+ygL1rznFdqY9XoZy4kEM7gWQj9kB7KGIgLZ3A==
X-Gm-Gg: AZFdTZcQQgpp3o6iXPH6GQkB9v3xHa0OthqBn+nyRJa38h5edO6as6/039D3VUluiij
	elFMKkFIRBA5t978XHNioXLhdYRMwZaAFDu3zn7euXxwEhQK9KFt7u9Klvn+4DeKVHD436OR0YO
	3CUiqPaGWjLZHaa2c2rRxNIu1QiFqMhLK1ldR0OQC6DIWVPjLfkHduIkHuW4vVpJD90/IdXr+mq
	ti9HEL3LjT+u4BN/giIMLVxzV6N7CzwqsZE4TYwDSwd+zhCDZ2te4Mt1QyM/1QpF4gky7Z+IM28
	OPFlAnqCtd9nf5Mb7I9JhdDgeDsWl+7S8UqphabIYYKO66dt0O2ZC+Pg/EPi3ZMQFjL2bnUyToK
	JX+bmcGmIivt0F6dCqd5ibVJYv2QI7JGqw2+tDFLrGfANkNlfKCvFAiQLVP8U9cRXZpI3sJ4V36
	Z08SalEocKFIo5btSkW5BpzFNRtrnL9DPwRUnjFfYct0LdsojDcaQxeb9cBk+uxa4LDluWrSCqJ
	hnaOJ+eNpwdpLvD/qxs4v2JdFg80mJS4Rfvom0ncgVSEW8kQ9GjDFCVNqt3PD0=
X-Received: by 2002:a05:6214:3c9b:b0:921:366c:7b33 with SMTP id 6a1803df08f44-921366c81f8mr282857656d6.19.1795575304752;
        Tue, 24 Nov 2026 18:55:04 -0800 (PST)
Received: from [172.17.0.2] ([4.246.231.113])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349d0f6bsm152547946d6.21.2026.11.24.18.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 18:55:04 -0800 (PST)
Message-ID: <6b064e08.c85f3c08.14732c.7c39@mx.google.com>
Date: Tue, 24 Nov 2026 18:55:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4871289934325131080=="
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
To: linux-bluetooth@vger.kernel.org, andreiab9019@gmail.com
Subject: RE: Bluetooth: fix bonded LE peripheral reconnect completion and holds
In-Reply-To: <20261124211127.41609-2-andreiab9019@gmail.com>
References: <20261124211127.41609-2-andreiab9019@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4871289934325131080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1221297/

---Test result---

Test Summary:
CheckPatch                    PASS      2.01 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.67 seconds
SubjectPrefix                 PASS      0.23 seconds
BuildKernel                   PASS      33.17 seconds
CheckAllWarning               PASS      36.39 seconds
CheckSparse                   WARNING   39.43 seconds
BuildKernel32                 PASS      32.70 seconds
CheckKernelLLVM               PASS      33.93 seconds
TestRunnerSetup               PASS      781.29 seconds
TestRunner_l2cap-tester       PASS      14.87 seconds
TestRunner_iso-tester         PASS      13.74 seconds
TestRunner_bnep-tester        PASS      3.24 seconds
TestRunner_mgmt-tester        PASS      90.05 seconds
TestRunner_rfcomm-tester      PASS      4.56 seconds
TestRunner_sco-tester         PASS      5.71 seconds
TestRunner_ioctl-tester       PASS      4.77 seconds
TestRunner_mesh-tester        PASS      4.60 seconds
TestRunner_smp-tester         PASS      4.50 seconds
TestRunner_userchan-tester    PASS      3.31 seconds
TestRunner_6lowpan-tester     PASS      4.53 seconds
IncrementalBuild              FAIL      33.91 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: IncrementalBuild - FAIL
Desc: Incremental build with the patches in the series
Output:

error: patch failed: net/bluetooth/hci_event.c:7470
error: net/bluetooth/hci_event.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"


https://github.com/bluez/bluetooth-next/pull/1221

---
Regards,
Linux Bluetooth


--===============4871289934325131080==--
