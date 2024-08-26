Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67540B677
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 18:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724696300; cv=none; b=LJifTclxyyoOiDgWrVQseg5d02wi/0eY60Is+Drq/QHtMUgSFSgf55R7aaibVpRq9LGuPO4F4wzcnObidj4eJ8pnaMMft79jBdz6q+Mc+qE3Allw40O2jHuiRbdy8J8TkrhQfW1x326uhukkX/fq5OPNLaeIIoToOgZ6gpz9J2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724696300; c=relaxed/simple;
	bh=pvbza7GWc5QIrPH9eudgbBADJH8VWb8ttQNomnCMxlg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=T0KTiBUDe0mxYbK9w66f/suP+gl4a/tmQsKCa44tGQGJsmLs38IypHLyUF8oslPdJ4d2i6LwygrH5pKO/I75SYoZNooq1soJC8JoUEIzsGBwdRkDzDaLQ1CbumeITEFSmwIEuVw9qVyPrC5hxzwZV3hbtjETaqR3nZE41Q1y4aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqoFSyr8; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqoFSyr8"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7143185edf2so3881034b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 11:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724696298; x=1725301098; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pvbza7GWc5QIrPH9eudgbBADJH8VWb8ttQNomnCMxlg=;
        b=SqoFSyr8JV66GuqzEFpYBGKtBIe2zf4HMm5Pe2l2xFsp9yrD99V4e1BC9fO4WqQfAL
         MRLeXsmewT2A4HgzQXMEYmYIhsfzqFUKXYm2OqENVdbNsoTKf0IXqjJGtCs0yGq8YQcR
         pgyto23q5+N1CIfzBtTAF59/Ig4nrwCEBT9sr1EGLxoXNMgi5qtSA8od6v+/LnA+sARO
         piOD3TL1XuGxOCk1NleMUd9RV6x04tgTxmPb2t4BDOq3cZ/YX5jZOPTCSZklHJ2Z+Bip
         sIHDzhtV5BXsAk9RIXaexBP/NUT5rlpjZYWyNWOo0UAQQxHKs8rhJv+jAHJQOvx0UB7g
         7d1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724696298; x=1725301098;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pvbza7GWc5QIrPH9eudgbBADJH8VWb8ttQNomnCMxlg=;
        b=SrVxParBvRmkFP6K5bi1Wy5tmY7F0PW+QTd4rDu/0Uq3nihr5cLCrkvsxMzs3mEIcA
         2rzlnjyJLTS7xdo3pOKzGXYoaoNzcJ0E5xaMGxBF3JTKp8kIhDcaDIYFpQ0bRFluJ/aB
         HfhzAGJlJo0zwmUm+PYMe2+7lHvHT6WRCJseIGmlxex95UfsfrA33W0LWn87VcIQgJ38
         5QkVKlMwir1/tMgdviARwJfv+oUv+rXCjUdF8l78W6Ah5t13I+Y2HmrDjTrktS01gK6V
         r+7BAUSY7l3+w5P5iBdFPQiyKIp7xXur4Iq8YgIVy36uJDFAib1PK4X411rWVV72/RKU
         +8vQ==
X-Gm-Message-State: AOJu0Yy8cM/7Ku7/HMb/WPOF7vXnDt5hIErFGNPf8iU6wFVv+1fcEBJd
	IaoPJvVhMvvjZFWy8IMk5fA7TY49tEBZfTNt+smx8d50Xnvok1DIDAHncg==
X-Google-Smtp-Source: AGHT+IFuhSQiCSis07jQKcKYO9SHZCa1C12Q3SEwgpPVlpJHTmTk059M6qiEuE0Uofj/yUdyJOtxlA==
X-Received: by 2002:a05:6a21:4610:b0:1c4:ba7c:741c with SMTP id adf61e73a8af0-1cc8b4affb6mr12393701637.21.1724696298157;
        Mon, 26 Aug 2024 11:18:18 -0700 (PDT)
Received: from [172.17.0.2] ([138.91.70.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714342e0987sm7285727b3a.138.2024.08.26.11.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 11:18:17 -0700 (PDT)
Message-ID: <66ccc6e9.050a0220.2b7cc2.cfdb@mx.google.com>
Date: Mon, 26 Aug 2024 11:18:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0654898162310201592=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, me@michaelburch.net
Subject: RE: Bluetooth: btusb: Add USB HW IDs for MT7925
In-Reply-To: <SN6PR01MB50705B846790BE05B92FDE7CA58B2@SN6PR01MB5070.prod.exchangelabs.com>
References: <SN6PR01MB50705B846790BE05B92FDE7CA58B2@SN6PR01MB5070.prod.exchangelabs.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0654898162310201592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:690
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0654898162310201592==--
