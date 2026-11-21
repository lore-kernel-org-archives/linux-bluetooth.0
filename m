Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795281668;
	b=c8QpEJOubrp/LtHBOe9a6lipWP5ub6L1vi4+vybq8VKyAu2BCjZtPr22V1DIe3DVe0ok
	 8rUjyYNHwC+jFdfYrmlrbQ8nsG2AtXFJRl339DC2mJBG1hxtlwKDU6w9IhbHonO5xo+m+
	 iJApU9pBpXCv5lXutfrs3uvxbllYPZ6AjX2ibQEESNyOaWx+lYccPMFQowNSkb+0XHX/U
	 7Ud6aV021GAN3hg3PA4dsOWXfV0dh0dHcSBypaRu0sHJ43hl3Y1xnJiAhkREqRyE/i4aL
	 711+IwVSpsIEFm8n/X6Up2ferPJAeewGiJW4Fr0oXKlfGTHx/6ES0luvy55oHt3ZvXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795281668;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=12/zTFs+p0Al7CWjwAjo3YN2dYsPWIRen1THkNcuY38=;
	b=wE/hY5SG9iHNxRI4iTrxo/h+5ijKH0Nn8um+ME6tNYP5ln7ifzcXF1BomGlBIpQ/OBzz
	 bE6oKvs4StKQyi+Mh2963jKVZROdKrMYACrnvX/RClwuqxGtVaxDCSJIU52oSl1fmoebq
	 otxvtzjgA6g4fntvAenlEjIScED/ZihNFinc2i5gmb670MozDFi127XYkvc5hMFGHuzZl
	 c0XrUfojxUWvlubnSRUvNBqLAutLjeJNtoQsvbG+rvvWpnT2a9HrMRC/G9NQl33vyY9mj
	 kMjp+MVBbY2mcLO9bNw24U8SQqRdwKzUQgzX3sb8iBXtCvXXX46EuXtpmdgZdLG5CVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mXsJCHP5;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DE6606A330
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 17:21:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3DE6606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mXsJCHP5
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-14394530ec6so3001201c88.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 09:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795281667; x=1795886467; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=12/zTFs+p0Al7CWjwAjo3YN2dYsPWIRen1THkNcuY38=;
        b=mXsJCHP5yXQJ0vyrKtWrXmtsG+8BRM+nnRZb1QLIGFs1b/9IXKyMn8dDUmCq+2erq7
         bqUyPxaVUJCF/DW/vvOafM8mVKi/CFLXAPNzWPvQfxQ4HJPcuvVXnqOAqY3iPRkm25H3
         Hr8c9Bd/VazQSj2wwONUKe32kRMx3X4/0XGLOL7bFoqqyXn2nL8NjxOEZGveAauNOQlw
         oaIj5onMPRcIYt88V91X8X9kLOq1xfEnRWwoFux8yYs/KTrlu50qbZqpAZyJLi8KIaw7
         x147fT+AfB9caPo/BwiZDQOTYk22oVFbdRHFnKxeRJNgrpOz1xztBiGF7PQ0Bo8WwGPT
         7wJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795281667; x=1795886467;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=12/zTFs+p0Al7CWjwAjo3YN2dYsPWIRen1THkNcuY38=;
        b=yI6AotOSXjQcC6/uOyrfOHk53oxN5v/CZdf8IVqY06n/JYPHHZAhAt+DQqRGSSbTGV
         tLmrJB6zi7/UP4H8bP+pqbDQ/kw263rQ9hCgDiNCspy0hmGmh5kWD4QzWwviTdYkLRXy
         wg8IhsUD20zKv/giXeyqVhqeKEOv4zVqh9V7m/+hkqK9kPotm9quBbnNIm6ueI84E180
         QIHqZwCPzV/uuf0pf0j4UHgQoQhpPKcmfnCIjAN/ex79ny2LgkhHS9RIh0IcDOLwFf8v
         uv7XkmPXaBFuds7GoShLc5x6MlxWPZfNtfi1gwH4mW8ZBPFmw1RORl33BRZjHEIh0Y9t
         YU7w==
X-Gm-Message-State: APuU4Z8yJw43C8ubwOQLddLxnTErOPiz17G+t7kQZB0KbBHwOOJ5lOJU
	b6xgXa1hpQLZf0wzdol+Jm4nOCbSaaojIR3vOM6AlFdq998wB5z1XfLFj1DlAw==
X-Gm-Gg: AZFdTZd9y9y715u9xF5SGDQ1GyrGX6U3bgKndOahdWC2zJ2FQ8c/pJZ2CUu0ZP5uPv/
	mGwv+6UKQs8THkjyvQHpuO4Er4u+eEYm9vxeK1xsEjC5BWDOYymXEeOoaOT4NENJYts28fR7YYu
	Ry2kWfuYKcJWohyqIvHrlduK2PITvHaEDfjBTwYAw+muBenSNUgXxVSES2qTfAbKQIgZ3zVlk7W
	0TMmx5f2HM3el+07+EPaCXuaqb4N2oCv52ePz8nxbJmM97vstnxx8Y5Iyg1j0dVELBUpGva0sfz
	HuhxLJZ0n8fIl3wx5kltxGUXn1KVi4/4Muf8MRA8KxGbcKU/0BKbruTjVw34yaxicruVOTfjL6+
	ojZx8XSrWM3JcR31Rs6wUToPLXE1p8EUjz5bffrkDaCbW3OB/zWHISjkiV7TlBOi+oApL5H2u4I
	eynuRGmRxlhtjfjMLZxkBphG5bKJ4DN1Sg0bm5cmKl3v3CEZfxZqjdmBKlnAEMo71nZX7OxXqSB
	stFAzLKKr+NlrYAg2z9jjr5Et88qr64xdn+epwdh4oCOg3C9xVUgERDVm1WblU6dM9s0goYUVP1
	ikGM5sGx
X-Received: by 2002:a05:7022:45a7:b0:1a8:4997:65f6 with SMTP id a92af1059eb24-1b5568c7032mr9376804c88.20.1795281666640;
        Sat, 21 Nov 2026 09:21:06 -0800 (PST)
Received: from [172.17.0.2] ([68.220.61.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567da4f85sm21216938eec.27.2026.11.21.09.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 09:21:05 -0800 (PST)
Message-ID: <6b01d301.b52ed58b.231d93.5677@mx.google.com>
Date: Sat, 21 Nov 2026 09:21:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1802399044818161826=="
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
To: linux-bluetooth@vger.kernel.org, viennaoffh@gmail.com
Subject: RE: Bluetooth: hci_sync: invoke destroy callbacks outside lock
In-Reply-To: <20261121120121.576-1-viennaoffh@gmail.com>
References: <20261121120121.576-1-viennaoffh@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1802399044818161826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218076/

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.07 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      31.62 seconds
CheckAllWarning               PASS      35.35 seconds
CheckSparse                   PASS      39.02 seconds
BuildKernel32                 PASS      32.20 seconds
CheckKernelLLVM               PASS      35.33 seconds
TestRunnerSetup               PASS      767.08 seconds
TestRunner_l2cap-tester       PASS      14.71 seconds
TestRunner_iso-tester         PASS      13.21 seconds
TestRunner_bnep-tester        PASS      3.12 seconds
TestRunner_mgmt-tester        PASS      88.95 seconds
TestRunner_rfcomm-tester      PASS      4.48 seconds
TestRunner_sco-tester         PASS      5.60 seconds
TestRunner_ioctl-tester       PASS      4.59 seconds
TestRunner_mesh-tester        PASS      4.49 seconds
TestRunner_smp-tester         PASS      4.30 seconds
TestRunner_userchan-tester    PASS      3.18 seconds
TestRunner_6lowpan-tester     PASS      4.48 seconds
IncrementalBuild              PASS      29.72 seconds



https://github.com/bluez/bluetooth-next/pull/1176

---
Regards,
Linux Bluetooth


--===============1802399044818161826==--
