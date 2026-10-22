Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792672797;
	b=O4f8WgDn0DkMa/he67HTyJKAat0We2ns/U8KhHur7PKX4vKNiSfRFIsskxr8pEXncbgZ
	 q0d9bxkMjFqori+TFAhNIGuW4FVpnUq3FdcUEKly2CFjb8A4YO4mYxKIzP7kaxaOr0LQu
	 xQf915NgzfQ2qJGQeL7+pHfp2w2qtHjPzve6QoVHqBiDCPgP95N9vwhoz9Hl7/cCUwWi/
	 nZUqi0DYmVPGutTGA2c2VV2ai64pfoioSeE60ScwzmWakSfBSUhlLAWc1Jbpzdox1awyh
	 otCRtnBJkvn3PNv/d9MIBKy1S6SrUGI9hcaQlmiPs70nEVkYmEIX8JK5QZIpOJsVBaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792672797;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=hqEcP+LQGDsdZyS/xoh+ZKwrRSH1RRLixfAuMZgpyr8=;
	b=fhV6R/g5RwSge9BPUN7tBtmb4zyEVJDSRzP3un5QyLoPUvRz78MuPGUjTeS/AnEi70Rx
	 G3QdbA4wgDengWC9LiP5/q3QZcYkTnIFo/RC+pQ+QLpvtzWMkStb77wFbpKHGarFiz9YA
	 nBAxv5JUtpd7xBChLtwNGtFLMu5uegsadcm1yeipmZpWrXUrJiQ3tU6/eQYXLo1cmRWSf
	 Uk5ndovAfsknSo2xTAI4Z4wogn63Z0yvMScZqQuAnoa7Zw0B23Ef4ZWxFeu+wN+hTTcX3
	 xIvrn2HEQuZcBr+MN9mI2n/38JYxBbZtJbKyr1yGJHcOC0XoFBtnmsIVLBQ2NXR4WEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IR3M+j6K;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EBD606A319
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 12:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9EBD606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IR3M+j6K
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso1057191a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 05:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792672796; x=1793277596; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hqEcP+LQGDsdZyS/xoh+ZKwrRSH1RRLixfAuMZgpyr8=;
        b=IR3M+j6K4rXlqg+jKModq7b4XFj2WiQKBzyNULTeISPFqnXWcya7t10GMAnXcP4tAc
         D+I5aaAuxyf6RPvtkV4xxQGNkttA8MzKL0FoVUsD5kmYxtlPjT2rHaN63VwlQ+YiZ0Bf
         vO+d9ed9e+9bHWkhYJBl5kzJlEokFq/OU+e0uLC5R3++02SPB7qaEY6Khy4AOo65/i8c
         nWvokP4VDl94dmZlmMKh1qPp9xjyFv15NgW1PKzmzpClSn2Rvl/Dw/ckhTtof3NTHYFx
         uu3hVmr7JrFCrV1FN2YOX4ga8H5pM3Tuk+IgDbIZayHqFFlC2BINc0pJyfXbBLnG1Bc7
         W2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792672796; x=1793277596;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hqEcP+LQGDsdZyS/xoh+ZKwrRSH1RRLixfAuMZgpyr8=;
        b=nGCSkSrQ5mzlFU87A6Bzim9IWKwY8r2200+e6IhplsohTXq5RZYq6xqTs7DhQjCjlm
         1uWvImbnF16FrdEAtm+gOZYtS3Z1MpKTnr+3eCRp6EGSy4uqFslQ6NOP09G4jsW7uU5t
         mYVhHyXiqCMj05UrVUjhh1TDjh4+p15d0s621Vf6n7JcmwIJaUrn1d/l9f9870pgLd/n
         hTVb92BKrVSmdkqwpe55LE4/YOMXAKqktWS8JwXeVn/a63sciusdx5gEuRhl8kUGq1A+
         JmoeGhLgh3d5wQBpcs3uKtaca5ZHUuqqOpxfLBf1F2QPN2bxrh46fUHxjLvdfdrkM0pk
         1OsQ==
X-Gm-Message-State: AFq9FYIKmu4m/OnkiI/ZFjyGiekDsmZG2eHZzgu8pUerFFfAucuq7z4a
	qeIBLwEeTJaVdCcrCH+UNsfCa3dtiazhswzdfijTF2myXU/5jcPDmMH7tmLhoQ==
X-Gm-Gg: AYBFou3ovfye19RokawYgToPv5Rhzb4bD12fOuDRXJMkf8jeJJXx3b0GcVQMejye5it
	y6FtNSW/3y6oHtRvwilNXzJHahkvodPNRIVThAri5mWlzDCRdfitzuXpKEvSqMHBujoZrZN+Rkr
	6b27lRD6r3fShymT6Jaoxe1G6TneTX3hCPVfD9YDEftqN1X12+F85jcb0+/Xlxzyf3lc4fEA/76
	XCc79B/Go2ADlrHEsUlKD1qOtpwVCwN25BqKPsVXd3dP0WblKb1sj5pZCnWQShJy/ynGQknIMt2
	MdaWVWv4N7VWXsFTbpqdgtqfdr+m7nJHaWJGXPuieFn+qwXAien47hn+6SII8nsqiEQIZvE5W7m
	t2ollwYoJRRLEmUZ/UGLnsH9tumtYDFAJDpb1f1C1hhNfV7qM0Y/aOgpxk5bR+Wr4A2HSu4L6u+
	J4JBl3TUFCmHiC/hQ8Wa4zo+CR9xaUUdHnbgZArLme2d2g8Cu2xC4Yd/Kd4pA/xoS4LzcI1Evph
	oCBpbP70h/vN/xRkrs2SW/orKr4uqhPoPB/1UgEDdZ8AAkoDVCxIuzCk2hteUGSkPv3+W0U+zOG
	LIbWB04=
X-Received: by 2002:a17:90b:380f:b0:3ac:80dc:f40a with SMTP id 98e67ed59e1d1-3ad86d1d145mr4251033a91.16.1792672796001;
        Thu, 22 Oct 2026 05:39:56 -0700 (PDT)
Received: from [172.17.0.2] ([20.236.19.66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada48bb3b6sm4292563a91.13.2026.10.22.05.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 05:39:55 -0700 (PDT)
Message-ID: <6ada041b.6e2bf4e6.3a756.12ef@mx.google.com>
Date: Thu, 22 Oct 2026 05:39:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7883906703631625362=="
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
To: linux-bluetooth@vger.kernel.org, ghidoliemanuele@gmail.com
Subject: RE: [6.12.y] net: call getsockopt_iter if available
In-Reply-To: <20261022111535.528099-1-ghidoliemanuele@gmail.com>
References: <20261022111535.528099-1-ghidoliemanuele@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7883906703631625362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/socket.c:77
error: net/socket.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7883906703631625362==--
