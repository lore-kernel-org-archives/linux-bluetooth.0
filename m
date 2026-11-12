Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794443831;
	b=pIyy6EtRFt73n41nvazrYgmYS2jHzBRn+XG71iZj2U+TUFda6wq1HAF3c5zsRKqEHIeB
	 25o74MjcHjD4MQF7ftvbTYH87eF05LlWfnCcu5Q2B/S56razeCd2ax0eAm7H7jt0U14KI
	 hzmdAnYfZ3oM9MFfcEpkYY7gzTHtVl1aCIw2cWHc/TTCm/BeQ3T71os/Gf2xuyazW1Pd3
	 yeGrloPjx5OFaYFrgSyJsr4/ra6YlcVnrA8vfdrNF6n0uOvNrOvMBHIgK7eWdyV/Ae0HA
	 obRA+0exMavhjtf9zbc8X5oBohhB0psSAartKfypcG4qbvDjpAUGhV9sQeiyCPDNviQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794443831;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=38Jmbi516evLMYhO1fNGtVjq15mFVmuzZBPfaM0ar5o=;
	b=eZTD0Dy2bSr41dG0H7cU+fPnkfOOKFDtsHFmAjo/zEpKehXxyimAo9QzNbFxC162VG9b
	 56zJaepBiwt//pyRcUHEmUrXoQqGoQOU+tV3jg7ilO/MHu++qjADkEEcl//sbFBm3lhqa
	 ZNGN5s0tWnWsDW+xDyz8kV0ELiAFIRjyieiK2SaTZVugysdmo4rnHARR7EyYT6W3mj9ke
	 1qv0A/0pMRfsXFQ2XRBK0miQU8DmeqIdPhwKXSxpw2mxJrr9HohHcBcT9zRY7PiPdwuYA
	 UGa8JIW0JwvcYlhcYWNV/FDU8XqTAs1otxRVzczW4W0CKQXtwo3gPE6gMW2QWaAXKiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qm9kTJf3;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C8D606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 00:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33C8D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qm9kTJf3
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b0d0b80fb9so2158660a91.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794443830; x=1795048630; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=38Jmbi516evLMYhO1fNGtVjq15mFVmuzZBPfaM0ar5o=;
        b=qm9kTJf3gJCNJx23hrwKHxoQ5vhXOo3R/qbcFxYxVgoI2pUXUYEli4YWUA++wbo3he
         UyEr3e1svN929ZhGSg6ONJFrDqCvZ0lrxdP5EKDjgPfHryTvIQgpjFkyV9Qmzx19JmD5
         EHL9j0E7VZqdmc8V0CKak32WUlmy5j1H8hy9nKaHmTD6nAFtKMQaXpG0M2pcUOs8UjTC
         atr7d+nQv1yBdMYCNHA3PviCJzJzmXWJVRuNHzQyTBwkQ6KnSzWh/8QqoR0VpZXp3qiT
         AnBpK/fxULbOZLaEVFNuyPMtmvJPcq0HwswqOc7qF9R/Lcb5JI8N5Sh4ULvzNYJv+B/C
         nvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794443830; x=1795048630;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=38Jmbi516evLMYhO1fNGtVjq15mFVmuzZBPfaM0ar5o=;
        b=krilRc97o6pSAe7plLvSqwBEDE3GO11WdrfO+Uf/DllCpBGEP1reEHeqhFZy6Z+FY+
         2G7YC5BuZds8BR1XxDHA1VGBVWoRmIhhcHHV9ql+qBILQT79TR/fVRAdszP2VXSj/ThT
         SCKHJYJQIjPkJmkM12Cf1aDbt5LM+CLAvi2L79CS0eAZWjjYpmaIQnCb7Mc4BLOuDB7z
         2zCCVGxqTBq5H/AQvZtCD/zEQDLXF9JzVpqoHLmssaJe7INI848aUMwFQDzNFklOgScL
         pgRMH4ET3h0cMVFfrsvm3xuDKp/2n02Fh3zDjzvDX8POqurLd5568m1G3mQcmxTnYmmh
         iSAQ==
X-Gm-Message-State: APuU4Z8Nj2XE0ZcgSwmxgatvycSJ5GI1QuMv3gYiNMhCMJCEYLkdIca+
	URswcz/jXRU/slqPUdxQaPlrVExexyeE1HIXadu0owXVBH5925sLU0hQwye+Ssq0
X-Gm-Gg: AYBFou2N58GViT0jqqWBtwtCca4C6SmocnEzWdoKbfK4SjVJ2iO6slwzct1gJ5W2CX2
	+hlmoUw6/Xzq+qwEUSYnk8/gMl9RFcFzD/+u+3tYVecRwUJn8ulgOBHqNRZUZ1q04JuZaJr5cnn
	d564tERTCrEi580/Ee1d5jXMRuqmxhFVhkp3gfD00SXcsPiDFFX26AvbV1nXsW5lFf/XZGWg610
	EK28rE4gNn1i7+i+m6opIUw3PACI0/ez1IfoTTwKZFIA7n/yfgyUQSV7nFm1oFMOupi082s8Fx9
	jHfuytyV6u4fQ56yKCXkLqu4ZOL04yN7yvuunPTvOLtFqi+P5ENR1DXiTHY5CLUerkSpBAEH7h9
	8BH3I/2mEb/vRKxjOaGadyuRWgHKv2KMs4ICyY9uCGz+3YFUNQfOAA39O8oTurBo3S5YMhUZsc/
	oJ/J6N72r/jDHc19wBeOMv6tPrzai7+1Z8UN3yx7Snegpq+RhzrYWnz8hnqbPj3avkcdA9njRxX
	JMolFzR57wvnPeG7RIMtDoTAwQxxnudhXOAJvc5ZYch8sko
X-Received: by 2002:a17:90b:57ec:b0:3ad:b8c8:4a84 with SMTP id 98e67ed59e1d1-3b182f267f4mr3925025a91.26.1794443830387;
        Wed, 11 Nov 2026 16:37:10 -0800 (PST)
Received: from [172.17.0.2] ([20.64.175.145])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c74bf3sm1489433a91.10.2026.11.11.16.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 16:37:09 -0800 (PST)
Message-ID: <6af50a35.a54b2386.199322.5d64@mx.google.com>
Date: Wed, 11 Nov 2026 16:37:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6774435058489719100=="
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
Subject: RE: shared/bap: Don't disconnect a CIS still used by another ASE
In-Reply-To: <af87abeff291ce358c4f4414c3b1aff9565f0bf2.1794428234.git.luiz.von.dentz@intel.com>
References: <af87abeff291ce358c4f4414c3b1aff9565f0bf2.1794428234.git.luiz.von.dentz@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6774435058489719100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: doc/functional-bap.rst:346
error: doc/functional-bap.rst: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6774435058489719100==--
