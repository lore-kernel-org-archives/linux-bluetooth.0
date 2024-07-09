Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667B51B86E8
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2024 18:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720548235; cv=none; b=ein6wVvw6wj3CkSiALOdvqy/dviIBnbd2vO3Psddy7UZkzD14nUGA+eD7qgkkLn50qGeyRQnV1P9jAbZW+b7l8FbUyogFcAqLTOr0PnlMsEOMsQDZvYaeuXaWM56oc0HqK/QbHSETuOs8MIXTGCjPAYb3joX3qniZ4gMqKGQXFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720548235; c=relaxed/simple;
	bh=laBmacV5zGVRAo8w/Copc7Kyh01xYchpEk09X0TUBqE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RRiCpndm/RtNUDXIPuD8dxJrfUitiKKYk/QtWL/cQZg4G5gLHGhuh+bMrGfi/yhIsFIayHEw6xzHJ0pgqazLyvPZivhxQQGgfgWA1zz0+vhcIGlvntDgIBIdhQcZEDfQjtKM4dztuqh+fVBKEWn8n69HABVNvbhh3Y6P02J59bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rtyyr18j; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rtyyr18j"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2bfdae7997aso3319739a91.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jul 2024 11:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720548233; x=1721153033; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bdr1AC1mB6EZc9YWRAJeR/Qsv2HAwq+Gjdc4z592inY=;
        b=Rtyyr18j5HoPpRk6t1eSPj1BZpfsHVuvjw26C1qojqq533lq6E4Vum8TqWcPxRfsgd
         LiziafQquXr3LI0Igq8VIYFhpjcalgmyljmz1i8xOCLiy1FMN4UdofAc9AFgsPSL+zeC
         o5DkHh2rTnbav6I6VFHz2fuLG80fgttHvA0UaVHMhihXJ8D0hl10QNTNz+qlAYpvmVu0
         Wha5enPjw/P9GMjUX8ev5rRC2e8J/98eoGiIBvbL3pxzaW0TV2NBFI0rppwvnY59oxU6
         piMGrrvt1ucYpdFrGk1j7QoVJ40mzZkpImuJM6nNoFFcNLT7TV9eARsxu21aFGRqZYVM
         PUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720548233; x=1721153033;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bdr1AC1mB6EZc9YWRAJeR/Qsv2HAwq+Gjdc4z592inY=;
        b=m6S5cuap7ZVpYF5cQuRRK9Wm0sBjl8kjPzTiJ/hhXNuWr9jKp8eKyETOxoGhS9EF+n
         UjMk1GvOh4SEdvrwH9LUWjDezn9NKEKh7t+V7T3VyAyG0+7pT4MefTkqTX3Dy1w262RW
         WXSup3np7reUFh5HJ6vBjsBN4ZBi3uS3serlwoOFyE3hvnfjWg00KKktw86/8FuRhu+R
         f6xYxOjMS/MIv71/CSLsAre3/OcQeAi972dCmx6oJ957XBUIrFbuYIb25PlTLxoqK/3X
         0v3OE+h2wOKDaiZIzVdYG3xqlgoY+lZiMWWdOc3RWiBeB5+Goll77biJKI6S95WSyUMy
         Afwg==
X-Gm-Message-State: AOJu0Yw6dYKsbaKdTXL8cPD2df7AxVerrugVQkx8EhgvKICLrAl4OZXC
	dpttKO+eHQt+pMTLBBVnGVrqJi3eOV2L8CBGy/nb3n0UTrG+N/NX9zCKjA==
X-Google-Smtp-Source: AGHT+IExx60kaXyMCgwLoBpAFgIswYYj3wNsBeSUUBqFN2+hkCCcxH2EUvkmwwasv7Se8yUR7AKYhw==
X-Received: by 2002:a17:90a:d24f:b0:2c9:8c34:9754 with SMTP id 98e67ed59e1d1-2ca35c7be35mr2875038a91.21.1720548233199;
        Tue, 09 Jul 2024 11:03:53 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.5.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ca353cc6cfsm2222972a91.54.2024.07.09.11.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 11:03:52 -0700 (PDT)
Message-ID: <668d7b88.170a0220.b3e0a.cf27@mx.google.com>
Date: Tue, 09 Jul 2024 11:03:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7888894521532163339=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, r.smirnov@omp.ru
Subject: RE: fix errors found by SVACE static analyzer #3
In-Reply-To: <20240709143503.12142-2-r.smirnov@omp.ru>
References: <20240709143503.12142-2-r.smirnov@omp.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7888894521532163339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=869742

---Test result---

Test Summary:
CheckPatch                    PASS      1.32 seconds
GitLint                       PASS      1.88 seconds
BuildEll                      PASS      25.18 seconds
BluezMake                     PASS      1713.50 seconds
MakeCheck                     PASS      13.36 seconds
MakeDistcheck                 PASS      180.35 seconds
CheckValgrind                 PASS      255.85 seconds
CheckSmatch                   PASS      358.51 seconds
bluezmakeextell               PASS      120.61 seconds
IncrementalBuild              PASS      4642.11 seconds
ScanBuild                     PASS      1036.55 seconds



---
Regards,
Linux Bluetooth


--===============7888894521532163339==--
