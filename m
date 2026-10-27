Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793129500;
	b=cIAOTsNqeifE71W3OAgMlEsEPcqFko6O/UWCGF1cewAPDqu4r/k8cK6fk6bOnPnWL1qb
	 WH9uJn9M7CGTvBm+7w2wzjwYJRJkBWdDmNZ4mxWrFeADFn+s/JoG3OaO+rzDAt5nc30VL
	 sNQE1Fw267S6BhfGMfCKVdFjd0fRnF2tibcalmRqhmlmeq9SUsRkCLlZykMT7DIJ/cpej
	 DazAyKvN3RTF/yNLtxMOKAdjQ1XZfMT9/PFX76ReUN4CToMYs2xLwXDQBVjqoEMs6PCLJ
	 hH4i7j+naK8M4JriVBA5n83hjauagxnbVThEWUHuCL1q3wCwD6Zv284kD9FTS6NUhEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793129500;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=UCPc0Boq9Vmat8MqGMRDSLw2nhDviTD5M6u0bpiAp5s=;
	b=yOjAz0j+jgyBtn/Bl8EFuukKy58Hf6WjEF0biaqFKsomqCsoYf4XlKHAX7ez2MMoHdLm
	 88pAGk5Yo+d815WQS3H+2yknUYYQF8qn8uDTmyxyt7Beo9Dc+IpHFn3iEXvMFQkwp9HIG
	 XEvPIpWejorNSZrlxnza3WwPNrU1TI2KJoVgPK/RLWwzt4PfSOm3bqk00w1Igu+5/hQjJ
	 u8a2+DgbMiE3pjl1iMGTZhLtVhqTxNHRjlB76Xj4N3MPPGgxBr31zjEXEYLEdP0SInFmw
	 TucfIdNF7UhRrZut7cDc4nWaBXbhbmIM0VTWpQu40nUMbKkhssuM1x9gJXJag+Tx4vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=naUyfyRG;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A42606A31A
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 19:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6A42606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=naUyfyRG
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso613879eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 12:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793129499; x=1793734299; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UCPc0Boq9Vmat8MqGMRDSLw2nhDviTD5M6u0bpiAp5s=;
        b=naUyfyRGp8BSntLnvkuEVLRq8VJwlQgeQIUutbQQVuXpFAimuW/mWJVyXB6uaBrLSF
         9mjcU/xs+akRPCiqXjSKBAHXERxjuWEawylk99SjKHExF4eDPdPAdOr3Ddwxdt3Yzaiz
         tpx9sJ6MROoytQBbphDv8ISJPiE0GjldESCceZxw9mE95zcW8rOqNPz2Gc6P7JYVMg57
         nw5IMJgUezAnv+VPcK6EzJMHdn8KT1vqyn7kAwUEIl45HWmtO2KPKGXyMsXwgGIt4m2U
         suR25McpxPwKVIbGY/B31n8aDRURor2dPmz99Si/3/kaC6KBH0aXZGBUTkhiv0G3U5+i
         3X8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793129499; x=1793734299;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UCPc0Boq9Vmat8MqGMRDSLw2nhDviTD5M6u0bpiAp5s=;
        b=gIiw5YBJ58m5TCymvzygpuxl14SEG1TSYZBnc2e9HGx44TRRfDTsFkLQlVA4AmIWh1
         YRiTqU93+JvpvhUr8ytWbhCnHxV2XvlHNg8SIxmi+gbmbY5CMPlBKt3lhbqkgvhu2Tn9
         R3IGzRM3GmDdMy209nOXkX/1hgJO2V7ReUWRfFdJGvcBcrUtVPxmAm3x4zIlzmCs6rJj
         a/9QO+/fPwDZWFGnvoIQyYmL7EISkQ71XfAHMWenEkVSrVnyssVaeqZzApzt7tZuG5Sk
         JEfrK04ED8DELEEsURZB60DbGKgix16VEodpCloqE/wsrqtbQou63p8hv8M6NA/Ex8eP
         NnYQ==
X-Gm-Message-State: AFq9FYJJL39j1IpW/EscUIT2Fk4mMbIR9/PqcZnVe370ITz02EwAtF6F
	wKEhTzmjU0Ytdx3YCJ2BaJrVT/KEST2UKWCawMSuLxKwrUOp/Sn3/4bF0Hh8MQ==
X-Gm-Gg: AYBFou2hjja7EQNDPQzZCmheE8/56T8MDrFKxAZB5Y5Hjz3ABM8BzvE+ZApMeJfPLac
	Qrr663jDqqfu9dkfmKvc4ZUJlzBF9eg+sCUQWm06jV61TCtPljBdwHD96Nspk3EAM8E/5KDjIy3
	8wy2PvYkizsk1L6aB9VMkyxYbjkDH9Qv1JpYO2ldo1yxabn3WWRyQ8UUceQ1GgPsrBuaNOtNEWD
	7mBHsmwogFGE/Ge8oMfEc87p0qR58wadc/B2xQ75PDKLBjYHdnRvkED48DawJIAsjWL/FutUSx0
	WjmkFZPGr7lAjBnvspBxl2sTGyybPjHWjbsI205g3Cc/xG3WMWlmeNBE1BDi+g7WST14DSRwlkB
	6/Ga4k942V0GjqieTmQ0q4vKYuoLey6T/fU2pGe+uojAUHweMmlwimJkIib2ehPvKiB4UCpj6zg
	riqChDyEzJD0ok6dPju7RNdnTspAoacJa0SsSkYQQF3uCSLgB4ceBhzyIwHrh4uFP1OfQIOav7d
	xVhsZXoEWUfKy4jBr4nRoIOfc7XyTQNwFX7l1BkaoBVJhs1qBHkny37Mjw=
X-Received: by 2002:a05:701b:2084:10b0:152:3812:496a with SMTP id a92af1059eb24-1a6cf72a727mr260109c88.43.1793129498569;
        Tue, 27 Oct 2026 12:31:38 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.71.5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a6d7ed488fsm263096c88.7.2026.10.27.12.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:31:37 -0700 (PDT)
Message-ID: <6ae0fc19.bdce4de1.396fb5.99e4@mx.google.com>
Date: Tue, 27 Oct 2026 12:31:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1674240902155702495=="
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
Subject: RE: [BlueZ,v1] test: functional: change the HoG connection rate from the HID device
In-Reply-To: <20261012152847.66886-1-luiz.dentz@gmail.com>
References: <20261012152847.66886-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1674240902155702495==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ,v1] test: functional: change the HoG connection rate from the HID device
   Pull Request: https://github.com/bluez/bluez/pull/2663
   Created:      2026-10-12 17:51:17+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============1674240902155702495==--
