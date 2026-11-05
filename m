Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793921657;
	b=VCqKTAyd63uwBPsd9ydpbmqeYIH8/ZqprqEfFBR4wGKERQQGPkcLvyoDzabBWuSU16Jg
	 SZzFjZ1xftN5z9WeME/537fqAx4zZ6BOUorh9wlh68EhUMbp9vM/4vmuWkNiGsxEcQQyT
	 J7e+iSV4UvmsRAz30axl/10UysgB8BqhmPCdONEOl9yaU4ey64e+r9TqBHLigAf8Cu56G
	 1c7U80m4BRKiNgSvQTwhg6uHtIp3xUpLc2/bYnOiIsZKVpAuDNu8w0p9dYorcanT7AywY
	 nPBx3nNPDta8yQxZqvVzYeJ8agmcU4uDUhTVNruGGo8/50pTDN5cM28KdwQk9dROugQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793921657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=e31NjbmDhOFmRN5hWW/ur2/7QH6XMs3UjbYTIHzFhwA=;
	b=cs87l6RNc1owEVb7kHmBV9AK3lE49WdemD3vPY9Egxfa6iIMnY2IhvgxmhnJCPvebfTH
	 501BY9SuECWxxq37r3ttorL5anFacmnKUnd+w8EpU0Ph4oWVUYL4bSI6JLyUxRlQgTKoi
	 qm9lkDo91VZreE9o+/48dhePyMQoU3WPskBnSBPUe6a7Y19pJaKpItelihLov8Yk8ZdVj
	 3BH7agnhAAmoHSTEUequ9O8Pgbi94Uc32eGiAXln480Gjce12tGN2Ihb5swRNopp88hG6
	 9NAK9pjr/JQEmOdBNSJYa20bzrn7slDZDS1/AKxkR47ms3GVm9VuKUwUsrbYaBjqjhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KCQXKhqX;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B565606A31B
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 23:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B565606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KCQXKhqX
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36cad25b8b0so76199eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 15:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793921656; x=1794526456; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=e31NjbmDhOFmRN5hWW/ur2/7QH6XMs3UjbYTIHzFhwA=;
        b=KCQXKhqXckWlCCGiMQLTBhQVCDf/XXg/R54OobUaPlGLJS9QXsIx2m3Graau6BUSav
         6MTiSwmhWfB89Kgs9HxOjOmL/kB4USfEv0iU6u1tXozhQV6X1Prm5qtoShSefQMZJdMQ
         NKO847GOAvDOCVd1aytqNT7JPeLIprYRVaOF2z3/cEShZZj5msUwReSlcjwJ6HBU+yzX
         QdnZQbow5pEbYolxA/nGAL1lCJ73oMf3wckpuzDaPlf5FUmxGYBG3kekSfH0KgbxOx+V
         THQNt4MDQMPltzXDbihVEgNQ6RV9WZuM85VjGghOsZ05IsEqMKxfcMDmDABN1ZyuSigE
         0tsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793921656; x=1794526456;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e31NjbmDhOFmRN5hWW/ur2/7QH6XMs3UjbYTIHzFhwA=;
        b=W4NtvEhE2+E0d+Izk8rE/C0rhbAWBeTGcwgcfP4BN1UvA/gHlRI6dsNhI6ZnkBNsrf
         ScQgOkTILzAt5cWmyCVZijmyp9/TyDIDVppyeJBcZdsvZXPe9JUQIM4XQECtZqNX8N9R
         rWG2FhOy2ePSINzyqXogi13tLqwVzdWJFUdnkg4Pyp8xn9EPenJNwx+I4xXRnQ8v+Hih
         9aqhSIPTmPOyP+DmBS+EHbMMrXQW2NLBZwnqcKad/g/sZLDfl3+tPQQDpDPGopmW2Ai6
         4FN4Nv9tdE6emzYeMdq+kPNfJlkITjZTV3X57bmzCX1I578lyB1GPjlsxf1XWRMZTzh0
         SMhw==
X-Gm-Message-State: APuU4Z+Sx+OKQKStkQq2qiUGmj7XKOaO2G6oos5VcgPiU5ZxAwbFsC1y
	KpR0PDMCrD/5a5Pjknzm2P0qDPHOLSiKqhmKWd2yw5KMa8UbZtT8/fvgE8O6hQ==
X-Gm-Gg: AYBFou1VU2rYR26CVMo2lLPcgrLKuFeq3zFRR385XnEPQp0V+x0MMwvpnVuQpFbo8M8
	vcEM81jjgLLj5nI6VAoPVPNg2tPHxJruqmZb7nae4jBYd1G/K5F92KSixpkcxaj4WUuPtfNjB8S
	fF5mCNdNmHPEOG2e0ql48lCcdzYfwk2cXwbcqNMxC6DvAPzTEudN0QVsNx5joiSKWNKNreTfhsn
	eBi5rdqJwxQzCzlfxixslV5GuHeGFEbJkcatxUz83HoO5Ly/8HidKYWQOmFlyJCLQgAe/AHlFLp
	PGXCaPLM8EDH9O0NtVH7FK7+EWzAUVLGkVy9LgHR73+sDvfpW4/GtD47qKt4gCFmIjmXev9zwOw
	U+6jdIg+Lcy1KMYcGgNhfhm0vzLehzsBI96qIH7JicV/lgvkcDEsUj+S1FtBMv2gScwNidI1DM2
	oooS+cgXJ7inUFqNN/DmqZ/9GQsy+CyCJN80g7/+gnbVK7sU0GK1LpxWo5WpLVf//JrjdW2Tw4Z
	zLaSeILl8/sJxldZsWdeWMJ6bKEaQru4gp30Yge7JaClS2jQtTiw7LxX31B4i98
X-Received: by 2002:a05:7301:6189:10b0:35f:2858:aa4b with SMTP id 5a478bee46e88-36f76e0f1edmr844365eec.30.1793921656183;
        Thu, 05 Nov 2026 15:34:16 -0800 (PST)
Received: from [172.17.0.2] ([172.182.202.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa651eccdsm547942eec.1.2026.11.05.15.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 15:34:15 -0800 (PST)
Message-ID: <6aed1277.a8e1b8b4.58bf6.832d@mx.google.com>
Date: Thu, 05 Nov 2026 15:34:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3308660622224184116=="
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
Subject: RE: [BlueZ,v1] avrcp: Fix GetTotalNumberOfItems command encoding
In-Reply-To: <20261105221620.2332170-1-luiz.dentz@gmail.com>
References: <20261105221620.2332170-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3308660622224184116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1203586/

---Test result---

Test Summary:
CheckPatch                    PASS      2.57 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      21.08 seconds
BluezMake                     PASS      322.34 seconds
MakeCheck                     PASS      7.13 seconds
MakeDistcheck                 PASS      169.94 seconds
CheckValgrind                 PASS      162.45 seconds
CheckSmatch                   PASS      314.22 seconds
bluezmakeextell               PASS      102.01 seconds
TestFunctional                PASS      1219.96 seconds
IncrementalBuild              PASS      350.48 seconds
ScanBuild                     PASS      1227.29 seconds



https://github.com/bluez/bluez/pull/2767

---
Regards,
Linux Bluetooth


--===============3308660622224184116==--
