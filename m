Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793458134;
	b=EXWrRbLgYIfmiVciiZ6SxDyc30mqXyCbCI5NROxnjbuyBXHK8Iq+q0GlN+TsmF+dTEc2
	 hHVJfIRjtabgtcdftQF6JQJ69fJXd0XeGkqnq6vQybI6dYUrrdPmHbsAO1vCfhFjFqKK1
	 W97pQ5sKr1D2KuV8yRgL1J9MwJdkvX1UIdvE2h/KuhAy2G9PR4UOT/KzjsLk8gLsECEmI
	 L+YQPCexIZhcRmmzG26aJdkOyDewVp1B+V3GnYGuKCKusf0guMPmmkM9H1vqM6NHD8/AG
	 HvdGSZvU3YDJtYrHmGho1OghgXzv9ue4deR8mGvuOvezAeZ2y4EF75cTNESeOFM+nSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793458134;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=0IXr+rFPmvbBZJLCXCwuwCEBigbn+qBP3QFz0+hKg/w=;
	b=vOFbln7fyDkR7brXjGaRZOIWQKfxD+rpzp3s2dYQbdIqmqg8qhBdSLs6du2s/uAuAP8Z
	 beTbds8rqDbXJ51x9Zq53h/5K5DNeN+L4YMfkPAQj/g/8ijsxh9M+21EvwZQYKDKm86iR
	 Wddvf9VUsRZaM7iRqB5JQiP9CgOYtSo2siqfUxZu4IBQUB/1VQIttnTLPcBSFM2mNKGgD
	 B0dWqchG35ngoEvZ5xQtT27Ka9IQKMV4EgzRR8OPcrjOmHftc4wIuMUpNggeDTlMs3qWw
	 jG5ybpfy4cbDsztufeTFchP6fnKnj3ogWFQtt0yQJ3apKtnBQnNMGR7h+3FNf4UiS9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yz2Blw+6;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A77E606A31A
	for <linux-bluetooth@vger.kernel.org>; Sat, 31 Oct 2026 14:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A77E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yz2Blw+6
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6b19e291cc6so1618534eaf.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 31 Oct 2026 07:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793458133; x=1794062933; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0IXr+rFPmvbBZJLCXCwuwCEBigbn+qBP3QFz0+hKg/w=;
        b=Yz2Blw+6FdZZcNrCJ3mTgtdBIJyKzO4T89LYKlvNxWe/wJtAPskSMANGc7iPO2+Ens
         CCXPHMGRJT8pWrPRDWPyTAaB8Nv5L4nE7V4zU9Sjy4Drk1HepyzmLRpBlHLiH0wJYiHz
         h087GRtOUwcU35Nt+6kqy+yI3pDBKuH+6PZyJ2HApsqQIuyUb5mjOlgaa6qgsXjui/uT
         CPOw2p3sIrA3aMj4IKhqbME0//SXR+BKbKMeRClRlbmfXw7hqt52vZltLGkaLu5rZGvB
         I/VeiVkLa76BmAV+1B0RzRojNI1fykFH1t2cLl4R+wb1PqOzfJw4v3ICfQDmsxT2QuA3
         u3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793458133; x=1794062933;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0IXr+rFPmvbBZJLCXCwuwCEBigbn+qBP3QFz0+hKg/w=;
        b=0Q9j8h6aagF6+iPFyKIHY0krR4C8o+us4s6XbvuXHyl5UtgbeKnvaFvpeB5jXe+jS+
         sq2hLrRxKuevbCoxPdL5INGJuKTvjjIPj7XAsJoHhL1YhK48OHmtT2Fq99qbOx0VCzP+
         +Q1yKe6AIvis+WJv8PqCnaf8UvEbd/zT5541zydNAJaYICLjZLmLZxurDWBjG3ZfC45E
         Nd/T0DQa+WfWF74L5dfFdP12EGg81bYzLt6i7AI+t5PGhGNwXg8yCOWpDT3qdvOy1jLZ
         O/fx/TGiR3iZKy9q29cyoPNunIJXY35+e+tW4W0AoCK9jY0PKar4DDAcTZ5/Gy873brb
         4lsA==
X-Gm-Message-State: AFq9FYI5dFI7cOUDfHyv43TwmTgr1Q218BTkaTveyGRC0XLSAJsp5Y6W
	tjezpPobF51HOzbbNID5TPvyJIzuN0+6x3+wicWzeL7GkewXpvDHQv9/ZuaEuQ==
X-Gm-Gg: AYBFou1SuGELn9+CJw9tf8vXx+rQJH2vyfr8Cdgie+pgacvj/cN3hLtaCYHue1k9Ct1
	/oU3A6/Rwc8y7/6zBcLyluZo/A11X7iO3fk45C8+Y68aiyXgR4+RSp+yip1dB84BASOm89OVYhK
	U+SNQ2iLyNPZYflNu2CgvpVCoI6h2g7ONqLYdliPvBAkpBiM5kvJBMD1Kddc3Uv2YmdYwi8R0X2
	4bs6Y3In5Rdh9KeFbRu8LH2WA9QMHi6xpg/YOkqx6KqVIXNjUISZ+Ok15AQqEXjTUNdKZmI+ky4
	pziQ1QVDt8CEFOVMKw80IEaosjc8tD2fNmXIgoFpDA8FFpxoqGi+ILWXy9D+zTJ07cWOhmCpiVz
	lteC36gXJSQPAGrl0YDmVW+tKdgCycdmmXpcsJskbaGH180NvsNbjt8X32flM4Nesl0L+WzIlAH
	vTAoCMUlcD/TM0WMyUGGJvxdN/kmsZWJ4TUdmkYpSslPhBpf4hL/j2di4fNEf/w+lkLatwBxyjN
	kQRAkUNXjdonT/F1tr2fQs4h2lObe+EQIoWjvqtUaZxfGLCIasqIDSOo+nJk8iL
X-Received: by 2002:a05:6820:1387:b0:6f8:ab9c:344b with SMTP id 006d021491bc7-714f290e6d3mr3253386eaf.28.1793458132992;
        Sat, 31 Oct 2026 07:48:52 -0700 (PDT)
Received: from [172.17.0.2] ([20.118.239.194])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2a84854sm4598759eaf.2.2026.10.31.07.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 07:48:52 -0700 (PDT)
Message-ID: <6ae5ffd4.446579d6.2ea9b9.8941@mx.google.com>
Date: Sat, 31 Oct 2026 07:48:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1906092615162776128=="
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
Subject: RE: [v2] avdtp: Fix use-after-free in connection_lost
In-Reply-To: <20261016071408.2961576-1-jinwang.li@oss.qualcomm.com>
References: <20261016071408.2961576-1-jinwang.li@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1906092615162776128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [v2] avdtp: Fix use-after-free in connection_lost
   Pull Request: https://github.com/bluez/bluez/pull/2685
   Created:      2026-10-16 10:33:05+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============1906092615162776128==--
