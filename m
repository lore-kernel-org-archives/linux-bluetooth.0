Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26DB1E890
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Aug 2024 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723410310; cv=none; b=PQkXAQDjz0Ls7ZEIK03+ITyBex4P0VZsQAZTRDS73M7GMCwwf4TWwgXWJa272a/KAlkD+ormU1v2z4ie1TjolxnYUMknnIuuF4kZdE1sd9tUwC745lnu+dIKibKYr0Wlj9++jmMFoFCou7uBN0P8pdPnZ5RZ+neQrn6hrfAGK8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723410310; c=relaxed/simple;
	bh=x4zqCiFjd8JEpMTAj50pU8Fbdw+7zStSFThvmIlpBA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXlp4Gft1r6cl2Or2++oY/7/wluoYXx9OIwqPyITAVSB9+1gvpcltaUR08b0yRbr8IanNsfaVG050EPIb2tAdQjPZGAc7yneyESzll82fv/31lpCeOmA/x3S30L2Ubsy8IgKmapajbPsWZje3Q7YelQC+GFkk3PFRbk0+ZvT6Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjoGIt/4; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjoGIt/4"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7ac469e4c4so597870766b.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Aug 2024 14:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723410307; x=1724015107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UL5D99O0OLyrDJ7cZQ2e87U1TZUu8UC6T/hwhu71104=;
        b=kjoGIt/4jzkcLN6jpgYRc6bZG5QPmWBIL+3cshjZZxEPwF6bRW+DUBVCFQjBzYQLY1
         OFebNVtkXD1yyDFwIP7kzDx2vO3y95UHzA+NeZ34oanGhjctXtUqwjvFShMNq3dTpJk3
         0TcUxaQR21T03hOVwmyuERbq2cnR8Nu+aNGZL3qzkyXeDH7DXYVA5ah5ZFhh2xfjyM4R
         ZnSAVzJUIzIWW8nZTfGot9rkPmdfk+mie2w3b3LHYqHdew6QRrg9jGPZKqkvLYO+/a4V
         rfqh0WT5fNCF989cCVLPAHfEJOlpBQoCX6MsgHJjzpDyWJCDEO2H4+1zTgnfiIg2zGVN
         I6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723410307; x=1724015107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UL5D99O0OLyrDJ7cZQ2e87U1TZUu8UC6T/hwhu71104=;
        b=vIOvVmgZVaosMSJ5Y5VaZOaCBJBZr2T76z75lBGKnq+26YZNC3NYVlxLN9aAghDIBK
         155uaXVrxcQDHPYvcQBk/JogOz2eEEYajGhbKkuLn969T7EY6/IZOztVG+FwYY0el3Nt
         QoyEAfFh8hAo+Vh/o36h3i8Bi5ibWBHS5t6jsMmKX9JZyR5k0zUX06dBvrcc7HcI/hu4
         UkbaODyGJj+vlDZkDF0P0GJa45eVJJiDIErVVNveKl+WRKaBDZYTrQhcZZvnwKYa2USp
         NJJz2x/Z2Gk7GltyeowU1mQxm1wMUdt0AaBGb9Dqcws0Ek6FQ5XNAXrM7emtOots2Ec2
         pVQw==
X-Forwarded-Encrypted: i=1; AJvYcCVR+IR3VQViWJTRPJLxCBzA9mteErtWOKDKMdqH15tAyipjSZhT7bGHu9ifiv/31+yIqkJ4y9N299d/IG7S6T17QD5QkfsTLGj1Fp1Mwrv0
X-Gm-Message-State: AOJu0YxH86wIvECHjJfTntmN0608o/NdU8IVoXMJleQJN5WIO34qOju9
	eny9OKHIRZ4wzJv/DECSAuqTvS5b3CiEauq1k+54gU6a/W8wgobr
X-Google-Smtp-Source: AGHT+IHN5HHu8h6w/Ia0Ve2BPF+zaCDU/w+cy7O7mxVoVgr/izxWKMHozXPv4HsG9MGNZDH189yeVQ==
X-Received: by 2002:a17:906:ee8d:b0:a7d:ab62:c317 with SMTP id a640c23a62f3a-a809207e2fcmr1021072066b.30.1723410306753;
        Sun, 11 Aug 2024 14:05:06 -0700 (PDT)
Received: from x1cx.uhrm.ch ([2a02:168:4f3f:7:4b00:1bb0:11f:418d])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a80bb08fe90sm173095266b.27.2024.08.11.14.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 14:05:06 -0700 (PDT)
From: Markus Uhr <uhrmar@gmail.com>
To: raul.cheleguini@gmail.com
Cc: johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org
Subject: Re: [PATCH v2] Bluetooth: Add new quirk for broken extended create connection for ATS2851
Date: Sun, 11 Aug 2024 23:05:05 +0200
Message-ID: <20240811210505.3089013-1-uhrmar@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20230425163120.1059724-1-raul.cheleguini@gmail.com>
References: <20230425163120.1059724-1-raul.cheleguini@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 25 Apr 2023 13:31:20 -0300
Raul Cheleguini <raul.cheleguini@gmail.com> wrote:

> The controller based on ATS2851 advertises support for the "LE
> Extended Create Connection" command, but it does not actually
> implement it. This issue is blocking the pairing process from
> beginning.
> 
> To resolve this, add the quirk HCI_QUIRK_BROKEN_EXT_CREATE_CONN.
> This will avoid the unsupported command and instead send a regular "LE
> Create Connection" command.

I'm interested in getting this patch merged. Was this just forgotten, or
is there still work to be done before it can be merged?

Best regards,
Markus Uhr
