Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87618342504
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766158024; cv=none; b=TduShtycSmnvPhuvdDSyLP3SuhyixButN31QsySxp3kJqMSz5dIsyiYbZ425TOH/JCifYRJD8/JhKewrDUNiXv5urzfnqoxGz7G69FoVDIYw4GvTDqOeitgJqTyhR7S36NbMEGnMhJEJGQUPC2IjuYhltiTlqF1rgARLsEUfKWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766158024; c=relaxed/simple;
	bh=jlob5DmC65deZcZargQ4UUU79ZgMGoXgZ7z1MKP7z3Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aI3zNDkCbwIdbX8ltdcyZ8bxiNzLBUmPu+DdCRSq1RfDcjG3xXAjttHKt03Gq19nDNoauKjFZFHyT4ie/4k0k91pSvzo8hff7qQkKk5YquyrhQPk2YUpWmwBzBa2nwAzQCvjnJOdhyKmWCBuoTXsEmGRRmWth2jJ4eiXUtDNMco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6X7nuB5; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6X7nuB5"
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7cac9225485so1579378a34.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 07:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766158021; x=1766762821; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CQHZ0UamiZaG/18KaEM58iIwEhCnfO04AnVXIQ5PQzA=;
        b=S6X7nuB5I4P8FfThZMSCIB+Tdp2dWHHtZhrBIfyEAZiVnFjirkDZtb3yJTNK/FoVgV
         sE9Ta/hws6RrU/eP6WmCTuR6tgusMhPDhoZl9FxgqQVqvDlbPfi8VayAWD/BPINnxUK0
         3R4Vu9cn4s/61RrKMFiazURtymUvkWeaeM2IdszECDFWIeUeJr754V5xkRGxNdMdwCbO
         6DSdGBTV+i9EfhgOtGUz5GHO30/cCEsVZ8sbsAb6leKv9zkbl3oiGoMgw2Rsj/TKn4yl
         lIjtGvbc3Q4XFRpzWs6uZR6Jum1WQRoglke2r+KHJKi0BR8WKKAhq0Rbj6JwW3z62nKN
         Apow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766158021; x=1766762821;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQHZ0UamiZaG/18KaEM58iIwEhCnfO04AnVXIQ5PQzA=;
        b=Fqd0TeUYJ3oM18J3MC2+K3alUnVSiIxxbS9s2nJcjeSJtMhJTFMxTNlPP5PqxqVzB8
         HV5+9pISeT8CRvB5iOMd2T4BMuh0bqTPuYMN7M+X6EZtn0d5UE+PbWq9y4h4XYxMdsjR
         PgXMgzdabRD5RINX5GVkKqtr3xRIDVIHQ4cCZrtz54OYJPNLX9bk9xYvh1AsdfuWI9PS
         glUN6EoAQ9xwJRq7aSzNN8pY3DQk1g0TSp3R+KML1e+DBk9/AKkgz90GdfupPb0N0q6o
         QEM+y5r0wsuJbVNxUbjx7xSrZ+fnh2VcH3dIie0RNdJ7g/vh10bHzE0HKrEgSOBm7sYF
         60dQ==
X-Gm-Message-State: AOJu0YyVTUqZBIv1a7HEu8g4gh8WHUmxht/4crlJkBKv84Z9yspD+AVi
	J7PKM/hEUc8+0eZhQH4n9CzvzE8+SZ/raCxgVbGRIaXdS5JfvfyYgsbXIky7XQfx
X-Gm-Gg: AY/fxX7uYjuf71rjMDk4KxKPJR/kYgz5b8o9A60F0Oh/37AnGZxhp2l5cGaohQvjFM5
	6koZkRXehtGEaAdfQSKYAfmTc5ZAoMWDXTR2FGeN8JTxipHZZo4E8b3zyChU9dQvKbtNfmmvoNE
	IBPp1QvWt8dCnSDvfxo+dNja0KL/+k9ZqOAOuUalkFL4fW16z3L33u7TqU1mFWZmklE6Ablwu1D
	m7v3Cn4qBuxi+JuF+W5hlM3q3tl5VqUnLzr4mI/JbSEKVZ9zA7oZtJAdmLUxI7+9euT+P4Nt0WC
	pM/M2ogrFLphlR0rIOX6XI1L8b0A03nZC0D+85yJsSeSU0gQOvJ9XAMYdVNbeIwzvKRFo8lfArW
	ZndiOVkWv90fpqlTEC0uhhfJ9tcZmEWFAlQc95tVIAB3ggLiet2OkoM9Hlt3Idrvtt958aZSGYV
	I+4ZG2CZV++lJ6Pe7vVZN6Vnxcr+M=
X-Google-Smtp-Source: AGHT+IGGNukaJi//YfE6t0FaOuWnOvPgjKGQlUQJkC9JtkXJ92JOjUokvbLgRcbgOepDAEONT9U+Cw==
X-Received: by 2002:a05:6830:380a:b0:7c7:5991:3c7b with SMTP id 46e09a7af769-7cc66a959a0mr1489067a34.30.1766158021090;
        Fri, 19 Dec 2025 07:27:01 -0800 (PST)
Received: from [172.17.0.2] ([132.196.32.69])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc66727e11sm1849296a34.3.2025.12.19.07.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 07:27:00 -0800 (PST)
Message-ID: <69456ec4.050a0220.23ebea.611a@mx.google.com>
Date: Fri, 19 Dec 2025 07:27:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============9094967585272570645=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v2,1/3] audio/hfp-hf: Add Operator name support
In-Reply-To: <20251219142902.559714-1-frederic.danis@collabora.com>
References: <20251219142902.559714-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9094967585272570645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1035059

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.28 seconds
BuildEll                      PASS      20.59 seconds
BluezMake                     PASS      646.53 seconds
MakeCheck                     PASS      22.11 seconds
MakeDistcheck                 PASS      251.50 seconds
CheckValgrind                 PASS      313.96 seconds
CheckSmatch                   PASS      361.59 seconds
bluezmakeextell               PASS      189.73 seconds
IncrementalBuild              PENDING   0.28 seconds
ScanBuild                     PASS      1101.53 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============9094967585272570645==--
