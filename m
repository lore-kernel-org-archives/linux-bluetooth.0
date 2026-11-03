Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793671462;
	b=iO8FQa+1+2hMJVZicwka681U/Omo6QWX5QEK+YySwL6gybZ46NlRhLFl39aO9dtIRxIZ
	 I1ObgVNSSGPJuRuprDocTexWNEQarSm2xSpiUmTWTGKMvqOzHQ7kfBNoPqntJK2yN8Ln8
	 k9f7fr+fQ9NmsGBXVuWypYIxY8/vG9DPiE6oMybBBhYgE2osi1omlQ2rI3k3h0BANWbqx
	 RJ3b6YqQib09FxU7ypIN7tVTyYCUMz0bxkXCsPaQcEbc7B889V6O8m3goELd3AUT8KKXW
	 xZ/rxI9jaoEvHWCwzKXZKrVPjFronqKoS00Q1xtaFyjwvYFEgR2mnfv1lSQhwvAMtLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793671462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=NGIAbtVolEr2OXZjJdggLNSecJBbXfhe96HyD5YzcUU=;
	b=EgHcoG3TRFaY7I2fUlbRHhMJMj96ukipomGirpvW2UcK08hQZemAvt1JTSz0VNUJdvyI
	 leDzoAqv+dTiRdxBHT3rnflKGrY1TVANH1s/EmPbQ14wod66curCiiEQF4ic2aWf/xOw/
	 DJBAJUje+6tTCxTEF3IBozmaIHqCU1zSO6np1bp8nR2KtLhFZxAtu7NTHWUYYv9iTkgs5
	 OtWhAxDHkN9FpjJFp13X8lhyMxoC9XXx+2H/IqUP8F5vDomU8GUemw2zLMZDnU1XAMlD+
	 28GEsSoW3GPl/Qk3wDSdDVfzu7+Jp/4u6qNY0OAPRUBvERUeZum12+wEu8Lsd+CXyRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=no5sElqo;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E76E606A324
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 02:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E76E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=no5sElqo
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso4650062eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 18:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793671461; x=1794276261; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NGIAbtVolEr2OXZjJdggLNSecJBbXfhe96HyD5YzcUU=;
        b=no5sElqoDoJ3lZVMGCrWxbAu8O2Y4e708V9MWWyglAaAX7ZooCNDOKNPyM9fcMOkrM
         jHSi58V3QXl04vATKHWLbv9KNFsGvAKKGOD0Gx7srROqwvpKzuqbcNrdrjmofvVI26/4
         p8NHHUxG91bgO2dVT3RvA8abxkOup7s+LeNd/Jd9Ij1L253bKXjOAjPXeXSa21/OUoOD
         UAEhVwDLbbQz0qvFQT/RtL2jYO3m5TVZclyL1Il8c7m+SlcudES577w4uVB/K+ZQ+4Mr
         p6GXtm/UONd5TIGEpJQjnl3pp03x3S3nwB5ANyE7jAfybEgPAZ9aR2yAN1raK7bemzW2
         1FEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793671461; x=1794276261;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NGIAbtVolEr2OXZjJdggLNSecJBbXfhe96HyD5YzcUU=;
        b=kShQS1W218+McH/Vgm56iUJvAltBRRgrXiJlhNF8f654agYvalptsD5uQKabiYQTzG
         74/aCHWbCeBHp43ZeNeos8qzNQZm760umKk53e5qciMsFZsah/Znu36x9jj083dP88MZ
         V8GuWizlJPugKtwYwMP2yVAAV0YS0nvVsGqvqQtKu1pyRxy9mOmTIaS0RXGz7xu79gSm
         KSG2TPhS3JIGiuLCLc/uDPGvl8dfUrtCbJ2XjlQNUQhcaXfY3xuRtKAZpHJltzlWKodK
         9M0QFX8K43pwhh4ESl+tga17wV0gqpB5Jd4s3Mr+SgwnYrQNLezfQOYGfFMh0uNcKB/J
         8VUA==
X-Gm-Message-State: APuU4Z8x2Y/8M+Z/XAWe0Trj1MKuJOUvRub2dYcLkpbGwt7dIIckWoC7
	yaDuLLq0xLdLVjl6yDDs7DAmX9PW8CWTjCFbu57I406LVWsG+8wfxfOK9AzWkA==
X-Gm-Gg: AYBFou244bxPni5zRCRiCLeq4M/q7ir+NSBzFUNnH7psxNCBwolRM3Q5vhgQyj6IAq7
	8Mu8ry2E7nE8McC/DCGzjCzhIJaoBBvT8zU3jYfxBYbmUC23Euzb4dGQmT5MrKZe+aGh0cdeACl
	4KtYN2iPnpK5rm6MxoER6+80AT7s4tl18hGmWHp7/i5lcNxcoCp6/44oR16KVObtN4/MLIa6s08
	pdcV4VFURx718VpucRewcUl2wAScKPDAfiXum0hN1Z3MJKDNCkGSRS55yaG9NG9R9FJfVrLj1c5
	N/i6Qtj+4ypB55P2IZ2VZrgrTA26GyyQaTyzOloUFwCEiI6FcMKqX+/FXNfpa3YtdR03fzIxkhz
	vG/IGHZGNNWfw4puziANyniDIcLTLd06Jq1KE6AoIa6vzLYQHzEQ50wnskaxwkTw6F/COa6qzC1
	KABxzUwPXAWS02D0hoJb2A32lfFnUOtnPrJGog8A35mMa0cvRglvtH2lamiy3qqQVdJtais7Ano
	Yu57C4g4ADJtXzMrBo7cGn5BrYWXCgdXqCLb2cVm+Z4RpirIKZy18euIXRlJFqP3n0zC3EarWnJ
	DzFqBw==
X-Received: by 2002:a05:693c:87c6:10b0:351:4a80:d94c with SMTP id 5a478bee46e88-36a423e1f4cmr20089482eec.21.1793671461179;
        Mon, 02 Nov 2026 18:04:21 -0800 (PST)
Received: from [172.17.0.2] ([20.168.7.238])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a429000f8sm42244945eec.13.2026.11.02.18.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 18:04:20 -0800 (PST)
Message-ID: <6ae94124.8ee6fb5b.1dbac2.3d99@mx.google.com>
Date: Mon, 02 Nov 2026 18:04:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5179613216181502361=="
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

--===============5179613216181502361==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1199535/

---Test result---

Test Summary:
CheckPatch                    PASS      2.53 seconds
GitLint                       FAIL      1.40 seconds
BuildEll                      PASS      19.53 seconds
BluezMake                     PASS      222.87 seconds
MakeCheck                     PASS      13.78 seconds
MakeDistcheck                 PASS      115.34 seconds
CheckValgrind                 PASS      184.26 seconds
CheckSmatch                   WARNING   218.75 seconds
bluezmakeextell               PASS      73.59 seconds
TestFunctional                FAIL      948.33 seconds
IncrementalBuild              PASS      261.44 seconds
ScanBuild                     PASS      808.69 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2,5/6] transport: Don't set linked transports pending before they are enabled

1: T1 Title exceeds max length (85>80): "[BlueZ,v2,5/6] transport: Don't set linked transports pending before they are enabled"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:309:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:309:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:309:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bap::test_bap_unicast_desync[hosts6-vm2]: failed on setup with "NameError: name 'CONFIGURED' is not defined"
FAIL functional.test_bap::test_bap_unicast_duplex_enable_one[hosts6-vm2]: failed on setup with "NameError: name 'CONFIGURED' is not defined"


https://github.com/bluez/bluez/pull/2749

---
Regards,
Linux Bluetooth


--===============5179613216181502361==--
