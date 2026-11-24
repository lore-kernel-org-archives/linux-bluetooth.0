Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795544577;
	b=vmkqPSnInjkfEn9uDJ/wbCf8LFQLL0IumGV+bqg89XY3v5TbhPRwUZOAsR849Whlzqyt
	 gc79wkoyD31uKzHGulXRt2Vjet23kgcoLKZEDxZjguhvSdbgF2bvDofNItUI2g2mFqVXW
	 6Q5mzpUqzrqMdPwSwKedL5hI1j0Oe6VK/BdDO/CmMyJSD6zBBLSz+Hr0ZkP99hDdlsgjv
	 a6v3eGr99Yvkr1NTm8waDzgdTg+8/nCKu5PiQ+I3J4WLdf66mbHnFA+yvvhsCVMJK2A+f
	 H6kNAzOuFHtZrWfBcaCKGwJ2ib84a3GH27jIN4TND9Otxi0WRISQx4VC1v02XTGFNyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795544577;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=y/cet2TGSeQpqh/8MpJ0qzkzL9mxck3NyRPHHlIMif4=;
	b=tgogjZ0bFisZsJgHdgGNye+oynKw748xpIWsIXPdzHYeF9/aSlPYl6be+j3s525tps6T
	 c0HNiiRw9sIsVaWAXkhGkJCKDGEkJ7SownCgYIO9ML2P2XqSIYO9ROnnaYIpGwG0T//af
	 HtCtu6OFH7bA2swHSMJ/83bxhZYFyx3+xBDJTIOgl6hnSxguib2i74yVo5XdgYd6pSUzU
	 qL+gPdLx/pULlHWgsTJaGMR6P6lykUoG5nQ0693g8fagYFgy1Nsew9WzxEd765bCqrOhs
	 ROsyj/WoSXbQbYvjJYJgvf+JqpVW4XDZwCYvn10nvUCAHM3fTPGq2FAEk3+JJ9iVbqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GvvbDCI5;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461A9606A339
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 18:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 461A9606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GvvbDCI5
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-55c38cdd5b7so28472951cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 10:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795544576; x=1796149376; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y/cet2TGSeQpqh/8MpJ0qzkzL9mxck3NyRPHHlIMif4=;
        b=GvvbDCI52JP3MLWx1OetcZrifvvqulZhU9ibxdNzJVP2I2XhfERT9ZJ/pvkHuiWB3J
         Rkx/P/jsQmtvymn6mr2t8Ee4oUaMZ0QhSj2XKOmKQsrGsZg2oON/RDLKEHYCw9YD0zrp
         aoSmwILxaf6mkzTGtHu/iL+sL14o34nZiK7Bdc5QsWFETM2uyaYjlKP3ErhlM7+loxzz
         Cj1NdspRylknYd9OLZIbYylmInzo9K4kHsJwHG5AqVrW/ep9ocXFUSx/H6eDmlwGBnGI
         N5ha9/AHfrGoiNjQfpU6rfmh3jwViRUN1HVfFrSkbbaBX645FNwxiyNK+7pYEplFN0iS
         GAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795544576; x=1796149376;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y/cet2TGSeQpqh/8MpJ0qzkzL9mxck3NyRPHHlIMif4=;
        b=UjBCzc+8TmQB85K8HO6PFW4Kc9RoxZ30cayj0z+z129WLYcDPiCGIfF/1wMxdH8eqg
         zkwINM4dwlW0TXLJGZKMRD1TXYGYcyC7CaxWhJoUIyymbrZWLzKf3Qsa9cghGULeZnOa
         8QAmU5k4eK5Bq/1xBB/SKg0yJJaGUHmOMQIBT9o4r8uMOpoa5hEuW+2bWf3nUMZka4xQ
         iG7cOsu86T8jB96AscSz0+vmxPdclKa8vVR4hmQe0XWoE+Lg0xB0tsd8SF67bkt7nuS+
         ZR/ujM9ijNWSiCq0vdlIwRiVLyyP9VD/lcvOZpNQhW66W9C0yMZb0qlkkmcDpBProWcp
         UTYw==
X-Gm-Message-State: APuU4Z+EvQMdDnFONZdtuAUfVaPrVwFvs2FM31M86pBvJ0Z7P0KGd4la
	LM6AAQ37KARIMTaCoHr2dlFy2IjoYv8gxO7JyXvXvZQKZOOnii3jsc55L1tYSA==
X-Gm-Gg: AZFdTZdzWF7XSami5Ugk3H4bGthADDzKMcXtQpBPlH6KVcmkN810Nv27LBIBP0yzbgO
	uXv1pYTazB1IaxYoVD5m9+QQjslrqf9QCJzMZs822FnlhSbXSCWtkYH2cGpYd2Ttt+5z0P6P5NC
	aG0OIcHSpDx3OxAWgeiaai1iJY1Ct/tci+sqXgHTuKkPn+LiqLkz5YzL1teNe+OjV1pOC9P2z6C
	aILykSlSCF5x83XEBoAe/H41NHJEUMWKoTnGD/jCeS9WqP6+Exz7T9pbQ8aDaa+8cy1M+MIWoeB
	xXk9loZby92mmGHbj4z268y+W5hl5svOR7BzrwDCFva82hlAusU9fKyTTjJes6LGim5tvcSyOQ3
	QfbjxAPgs8V3cOFmxSrkg6IM1QFTJzNotuwpGZc/QWF/1tmmgKFICBMS8xXuFm78ChcjH0oqJDJ
	N731CIy/10+O/J6JGCTjcigz0luBQ5kqeUrnzXmtYoQNPjPzVWmwPTv6SZv5MWd1G5i/vSim8+m
	Qyqm2HXFfRTpETNhWPfEb/q2gdsTLohEX1vl2IrJitCUgxYij/qF9fVfH2pi7hlMw==
X-Received: by 2002:a05:622a:613:b0:535:b21:c997 with SMTP id d75a77b69052e-55d769314admr284142101cf.8.1795544576170;
        Tue, 24 Nov 2026 10:22:56 -0800 (PST)
Received: from [172.17.0.2] ([172.174.199.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134796329sm139090616d6.2.2026.11.24.10.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 10:22:55 -0800 (PST)
Message-ID: <6b05d5ff.ef491db3.11c694.6e0c@mx.google.com>
Date: Tue, 24 Nov 2026 10:22:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4618702137989421056=="
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
In-Reply-To: <20261124140956.15296-2-andreiab9019@gmail.com>
References: <20261124140956.15296-2-andreiab9019@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4618702137989421056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_event.c:5435
error: net/bluetooth/hci_event.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4618702137989421056==--
