Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794882330;
	b=k9Red9oFDsAjTjfuyUBQ55n7PhvJaJGgqEi7qB+v3TLvHnmEZ1AE/BHO9sWYUUVYAyWM
	 w5TtJIMuSTuL+4GJfHirtzmGMHEJKurjRTytjvdqXtdQzfh3A0wurZng+H1QFJKJlYCn2
	 DRZSHTV6A/qs3oxoNiIDQpOOH6XNfzZc0h8+Bzf4i3i0NqC4CFENmvhMtrVDUnG2RgW/S
	 kkmQTle6wuG2aDxYEmT8CDFhxvKP5Sd4SGHEPXiJkn9J+IFq3/cp+kg9Ei1bV8P1Dhk9B
	 QO350p805KjRzwrKjHTiM7R9K6KoBNs/hWUwKf10U2yjYmGLSpMMlLDBWwX8PdP4QnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794882330;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=nFOZLGQq/PunJ0Ald+0DDA0LnWkNjUnddIJs/2UKqmw=;
	b=SspJqK0ap0iR8Yx33ciTja71l2b6APVIOeqiDDOZNaXlCRQgjWEyoGB0D67naWJVFUT5
	 94o1Ef4/2t15Oz4W151Wi4I98BaI7T5ynqY+1HTwuAVlGtGzvPB6u5Qk859EyaP0hqLob
	 bJsxbIGMznC1jEeEePZFE1e/VZzBWFMwcstiE7tXcDu47fR8YppfHTlPoN3TiVU/zlP3q
	 +WxAS0AeIWj+dlaQpY3NJC1uaR992fZbTPe/s80GVcdIRiY3mzd1xAgH5XFYuymi8Yj+E
	 xoHZ2ZBFoDD/cq6jTQH7po4NjW+Olg8D0Kx9XKwHhBYav5vy0KxbKSpEDIU8SWdQfgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hf+qOxMO;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4BE606A31C
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Nov 2026 02:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB4BE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hf+qOxMO
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-862b3a39d0dso1112392a34.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 18:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794882329; x=1795487129; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nFOZLGQq/PunJ0Ald+0DDA0LnWkNjUnddIJs/2UKqmw=;
        b=Hf+qOxMO5XAIxzFU8PddY0R1DNAeHSAXG7p9OEtY1MHZeh9d3je1/OMNmUMUpvTqmE
         0T/1u7TiZegzPPsqXfhAJUjP9Q2Uum9nD8M+blwMNEChRjWFeaQHvMxNFj4zv7AYCCq6
         6iH9TZ1m/MM3HkHUs1dEL2G5go9riynsqg7zMb6t9+nDn/w6TWLjz9FQ1KVL7F2GF9Ho
         0hi1n8o8uUh0+ILovY+UwgWQgKTXWdxobf5d/vV2sdMzcmhH8lHPBsXCJOEr3fWo5QeT
         zEc0B0vrCWE9q8D8GzVLvm7hSIdGuAXxMy4XlOhpKtHNz/3XfuBmPGiviipcmn5bZcAG
         x6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794882329; x=1795487129;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nFOZLGQq/PunJ0Ald+0DDA0LnWkNjUnddIJs/2UKqmw=;
        b=Pp7dyp+ZXfzTR7lrKePKsWef+3bVYSGIeYJ2U7raJdZdluACv5lGDxQLNGMq9BLIPA
         tz89mPm65nfq6AXfTs3Br/ptWoufSeRa6/GdF39Ne6a5EOXru91VVYZv4+pWpym6i6tI
         sadFq0EbMua7I2CwGsRcCzEWiktIhQvxcBlgOJ8qZRE3AtCe02B8tp4AKivbC6Yan59b
         Sgu2UHx/xZaBjxh0MSZmLGW7F5NOaCKve1OCQgOTfbyuZgSSRS+IJx3ta2VMFDW1wXx5
         cP9V11MPQNu/OO6zyYd8KnyBytWuxsWIyRZ4M7nsBu/jlg4Qvs09cMEAxTNESFRNlqrU
         QUNA==
X-Gm-Message-State: APuU4Z91ImLDicPc4+Wvv3f4fVLx3Oz27A9QSzhaShFsHyd95AGCmSos
	77+tkjtKopBe9DC6jkJObVPcRcJpuDDI5QVNUdsZ/IMA/4IjZSdQT9yK1XHh0Q==
X-Gm-Gg: AYBFou39R+jC3htoRvvtwcOA8ZSbuotlBgQeTmHaDs/LfjeyIm5K730n2Y0ztLkZOAC
	IvTB+7ntjW6vPO7HcMPZppvS1UXeNOU0yg9eUcF0RcpRbVAp5DrUyIc6GWTV7aw+gVWO76kKPKK
	EUrgcaSXvQjhJtoAhxLp0abtjyNY+bVaFIYmpXoclTcT6YlKSb6qyMSyWzQPeuAGySKbghbtgsZ
	ARw8E16U6NdaSVjhapTrAQ2GzYGrntI539npXTeMXgwyKXwmZyHNTGP56nCmGzSvglPB1aRMsoN
	AcwlvE7ZLoS3JBeV9tSJkz5eQ0G0aJpSxs6kFe4oUc6eKi0ykML7aT4hKX4jtIncGX9eUjfLXhH
	XxjJHZetCRd5NmFSM29rHSniZgYTTzgktZbDsbvfWNkYxcva/2I/ND5bQinnfvAof5JORmOfPjK
	88AfhMGbIa5kzG8uckftZoz9FUtMix0bDMmyyYw4N8iniKs+xXt1WTKuTLjITqeDeNGCgapV67F
	J0VJ4UPzKv9nE08Ned3unsDudKeBM2jNCIJxStb4TCi7fdabBc7MRuHhU2r9g==
X-Received: by 2002:a05:6830:2b0e:b0:823:38f9:ea5d with SMTP id 46e09a7af769-8628983bae2mr13210419a34.11.1794882328749;
        Mon, 16 Nov 2026 18:25:28 -0800 (PST)
Received: from [172.17.0.2] ([20.80.78.129])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862ae607cf4sm7782589a34.18.2026.11.16.18.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 18:25:28 -0800 (PST)
Message-ID: <6afbbb18.dff45fae.2cfb6a.d46f@mx.google.com>
Date: Mon, 16 Nov 2026 18:25:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7260908193788994406=="
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
To: linux-bluetooth@vger.kernel.org, jperlow@gmail.com
Subject: RE: Bluetooth: btbcm: Add entries for BCM4364B3 UART Bluetooth
In-Reply-To: <4a1efe5e-ec67-4caa-bb84-35759e66ef42@gmail.com>
References: <4a1efe5e-ec67-4caa-bb84-35759e66ef42@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7260908193788994406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: corrupt patch at line 12
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7260908193788994406==--
