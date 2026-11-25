Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605968;
	b=NCQRGjyRjFY7u56rE11rg5Ps9KVsjftGwCRBsT8nJSkfclwzQtBubg2nS/Xf26jqmq2U
	 gs0YgUL3Hm++wHuNyLc/UxlBiVCJCNIO7GJPBq6nZ5Laju7se0R24fDt3kzjg/Aj94G76
	 +6y+UeLi9azH2cyVwNzAUC+1kqAb8l8Kq4bGVl6w2HvvyxKKnr5UzstDbDet0oll1JdCL
	 BSSHlMoCmu2Ahcn1yhbtNEruIw2jYvdJnbvhlsODURg1z2KTXnxq1WUdC08zdiFlU0i5S
	 DIWaXw8evOsdtJ3Y/2qopQKzXFb597giPUZEGIuKOwv0DS8NBrNdwsH24sc82+6FeUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605968;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=dyvaWk4CYad9+UrreMQ6V622GcK1KnhpGz9ELDHoJlU=;
	b=2TQredvIROog7BVmOY9AY0Ee+v1iTPs63Jlg01zccu8Kahue8J0h9oqxeT6VLvQHG59S
	 +vEPUTpyOgvCAw5U3TO4LY54+mt2g/o3oF4Mx5ZfxKYCE8Eu1ET5+otkFkDVMrSZNqlz2
	 wJc8Siv/JnqR+0VfjsbQkM8ORdgtdsp3OEOgl+fOcmdC84JccWxIZQOT4/dmm6rAiuZar
	 sNGDcgr4baf/0Kf66uP0ic74LPIV+uZZ9zxHo7mg07mk0Ww5k2O95fhpwr1AWNkHGXGVt
	 OHO64fq8HdLytw3J6+hhsi0sK5zWiLYz2/kfj4IB0LPlqGfDLzw2tQKCtENi02f3nrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j7hRuV2Y;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD69A606A321
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 11:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD69A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j7hRuV2Y
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-845788309b4so2693927a34.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 03:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795605967; x=1796210767; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dyvaWk4CYad9+UrreMQ6V622GcK1KnhpGz9ELDHoJlU=;
        b=j7hRuV2YhwoVrB1H94xgkWoozQnuiSXa0VawCUu7INi3m5hoNZjRFNqbT74mRAJrEg
         HGtgDuZjLPWYERX7IpIP/aUVZYXEjDpKQweOnr7/+q+pSt35F82jEiL60VeqyATNqoqR
         SsQfXPCWp7zKaDijtbj8YWxG0xFl4Mf6xk6WG+66HjmU2DNondGG+X++WrXqj8udKnSc
         gSJBzoQ4YsgRu7jZRFrCs/rB+E2Bcitb9v0iPybHeThM2UA0t/lYvzT86j3hXxEIXXki
         iuiqAgpTJ3+IJpTIIuMWzUTzqEMsle4BxLhHLBMNf/HutpWOcsMladmPVbWk0h2yfEb0
         Wu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795605967; x=1796210767;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dyvaWk4CYad9+UrreMQ6V622GcK1KnhpGz9ELDHoJlU=;
        b=ktgz/fgOIxv8+AGMfKNLvC4tATCd01Fi/LnVYV3EaPi7rZfUExTYkCaX4s3UMRkB9T
         v3dwrCrDORu4nwdeY4nqPt+POrw4VWj4tUs3ZbMdWzkXnyb9IxuJ8cYPgHB8V3tE6Sbi
         FHOve36I9lWmbcnJJGEGrIMGujIJ5sqD+JDzJAuivYVckYrL73wK47NPC+tTiHOVg/Q3
         prb2VlRkOYiK4ukTeXD+quaiAP44dLilRCLpkz6C3+RnF66YlEQ9thTv2Wls88Ca0DRf
         n8NZRlg2/wTRhEKI9kd+ruo7ftV22dVarn1r/jz/bfuorZcFVXauptQpDtG2hL8Oj1RD
         VByw==
X-Gm-Message-State: APuU4Z9Uqj+OrqSXXszH7EKPFkSExEjH5nyk3boyMJEjjQs6Mha3Hw7T
	Qirm9xpMc414sPDaPbNh5ya7zpleWHW0XT+V2pBoGRErzSQhVv9/dPFb6Duc79cF
X-Gm-Gg: AZFdTZeq2vmDAg/L0LccSTcP+5U9C9Wz3AErdaXrsXGxs58A84LJ7qo3Wuy/cZXAgVA
	M2na1KfBtskrRO1/oIBSRm7ipCi3Wd6xEEAbAsC8sb5v40YyPHsjjld8TihBPWPGzyetJ8mj83n
	7n5AJvZBXgBph8Gurvvbi7LIWf87Av9SOKCdUP+m3MiL1zGc5hCGtMDmju2ojoRFx/FQ9mQx/5L
	/TL/kxM0pvQO55xOdp+viOE9RzDO4SqLpWKDCGD0SL4r4+MAOFLnrKAOKJTdGmWXui4TOSsdodZ
	L2WYrVauG7yktQzHAumzb0FKHxQlceuB9wEIO+X/kqNjkCTEluyVl6xFmIYbvn1VL8IlCg4EZp3
	+dON02Tob4Cc+fDJVVzQ31kzovJlfjD1KfkqYUL+kndKDHIYiyfgNslh3MhC4XrwdU52eRzSabO
	xyzouuw/t/y4jszykqtmmWZxkZIoFiMUp2LO282jKzksEUJBJXOoz1AOnSa/Q7Ixt3CnYT2b7TR
	PtqyK71gbmUROnB/hDhPiKE5Yhgza204mMZGM6ny1BeOquIbaqGi3ni/fjk
X-Received: by 2002:a05:6830:7185:b0:862:c089:d895 with SMTP id 46e09a7af769-86315083724mr20625851a34.0.1795605966790;
        Wed, 25 Nov 2026 03:26:06 -0800 (PST)
Received: from [172.17.0.2] ([20.80.77.31])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863168dcf38sm12568593a34.9.2026.11.25.03.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 03:26:06 -0800 (PST)
Message-ID: <6b06c5ce.be725b5d.1246c2.b5a1@mx.google.com>
Date: Wed, 25 Nov 2026 03:26:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4476180520610197331=="
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
To: linux-bluetooth@vger.kernel.org, petrvaganoff@gmail.com
Subject: RE: [6.1] Bluetooth: hci_core: Fix not checking skb length on hci_scodata_packet
In-Reply-To: <20261125093208.224568-1-petrvaganoff@gmail.com>
References: <20261125093208.224568-1-petrvaganoff@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4476180520610197331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_core.c:3786
error: net/bluetooth/hci_core.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4476180520610197331==--
