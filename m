Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794865738;
	b=EsRsWDeUxJakk0aIDYbnuBfrg6c/0UzDW03iP5HLGpghsniRg6N56Stk1tI0S8ikNxT8
	 BGq3rrxqL6AFIKMI6dhJtDSZWwT594y+s3M/ZMIrSW/OBv+jwHhC4YcNJLYoKC8esyfzg
	 8dCGuZpbcqvJUncWMuoZOZlM6pWTksMPhB6yeWOAUO4qJeYUwLanFAA9/jM4KbqgQD7Mp
	 luzdTZvvMTcHPvuxxI8bu+E2WHbAVXy70lye8ISk/2r8tatVG4P8XCkM0U0ZMlJEzZYlJ
	 sCSiCpCbfIigMQivMzk7a2nrssdRtILy7VP2OCSxTDs+ntWiZSHBWXb/azabb4bdSuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794865738;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=eK0fT/XKmKAtRWcHB5+HAN2dTczFRzOOegB/J/+tasc=;
	b=mOIpkpXzruhQ0Q+4gkiv3GlS6Aj+1jQk0yQoYE8cu6tLaA2e+rSaeQZ08vfcEhl5HacT
	 rpwCF74VcMd5jwDs5rOBBi4aylgrq2M/hzjKmseMFw4fFiCPL0JBr04nlnSyayIVoxvz9
	 gRcRkSdHRD3YwZFOPD7QfzEJfgC29YVZzTWIHK25z6QAZzHc7id8NxOPbXTLFa7L+eLS+
	 hsyMdHiQu7Cz1MCulwWUJRsk88nrZ1gXwF8jnEMUJQ1i6AOypqPesSuNnmVAKhK+Ng8av
	 jTzKW3Kf9MQ3wqp3dLHtJO/NkQTeABwnWYlLVA2+RB3Uk+KG8bIMPsLMzbnL+Zq0t0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fHBK1N7b;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC52606A322
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 21:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AC52606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fHBK1N7b
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2efddf749e5so49025ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 13:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794865737; x=1795470537; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eK0fT/XKmKAtRWcHB5+HAN2dTczFRzOOegB/J/+tasc=;
        b=fHBK1N7b2FcOFIyOClOLD5KjeVklQyXfC2XlR9KDeweO4IOilD2HlZ4YkUkaaxRSo+
         GIPBZT6N1EONsGqaOqCNhGqzCZVyrCQ7IUxB3gewXmQGrOuwcoe0PU7F2nSlY1scDg2e
         cty8vRGrQeiWxVDAXPPuVsZTwXYyqDk5nbfqt78XObbSxk+0VLRgPp9Y79W7w9TPPr3+
         4K6XzBr+YjnV6zecMpHHXULBZuZpfXnec0eo0SwH+Ogi/tEP/OyMkJcF/ROVnRYUWZMP
         HIGERmmpQZ/tpsrmm9SS7XN0IB8HRLIaQrXuzn16guzFb+NeysAcZ3DJ7N/CuSiFuSzl
         5M8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794865737; x=1795470537;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eK0fT/XKmKAtRWcHB5+HAN2dTczFRzOOegB/J/+tasc=;
        b=CEFIm03mUJPrFcnrwNMZPnfDE5uL6txt3ODMOoV5YtQy3nincSmJOH2ptf1hKaDVIZ
         eNyaH98c6E++D3z5dT9L8X6EP81Pepuh2JKtb5D79TCBdF5UPxFuGHXzNRdsNq7xgaWt
         BrHY4h3PwFWJebWR5g1rEWAhlsxCj+FxV8ecFWHEWVbuQRhNFN6cKbJWTzxrXXyQNyYC
         6L+ZvqzdtahnTfDg83LH+LB1778SdJRk+WdIfFyKKW60tQKisVjcWVtepkYekB7Q8dsN
         8Jq1GumyGC6jmFeY1NMh3Kl2OTkNm6Uq917oShbmi8C1dWvUaZdG+hIf8JdFKzkdgYdC
         AnLA==
X-Gm-Message-State: APuU4Z9b26gNTT6wGQ8LfC/IQqu94UeFegrMVSxTG3+GoSQT1gyvPDjj
	UCX/bx455DWL7XCufJAusyNpsij8ZIaW/56p9I+ED5rpokRZwG5g+IFTaVUT8w==
X-Gm-Gg: AZFdTZeB2gfeFKk6edofdNzn2Wi8obOZpH7Eo0prBXIxg/UP57aIcNEx169Rwss7tt2
	pIQm55E7/tJydNXKOS1KOOmZzs5K7grC0VSExHMpG3J5MjdQBjnDa4lbxxF3BxxpW5hsgDTsKRd
	mrA799sqg0Rn3X96opYcBnguh/7qz0sWIGGaN2Jdrg/f/VqXrg/svI228Lls2eBFzJXKBrlKf++
	9Eaj8BXYbPiZq5SIrmFCaa6RYO9WldpB+ztC+BrA00US2OqNNVXgGzqk5Z4NQPy12/9dbPRwRDc
	D7HNQdJwt1B5e/NsA+Hkdc7ZNXTIPDauVa3NTPSGPXlnL4vLsNiYiUcQDeezXXjapYNzJfkkI7h
	xUALxiHc+6WzyJf3N7KZqKXAbPA9zrN89ovVarxVb1d+GIMuTpQ6PrEiyMnk0rZYCRn1RUNBbwj
	c/1/LaTzWTyFkmqzX2M0o4tlLAJOkOq4LPhE1cjktJhJNdyimp66w4qCtzefjpT/z4NmNwdZov1
	poHb+Nfmesnx379RlvfgLDcBfgxUlG4vmVeRcezE3aysjvBnqEgyzmnEUxZbTc=
X-Received: by 2002:a17:902:d481:b0:2e9:8202:508a with SMTP id d9443c01a7336-2efd9b5763dmr4964395ad.16.1794865737475;
        Mon, 16 Nov 2026 13:48:57 -0800 (PST)
Received: from [172.17.0.2] ([4.154.166.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd76d8308sm4383275ad.10.2026.11.16.13.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:48:56 -0800 (PST)
Message-ID: <6afb7a48.85f2d3f3.1dd4b8.0389@mx.google.com>
Date: Mon, 16 Nov 2026 13:48:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1310532975228628105=="
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
To: linux-bluetooth@vger.kernel.org, jinwang.li@oss.qualcomm.com
Subject: RE: [BlueZ,v4] avdtp: Fix use-after-free in connection_lost
In-Reply-To: <20261116090719.1226616-1-jinwang.li@oss.qualcomm.com>
References: <20261116090719.1226616-1-jinwang.li@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1310532975228628105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1212473/

---Test result---

Test Summary:
CheckPatch                    PASS      0.27 seconds
GitLint                       PASS      0.20 seconds
BuildEll                      PASS      16.49 seconds
BluezMake                     PASS      238.19 seconds
MakeCheck                     PASS      2.75 seconds
MakeDistcheck                 PASS      121.38 seconds
CheckValgrind                 PASS      124.29 seconds
CheckSmatch                   PASS      238.10 seconds
bluezmakeextell               PASS      77.42 seconds
TestFunctional                PASS      1035.17 seconds
IncrementalBuild              PASS      241.41 seconds
ScanBuild                     PASS      868.53 seconds



https://github.com/bluez/bluez/pull/2834

---
Regards,
Linux Bluetooth


--===============1310532975228628105==--
