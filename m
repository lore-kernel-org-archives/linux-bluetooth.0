Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794125198;
	b=pjxmXBmcUiBGLpvGcxL2tcxj+MLnzeHT+igzZjXq+BoqWXbyrZQTnzLPwsJhvN8ezHi9
	 cBv1rK3DJX5+52vHx1P48f05CkDYho20DlVMDdlDOc6QXrMz8MQZWp9Wpm1FKPLDQiYad
	 SeQm/59dpAC0/nE+74menygqg1lQAeOXFsh2RG4B2xtPRlk43upvnd4GMP2fJBxiZjx2C
	 ygA7cC49FAur54LWrFBpDW8LnTeeFd/NmwpjvlL1pK7P4U/IdywcmTJX7IC/vhxf63mN5
	 wBS28Cm8PIL8osxegQgEzBP+IaOTijLxXKX8jg1cN2uTkRN61B3oweTOEkK3TNSNuKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794125198;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=aRaoXROtRYBdp8vtHe9AA9bPGxJZEP9tgRBKge6WpS0=;
	b=D3UkKvTpLArK2YBwnQGoHPENOZE2TkmhXY5kQ5nGt7NcGCY2zuevAA6590hkAfm/cvHl
	 XhSxDJWCx/c0UQcAOK5ds4FEDIe/lLcYKr09MI/YiuAGUpCYWlxaPMcPq0/hOxinU4aLQ
	 CiyW3l6IaX8g+zUUPdYjWwu0h4pi1bQr6NyD2G1kR7lK0GNlRTsX74LR6OavA2WIYOdtC
	 vQ6X4D29qYYhzX8He2cgAD6vg3elMM8kFTOPWbkkMC4eBJ55WJOSUepjiCtncD+eC48DC
	 okppPskKxOXA183GVGuuGHP1C4cwXLM5czaT7Se8sLPT7EQ/fBQs5h3r+8M8zv2xy6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="pYB/Kkpd";
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0368606A320
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Nov 2026 08:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0368606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pYB/Kkpd
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36fc0a3fe93so555260eec.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 08 Nov 2026 00:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794125197; x=1794729997; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aRaoXROtRYBdp8vtHe9AA9bPGxJZEP9tgRBKge6WpS0=;
        b=pYB/Kkpd3V05mQJPIjJ60Scy4xupVHKPe/N1NcQjcD5Web/5HJ8tDPeOE4RJ7a9LOI
         iNXmEMhafYDnLhiFlD2B2LHY9G2ubcP1NaD0KE47TSxd7wfAJPcofFBiOBD2GsvwP1ex
         lWQ18bQGeN7dyaRLb17leVu8VFFxH9q+NT1ZLObZuoEbvKT3gOvKtuCRjYHsdk6sYp3/
         xRVA+1Kn428ZAJOR+JbTKV3k91SR6VYH7p32wp/rzInUA53fUpnQavK8uErkGRTW2bsh
         XM45E3J5JC6F0ugi61tJP2RLNorUt1OZNEO0R/yqdfiH15iy2po223F7+eDdOayPnN88
         pfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794125197; x=1794729997;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aRaoXROtRYBdp8vtHe9AA9bPGxJZEP9tgRBKge6WpS0=;
        b=ZUsMBDnBb8Bl/93oT6g4s4jUlmLKm3uM+JRUzWhgdffAy7UO026jHS3X8meoOGFFKZ
         +XBVVX7sg2OZQ6PIPJ9HSKg3HFMZSC+6y3Bvt2BAwiQv8VGE/PsiNKI7LfbjjT7hEHf9
         ID/pY7FSlmvRg0ThJeEO3j9ooXY6f3l3nKsba+FPmmqwLNn9zXV42/A0sR48QYZrY6Bc
         Ea++5LIE7Jm5OQfkIEFykg88CkRS3Fm/8C676yXW7KCwcgwlEDS5ZsZYkTdkUa7+ase4
         +9lzH3ObeM7490UcQOQdP8MpZdi6pZA33XdQ/hjXUy5mIV+ku8+LM9HYo2c1auamV4hA
         Pzug==
X-Gm-Message-State: APuU4Z/q7JB/0VdS/IIRQeSQ2oo/bVN31BcPhEvujkh5eGkumPo6JPRC
	8QsmSntTpDNWTE++bAzE8Kpm+v+2jVWE7CSw+Gs+uamxp//AQBn868bb7nzVLg==
X-Gm-Gg: AYBFou0uAmPqDPUCVMhGX+J5CXFZa83NlANzHpw+oGMRH4mC6dfp8LgfevVTpITZl1h
	X7Ej/k6lNdzSCnCLiMH0eml5qGU+cRvwiAyaXDXpB8OezI1hwNMiduMxkW48MBbG2i9AS76OPhO
	rvlYaitVxDaYmgF51p/mZnX0+tAZro5xEKEGR5DsUrvPBvH5Hp61bD7Y4enpt+MWCtrKiE+LyeP
	SLKdi464qgCWFhwOK48rzWyEtatBGdrt9OoY2fvwsWzBDPaZVP2xoWiH+0FmkdLunOigyInoQKq
	8vwE0DUvD4BP9Hvr/rXtLj/YbeISj1QTTQZzUJlHdNjHy5OwSFjeE+Muc4uLvR4og5WJNcJQjWW
	nhxEcAjlleE3nZ1F6b78qgNbwISZErcbuZzO4Tc/cYCHmdelmHqzs2LfVJxcbOBwn0IMr4kkczC
	tzHiqzXzh40shCWpbmwUWOg6fPB2Ol8WKftzvgWweDe90o/cSFV9P+TIMYY+MERwM3V8NIcqaZF
	kv8D/TPw6NWi0yCQlb4vGw5p7P7gpffbObCWXwHS/lWsWJv9GBygLJ+O38RsDiOdCmrueYU42bH
	z4Dy45s=
X-Received: by 2002:a05:7300:f14d:b0:36e:535c:60b4 with SMTP id 5a478bee46e88-37256614231mr1905092eec.13.1794125196923;
        Sun, 08 Nov 2026 00:06:36 -0800 (PST)
Received: from [172.17.0.2] ([20.169.62.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372667d60absm3788292eec.26.2026.11.08.00.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 00:06:36 -0800 (PST)
Message-ID: <6af02d8c.ec2c7a27.33fbb6.60e7@mx.google.com>
Date: Sun, 08 Nov 2026 00:06:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4831150133879262668=="
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
To: linux-bluetooth@vger.kernel.org, turbine.bmw@gmail.com
Subject: RE: [BlueZ] mgmt-tester: Add LL Privacy tests for a device's changed IRK
In-Reply-To: <20261024004732.57922-1-turbine.bmw@gmail.com>
References: <20261024004732.57922-1-turbine.bmw@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4831150133879262668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ] mgmt-tester: Add LL Privacy tests for a device's changed IRK
   Pull Request: https://github.com/bluez/bluez/pull/2706
   Created:      2026-10-24 05:00:36+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============4831150133879262668==--
