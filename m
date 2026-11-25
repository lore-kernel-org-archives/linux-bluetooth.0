Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605957;
	b=l3GwZDgLeXjIC1xOGHaeVfri5yuJbxdyYJBW1dN/YhO7ezBhjVIYgZ57LbZ2inrtciVw
	 SVqeHFHMQ+lx/3w4Y6+KbwVRTNZ3KNjyTgE86a05O0sb5WmuxUQjBqn94dEnYud2x/ZRU
	 CTpnY668KYn/dDARAnEk3LIxpV6u0yy/xGEeVcFw2/RLHAVo3cAOnKutFqoHWAA5g7Z9Y
	 8s2AtTD9sGtSnCpx4MpHB/jBSPoABh2FG2iplhdZvqU4bb2qrLGoSDWkpdh5exzRxxB9i
	 RvbGLRIeL5Ug5MlWTw7rDMQy2+6Z5TLwckiOn0ZeBeLh8YTGyFAO/t8J3oIEE2kcdnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605957;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=aGoA2z47CMzay28XHhTQgpN0MZ7mCSFOPZVzkiBhccA=;
	b=PvcKnUGTSscfHxyp1zxhuLvGHQyoBWhd8t9+duih1i3Rm1RM25s1aYjlFFgHJrwOAgUB
	 OXsrQwZ8Zl8i/hgd60eaqmey2t9S7j8bOoITUauHQvG+TN13O6gpJR+ikEyO36Ko1nkzd
	 xrShDkmv1tXOLR3OJ3X5sgeH/xa87SHbK25M3Bh7rqzeP39zd/2uu41QIU1ZVPn3rrRZi
	 keTeViDeObNqwUIK5PaOX1eDtrWrCoS9nt1yuYAYURimUT3m25p6i8hvDaMM161plj8xV
	 qDlEaQkHvdEwChSxghVocn1+6hv+oyYcl1LsubQvbvEr5RxvAqP2X90o0duO5VLrvUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I94xOW5J;
	arc=none smtp.remote-ip=209.85.160.42
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB100606A321
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 11:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB100606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I94xOW5J
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-475920b9ca2so1909640fac.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 03:25:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795605956; x=1796210756; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aGoA2z47CMzay28XHhTQgpN0MZ7mCSFOPZVzkiBhccA=;
        b=I94xOW5JCIPnhQCtkSBdj8VjiLU2i+dJcEaMFkBE8ysAMAz4qZ5e3TQAeupbTsgIh9
         s7NjEDMw0a9spOYY4wBenL5qQBsr7ywxtLBT720Tdbpld9F0wbrfk7oZ1Xfn1TqwLT6j
         kBaNeauC6jX+KzkjVVRMmVz/qmcFvUR3Wbnryap6MNdVcNfaQ04YzwoNDZDBD75B7Uxn
         9BZigLfEnM3tkoF3UISq7BbIz7WOYvtZcbTcxDMCOWRNbswjZS18XuJVLZzA03oz4E7O
         YVRbYUfEEFUYWWAC2vHkzn15xjS+03q0aXzYIexATxV03ojpART0CVnQbrXULoBh564F
         YJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795605956; x=1796210756;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aGoA2z47CMzay28XHhTQgpN0MZ7mCSFOPZVzkiBhccA=;
        b=aZ6XBVQXvNbXKX0rUBIrtXp7S36WFpPqgxEyWUER5fysJAuWw4yh522Mu1pSZ6MDjZ
         fn1keVpD7Ox1gooLoGnlIF1g/l8rBl2PexnJEOcKQbDLGm5tTz8PXpHLw4lZeAqU5jI0
         /9CfFKnQM7gibJuGZ4BD8u/3hmOenUbOBZGpRosPeoSiQ/ZcEWHnXLC4ANYe/mC95R5r
         JwQkhaWqjsYan6Ylu5gDnAUY9glk8L5YRx8YXDoHe3UBccV/AIUNKDWWAROYlYm0JcuG
         ngU4DWtxO4TFsCidUclEz5QWUq5ZMAjr4RVXNyGYdoxTMXQbFbGeRartUJVYZnP+7QVn
         14jw==
X-Gm-Message-State: APuU4Z/ouaMPKBVdPUpmnVXqfzAgEjh4o+qJuX5TL5sfdH0qx0DxBcRZ
	BLsLVTF05SWkm7lDPvjEk1PcWSQlJVJbQWoyXJHJ3prT2q3FOHUpBdBSyLA+Lg==
X-Gm-Gg: AZFdTZdfSvH2RMp1allE+HO6ca7Q7XhA1dcsV8HaXzxZ+iXYaNlL/yF+/t4n+dRMDpJ
	6iRqi+PDRAoGoMUnGZlOfLs+c4+cNnCyyMEn7vv1GMuMuHb5uuVlA4likagZW3LWg0mYMTcvem5
	dlw2tiAN1f2s+QKy1XGkQ7bUhcEXYARwtkuQJJiLZTfjLs/UeJ0AgCRrgbXRXa63fhKv3Lpgkc3
	/Anw7Bo82fPlvGS5eDrdxPcIfnpWPDb3Luf+6QkZkBcF07HTOwvsmDtLKlzfCJmTJJfSflSyRy4
	IIpYfuYHMA/uvFh8K1QaSJxzjHHjVBuOesVrFEqZgXXIM/OEJl3vFBPdBt8NSAfERVp5U3EMbKI
	3P160K08GxHX76DQwIuR4aT0/ixwZJZ13OTQQF7qduqVH0zaj5KBbCSVeDRiJ94ELxWLr2d1B+V
	SPXWQaICISh10rnP7oIFu9IQYMuxgdBhIkH3BCL+a7RRvoYKjgb7sJhB+AMUzrpW9ITK/ZYu6L8
	5Q09UC2RvHtf/iCu5mGs5gF+p3QHzdK1gO6sK72fNI1ZIUG5/4Pg5pTjuKN
X-Received: by 2002:a05:6870:2012:b0:4a8:3c42:2dca with SMTP id 586e51a60fabf-4bc7ce7a1d4mr16127101fac.8.1795605955782;
        Wed, 25 Nov 2026 03:25:55 -0800 (PST)
Received: from [172.17.0.2] ([20.80.77.31])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc60491337sm16024251fac.12.2026.11.25.03.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 03:25:55 -0800 (PST)
Message-ID: <6b06c5c3.7724c133.1c6204.b966@mx.google.com>
Date: Wed, 25 Nov 2026 03:25:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1412560054086663973=="
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
To: linux-bluetooth@vger.kernel.org, bsdhenrymartin@gmail.com
Subject: RE: [v2] Bluetooth: RFCOMM: fix race on dlc->session in RFCOMM_CONNINFO getsockopt
In-Reply-To: <20261125075852.641537-1-bsdhenrymartin@gmail.com>
References: <20261125075852.641537-1-bsdhenrymartin@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1412560054086663973==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/rfcomm/sock.c:737
error: net/bluetooth/rfcomm/sock.c: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1412560054086663973==--
