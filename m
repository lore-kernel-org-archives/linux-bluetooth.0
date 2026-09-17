Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9890382F1F
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 07:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628567; cv=none; b=q1BqOhhgw7K91W5qhBEMtj/M0sBqTQKRrYpjZ+mKjaa3w7pB77aM3rU3I8xEgGHIfR9lDCpOreY5ua/6gdkQd59wxZN7MdHGvOpGhKgO2Z6UmBiy+hCwdptZWL31+IP4ocO1sjRgZ+oB2Gf1KNG95uwjgXjnOr/FG5OkhN8FFmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628567; c=relaxed/simple;
	bh=wdFCrQO6san1JFYBYGkQtuUUBkwXp4RkYV7du5SHfjY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=lNPtchUYDyH7WYGbnQwOzSEgvpjxeWBbwxg7sOoZEev7DtGWc/SYxiOb62nUKJ0+/WCD+NyVEuJIeNMHPFmMlEK47g+eUCAjy0az7ahefIA039SSwFx934dFPiNFCzBvSYOwTWeK82xy9tbhcd54zpGfDndddnBOaR31CNmH6sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTZz4WCT; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTZz4WCT"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd5cf03so432945a91.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 00:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789628566; x=1790233366; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wdFCrQO6san1JFYBYGkQtuUUBkwXp4RkYV7du5SHfjY=;
        b=VTZz4WCTQYjWOatiE+HIHSHly018pdg3WkT/rAaYIMOAcg6w0L1r91qL1QRjHUI4Ra
         9gcul1UN74nTVtgsXVT39l1NAB1oVo7qKQ5mOUhQmbrVNK5Ce7jT2EUrwRPmCXrb8iWt
         k/W1gtorHqjuCrWo6qS7uzGe45CQ3ELjxdin6oXu7W5VXDLK8gFhYnb2Yf25jrMJLPwS
         SRoq5Ub8IinyRhgF8eWqA/Nm54bcKimza+XqV4xi3Z7RtrcpSx3z8OF+5WQyBse57V76
         R1kpWYIDb5LeAjnoXKKhstEOIFklbe3dqIl8kUFvq8zRSYIAXEcbtizMWD/f0R9BIVtk
         GTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789628566; x=1790233366;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wdFCrQO6san1JFYBYGkQtuUUBkwXp4RkYV7du5SHfjY=;
        b=XzATvkcvwXvuaSLDs+Nxw/exKEari1wTh4RZklTGa82Q2i7/kUVZ1vxmcphKKKOYS5
         N1UqEd+wYMzwIniAWmit/L6KmZL2l0v369zsHmtU9d8HyFJ672ncGIaFoy8FqpxdORWa
         xuGXAe7CZsvJxEf6fCj5N3V/tPgaIPC3PNj4aV+6MehJqkMPPsIyjmU7VDw7n3WyalJ2
         VMohi2ZRxVWNnBy2WVgZvckF7mZlEGQS5ZIgvddJSKoo7OdG+1wZUvM/n6wptLWVmh6e
         ZpcqwxCqRBW5wH6wtvY3YiLrhGTI8ENGLlxb8lUBuE8t+Hs+M70DrtcJdYrsVmdfoYhr
         4GBg==
X-Gm-Message-State: AFuF++kiUWLFhr+dxjgz5x2sTDWd0qoKVdEK647/qOOCRrGQG0CEC2gR
	2bun7vN1yDfMjOfXDHJMSapLR0fivJzMQPNcmHzrLoAsnPI0OoN3IMnfENifRbaD
X-Gm-Gg: AYBFou2p3SDKMoFR5vbvnMkHctr0JzH0/husDA2Y6x64xMpZfaSYXYf1sQaDcmWhnKL
	zJJ1Ke8gQVSL5xAtnujii+IwnItsM4DQb+URJDDKINnrQi9TaadW+nJ0qnb6W66zJpnDzuuZec9
	ZTBggIHb1dq664ZS2KD+LcdMCQStFfcUktw7EEkIaIEAnenHJuW+WC1j/6XPNe+ckdIvDyL8XcF
	UrVFsyysfid2JTDTgnK/KVVUVYd0N9ui1NP2rB4JSSCqbk+LH7567eTOUKjAGiv354IjgRMMQIf
	k2hpBfsDhJLrrlLJaZQXpUEfcr1GjQ3ynfpLshm/fT+2A/ZeVtf0QN/to3cSdeP8T3RTwim3G4P
	8PBWEJ4npBpUY3WMHoHr524Z49eVb6a0Y3aO6lwTGlZUQS1H0bauh2OYECmgaWiFcFh6NoUmez5
	dOuXrxozL52ztm61BtdzRGSpjs92deqWSFMPVxLB2FgfasfQfiNGZaZSVedZrHLDvEYgCJwEr8T
	86l
X-Received: by 2002:a17:90b:4d0d:b0:39d:f189:48d6 with SMTP id 98e67ed59e1d1-39e1e27b244mr11929261a91.4.1789628565961;
        Thu, 17 Sep 2026 00:02:45 -0700 (PDT)
Received: from [172.17.0.2] ([52.183.7.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e35b6a350sm3854637a91.0.2026.09.17.00.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 00:02:45 -0700 (PDT)
Message-ID: <6aab9095.8f0cbdd2.23ffb8.41d0@mx.google.com>
Date: Thu, 17 Sep 2026 00:02:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7505434636295179052=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yanli.yang@bedmex.com
Subject: RE: Bluetooth: Add AIC8800D80 SDIO firmware loader and UART HCI
In-Reply-To: <178954773705.2.9860089868793386321@bedmex.com>
References: <178954773705.2.9860089868793386321@bedmex.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7505434636295179052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/Makefile:51
error: drivers/bluetooth/Makefile: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7505434636295179052==--
