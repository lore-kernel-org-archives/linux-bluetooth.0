Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795484318;
	b=z1YgzWHl9GO+IcYC4gCpGYuLTZ3YO/VGjHNuAXC8UeQ2iOd0V3lpCJtW/BwMtrDSTCPO
	 s8GvqZSjBSK9qYt5t3ciHGs7MTtnc2jwrBiyFAuLlrJmEKcruqgJH4XfRMNpDEJ6HKY4g
	 UUZxVRu2PZVhNEmVxd1uvPxAh8KJ7ow7RYRNuZg7X9ew9IxMKe+z0ywjVSkuk80eK03Ky
	 1k+4MADBQody3iGMBQ/h3ZpoEvIRf3XkUE4UUel4ZTrKnF+dr2afOvtzUFK4mL0Tnjqdk
	 KDgPFyA+C3XpUDcuGBAULwsQSoUPy40MMClBm4mcj7JXxVlgIXxQUq1inmQt3MQqDiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795484318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=pUbd3JxetIJA9eGXe61ArZ7nMtTQLau3LT0B3wY5XRM=;
	b=XVR5u1MR2Cv5kGYU1hqf03MZ36PQ/Jsv3WvNnc8EBC3pyIZYIVaTL7DtK6mnMAkiN1ZG
	 kqXSG2rEhKFGg/8HfOlXiNwr2fC82Lif9apA7GEtrNMxrwcPwBcSD1YqNMYpKEEpiCjpV
	 XXRoc6NRDAt1lDNgmKLf7pzNnuDKfOVhi634IGrVVbRPDwrwczEfiuZSdMf238BvimN/V
	 A9sqDbWeBskSzqOSu7T5aW3mbeIUpmNZCGG6nlAfjIeRBQO4gYDClTkDtwn1hFZhUdfZy
	 8q0/S9yLQWAqQXsqaJKQdk4gr1WuMhnKHEjcGeEsp9gePb5k4de/OvH4DYu/1DDtTIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=erL01jmW;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA84606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 01:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCA84606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=erL01jmW
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-862a5b64755so2265630a34.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 17:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795484317; x=1796089117; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pUbd3JxetIJA9eGXe61ArZ7nMtTQLau3LT0B3wY5XRM=;
        b=erL01jmWXwlnminh5Tv3PehhHrCR/HqNpAFCrUoDYWN6EbcUvyB44EDGjPG7XVEjmA
         M+UQ7BIez3I1ZMOJH4rSKobkLMXGyvUcQsONm7fsQwqkcKGEYhvcT6QrPknZNw2kJS0A
         4F4EbM77EXoIKufHLiaRP6tb9/Hv9lSFLG4iuTCYKs18R/t4dpCUr+YWxnQRybMgo6Sf
         DPWc2EU+/Rw8FTACJl8H0FtL6UHtqYtvJric7iI8V9Yg5Trw+149WW/9q5+mhygvLbor
         AwPXGbmlX5u4FONFCh7Wjy6W5l+kcizEq+CMq4itNApc36R4FeMEcQfdx864jxUajzdU
         Ib+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795484317; x=1796089117;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pUbd3JxetIJA9eGXe61ArZ7nMtTQLau3LT0B3wY5XRM=;
        b=z8bqR/3w1pI2rpO2F81iEDgHsU1YBTM1lAZ+XXLxgt+r1Erpo0DZnwZ6SelSkEAOFp
         JAFCI92Evriz8psz0vRQGUxMCNy0sZjvThMlC1dLMxyiVIkV8OlAJ2GQQzzpanmerfhG
         i0KwoXIjybqYxlZv45j4rLEOmiqyexd6LXGHcaUCUbWkDM736KtpXAzp1gLZMVxsRPuA
         9c5HpuXzuopTSjDpC4Wwa+oA6CNtREDbiIL4JSKAXwnFKg6sWM8zzW2o7vWddBs2nnn7
         lhStC2qWPrGZaDSJep1sQGKWYqexKcpXDzWISNIfeQvHXMDCBCwRaPZ1j4QFlg8GcGNJ
         NmFA==
X-Gm-Message-State: APuU4Z8SyMf7K61meDeBjiI1NfKlZiXGs7jx9/oKEEyRM6rvHgvyB1PH
	WXX74AVMF3hl9/217YxCyIKW8RyDllhQStbDnd8ZjUh6zNgeZYpHpGrLG44oNQ==
X-Gm-Gg: AZFdTZdPVey+imRlZlncIt60P/eKzQRx8Wcg8hUmteV26YHz9+YCOj9A66JC7begGTO
	2W0BEGGtIWl7bARZKBWoWvPqR/zo2xxGem12f1VNxVNM7JTksUzle51wtkQrQ4b+lcp1mTRmE/n
	TV0XnLhrWMER4P7AUFBjzwXe5JEOAFGf6cd6/ronFQr8PxQDVhDJYCYROvpF0f9CjdNS8bLdUKZ
	7PREpIdWv5XmpkeqiuI0NWmI0b4qewmc35p3IfMqFYI4/r+yODSj8wkG8mD+mOIc0s+9/76b6DA
	XBUYTErToHnGuOsJHZhrc5CfmAkKfOCrSydSp/CNTqZjrWzDlx+1PlrUcRRcyu8ty2nEpPBVNvi
	tslsuyvnv+RaOm7vis93/NM9OzZu+BCsTJ/xV12ktlSOJ1A16lploe3atp+aMy+47OWWv+umyKp
	i0Gk3N5kxkm37UlcHi6TMsB2OhFjF1T8jNzBM4bYN/R9snQTf1mnV5LsUdjkfxUXYyUoFbVaszY
	+9UgBGW6P/t9B/pGMifagFDbq2VrzSpbFDb4EDaiA7Kl16YkiKVsXUQ1O4abOMJnw==
X-Received: by 2002:a05:6830:4ac5:b0:81e:b506:592d with SMTP id 46e09a7af769-86315987fa5mr14879241a34.27.1795484316722;
        Mon, 23 Nov 2026 17:38:36 -0800 (PST)
Received: from [172.17.0.2] ([172.170.190.113])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8631692d9f7sm10183974a34.24.2026.11.23.17.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 17:38:36 -0800 (PST)
Message-ID: <6b04ea9c.674ba918.33e30a.ff44@mx.google.com>
Date: Mon, 23 Nov 2026 17:38:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7065312344813496888=="
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
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ,v2] bap: Reset broadcast source stream when ISO io is lost
In-Reply-To: <20261123163021.391908-1-simon.mikuda@streamunlimited.com>
References: <20261123163021.391908-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7065312344813496888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1219840/

---Test result---

Test Summary:
CheckPatch                    PASS      0.34 seconds
GitLint                       PASS      0.25 seconds
BuildEll                      PASS      12.88 seconds
BluezMake                     PASS      195.85 seconds
MakeCheck                     PASS      2.66 seconds
MakeDistcheck                 PASS      103.66 seconds
CheckValgrind                 PASS      104.41 seconds
CheckSmatch                   PASS      178.73 seconds
bluezmakeextell               PASS      64.20 seconds
TestFunctional                PASS      901.08 seconds
IncrementalBuild              PASS      197.53 seconds
ScanBuild                     PASS      664.10 seconds



https://github.com/bluez/bluez/pull/2886

---
Regards,
Linux Bluetooth


--===============7065312344813496888==--
