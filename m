Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793646103;
	b=pkW+BRcbHfNSg3foYYid4BGdObgWfG2a/QwRtv08jA4HTLtOaj6Q+HV4jwjeKeY5y+AY
	 1VkFN7G/eiEVvFgJ6CqSP4ZiEETTyX4KdxLVSVTZa0xiFawzhzL6kVSf/1h7bNNUdPqXI
	 4rcp60eN9Sk19BgmmArBOGD/X77APrpjPJcGcefRc3n5oviACSwUntPHpHPkuSCh8lGN5
	 45iB3eSllpQ+ug69XNvlQKOR0ztlflk/+arT/R4LRDdmQ1gsMNdI41PtceQvZN6y0CR/k
	 YQaAS8qY4Ibb37mhdc29ox9fCUZotI2T7bSE+ViL/6zrZME1s9y70QvMcbVMUu7Gbyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793646103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=dKNAD1LTk8inN1fnvTbvzkI0BhY7gOD6YzpvcV+6VaI=;
	b=hYYZGyZTwPK15EuSGDZrJ2JKikxMXN/jxlj4st17oG2gJOtJZlS1W0leYmOMF7bIjnba
	 YtxW1zSUtu768UhXZkomFmwkz/6cs/gGZ7r6F3V1k7Sgm9HqhenHUT1QMBxIfnVueDyZu
	 dsPTEfwZb++wchkNL81OL2nrlet3AJZsOspHxBItRw0oDA/qdHbzYmVxEgnyw7vzZoLxO
	 VOsdYVTUVcjKqLVqPDQykCkmXF7HsmLst/LSQvTu/3Nxt7itpECdeCsJUKCg6aUa4e+KE
	 SHXLDHr691m+YYB+N3sfn3N1koZraBmUfIKxM6AI1RcMs/7hKbS93wRGWa3CrFa/Qmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nxRiEJBN;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870BF606A326
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 19:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 870BF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nxRiEJBN
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5364d86f7f0so48061441cf.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 11:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793646102; x=1794250902; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dKNAD1LTk8inN1fnvTbvzkI0BhY7gOD6YzpvcV+6VaI=;
        b=nxRiEJBNuw8UB/Wkz0B8niJirxNlElino6FpToGQCwZIgHjfMhq74saY8VcYJ8maeO
         D/6bOn+detobfWT7jdnricalkApuPKdolHLcCiU8rbrEmAYQiiSdwkrEtynZ4KvqLmD3
         bk8HPPL3X8P7FiO2MBTsxYdl9uXWkzyubYfVIBc0W+PYBGVV7FRjwevU7fSklqzi1Yo+
         oE/qW6rLbx7yRQzQrwLxM89kktgzsTuPJY7eaPC51PcxScUzxSSN50nBuRCoc4IqyBjv
         a/iFXcA6BQ/E0oS25l7c0Ml4qiEQrEu+0Yqd6EfEMko1/pEVv3F8GgG/HjU+ghnPyf59
         Dtaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793646102; x=1794250902;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dKNAD1LTk8inN1fnvTbvzkI0BhY7gOD6YzpvcV+6VaI=;
        b=AyhWWowtgFnQwyj4Ro0MyUNEv1ifOCRGOqSN5M0C1yNl6jxXPQglC+ZThZ+SkFsYNo
         eDycNKkNZoKIvN3l9q0cgPVvV1miMT+b7AowmFP5W6WCPWsU8VXY7Wd2IeBucgKIv1M5
         riQyrRfYVf6oF3S7c4TCR1H+C3VV08JLT438Te49AeYogU+F0RNcNTuka2wC8gdohxu+
         D3+qbcYsaZob/i6zaA+2fGLANpj+CLbnCRUtmAl/A3thx7VZ/sJLRtCkl4D9W5IMok/4
         sSR4/B2hxlcewWCOlJ99CH54gK/88DV1XTdm+zuU9RAcufxXFnqbW3twntlsjCsPj7U5
         urSQ==
X-Gm-Message-State: AFq9FYKPZyuxUed15QGFb+VKC1Hr//i6dLU7qaK5h2+kPAH09o0ktuil
	4EcDJ+4XF+yalVM0LTBs0JKXoqF8GayrPpRqF5Np82kp4EZroKf1ecxNyLXRAw==
X-Gm-Gg: AYBFou3G53tlct0Ih+1eWdgFt3ih9ZAROAPqfOB9BgtSqWr4fgtTRnCyhMY+ZgTPwWN
	nPx9Zv5N/W8qWe4UnfL5QRiIPcnd1mBwI7+yku0/8epCVqbRznnxMRcaFVPK2R6lvsSVGwbVNUU
	BJbkaswrbZuqo02u76FilpK5FpavM8W1aerAxxSF3x/Fsl73bgqkubpeAUxUbxAR0romMcs7zuy
	Dv0TsaVtY06039fcaUMvRGZlWPi6uW+zaCdOW9zyZef6jeb1PhrM+NWbCIj1bu/wz6s7gTHaHRn
	MDjzVHYbFdHc4DCd/4qXrS8P+Wb/fh2xVgYw1n6Ep/xYX2DpL3R9NpMPPl9B53lIGppJKrkU1be
	aw8YQseB7b4Sa3+YjCTNR9VmCD/yvXF4gvvnXZ2InmaOQ6/hndBmbOAFpXzx+Un4z3rFR7idjv3
	qqLe6MAhKk2sHzcKkUmNqBDMODpByIUDMZln2RB1p7/iaI6IzhIX0QFPAT5ET0cpQX5ItoyU/Gw
	oLSfyVC/gvJ1itgqeCPWUcfLw5EmM9fL8nSdBXW61O1qjRGlVXYB60OvUH4vkN/
X-Received: by 2002:a05:622a:c17:b0:537:a19c:6e5f with SMTP id d75a77b69052e-542b6972e55mr195262421cf.28.1793646102322;
        Mon, 02 Nov 2026 11:01:42 -0800 (PST)
Received: from [172.17.0.2] ([172.174.191.55])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5498cc59c80sm4965391cf.27.2026.11.02.11.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:01:41 -0800 (PST)
Message-ID: <6ae8de15.f8c2439b.a78f9.7fef@mx.google.com>
Date: Mon, 02 Nov 2026 11:01:41 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3198011222185536386=="
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
To: linux-bluetooth@vger.kernel.org, cito@online.de
Subject: RE: [6.12,1/2] Revert "Bluetooth: btusb: Add ASUS USB-BT600 for Realtek 8761CU"
In-Reply-To: <20261102153243.373899-1-cito@online.de>
References: <20261102153243.373899-1-cito@online.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3198011222185536386==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: drivers/bluetooth/btusb.c: does not exist in index
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3198011222185536386==--
