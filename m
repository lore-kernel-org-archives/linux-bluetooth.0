Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795650046;
	b=COX4+BLSL5KIVF4ORGktcD/WVFuSIa5A3bkYbYofcxuPQVaOCUPo0lWye3lYGlilCNtR
	 LsbUMfRa2jVM/xBcSv96TxmBytXAAQ9SuUHK/HPp03QQxrwDfpR+CTKjplxjUdkyui2GT
	 hrgiFiX3fIUMQv3PSVVxWzYhs22OC9879/InaIfSxcxjIg4zZZYC1+z5SbRIMk9dgrzqv
	 5K71iXN8yGxB9TxPZOrB1Ijf0C3UxEQQCzYumVxDR/CgtveNVYKfh7gOekoDLbNvE0VQN
	 pWCCRTinY+jCimri+aQyCbGXkUj2DQ3NVeyuXsdaFtQH48eGz2tCuLkyW78TfwRCqbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795650046;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=FWWCB/W95vztrzT/xUR2OufEbks4s3F+k5PERRgs9dA=;
	b=gYYItuCmpHmv/MO4OCgAMzY/qMlIgte9Oq/gp4rsqBoLeZYUHDQDBH7428pw5iJicJlP
	 jdOLaBKQxQPtGcup47LxnIyaSkvOnsuMqCx3Oz90PD2CK6jkc9UrafLSvJakizOSAsp9m
	 F2kftcH0yBf5hBl9d9N4Ns5oiqRI/o6y3rOP7bFVWNN0Rt3D8hVMCtVB3cRM7eeenKe8O
	 4dWzNh5fG00XcSDbLmByp5fdIYvGkYCfmW9qKd0KCBusElt2G1MtwJ258NrLSuhXBuj8d
	 KbCpzILqsVGohFMch1QxGvFuGiCY1//iZsFxmJplWuwr4iB6kCGSdNcypvZKYoz17Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kNtGztyr;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097A9606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 23:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 097A9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kNtGztyr
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-92116a3ef3cso80916936d6.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 15:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795650045; x=1796254845; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FWWCB/W95vztrzT/xUR2OufEbks4s3F+k5PERRgs9dA=;
        b=kNtGztyrA4PDEqR5/1UK4q4G4IQb+dYRscazepzscACN9/9coGIBauW8qi0HoolNva
         45kmOs3K/fIbBW29K7PzuaYz0NOnWaYGtEaM7z8iZzGMEdpmy52KkaLqfudGhYB9tE7M
         8KnYGHenHHd+DOxBQFaQwRk+T5VnQcELQ8oERMHh3/s008+MxqrXyQ2kgdcdjK0T6MxD
         5nsqfun3zv78smw5rugKveLmsg9EEgZqLPbgxIrzT/lrdazvcYJM+AbYMAEfnCkFALRD
         BP1licKBfTjVKGNLpZhbze83ym7Yk30+FJSHzOARt9AF3Ax7B/aj1cNURuAYsV047MHq
         2sAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795650045; x=1796254845;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FWWCB/W95vztrzT/xUR2OufEbks4s3F+k5PERRgs9dA=;
        b=hUgpAfuAooONwmifKkjMnQYEGzOVVSp6sB8jLMdKqvMYtICDtrHZ6yYhZj0L2t5FqB
         gIZg/9vbPsi7AbWqQquJIe5lfixR4TNpKZZu4vwafP1gp9qKtUlPg8U3TaYOwQxvI9yt
         4lly7sW6dbk69II8Nciz+zC90UCB2V9bSuN0VWnUAzIbpV3aw51MxkBp5EXR+z8PGXN1
         Q0voBU0hOf8wMJqoEtt7jWe+QIlKxT1PUEdNijWDjLSwYZ/3GT9GQzJ9s/0Vu6MUbq72
         TO+4WZJFB+bCapy5VxBScUaLmk/IZc1KIJ5pt5CaGesfeLiIoaRYAkXWJt5hgJGS0Ubl
         W4oQ==
X-Gm-Message-State: APuU4Z8wfO5065ayHDRFA8ijCqNW5TDg9y7fEYv98KYpJkguNsbUqbbO
	QNAMg68DdopvgoK1c9LIHQ764kLpt+fBromjkHXcbygXNd9L1iBZszCDunS8wQ==
X-Gm-Gg: AZFdTZezzaXI6EuTRCgZRYuT7AtWJ/mxijmMyC6ogdPSXyoRJUoezYqEkV8oJmjQ8jQ
	pSDHQxRfiJT5ITNaaUM9HMN1YNq74+qo8BAPYmfKPWJiY835dA3/QL8M17J2OiXDmkDmtgVBNKu
	zNWT1BNEGO3VPGD0BVatsHxDWqEXtoAcY97VBnPPurJsQbAfoq5gqSPjLENkZ+MftG44wXLKH01
	UYkNHJ/ePmSWoxS/s5V/oO/IVkOajLLcQobHmsdmb1SWDn75JL/VPrj9krVdteWW6PD2Tx0CXoN
	jzozji8LKq+X1hrJgOHQGCMgG+qDSBNo5G384BKMe2uj7sdZY9DJYTzU5u08iJ1YswSarBCrCQT
	uP9XcnIn4y4MW8W37nFrVc5Tig0MoQARUerA9ik3ykrVjXS1RHB92Gq6gfLREq9TftvplzOBAqd
	fxOQEiYzR8X9GUhVrhLGH1vevkn2xkjd8SNbe5gdgU0EijfzL+1k9oG9sqs59YpCaUj6jrurbWv
	4YTDN6p5KaTJV+TXIIqISEHLFAXTRxk3NgaLp3WODRPcFsyACDF2kWbp5dE/C8=
X-Received: by 2002:ad4:5d65:0:b0:921:2378:4af0 with SMTP id 6a1803df08f44-9212e07831amr354961266d6.10.1795650044962;
        Wed, 25 Nov 2026 15:40:44 -0800 (PST)
Received: from [172.17.0.2] ([20.109.78.212])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349f8c34sm176036576d6.32.2026.11.25.15.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 15:40:44 -0800 (PST)
Message-ID: <6b0771fc.31b977b5.172c4c.002c@mx.google.com>
Date: Wed, 25 Nov 2026 15:40:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1374032921451091802=="
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
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: client/btpclient: Security Level reporting
In-Reply-To: <20261125160018.590013-2-frederic.danis@collabora.com>
References: <20261125160018.590013-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1374032921451091802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1222319/

---Test result---

Test Summary:
CheckPatch                    PASS      1.41 seconds
GitLint                       PASS      0.96 seconds
BuildEll                      PASS      16.79 seconds
BluezMake                     PASS      234.33 seconds
MakeCheck                     PASS      13.88 seconds
MakeDistcheck                 PASS      118.81 seconds
CheckValgrind                 PASS      285.03 seconds
CheckSmatch                   PASS      239.03 seconds
bluezmakeextell               PASS      78.72 seconds
TestFunctional                PASS      1035.71 seconds
IncrementalBuild              PASS      242.41 seconds
ScanBuild                     PASS      858.93 seconds



https://github.com/bluez/bluez/pull/2921

---
Regards,
Linux Bluetooth


--===============1374032921451091802==--
