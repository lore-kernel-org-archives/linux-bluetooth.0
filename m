Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795214055;
	b=0mbLWcKBHFQz/EAafd3lCU7P0hiehynJ4VcMmV24q9YxOp8gjIcoAdaE17sS8Nnap1o+
	 QdYI8ILYpxeDL5leIYbC4YnCAUrOosSfcI9KtsVua8j33+3ktGC/qgzuOnQyay2RdAcWb
	 YXjkOeFYYLc0hUGAbm8E47zP1wXkkDfqbyN7jawFPWN6A2rh7KQVDgBtW16TCyayQtUEi
	 sdt2mgZOg3VOXWUiF91756E7dgGtg2tBPRSXLDssgUajjK2qIZXqfKhE0CmGKHEUVKVcM
	 iGnZZTzvalN4PZ2ez0NjeiZw9jfIA3ciweToSHBmc3y9kZeecIQ0kzh0Q1+H3yGYcNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795214055;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=v6LsXe5WOnF2vNT6M8bzn19t8+4pF2i0Hb7l5soQyTQ=;
	b=4rGCBMG9XZ1viMFPwVwmpmbN6JHBpfEubzpcfc5UVnf62nPV6c7jDIij5xCTpsShTBD2
	 b9p+Z/jw4kmEnTRDA0o9Pt3d2v39kWE8RV8Wx2GBteJUktpInZGQ2vcwdwpwK6R00ZyUQ
	 aWNxtO1f58ystfj3sbBgNOvuxndwdA6LmSFaT5nZqb/dCZa/ny2xEn0W+/HEm7CfKmGQM
	 C3+IX9LauwufwqBqNcOE0cnI25AIiff7se96593P7/KTgyjfI7594D12pra2uv1VMzkjc
	 a/wGNcEjyP6rnNViUJ2u8cZVQbTNewStGJcJ5OBtFdaG3+kSI8Lthl2dnECYIFOmAbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SWgf7DWm;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E83606A6A0
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 22:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33E83606A6A0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SWgf7DWm
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36a315ed211so1533498eec.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 14:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795214052; x=1795818852; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=v6LsXe5WOnF2vNT6M8bzn19t8+4pF2i0Hb7l5soQyTQ=;
        b=SWgf7DWmolaMP9dyMWnUOnCmqN4LkbhWYXz7bYpFMMzS07Cc/7Coj/hvAfU9fHSYhz
         Zft/n9x2DyxbPdD6WGIWBaqVHYpPtQ9xWHbVy3NVF0dvIGNM1jp2xV9bShPskLPALdG5
         wwF8+xJ/vocNVo3F7IWnN4aMn1DhOSJZgyELhwBN1rvlBb4vdc/v3pB5JAPA9DX50Oq4
         SM21jQN+ObHE3wRLJk5cAqusWvipt7Eb+GpHWUFZWrb0RfJ/c3DvSnY9mlDvyA6AVF/i
         lfQGP6DrbA6c+94N8pkCUlxyyEWhF+uI2rm6/vaNsiue4meoCazFziJ71xrdJjvJ3TXL
         ey/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795214052; x=1795818852;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v6LsXe5WOnF2vNT6M8bzn19t8+4pF2i0Hb7l5soQyTQ=;
        b=U1J0VJkC958Q9B0lk5gLnPBrWwGYKEOGucGNejUrFeKQfXTQB8P8VQsHnXq8uJL/Nc
         Og8I4eUW5gS3Ab0x3zLcTUxm683XNRukiY5rLyknjySIoyLruz0FLEij513NlK4QHDi3
         3C+/E4XyluidQfjLoAPy/kAe8AkUNctF8MyGZYn9eQXCwR3WWiSHaG4zjVbMMnUGEc0k
         7/oQYX5Aw95aUKgEypXjEkX5kguWw7q1uYtjcbto5Jh3ss2hrL97r8MphAdnt+SRQQ7h
         xnqMfEPcuH6HlfQ2Ht4Bdvb745pZ/3zVoUnbeou0xmESyn2PkWD5m5VXvwI4X0cG6Bml
         baNg==
X-Gm-Message-State: APuU4Z933fd+mdpe8hN42E39kagudBTZyzGb1vJFciCchoqkQ8mDqI5j
	Fr3wgfxD6ET/UeRlxd7X9tYwu8faTv8XsQT3eibAgWij6qU9LzYSX20l6Rt/0g==
X-Gm-Gg: AZFdTZeAIbNAOhNzI6bfNC7pT/TD7CWPJcnoYobaitsvSfQlg6RkYDbFiHu4bjXxGBM
	xyagJR/cUyaYJ/KW027nZqXQWpE4qm0yGCaW4ABguJlYaXlUtXujyZM6psZltEHmA06zRGL38mm
	Ma1SUajisGTns8QRswp+LmMrgzpCzigF/7qMY8BOZ7w98wYLa9Qf3B+7Iyw954hRxoTj73PJEYd
	2Pvdoz7TWeS17vHB1f9HHNVv6evkf8QIQ77PJ9vBjgWSaOEQ4xWe03gfQWs4v+V1fewqKE3sJD3
	r5v3OvQTtVjXHMme3mlrifMUsaFnJ8UhyPdaSpjsGGE6n1PJTVoyMzc/qOkZuS2l3GBmquTmQDv
	nhQ0R7OMvS7qd9uflnezp2/YLXQzOXuNz48ewIcUQVZ2aHkAPTxxpKSfwgLw0MUjEV5kce0VrlW
	Y093gBSjPzRowGz9fkFSIpDARpZie6hPo3eQ0XjRjkRLYaPsVnA1ZKa1PJfZb5Q6MUSgKt+K3u4
	l9+NWqeuczQUfPEu8CIgV5D214WByNLAv506xm9EVVeLigGIm8/ekVd4iGPcxMf+A==
X-Received: by 2002:a05:7301:1a85:b0:36a:79cd:12df with SMTP id 5a478bee46e88-3856fe5ae43mr4662154eec.9.1795214052080;
        Fri, 20 Nov 2026 14:34:12 -0800 (PST)
Received: from [172.17.0.2] ([172.208.153.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567da4f85sm12120078eec.27.2026.11.20.14.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 14:34:11 -0800 (PST)
Message-ID: <6b00cae3.b52ed58b.231d93.d3a3@mx.google.com>
Date: Fri, 20 Nov 2026 14:34:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8066526918930230226=="
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
To: linux-bluetooth@vger.kernel.org, noplatinumfound@protonmail.com
Subject: RE: [BlueZ,v2] main.conf: Add SecureSimplePairing option
In-Reply-To: <20261120144201.19188-1-noplatinumfound@protonmail.com>
References: <20261120144201.19188-1-noplatinumfound@protonmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8066526918930230226==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1217447/

---Test result---

Test Summary:
CheckPatch                    PASS      0.38 seconds
GitLint                       PASS      0.26 seconds
BuildEll                      PASS      17.73 seconds
BluezMake                     PASS      270.13 seconds
CheckSmatch                   WARNING   247.66 seconds
bluezmakeextell               PASS      91.05 seconds
TestFunctional                PASS      1109.06 seconds
IncrementalBuild              PASS      273.99 seconds
ScanBuild                     PASS      963.39 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/main.c: note: in included file (through src/device.h):


https://github.com/bluez/bluez/pull/2858

---
Regards,
Linux Bluetooth


--===============8066526918930230226==--
