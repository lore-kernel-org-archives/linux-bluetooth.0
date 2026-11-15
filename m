Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794775414;
	b=Ew02fjUIy+rD/Lx8hQk/QA5VPANn4kxKcdPTEkN6KEBqK/HAovt6rnQ/FAbOhX9IIygR
	 IFkBkNhkpvwV83/JmkeNlI2BA0YwecvzLyVsfwsNE8o76ulN4E4IXtzLN4flZzW5+tMgm
	 LErpbtc6b1EhOFfUp3VVPV4bdxL+Dh64J0RFa1XRkg1Ov5sutXCKMYMnmufxri9W1COrS
	 9r/+6r9OjS1RRPsrdPjwsv+XC/jibcYkTJAiDUjyzFBHGRkVaQ6ZxOfAFYZnX2alVjdHJ
	 q85ieRxEC3UPtH50CDKO8kmFdRuFYq9ERJkHVAqecpnamPSyTgO9GrL0xqJ8scqeMhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794775414;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=wkIJBVlYEEQRge34M+zsBbpTYkI/eAA2+9uoCVnvTRk=;
	b=Fhd4ez++XEGkC9BPzODaLe1Agibju82LY4Wof7OupY/IyHC+LT3pc7zNwF0JziahiNwV
	 dXJWJ3+ADL5hMFJtXKj7j+035mcgxHeFovLIeZPmDKJq6DqgEgKbOjqyimGP1Q0LNhieI
	 joe25vQDxWPjAkupOHnSlSf0hGlxsIoAv6Mj58/04DaiYhzQxQ616EWydyVmTyHHQOGCP
	 8EMvSY+NWz21EIknKS5iGtEB8Wvnt0MUGlH9dibyjnBgANmU44p14TVphp/hnv+MFb7hA
	 OfXxWyBZEzb4OmbDYZLi7LnvmebNilrP3E23v0sd1/ld2TZRakGx6+ZK8tSzLvT0AEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dTBhBq9N;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147F9606A32C
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 20:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 147F9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dTBhBq9N
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93f3c616c84so290876685a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 12:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794775413; x=1795380213; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wkIJBVlYEEQRge34M+zsBbpTYkI/eAA2+9uoCVnvTRk=;
        b=dTBhBq9N0nGUhYVlTszKfQZc6Go6u4ByBEBRr741kvqdVL6RhKe9xZF1EBlHJyKN7N
         IafsBOZx9D37TVKkoz4xGI2Wl/qKBZM1kS8XNgjJBH7fXWdL2Q42iJwXQvwJGwb2xkrV
         1p7N3FQ7zahAmTBlQz3cJGVWkUGRrwd/MpkiwgByBpkb17PJrrFoqmvclNFOuXbpxUMK
         M1ZJlvivHrA2huhE5mx2b3GlcXTMMspGffsGiJS5YDTPRIDzDWzQzsTIkzfbkuP2faCX
         hb7Y35H91JqjSxeblD6cH6UpwcPqovFGizX157cuunsnAQv6+TeVGMKMNgi2t3zHoSX2
         dlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794775413; x=1795380213;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wkIJBVlYEEQRge34M+zsBbpTYkI/eAA2+9uoCVnvTRk=;
        b=pTZl37+mYgVrPBpPdMG3xM+lXVfUWhGKoj19MbQTT7nwWJhN7adXFYLxR9K2awi6G8
         DJ5aItx0JkL8NQrtwgIYAbjJlj9uXQVjLs5d3Pe/gZNznhnhcR4q+0xc1+sZop/IKy01
         u+SQTfFP0X7RUeewR6oAnycZVqmZKiZzkx+OKdqYVch1EB/2+SVFR8RBvUn5oy3rctRw
         Yei/kMwaqtCH8pRQh778BEfh7Fhz0ac6LxWBGIHpNJqhRvLiTGueQ/aNxHk+PbgrJFpV
         rl8/w8ec0pIGDj6jTnDu180Y8voBbMAl9jG8R5bCHtrBWAPqisFnf7srFrya3VMr5AEE
         y0zw==
X-Gm-Message-State: APuU4Z8iJmr0sSGkYGxeqEagTxjmA+JiOb1l0XbOolXJymGuFGZOxBil
	EhFHCd1v0IGcqe0pc19Pxttr7mKHYxglL/mgDzRJSLbIaexFE/5giL3oMSE9woPX
X-Gm-Gg: AYBFou0vv3LcJA/uhy8Ct72r2z53rzZ5kasSeLlHuBPHHpIlZBMAxXEHw1aZxjDj1wo
	jkveTEz9LwZbepLmThJQr5HKxzpUA8MnDBiBHGwV+a98aI9qnr7/mI+HV7JyLuV6rIHVDzPT7PJ
	BewEAIZ03uqpzWfdzKRwSxX21x6dlFBS/CatKe6AVSEAhsozs239TR7ZF9Fx1qnL+rdPBRpjurd
	MMMOcfsYM8dt7KJxEvMB+ake1C3LdKy0wGwBfSAtncn4I6Zn4ZZsEJ3dlFFFA0x5vKWJ3uvYE5n
	4oaY/SXW7jXc+qyccRXz5F2YxODK+NIKfFZQH5/p+Z51JQJOnqkJf+i91tMaRE3MtwP6IfcGZ6X
	fRWqkrR1eoBZoP2EkKNl9Wfk1PaJm2vLweOqc1a93Org93IR0kZcjU0/FhGMxpfNDsNHEtCqxOe
	pAmu1cEoXRl6p8twXhVRSuDDkw/GEBOWtHV1Wp8XtekZ7GkDyhs2GHO8SvO+Adn62jZSUxqHQsb
	toK9lyJKX9HejotPTvFGeI4j9HNxYQ7OvT5rwK1lNKmoJ0dshnStGsdCMw/8aw=
X-Received: by 2002:a05:620a:3952:b0:939:6de6:9518 with SMTP id af79cd13be357-9494bc2b243mr1463420685a.47.1794775412982;
        Sun, 15 Nov 2026 12:43:32 -0800 (PST)
Received: from [172.17.0.2] ([20.15.102.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c8f92bbsm696632285a.40.2026.11.15.12.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 12:43:32 -0800 (PST)
Message-ID: <6afa1974.2ba6c529.16a0b4.95d0@mx.google.com>
Date: Sun, 15 Nov 2026 12:43:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9184467876930971880=="
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
Subject: RE: [BlueZ] audio/hfp-hf: Fix org.bluez.Telephony1.Dial reply message
In-Reply-To: <20261115101907.68963-1-frederic.danis@collabora.com>
References: <20261115101907.68963-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9184467876930971880==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1211774/

---Test result---

Test Summary:
CheckPatch                    PASS      0.51 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      16.18 seconds
BluezMake                     PASS      233.84 seconds
MakeCheck                     PASS      3.25 seconds
MakeDistcheck                 PASS      121.14 seconds
CheckValgrind                 PASS      129.54 seconds
CheckSmatch                   PASS      234.35 seconds
bluezmakeextell               PASS      75.96 seconds
TestFunctional                FAIL      1015.95 seconds
IncrementalBuild              PASS      235.24 seconds
ScanBuild                     PASS      874.81 seconds

Details
##############################
Test: TestFunctional - FAIL
Desc: Run test-functional
Output:
FAIL functional.test_bap::test_bass_past_earbuds_transport_acquire[hosts11-vm3]: AssertionError: Failed to acquire: org.bluez.Error.Failed


https://github.com/bluez/bluez/pull/2829

---
Regards,
Linux Bluetooth


--===============9184467876930971880==--
