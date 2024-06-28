Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2387A1E53A
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719585701; cv=none; b=QnRtkweCBugRMyrN/ayYQ15g1C2ndMOPUeJsJ3kfF+kbJUbFwS/tyoTOEj5bFJ6SaIG/mwN6w6eFXdZj+b4doBEhZ669O5epH1+ah9b1VXJ2udSFKp8lZzny5NkjroRHNetPkxjDP+tNhnNzKVLGEQUpuIt3Tdg+PGas3a5p4V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719585701; c=relaxed/simple;
	bh=sLaoCajtZwRzqSc4ww4uYZB7/esh+yQ8rYNuY+kFlhk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=A2x45SO6L1jnU5YkvPnnLhE5uY3lX+Ta8jJtE2OQpB1KQKuJj0yRuwMTPbvokMLnNakCu2PTkYMji55S4tgb8V1dzFeu5nooGJEKTplnYRhm8+QZpA0gSTEp2HV2HJoVF8BgmAmEozweIROdQq9DhsbZ2YmQ/KxQaawOaOvbj4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lsmP/Nv1; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsmP/Nv1"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-48f3f874f49so231775137.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jun 2024 07:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719585699; x=1720190499; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LoQMUZ8eTdvHXNaRGWSMQSNbvp119pUhjjerTBuf4mw=;
        b=lsmP/Nv1coQx86tCWrpNXjOsWSEVTTjP8OB8j3hjViNZ3xow/ASJPrkcYYDSwjLyef
         i9Uk3lRR1pG7ikVlCspgFPgBO4+FXxrkclbYajTvS0BxKLb7RKdF5MVjKjSrKsCL5Ywf
         P6SLzNyKI1pFt+muCcqsVDijkTBIgLK3nL9Q/swSX9HaD2PdF6hhxA+RnhUbIxVZ+CgB
         le0B70+CESIbNDIfIAiPjfHQ9NXSIKpYD6o4e43y5KR2Qlu63+iZg8junyVtrM2X6+pS
         G2m8OPinVwBHJXRGOtrqD2DntQviCD6wZwXEsCj6PemfvMhlP33MF47DyvSc23BEVor/
         pXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719585699; x=1720190499;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LoQMUZ8eTdvHXNaRGWSMQSNbvp119pUhjjerTBuf4mw=;
        b=Xc7joAvf/z5J9gRqZgd+N2nOOc/0iMgRhQOexzMtHx94yrEA4GA91diooaPgV5Mnae
         BW3xXpUeFDs8s71otZZZsUbcTMQuZd8YbbMJqs+ZtnEl7LHFi+QdURa4qvfSuHKzsysn
         q3OKEDS0u8Yt1azCdkNQL+RDJ5RFY83WLU49Ay8IQHsrpKWJHK7PHJOPd0y1BsBwCh4G
         k1TWKfaDU9cJu3dY3PBvnZDgYH9A9uZJC2IcNkglgj6zoeQ+XbyyCvt0N8AZPb7Hfsgn
         iJ8DcX3zH5FlyXbtIv/m0LjtnI6RiXpItqCsoNWK2YMot+ZYIhKI4KO71nYOO5Rd6cFs
         +xoQ==
X-Gm-Message-State: AOJu0YwNNWX5zC9jwRtxvEVGcOls/SB7wx9rZAKw6TxwnY85fz8VKTsz
	xYci7hwk0qS6LfGOTOnylAm9k4d2F3rdrbuxHI2rSFQWo+JNJkmqr0tBPA==
X-Google-Smtp-Source: AGHT+IEUq9ivHEBuw80cgQQqN94tnweTV5PW9AFf0bz4F8e96TB+CXnQi59o5OWb1fJJTo46yyWhSw==
X-Received: by 2002:a05:6102:501:b0:48f:a75a:278c with SMTP id ada2fe7eead31-48fa75a2ebbmr104222137.27.1719585698806;
        Fri, 28 Jun 2024 07:41:38 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.159.20])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d69260129sm78485985a.18.2024.06.28.07.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 07:41:38 -0700 (PDT)
Message-ID: <667ecba2.050a0220.1bfd5.3c5c@mx.google.com>
Date: Fri, 28 Jun 2024 07:41:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6005710551266931759=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: [BlueZ,v1] l2test: replace sprintf() with snprintf() in recv_mode()
In-Reply-To: <20240628130142.549979-1-r.smirnov@omp.ru>
References: <20240628130142.549979-1-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6005710551266931759==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=866579

---Test result---

Test Summary:
CheckPatch                    PASS      0.43 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      24.84 seconds
BluezMake                     PASS      1701.86 seconds
MakeCheck                     PASS      12.81 seconds
MakeDistcheck                 PASS      178.71 seconds
CheckValgrind                 PASS      253.05 seconds
CheckSmatch                   PASS      354.23 seconds
bluezmakeextell               PASS      120.52 seconds
IncrementalBuild              PASS      1433.99 seconds
ScanBuild                     PASS      1002.24 seconds



---
Regards,
Linux Bluetooth


--===============6005710551266931759==--
