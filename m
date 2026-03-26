Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4C78635D
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 21:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774559871; cv=none; b=Fa52b/hUC5oMHvrqXYQFH9fW38IkSS1WRGS8FAlzfO13U/0HHXw5vTxcGixzg9NswKUjff0qpS3Fr6+3esvoN8tXwxhRrIVPE98lWsduAC973C0iaNJQq9UIdn9y768o/Jxg2IaJpSd9+5lzf+QcWZatlPFWAVzfITQTEYVsSOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774559871; c=relaxed/simple;
	bh=0Z1mBofco5+gNQIBOSQYkyoNssX65rAiL8rw1ql6Mos=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Vha2CaPigmAy61DCe0mr7V/+GDl0yIp+lVk3AbxneKTG+VgLh4/MYwE4QOaG2vMkshCMoRbcP2hyh0tijn0+9HLdceo3Trmuevxp1t235IInLWZLIO3zoxjwWOVaDxcRXzSwQt+t0Bs2bS0fggM2a26Xpv4e4vXWkZ+SlcQlEXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItOMeHPL; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItOMeHPL"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b4520f6b32so1731651eec.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 14:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774559869; x=1775164669; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0Z1mBofco5+gNQIBOSQYkyoNssX65rAiL8rw1ql6Mos=;
        b=ItOMeHPLNSW+iHU3TEpTeM9WRYGHSIcPxFep5IRVi3HV6EfA0xU4G4fuETgJS6cTw/
         4PXfDdOWV3EUPfccdPHRwyqRXG5wWCSuivCJ4SgIbhRfBhROmGR5uPnzkYv6sd/LsvMa
         kc+QpUte5EFgAvLdqF291vk9y2RvwyyLSPJytfrm+DvV5zkaK9JACf9fY3bUJbVvO9Xc
         Gr98i10wXHIUaJAr703P/+Ybd3PcJfeMt5XL5SY/6bvrU9ndTlRGv4y8E3PhnTtCNpth
         YISfZfYM6YSxUmQz1GIrt1Qn9t5H0NDR92lFk4SAv8Tqc0Z6U+1t7F5nuydnD7uRh5YY
         t//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774559869; x=1775164669;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Z1mBofco5+gNQIBOSQYkyoNssX65rAiL8rw1ql6Mos=;
        b=HblN6k53oPxi21Pn93s4JET03I2vqyMGMiHo0u/uUHK/19UG3LAWp/It+93HwkLUGI
         bn8w6DWGo1wv3W2rr3rKVT/fsbv1a51TrwRSZaivkCzOPDD9I7v/usFa1e64FdRuWwYQ
         s4KsC9jBRlEbvsAjkF09d0wt+ruNccvkPXJMyMU4D0+HOWLzBa2nuoChA8GvmDZXBJOg
         S9nZOYTftxdQR7o+mN5zz8anjAhqVWOddJtiHvLUBuOjZkcu94qwAMsSkarZooHypB4e
         CF9WXyoZbdHzjj+xEBEkNvaDq1V0P171KBt9/y/ZzV6elM2AqDi7RGWWjXToHVb0ASru
         02Tg==
X-Gm-Message-State: AOJu0YybDmY8gSehsB6n1MAUOIeJvRMsqk7/bLpbybJW5ruH7WAUqtkT
	QIZDFcXu4sLAs3+9i2jPCcsO3m0QymCKUq1NUH+3pCj2By56cPg5bRvC27XPuQ==
X-Gm-Gg: ATEYQzwrz427hGw/A+0hzvpc1WYWD0s6fkQViKjmXqm2yeIBzdu4kqKuCfeAGG4wimP
	mV6nKD+TwL6d349LoEmLV25TL7dALN9wOgLpOlvF64ixNstZBcp7D3RFx/g9xXyNvqXle6Ieqx9
	6j+I2M4gOvUDbkE5sUjpB4qQ0UjS7rdZm3LDHf7fvMszDg9scWlMmchotVDT8Hf5sz+CLrAUtFJ
	TQ5AxrMoGphMQAN/fGeU9gdfCJErCmp4vmZdRCR2uNX6tJtfVrQwOopWTXmWWSD96hAiDbwxz7R
	j+8d5eAZJD8CSkHLzVBrj010NgAvk2wIxy7KI5FuRUaDGr1P36OM9jVwKy3IrodHAOm2w+jx+l6
	j2COhMrMRoqYA+Ep4b20vzznEOmvLeRuqpK8cchPY4Tp9lENq6amUDd5TRl8GRNRdm28Si8fDob
	ZHt2JCm5KJnA/H1QqescpRkaape9LrsVU=
X-Received: by 2002:a05:7300:ec18:b0:2c1:7ca:cec4 with SMTP id 5a478bee46e88-2c185de7d78mr80924eec.13.1774559868971;
        Thu, 26 Mar 2026 14:17:48 -0700 (PDT)
Received: from [172.17.0.2] ([52.159.247.147])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c16ec26651sm3555529eec.2.2026.03.26.14.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 14:17:48 -0700 (PDT)
Message-ID: <69c5a27c.050a0220.43bed.61bf@mx.google.com>
Date: Thu, 26 Mar 2026 14:17:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0342256588366665684=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: hci_sync: Fix UAF in le_read_features_complete
In-Reply-To: <20260326205046.890020-1-luiz.dentz@gmail.com>
References: <20260326205046.890020-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0342256588366665684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_sync.c:7463
error: net/bluetooth/hci_sync.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0342256588366665684==--
