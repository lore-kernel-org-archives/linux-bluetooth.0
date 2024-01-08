Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2805F2EB12
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jan 2024 23:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFCaZTmM"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso1823411a12.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jan 2024 15:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704755585; x=1705360385; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dA1LlVcElJ+6skV07iOOGkwgYrV00Mmu2mijbtB9ADc=;
        b=gFCaZTmM52ZAASqvl0vNEo0aKeaE9NN6vzc51RWjXnFx/No/opgMspyy931UBm0J0u
         ANOxWEKEBswSyDJheBQ1pqTSMbsByDPycqnQajolrnwibLqIQZv5O8BIFSv2WLna/WK4
         oTY+8SbYnvtKzYXPRyo+w/6aCI8HVrvxyDOLbwCJ4ljfNs1E7aRvXdU8gK5Tj0M5gmI3
         iYpzcWq9SDaScEUSJzQD2KvVqAQg16a7sUIgX/zDpiKpeOKgEbMNRvw0Y3oZhmOvVD66
         ovb+g/V7MTZ7ZIaxIkpKch8fpvdxBhjTuyArBxtvVrZxNiPIrLD1liFeZl3f43BpJRrM
         cL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704755585; x=1705360385;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dA1LlVcElJ+6skV07iOOGkwgYrV00Mmu2mijbtB9ADc=;
        b=LBoKDrVuacAD3eL4/nKmaKMweqLcn40+t052tVN8e1/TFg2KNUiGWPquHhkq2kQyGv
         5THH6wt/qoiH0RG+IorWQPgUV5pgXlnx3o5kMYJvpf803ZmZ7UL0tdYOQia3Cdk+UFK7
         WAlTwxSlrwn6Ef9fm3WWC+ptvR5MY06uqZeJsoK/5gm7AYFZKYCMnyV9g0OuMubKURKb
         FUqhbTdaBZkN8cwJRgToqJl+jQqcDijpxevSFFcEQ+T8kpxQyotWYggISCYDOEg1FedK
         ojrD7lFNva+NCelQhYOvaX3+HPj/dFkLhkWFoGhcRTjgsTmg9TWM3ysAWvJdXTzB9v45
         uCqw==
X-Gm-Message-State: AOJu0YzJEg0ar+Ne+oj5FSP8hdgnMCoNbTowv6xIiqS/7qTQwlzkkqmR
	rjZeTUsvgLyoF2tTahQWzU74kBcLydI=
X-Google-Smtp-Source: AGHT+IEyUFEh4bCHaVH1e5eGR7M9hDUZ+McVV4Dmj7Oc6nMh1KB55JBSu61WNFRzcovsqD1FKmQGqg==
X-Received: by 2002:a05:6a20:3a84:b0:199:9a0b:ab2f with SMTP id d4-20020a056a203a8400b001999a0bab2fmr3424283pzh.4.1704755585002;
        Mon, 08 Jan 2024 15:13:05 -0800 (PST)
Received: from [172.17.0.2] ([20.172.5.211])
        by smtp.gmail.com with ESMTPSA id v66-20020a626145000000b006d9ac70682bsm409574pfb.167.2024.01.08.15.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 15:13:04 -0800 (PST)
Message-ID: <659c8180.620a0220.1d787.323c@mx.google.com>
Date: Mon, 08 Jan 2024 15:13:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1936266157436193971=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, verdre@v0yd.nl
Subject: RE: Bluetooth: Improve retrying of connection attempts
In-Reply-To: <20240108224614.56900-2-verdre@v0yd.nl>
References: <20240108224614.56900-2-verdre@v0yd.nl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1936266157436193971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: include/net/bluetooth/hci.h:437
error: include/net/bluetooth/hci.h: patch does not apply
error: patch failed: net/bluetooth/hci_conn.c:178
error: net/bluetooth/hci_conn.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1936266157436193971==--
