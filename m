Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F01C1F416F
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Feb 2025 20:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739653032; cv=none; b=Dg37S4JPbt5H9BvjOBSd/SrIknKsrz0dKzLB/LfEU1M9zTzKWeH/TwlxmW87x0jSSMks3JthydovI89eDzzj/KodhBYUosWm7K2ok9Lp3nGFqHD7Yzy1UV0nfXabXFdcoPT+lsHV2ZCkMx0WIP90XALBdugqnqkb7zVB83cwgDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739653032; c=relaxed/simple;
	bh=Uc9X8+3TnDgk3bxw7Xak2JsWlEUf1s/LE+46NBFZFGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HU7KVFE0ri2jRe5pay6zAK3+uY1eNlnuLhWBBMS/XUVprOVe3cmdpMV/XPM4o5YxX/CCaHT6XNd7OtodcoEuMGZrnqZYmGYkEC4Ammcv5c6onNu5ZAtNkyc72A9CijRxRdTtlv02JF//AME24FaVHRzIPWEeCLeETXHuCVOGk0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EESSVkUt; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EESSVkUt"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e5dc299deb4so1080187276.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Feb 2025 12:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739653030; x=1740257830; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uc9X8+3TnDgk3bxw7Xak2JsWlEUf1s/LE+46NBFZFGw=;
        b=EESSVkUtbPE0+Dh7Bz+fRZ7QAk3fWi1DQD4GLtkGumbEmoHvPlVZ20C06+Ihq8ePDd
         E5A1QysrzCO4gwTVIIScOGfmuG0YPX5FhMF5ncj244o0dkLLF+DfnSG1bJ3xWgSofNHa
         1hs0ZUZLq2ymP/vVZZfDM8wDEOIWcr/BnoFPYOjP5jWbPgxN8Xaw4VjXBua5gHNlsVmg
         aZWwXz2vX/42Jhy8kjlDIaMiWzHabKokfPi6H3AYynE6SczBXrRj7FyvFAXR4IJLvNSP
         FAwysN3hBsQTmaMWZLNL1fa5MmYJ479x8Pfj7c53bHd2F+Clo7DlSVU71c5tDBPUcQ8p
         qGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739653030; x=1740257830;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uc9X8+3TnDgk3bxw7Xak2JsWlEUf1s/LE+46NBFZFGw=;
        b=d93un8hOE2larz7f+fUa5aTllvX9Rw3fD5RbGVLEFeQeEzLiwe+o1qqlfuf1j5pU4j
         3m5QvMbgOu5/LivaHQYY6Ms/ZS7YMz8wjWYWrTztJ2WdThHz4PQckHe8k3feoPXSDXtH
         OdwBmemWPyNDy7LcDCKWzizW7M2Z4RLG1uBfVhuscvnHfaAYRb5y3n0LISlUgis9qUe4
         w+TwgvOosRb/J1s9KJ+hY8mIMoIfzhbZYF6XYbn2a8P4i4aa1FM/HXQoCmXULxKtJQfm
         JdYJyq0g/mVNGMkXhgTfbAuEt7qAf3rfoX7CVZO9ucsjTo5lOxp493mIltYnlWOx5Gno
         awWg==
X-Gm-Message-State: AOJu0Yy6kWfSVQFwzDc2bF6QYu9+tYsaJj8lGKHSxUGKlQzscrSN5IHA
	KtMtVB0e5hB2AgAo7z4YcTxy3BbYOEzfXQimsdpJHuc5UUsmSBI5nOM0cXDWLYKBlVWkvgOEd85
	chUK0AA3kuMNAIGV5uraHALzdvG8=
X-Gm-Gg: ASbGncvW4C+l7t4PG6RO6otzdwf2eTi1fD1rh4zrb5nMYbbX0zzaIseOnVTrPwBohMw
	QUDV0Bjpk4OcnI9XWgg3wlYCocHn0IGUh3bpCDk/SshC4d4X0PLME5UIysUBW/usQ9ukwQcaZVg
	==
X-Google-Smtp-Source: AGHT+IE7PgrF908KpyaQXiQnQGzwnl90Nbkc34cJ36z1lS4RVhip4iSojY9kfqWuOgz5SIBuSPgbUXk55cmIQksPkKM=
X-Received: by 2002:a05:6902:124c:b0:e5d:dbf7:ab78 with SMTP id
 3f1490d57ef6-e5ddbf7b1a0mr21100276.46.1739653030204; Sat, 15 Feb 2025
 12:57:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214153711.887794-1-luiz.dentz@gmail.com> <67af70df.630a0220.120429.66a7@mx.google.com>
 <CABBYNZJqkSkG+1oNhn4_Gff_YzCLDbF-Qbo-UBvu_pYpqMEaWw@mail.gmail.com>
 <CAGFh026Kopho-c3Oi2JmwY1SynYGnh2pcPf3-Y6Dzkjm4-hGjA@mail.gmail.com> <CABBYNZJ4igtnTvVxMzDTW3ymCcS31ZJ7Hg7239gcfjLHKx4C-g@mail.gmail.com>
In-Reply-To: <CABBYNZJ4igtnTvVxMzDTW3ymCcS31ZJ7Hg7239gcfjLHKx4C-g@mail.gmail.com>
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Date: Sat, 15 Feb 2025 21:56:58 +0100
X-Gm-Features: AWEUYZnxeDddCMcZts1uZRjD2A-l76Cq_QvpO1wepb4_yHS-x5VfyNUVODgFgRU
Message-ID: <CAGFh027HASR2dgSMrktJo-B7KAPS81X6h3F-awV10w_nqkegxw@mail.gmail.com>
Subject: Re: [v1] Bluetooth: L2CAP: Fix L2CAP_ECRED_CONN_RSP response
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>> Looks like these errors are due to fa4d477ab535 ("btdev: Broadcast
>> EXT_ADV packets based on its interval"), if I revert it passes all
>> tests, so something is not quite right with it or we need to fix
>> iso-tester. It seems you remove scan_ext_adv from
>> cmd_set_ext_scan_enable_complete, I suspect that is the reason since
>> it probably no longer pickup things immediately which makes a lot of
>> tests very slow.
>
> Hmm... OK, I'll look at it over the weekend and I will try to fix it. Maybe I will have more luck with setting up a proper testing setup this time.

This time I've tried a different setup for running tests and I was
able to run more of them. However, not with a 100% success rate yet...
Failing tests:
- L2CAP LE Client - Write 32k Success
- Mesh - Read Mesh Features
- Mesh - Read Mesh Features - Disabled
- all tests in tools/ioctl-tester (maybe my kernel mises some feature,
but I'm not sure which)

So, I was able to verify the patch properly this time. The "v2 -
bthost: Set advertising intervals to valid value" passes all mgmt
tests and ISO tests in particular.

Regards,
Arek
