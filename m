Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F40DF52
	for <linux-bluetooth@vger.kernel.org>; Sun, 24 Dec 2023 20:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vx3gxJPX"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-67f7aa55bfeso27189686d6.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Dec 2023 12:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703450229; x=1704055029; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D1rYrvTGEbl4/43foHdCoX5tA1+o5e4qF+uDZzLXAS8=;
        b=Vx3gxJPXzI3EBrfBhdR/v5QRH4sODu4V4FQKlbEJPor/nQ1MgkExCAeyOo6fk9qbQA
         OUyg+cxpaB72ZgdhpHjy06kjHyDw8pJMh5aApg4QI3nI4HxmwL5YWL0n6zr1qLEgriNL
         o4McCJnraKl5mAtPp03+FbTZMlrGppnoJI7tPVmasTFZru6/jxza9ZNRoM5ygTaEH6dM
         x2ZSLLO8U+LDSh6XilnldiDwBPtNoO4t2S1VI5DHIHlgUXkk+WWpXj2LtxpzOeUkNYXz
         IMwVHoHBecMleoxuiGFSAfiVcQaWl1JBhsG/VLSg6p9iDl49WQ9nNYV2PG1MNvYWznY2
         HfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703450229; x=1704055029;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D1rYrvTGEbl4/43foHdCoX5tA1+o5e4qF+uDZzLXAS8=;
        b=ac9Ik2A8ug/8R5I5pbkjKL3arJUe2FVDFEx5dVcl1ubqKwwdb4J5Tux2oToLv67K2Y
         6e9iRbcIDJf2BJt+497YvKMFmP+iPt5XT8j9LAdEtuH82ioHmGu9TJ7O+jZY2emV48m8
         QUdAUjqK7ochGaj1gKlqVt8sUk8as9GtNOEYjQY0UkQ1FxsoOsiDZJ/u+jPLgZfYG42/
         Oqs7DCaaN3bFnREDATIK6Ehq5niu8J95xmhUIrmOeaDeHUkiZL+G/7gJrNexpD0naQns
         z3tPJCnhKT0hd82UoZ9EkHH7CL6RhNT3KSlnjk+W4uLsikNrEUqvNZONUygJPfRgtx/X
         +S3Q==
X-Gm-Message-State: AOJu0YwHLTyq1vQuIcafeMtDI2Jsx6RfnL5U/Tn3q2HPSrvyCHr/wYmE
	BMhpAQbwoLHffysn2iO2oxRnp3DRhjM=
X-Google-Smtp-Source: AGHT+IGc50P6oeFBO72M8EQEho5SzMh9Qsq4iA6okqxAyfB9X78qe/nXRVxgQImoJuVyIpBhKB3wHw==
X-Received: by 2002:ad4:5d4d:0:b0:67f:911e:8c67 with SMTP id jk13-20020ad45d4d000000b0067f911e8c67mr8173093qvb.38.1703450229240;
        Sun, 24 Dec 2023 12:37:09 -0800 (PST)
Received: from [172.17.0.2] ([172.183.107.241])
        by smtp.gmail.com with ESMTPSA id u10-20020ae9c00a000000b007759a81d88esm2981935qkk.50.2023.12.24.12.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 12:37:08 -0800 (PST)
Message-ID: <65889674.e90a0220.9c5b.c666@mx.google.com>
Date: Sun, 24 Dec 2023 12:37:08 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1262195309099287913=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mrman@mrman314.tech
Subject: RE: Bluetooth: Fix Bluetooth for BCM4377 on T2 Intel MacBooks
In-Reply-To: <c9dd2a5e99e032dc181344fd0359aac9@mrman314.tech>
References: <c9dd2a5e99e032dc181344fd0359aac9@mrman314.tech>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1262195309099287913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch fragment without header at line 6: @@ -2465,6 +2467,7 @@ static const struct bcm4377_hw 
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1262195309099287913==--
