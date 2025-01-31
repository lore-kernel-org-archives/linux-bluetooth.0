Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E2F1EE7AA
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jan 2025 18:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738348188; cv=none; b=NB/ToZ3zHtSEtcxzeIfNBap39efWq+O5TchtYitm3E3tNtWY9Qd87BNWOto/CtKkgNcuSRNh9ktMucAoX3Rfi0AXyRgQQ5xVXK/0a3DSaw0FBjGGLedQLk7+3ji7UTWT4PfnDjXunnOY++3JEzou/1D9bdI6HU2cIdMC1MJ3KM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738348188; c=relaxed/simple;
	bh=YBieZOI4usfor/Hwvutwqp/UUE4bvY6TEvY06vh7BR4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fKsOyqqXA+/JJGrMj9DHmjrxzBpTL2TZNFA3eCi2iMrq7zlR9hdLOyQ+s9hFIO2i413BO0FtI0Wg+Lz3inhrZ3uUqxbL/EJY30B4iAF50WDlBo3e0DSNZVc52QQeeLYJxKilXhq4V3MtbK8ldV5YIgHVLnjo363KTYlkS8WPr0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfnHWDsT; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfnHWDsT"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-844ce213af6so61711039f.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jan 2025 10:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738348185; x=1738952985; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=feRfK9lxl8hwfS4ayfaOWBstWdf8fYGjoFw3yTGzlmM=;
        b=nfnHWDsTBeKWCi4f/me1ndmZWHvWJOOt/L2HTxoixoZNq/4fmaU4/iW7bYUS7US0ZO
         Pfk5ezKb9/NJsNNj4Sv0DZuEERMtImX0951GpGs4M5EeFbA7/0URwQQeagAjclf1tBmm
         Z1P1e1u7aUeuiXxDUNDP88LR7EFq/AfYYOEPrfS3xTv0P+aYypJTJOQ13gHwNdDNhHsT
         artFV8/xybr35TMmfPvLuIRzM7NTQ2TdbpuEgDu54UP1S6uj8FeEHOEJPDFqmXxb2qnQ
         Sa1QJV4vmhK4gK7oWTvyjrIF8Gt04EYssXqXsH4KGh/gErEPLk/zCC51EEqXYPPLKDBv
         xAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738348185; x=1738952985;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=feRfK9lxl8hwfS4ayfaOWBstWdf8fYGjoFw3yTGzlmM=;
        b=Hc3tIQrmzE7Wf05jjnGb7Drlx2f2TZwMldXH0JFDweKoIPM717bbKH6ArKKgAeI4Jy
         WmLz5LblIUgjLKNk+BbPEN5XRQMOvxb2KvHAmJcOA6rcXHZ+3BQnMp3y5hI8hJqplNFr
         +FR+UE7iUa9obFtg2b/Z996MHF8lK7t/ZlxIZ6Xq6Zg48rMeo9BP1XRURGuWQ5qB/qqu
         9IpL4hWikl2isAnMxkPlGx4ZwBb9Bix4aNrPdAMoqhtKImvHcmRFY2Lmyw1M4MZBxZRa
         qfl+DkcArB4XzVqtpDAo4ovqsoNXNo+6j1uM1BKoQFUN7rw/35IJblq9+rIxU7ZDJgsF
         wuUQ==
X-Gm-Message-State: AOJu0Yyv1qGoeUI+7KoZ9trBTCITsoWLREovYvIPNKIrvGcgUIUYidrL
	4PW1byPKBKxcfRtALac2Azzke+z6Uh6nNr7966TxACCyXh9EbGv7zGoutQ==
X-Gm-Gg: ASbGncup+DYe1LZ42YC/A/Fu4I4vzURu7gda+vVkjD5zFc1XZDeIv/pczDRiU58IOGI
	xRfDgUVfTLkrBZwpzEdJ37DtBzPaD51BlLm7T+5zhnQos6KMsWUwrSQ8oXASQph8EbdpxsNBmG2
	yDSYB1vQPD7OG5F/G9bh9eMYiTiu9R4lRQxO449CGSy3CWstdkD3YcHv2a8p2Y2bRMz42I28CWd
	PHjUqsYnXBuxthuapQS+F0tuY9HiKTbH2ToGjoTr2DmlaG7ukAz9V/eaB/5lud0nPsx79FjppOg
	T7K57h07Ww6UxFfk3nBQ
X-Google-Smtp-Source: AGHT+IFuKSTWUwsnSXOtAbIHObbpnMWK3C0Hr3pMXERlytVk1FPAbvLa/IFtDefCFvvHN7GSjD6ijw==
X-Received: by 2002:a05:6602:6d02:b0:832:480d:6fe1 with SMTP id ca18e2360f4ac-854006e200bmr1123209039f.0.1738348185278;
        Fri, 31 Jan 2025 10:29:45 -0800 (PST)
Received: from [172.17.0.2] ([20.98.37.227])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec746e3e63sm917730173.144.2025.01.31.10.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 10:29:44 -0800 (PST)
Message-ID: <679d1698.050a0220.1e8abc.1566@mx.google.com>
Date: Fri, 31 Jan 2025 10:29:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5888536189251275253=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] build: Remove AMP related functionality
In-Reply-To: <20250131171759.1642480-1-luiz.dentz@gmail.com>
References: <20250131171759.1642480-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5888536189251275253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=929557

---Test result---

Test Summary:
CheckPatch                    PENDING   0.19 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      20.30 seconds
BluezMake                     PASS      1474.04 seconds
MakeCheck                     PASS      13.10 seconds
MakeDistcheck                 PASS      159.94 seconds
CheckValgrind                 PASS      215.76 seconds
CheckSmatch                   PASS      272.65 seconds
bluezmakeextell               PASS      98.31 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      864.78 seconds

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


--===============5888536189251275253==--
