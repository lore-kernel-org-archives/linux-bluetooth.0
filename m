Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794967547;
	b=xsfSgfJFZVHZfsXLGOPYskRglpT29CfstZBE2ER0Z3n48v1AaKVdp5GJ8i3MUBi85RMY
	 TBIwN9ekwiHtKrCvIQMglLd6RiXfDSNQY6/SkRuisufo24PHbB6WHH4WFJFRtbwuxUpu5
	 S42Nda+rm3DKU6WecHD8FxibGPQma8qqnEFyNIBT+kfourix+I4pI8vQVZzQB0PR6ouMM
	 53HR4dRI5oVwyYErX4OVRXAcyFtXKiRnyRQiASXUFgQrbkbdwedUEnHblvt+VWTY3YKfx
	 Nvg21s5QgQxh1aVGkDHMFnpbzzQ4ue73PS7NfkRQHs3saMkDCCJm1Io+mK8aLLdTQLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794967547;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=6NuZOk/Pv6i4a0vIAUDjbA4pljOtz/JQBFZZLIQmxB0=;
	b=x5WqgMCOycTJMagFNshNafsIF9fs7uvQl+uDXgt+mQ1l9l6f2hwA1lsQlQnhx9ETQOvn
	 MP1B85440ldD0pJ1wFax+zhBWc+iIIffXsijhcMgGcmHuqk7MtFx+fHU7wduh+qvnNI3P
	 iNr7quk/e9p71usGHarAJWFE61LkeS3FUoJ1uhTbqcB9OB5P81GKBx+0niviM7TBHE/Tz
	 Jo2RtvWKwb2E+Wt8f5UQOU5CB5yIe/xzzRJ9aSIGa0X9KIk8FBC7RQ58EUIFZ1256fKx6
	 J3+i3LNFACeTP7oSx0ENSwg5IXzFo21Mtz3Ntq1rpH5GP5Pj+KlHLeOg8VZB3pPayvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GNLbn+jF;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A882606A31C
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 02:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A882606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GNLbn+jF
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-380b40312e2so1474375eec.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 18:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794967546; x=1795572346; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6NuZOk/Pv6i4a0vIAUDjbA4pljOtz/JQBFZZLIQmxB0=;
        b=GNLbn+jFRixm8A1Y8x41UrvdvaZgO3F6kinyx+Haogbm0y9GMEVdOrgFpRQM/yqWv3
         A1DKEuIgR0MkV9ZptWJI8xyvGiHVHAygZMJ8YvHyqrkKDbCHj83kNn5yGtDnl5df0qVR
         RmvMgpQRciu6HkAqbgGigFUWxUhlQfDAHQTzPcggfOhv1da18zJCHTPz15PkWBjsjhkx
         YTRDHx2nZ5Mm699X4cOMZCt0HNywNQTYgLRg3Rv7uC9xpz+cDksqsJRA/IvN6ky6xyFO
         89A0Qj0wfOFCZv2wiVV4lddH66bg41oTc7n91c6BAIsaGPE8Xfwd/rmnpRsKgq2c2KIa
         NYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794967546; x=1795572346;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6NuZOk/Pv6i4a0vIAUDjbA4pljOtz/JQBFZZLIQmxB0=;
        b=HiEQyzDBr3DhnU8gBs+zQhS7e5YMlrSJ7H7j9UDwblDtcCzV9uqy6aA0kh7tBj17dB
         LVQe1eIVUlwFtmT5AGjOdfR+jJ8NiSUJ8yeLjp4/L6pO5+MQyHyXincLa8C/71Oz2Cxw
         8U1RifrvF0SKuE0AWoS/vdCyKzDVXXGVJziQj3UhjS2vKjQka7r8ZSJKTMNSd3feDQPo
         iRYctexPOcSqCROvUiOL2IyrwYm1ARoEjFL9TTYMobb7EVeR40V+o4FBEQqjsR+7FkuC
         L5USSzb/pIOUyLuTJNJXcOyopYSFp3jhLJK0aCrlF1NrmXqmjGgKCOQBu7Qfax03oOzF
         id/g==
X-Gm-Message-State: APuU4Z99sMr+dNWa/C+l0fWGMFTEpovtqqluUpVuk8pNdmp4EL3E1YQj
	a44/XqfLOIjpFJBgcIuanvX2htddlQau5Q2moa90WcELm3bgHoIV1/AeqV1xHQ==
X-Gm-Gg: AZFdTZdyCRXs9zLynDZM8hFOAt4YUTFhesb+xgJl8od3lKr1LpdsfdGwupOV2kSSMyy
	s5zz/pGXHOt/2s1sLCN7W0a16kwFcPmgSVkln3OQcJk21ibgwXnaofaqZHaL3/Vijf3c9S1G+EW
	OEM781kz1teXOkta3e+U+cihLeMNjAN+u66tdjDtDC9cayIuTXga8KpG/23+L6digE6ou9xD1AO
	xIpqqtbJrSazdasOMcOQFu6CFtZS+m+/zOjP0h8/omHrGsvqHmDKmebmjk4xvnbZ1a++5KR/NCe
	zFxBJG/l1gjr6W4DQK50+fBvjqR0k8QhBCT9OGeRtSoznK96QjHpG3VceO5SSESe35MGiLT1Nnm
	dWRViQLod/FcZuT80YBRgb0Nosyr+1OHv1Kqv/3yIzYa4u8uaXuewAIMYTGSeM0QHwL7QPm1glp
	byLOp7jzpQH2ATDfg+hpiusEm7XQqKuGeFqIrAe0jP2UY1+5+iWprzDz82ZkSlqlrdLXout/yBt
	TiRlEvzWWKNHcfw1GLob57UwK+QEIr+Ys6y2Q1gOnkukLtThMTEXu37Kk82zA==
X-Received: by 2002:a05:7300:e80b:b0:36b:d3dd:2e9d with SMTP id 5a478bee46e88-38280174911mr1457293eec.19.1794967546194;
        Tue, 17 Nov 2026 18:05:46 -0800 (PST)
Received: from [172.17.0.2] ([40.65.59.119])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a72e52easm1890062eec.17.2026.11.17.18.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 18:05:45 -0800 (PST)
Message-ID: <6afd07f9.e153b411.2f6cd5.976f@mx.google.com>
Date: Tue, 17 Nov 2026 18:05:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4011625201338878191=="
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
To: linux-bluetooth@vger.kernel.org, ofir@xmousse.com
Subject: RE: Bluetooth: add passive-discovery quirk for Intel 9460/9560
In-Reply-To: <20261117202632.49924-2-ofir@xmousse.com>
References: <20261117202632.49924-2-ofir@xmousse.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4011625201338878191==
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


--===============4011625201338878191==--
