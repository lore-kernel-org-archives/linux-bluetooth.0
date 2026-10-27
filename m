Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114424;
	b=zYJP8C1Tw+v8oNBZFLX/5iw6bBtjjnWfcXIJyQrBRC1DZDR+mI+jjPvZ0KleRuYuvrMW
	 qOtTjBrwqZB8Sl07UoH/2SkaKFd8en23+tTS58LNiuurI+Spz3JJovQU94+9nGFmMsA90
	 btCrw29cxfj7q/ZjiZAnYmY7dr0tFUcbPJzNKyXDLwl/sK7HIe0QCHxW4sZtACeV/Zs7n
	 5xn9k9Tl5RhmXZYpFvt6THchAX460dalUEBh+svBsfLSq8d5pVYJaTsttI67Uvf2odrR0
	 kvGP6izrLKV9N9CPQpd9Em8dflIKgE6ZaLa81vP57HmfbACmkLvvtUXd1e3Yzm6a8rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114424;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=G9ZyuEx9UOhHpT8baQk7amWNl5zAXaZfB3JdjqLb6pQ=;
	b=tJhRxYIhAACPuoHXJtf249YlW/RVpbQwOgFFEJpyKWFJFw59Eoe1qQ1upUyCmBHypRUk
	 aICPmcbJM6K7drVc3oJ/ABDpuSFbJQr7P1eMgnnvTzAt1STu9Ca/tpSV4Z8nqwJ8tgyqe
	 s0YCXxU8UZrw/Zy+rDMohf3Y2xxhaeDLbg84JsAcjYxHONt3v9bdx5Te8kU90sXd0hdOR
	 IiAeuMkbeTIl8kl4GnJOOP0I0Kfg3G8HOWtns4NIsai/bs7YVoUGR0anJel5WHDG6/fIO
	 VphNaH/HCkfXFB0e4JJeVS0gEMZJgeaj7gxBCQfEcfdc2OIYWbSvDjzWLiSP7Kbz18g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WFLmq4gk;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD995606A336
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 15:20:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD995606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WFLmq4gk
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91b89c6caffso1146d6.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Oct 2026 08:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793114423; x=1793719223; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G9ZyuEx9UOhHpT8baQk7amWNl5zAXaZfB3JdjqLb6pQ=;
        b=WFLmq4gkpZeqyaYwzsOPqCJLU5LHd7IBxtogf6qKoek6aGwsCzWTksZuBl6npZY3pk
         ic5lgLL63Qqo8YYdO2ABKLts8J4meZEd/L6z7stGmI1erk+imXd7koYlTOCEO61OddVu
         RuYJMXAE6nOicC3BDVhrDPP4wnMEvrnzOSYVbb1bT9G4xZbXon3erKlplI9Ah1GO7WtF
         2T4M9BqSLB/qFR5GQMzy6bD2MR1W2NvWGpKqhmQdaNhuAcIeArp4/0sEaL6CfiySBPp8
         AO/K4A8E6AwVEzbgVywcdmAWauwPx7NQ57Sp0MHoFbePzZZcDIH8DKxA2qkbvez99oF1
         tqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793114423; x=1793719223;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G9ZyuEx9UOhHpT8baQk7amWNl5zAXaZfB3JdjqLb6pQ=;
        b=QA3V4mEyRwwSM7UFMA0cyUrzc+4Y0zQym8ZPT98QGRosoyTo87KaIV7gM4NcYiyTHh
         3zAElkTtbAZ6iAQXtq1afsAti8SHi40ZFGgIsO9BhFCo51Oob1BFlhMC+WAjj5Q7GVj2
         LbZJxPtafTr2yvtuGLDb4PCdZ66j1Ks0J0U0Dm2kXUuwl9ehQ5h9bsFJBseH1MVyT7z8
         n3JTEsdb/VKOf3j4PRHQQKqBc3jDe+DoafEqGtZaiWNU6YblCp96J4fwXh3pEjB8a8N+
         4j0IViOLurfjyfCP/oD12qXuUPNllYq8+9RDUjd+anGwwbvknEZZtXAZTZxK5ZqSvY8Y
         nF4A==
X-Gm-Message-State: AFq9FYI0GVX/2VtdrXmhqKhPHnRDtUvVL88WXpBGGsvuZYl6Gea76ptr
	pLgqMr800qrxkQCUDzBTo2CJudIzuI6uI9bIfRjZyq0cXrmvfCODPc8KyN4JWw==
X-Gm-Gg: AYBFou3H8fyvXZnEmytQDXqNC/24NHpU/Vf0Xv+rVeueIGYjysdQnP71YPwZ7lQ7JA6
	mG9Kqo85OoqfPi5K23HFWYYpiqV8yIvQKfTTx7ppl4n1BqpIJNjYKdDSzZNsHc357iAp+0M1qo4
	fUxp6xLYcSsd1HsammRupHyov4rG/mfSoIcrpfuk2e2dsaEeunzP7g0fH275hTinhdSqvxnbOo2
	CvA2raPxkw1RMv2hzBRk3ky01t5gCmv/Sm+HGWeAM7Sc1HA5N8IoCvdx2FcTvnjfFCWMiokmajQ
	gi/arLuTe+GfeayA7BhrbR5HOOlLvZRl9ZZ+0Gk90aTau2nBEEw8puRP6GpB3MWIklys8CpqyGw
	az8sxGhhyiZmMPxmL2nU+c5Y5pfDrJbYnlck6XUcTGdfuA7G2sXNNyOsLDoaXmwBe0Ih/S0b0kg
	oLGDMAh+MOABJrfY2x7eUjUFsktQTooZeOsvaxZDsxUUG5ySNb70LYRhhNRYKH+EJMgdG2KoMGZ
	O4ueaH9FOlS9OzybmlfyVgKd+PeYjP1jaXY0vMgqksW0bjcROut6MKoqFXxPzs7
X-Received: by 2002:a05:6214:1c44:b0:91c:73fc:a5a8 with SMTP id 6a1803df08f44-91c73fca697mr28600936d6.9.1793114422369;
        Tue, 27 Oct 2026 08:20:22 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.47.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47bd01cdsm104264436d6.7.2026.10.27.08.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 08:20:21 -0700 (PDT)
Message-ID: <6ae0c135.399bf8e8.2794b0.1f48@mx.google.com>
Date: Tue, 27 Oct 2026 08:20:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6353656587981502312=="
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
Subject: RE: [BlueZ,v1,1/2] ranging: Issue CS Security Enable based on the ACL role
In-Reply-To: <20261027140953.1854740-1-luiz.dentz@gmail.com>
References: <20261027140953.1854740-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6353656587981502312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1194674/

---Test result---

Test Summary:
CheckPatch                    PASS      1.11 seconds
GitLint                       PASS      0.69 seconds
BuildEll                      PASS      19.68 seconds
BluezMake                     PASS      304.29 seconds
CheckSmatch                   PASS      297.45 seconds
bluezmakeextell               PASS      95.34 seconds
TestFunctional                PASS      1130.04 seconds
IncrementalBuild              PASS      302.83 seconds
ScanBuild                     PASS      1160.14 seconds



https://github.com/bluez/bluez/pull/2721

---
Regards,
Linux Bluetooth


--===============6353656587981502312==--
