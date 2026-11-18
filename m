Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795028294;
	b=w8tOa9Z3xEg8WmZhkFMjGSwlMjaQFHs542JMlCIfOA/AvMyeiX4fBj8X4VAPDRfQHasH
	 rgXB0u9e7isF4dz+lD5LN5D3p2VVRIsoge8G6d7cKjGvBiJxmlh/9bu5FUnyg3UmVOdAQ
	 i0dj2xFxQ1bUMdUkutPxAf2gers2reo0PdA+fneI5ztE/M2b3tCHXN6bDJNcdfAknAzlS
	 0xnEpVL+zIs+jRaw8t0dp0sC3y5VN31tDWJNB2Z091Xyr2cpIz9LtkJ/vr7w8hTxdFqti
	 I2lXtdDMNegK84OSJYYEzZyCUGgJK9iYi0fUJbVTvWilgc5B/kEpXbgz56L6J4NY0cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795028294;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=MQ//HlviYfZb3abywXRUGjE6SmLAzU7iOjz9ngCp69M=;
	b=d8YFQ1RGdsHqoBJ42elyd8C2iQZ+KKLphr1bSnkWtpHMEgLiJIjMT9Nzm6+384XdoDN7
	 1f0vaocssZJg9p+2yZ5Y5nAmFwH1nD1yJS9rIr63AnZg0275HdVAbR14kvqN6VPH+1tr4
	 d/HBa9y4ZcK36PCC12mZ8f93fs4f+iv7XsuxKTaX0aInmMH03ki3sinZLuhlQ34431+IW
	 BiKjD+n5E/tCgsKqqxR7cPbX/TAKR34kqF2Mn2OKtQmbGPNxl+v6JIsjU30O075Bl4ojE
	 JAWk+04MqtWAelpocQUhR1pWyk1nth1Mm6vX4YNLDO+iiQHtSWgVqXRgsHPRkBMQWLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fWEjIgC1;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16062606A320
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 18:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16062606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fWEjIgC1
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2efd659464fso5689155ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 10:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795028293; x=1795633093; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MQ//HlviYfZb3abywXRUGjE6SmLAzU7iOjz9ngCp69M=;
        b=fWEjIgC1uNFp/az8yqbaMQq9AFd88noNVFEtp4P4abNVql5X4xZrN/O/JN1F+ryb8Z
         nRG7p0Iy6MmhoSUOgWSDHZed2q7alBz0No5E00LzGssuo29od2p7BfgB7jeXbGv0kLZX
         vavQg1fAZTY5ORKIKw3KZO6iBJSiXTxUM2evZcHQMN+ijecc1ugMiX8125PV+sGiANw3
         bJV7hmhugHopvQbrVa5CJwiz0o/13bnDGKyZ8StXHowjiq4bnoAW6xOo30RSagGdk+0f
         50LZn3/8nvyPgivYSReA48zyqzhrhWNuY8p2DFa39IK57ZaSdZTAwAFIzib+nLv3QScl
         TWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795028293; x=1795633093;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MQ//HlviYfZb3abywXRUGjE6SmLAzU7iOjz9ngCp69M=;
        b=rjJQSprCgKMJjKdAsbwfUdEeVSWaZNLLq9iTgRzYs25DPdpURxWsHGOH0GQ134CSGQ
         LFUa60gn5ucjCiiCYbYsDQi6wBlcIcUGVOt8aTciX+ZdVLw1DT7XZugualjE9kwkqMhC
         90GCiIwChpR/y7KYskEIFqKk1cd3QA8DKgZMXPyN8gUKFLD69PVO0qdyh+Wp84Y12rCm
         Uzw0uCdnZN7Cip2+Dft9vfV4wMSL43rgY2uaJ1Y4hk4zZGIGITJDIvCz1jXamoLG23V7
         b/dpcY4uvawIZ2rjkrEh13EUeYRU3d9EMbXWBBnmykaxXsk48v0ilMdPQy69VJsZTkk2
         OHwQ==
X-Gm-Message-State: APuU4Z8EJo9BWORSR2b3bPcRUoV63+CZ0bZ7rHRQaocFbGxdf5CRNEqK
	ljk+HLAW0TDZR36vM9tXqhxmpuupvKYzuocEWhB/88InlFvH9NJ/gXyyeJadhw==
X-Gm-Gg: AZFdTZc0f1pFiU4GNOgMGlj6jnsQb1cqjqTgNCuAErbixDwnkSSxc/OnY8kqNaGef0+
	e7J8Wx1Iu6wdPhR00gdf1XdPkg2vhkINHhBsCEa04AhivyclxqZyYmAAj5JH8udNNksSOFoP8/J
	vC11YM+j9WWROIFQ26Z/E8Y+UmAGmvFWzKPcd3YVfJkhWiumYf0UAugl0Fxij+p1AeXa1ot49e3
	1WD+o6rKOWGJ1E8Y/1OhW5ertcb48VMNKBwDIg0EWGZsRGyG2R9nDMsvKYOl504OKNoSOiSXssA
	mROef7UOJhuz59v8TPw+nG3JeYyCfvGCiC70Tja4BZrRbezc7YiluXsfwHK+/xtci27JIBOawck
	f131zVUYSNBCQhJLOjAj5DzzU3TA+uSwVOP0YVmGKuXmS4KvM9pJDjMjVbOa3z6TtHgWFj9asxu
	DA8m7uWMWAIazsrBYGdSmM6eurIP9pJWJTWt9XWGrzMf8n48X/ZoPLnyhHtWkBh9zOFB8vo9nKh
	eM5qDr/fePwKJGRzKmAQsG8bnIdq2Tinx0VYSC5hrL++ACK816fykG89sz1LC3X
X-Received: by 2002:a17:902:e547:b0:2e8:93b1:49cc with SMTP id d9443c01a7336-2eff756dbdbmr37877515ad.35.1795028293223;
        Wed, 18 Nov 2026 10:58:13 -0800 (PST)
Received: from [172.17.0.2] ([52.156.141.152])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff62a7e89sm18012685ad.68.2026.11.18.10.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 10:58:12 -0800 (PST)
Message-ID: <6afdf544.c6d97709.1a87a8.02e3@mx.google.com>
Date: Wed, 18 Nov 2026 10:58:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0280827367467091826=="
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
To: linux-bluetooth@vger.kernel.org, bence.csokas@arm.com
Subject: RE: Add struct_offsetofend() for pointer arithmetic
In-Reply-To: <20261118-offsetof-v4-1-95b385c10b22@arm.com>
References: <20261118-offsetof-v4-1-95b385c10b22@arm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0280827367467091826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1214921/

---Test result---

Test Summary:
CheckPatch                    FAIL      11.39 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.44 seconds
SubjectPrefix                 FAIL      0.12 seconds
BuildKernel                   PASS      29.52 seconds
CheckAllWarning               PASS      33.09 seconds
CheckSparse                   PASS      34.98 seconds
BuildKernel32                 PASS      28.94 seconds
CheckKernelLLVM               PASS      29.37 seconds
TestRunnerSetup               PASS      688.45 seconds
TestRunner_l2cap-tester       PASS      14.45 seconds
TestRunner_iso-tester         PASS      12.78 seconds
TestRunner_bnep-tester        PASS      2.98 seconds
TestRunner_mgmt-tester        PASS      87.84 seconds
TestRunner_rfcomm-tester      PASS      4.23 seconds
TestRunner_sco-tester         PASS      5.36 seconds
TestRunner_ioctl-tester       PASS      4.37 seconds
TestRunner_mesh-tester        PASS      5.32 seconds
TestRunner_smp-tester         PASS      4.15 seconds
TestRunner_userchan-tester    PASS      2.98 seconds
TestRunner_6lowpan-tester     PASS      4.21 seconds
IncrementalBuild              PASS      28.86 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v4,1/2] overflow: Add offsetofend() variant of struct_offset()
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#324: 
new file mode 100644

total: 0 errors, 1 warnings, 36 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14996702.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


https://github.com/bluez/bluetooth-next/pull/1149

---
Regards,
Linux Bluetooth


--===============0280827367467091826==--
