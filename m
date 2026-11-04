Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793756908;
	b=cWyN9leSr9g2pDtBWXlb8rc4f7qkS5wGO/z7z34+Dk6nDRtMnyARpeu51+ua88HBZL/A
	 zqeFG+NhkVXVeHTKm0YHsvmfwq846D9d7p1IrCCDi1YCDwdbVHp84EzEqKM/j6Lpmg1fO
	 iQTlR4WSh6M9AGs/Abont9rJFhsj+AP9aPySZr9zQpUZjBlP9zpvX8wRLXcXn4TLweK9R
	 4NR9NEezHKCX5+qqmsiltFY5ZC750ygPtCe8FG+5CeH62uo48rnn/9iUPZ4vXpLi1QvtI
	 1n1vEEZsym6RaGgX5+a9ZQX71iUxfxxm4bMTu+wVxWMKQOYThI2TsDWL/g6j4ibEW4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793756908;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=hXAzpu/FJnc9cnPXJgYYvHLFynLlFn7tYCz7mTp9vkY=;
	b=ZEw5C7mrjRgnSmYlA7Ebz0k+2SwA/XwcvIr2yJb2M764kQskatIBugaGtTDJ10rJJv6L
	 6m7B+DnJMVFjf+g93sWxYRmxaC4oiqyeGiCavjSvh6uMDjwDHsLtwgvkCUThrmydjGXET
	 8BJuSwcaEXyHPBlUnjish0kiP3UG3x5z+Gd/GUpJ/+v1T4376/pY0p+o6Zk3fPINQaCXy
	 Wi+9q/cQnMelBjQM/YbgtPUAfrfYF5dcrPTpcwJ46cZyjQcpl5bBGass8qrLGnL9em00l
	 aE4esqSYXCDpj4ecwqtagU+WeubWEXa3bAU3bcNgF6lIuMO4sC7jvMhFAiUGOTHEa8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HwGxqxZX;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5AC606A31B
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 01:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D5AC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HwGxqxZX
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36cad25b8b0so218148eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 17:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793756907; x=1794361707; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hXAzpu/FJnc9cnPXJgYYvHLFynLlFn7tYCz7mTp9vkY=;
        b=HwGxqxZXCE42ze5zIiFIewRui1FgPHdbnl8xSxwZsa+txrwYRI5g3AG/8AW2zniieN
         xly6bNLXSSDCLB2V1EWck/CwQ5/J7VcUV/l1bgua9bEMf2TXTQbIXULLTpEHrJ7wH6dk
         fXt3id4lXLMydTBQy+T9HHx/pC6JPYAco+EJamWWHf2beDTkB4SFNENBUU2Qai/+wTCh
         fNxIado0t0poxBJ1dgWGZGRKpmZUFPX1I34/baGDI4cd37o0GdzazFIBq8gwsSnwWUwp
         mGewWQcG4lZ2tCIKpK7mEEUycFTryQv1iZddp+0RfGOqmIcy3bGfn5ZEKQ2LW/3ucGL2
         UJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793756907; x=1794361707;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hXAzpu/FJnc9cnPXJgYYvHLFynLlFn7tYCz7mTp9vkY=;
        b=xT2dlnJ5wHZC/gQcH62J/ecllgsHZZCyY00ntBUWiTWuuEMl43EVbTePS201hoDifr
         1JVTMb/e5UyUeWtk7umJxhHyOacpHH1dHXSbrm3Aorq0edYUCcRD97jwERXAO1sW/0TT
         T0vscx0KoHQWrnFiXm+G/BKOL8vjlUHp99sMaC2m50Pt6XtlwZFO/lLoq6YABVwWJ1JM
         lLMP/ih0Qs0lFMQ3t0/OT/hVqbD8hYYNug5FaReipU1ce5d4dB8Ry6zYfEu+riK4Zt0D
         VZyOdVp+0DtmJ1ir5snNEemJPrPZt+4X0Qh+s8f4QxrNY2QHo41ePycLkp8CvNQQNTUU
         NASw==
X-Gm-Message-State: APuU4Z+GIIxfCgk0mBD9hpv6QdN7HkmEB8Ej6NQ65w1+ioDLFhvDfCuo
	aMQG0YYCq2nYMCWDMPYGFPMKyXeJyzpMXAetGlpp9KImK5dYAqX0LSktghbO3w==
X-Gm-Gg: AYBFou2A+9sPznHpSgscs9F/X0CKa81kz+GRFbThP8TIhOyMzBjwq7MLyXCHsrNVWm0
	3IeB8ymjPQ+11yN/1y52Dn7HQ5K77Cr3g3McUJFITXP8+YpW2uOTDaQbQBspkZe8t6K7XvlTEpt
	YPbNVVcCJ6hRVJnVufP0qzalYNMXrQP1cygbeookEA0kITrMP83OdSjys72fc+uS8UZ0jnsCccn
	qYlWIknyVRLh68kF1RPSRG4CxfjfH60HRe/EtwLZAlBQZtXCrF7Kyr3HX4VSjFVEfVCJRZnJSv2
	yhWdANtyqJdAazahu7T3EQCj/4cdZn6MJenrGR6COEuIOo3T07m7PfH6IS2VeV2d76w4OCeUvOQ
	kahqSq1ZkVwq0I96O7bpK/mSKs0BCI+X90eYonPlQvRjxDKt13WgvSyFiXIC0KLnRk09FMG2fjx
	gD10WVjTMtidgcF6G06k1B40zPq/1D08qABw8S4XI2sIXZKL9jLMmSSi5Tfe4gYCp0J3qOyK+du
	bhD3HxOCtr/aaODauQJRj5aSBDJKFzVhK5mmUrKIfVZK2ZFpYJ2f+6dHIcK
X-Received: by 2002:a05:7300:e9cd:10b0:36a:ac68:c745 with SMTP id 5a478bee46e88-36aac68c84amr6153703eec.25.1793756907241;
        Tue, 03 Nov 2026 17:48:27 -0800 (PST)
Received: from [172.17.0.2] ([134.33.77.33])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38f53a6sm2075248eec.15.2026.11.03.17.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 17:48:26 -0800 (PST)
Message-ID: <6aea8eea.777ec61d.8a230.4fc9@mx.google.com>
Date: Tue, 03 Nov 2026 17:48:26 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5115694788849013603=="
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
Subject: RE: [GIT,PULL] bluetooth 2026-11-02
In-Reply-To: <20261103221921.4071765-1-luiz.dentz@gmail.com>
References: <20261103221921.4071765-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5115694788849013603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To record the empty patch as an empty commit, run "git am --allow-empty".
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5115694788849013603==--
