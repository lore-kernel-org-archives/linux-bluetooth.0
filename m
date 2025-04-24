Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D731C8621
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 15:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745509865; cv=none; b=EoPiGA30Ai8oGXojNjwat23Axly9LPZZwMhAuvKcoxT0DXQAd7cznFk/LfXQB8nD3H7jkv4LRCPTzpWAA4yClhzwHEqgepgKL9GXdGkZzbG/j+xDf6B5iv8+yu9tCy52Xx8FySbp3YyBbrHhPsahzpsjXG/RljdcOviyHNXD13s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745509865; c=relaxed/simple;
	bh=AMJkikQV5DUagaWn3RVmRqao75aqYFYhW/wwHx43oNM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=e2YuaXXSQ4iWNl+SH1SoKiJm1SXaiuxr3pUTpUOeL+epE4rptGfRRnzIp6pev1bt4nKQmJ/h5mXvrqNA51y6SOo5FMFE3pgTMn3A947WZPuAF8t78pl2wRDOdZ2jzK6pUhQlEurZI3yvdMRNjrs4V6+2YqDrHvswwdcZQSjf3zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMq30anp; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMq30anp"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c560c55bc1so137561585a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 08:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745509862; x=1746114662; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AMJkikQV5DUagaWn3RVmRqao75aqYFYhW/wwHx43oNM=;
        b=lMq30anp2+B1sg63Zgucq4B4fbcKhRaIIgJbr8Gr7u9VHNPaAmfcnbMo5gv+c3/Xcj
         dXet8TgsDPIWna+Ea33T6Krjj76XtNX7XtycwVpUqy2Q0FAlivF1T+AaDdsJyhEPMZwU
         xPewYNehDUTDn6ybZxQxsyC+QDUPtubB7mn+ezM07PLnL46Y2M2wRVCmTTQue3pCDq7G
         zskn3b6hzuzZtdRwzufjP7es8OWmTr3cgWpQCWqKToYvB3gHdQ9AqY/femV+7ywaRkeK
         EIzYh5v25cCqRh/aQRCbi76Bp4plkZgelPs18HVmykQ6N6X5jCRe/S9hXhxZdU8qoOBw
         mr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745509862; x=1746114662;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AMJkikQV5DUagaWn3RVmRqao75aqYFYhW/wwHx43oNM=;
        b=aAQsEWiyRifq0oqushCZvqpQVLccaEcIBuvcz+lAToFV/4ulWm31prxDl7vdZ3YA6h
         y1FNIwtPSQ7lKr/NhW8AKOgrH3bAGfKWVcCv9GtlROPsIgPU5/JxX+MBFDqwMpPGdFWS
         KNGEYA4LHu8Yi5sqmmTU8BnYrsCEBix7wChG+OOBGoHNB5J6Eqx2TNP5///dRB3HYyUN
         wm0u8HF1hIySf0iq1KE3xxV2z1r/S8fhwuLl8PY8BcJnquFXYSyM50ngleClqX1n7+QH
         D2XonCKihZfmOIVO+oMERkHq0UGGiUKeoBUAo9BMGuDNEl4gGXJkTFcNQaacXe4fUn25
         rPeQ==
X-Gm-Message-State: AOJu0YzwwVQ+ZGZHwfODSpqpeONABiyjEHK7R/j/YBBz29rd0dj4UxhJ
	yItJokZcXUzJnlWIoefa6rUNiVeAQCRs58BTPpLFAuV9rNBw9SbJpBlYLg==
X-Gm-Gg: ASbGnctVUlo9EOqOI37phL3AnqIke3ixEkVyPznxDdgpWb0u6aNWyyDN38IONouGXfJ
	P6WyeL9VYtrWH3Vj983IEWHGGXG4k21HZmBQ4wTQzMD4tFYYhuoSCYWUvRWWk1vG3CG98oahk2+
	vd+k4wyORvnbFLFVFmPN20CL/g8mb7sGYUzjVVPoKmxOjvonAK96+Yb5R09gaPaCydtoy22mQVm
	RNvqzE2nZTOp8ds7kVC9efYNQs3YfAbfcNQE7Z61HNIPBcskp2uiMdFgTcr7FOvm09/R/j9iFiG
	feaeEdvKE0Bd6vwRqnzW+zIl5lEU4nwIl7dzJOVA5nTMS85L0CeeBnQbCf0=
X-Google-Smtp-Source: AGHT+IFv94RMQSXSfPkuu8tb61ufYjOBy9stnL7rt7t3Cx2mROh6d/MuJnbu+lNwcAmstS0gcLusUg==
X-Received: by 2002:a05:620a:199f:b0:7c5:3b4a:a61e with SMTP id af79cd13be357-7c956ece72amr438593985a.24.1745509862549;
        Thu, 24 Apr 2025 08:51:02 -0700 (PDT)
Received: from [172.17.0.2] ([172.203.175.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958e7bdfesm101452585a.75.2025.04.24.08.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 08:51:02 -0700 (PDT)
Message-ID: <680a5de6.050a0220.10f0f0.5470@mx.google.com>
Date: Thu, 24 Apr 2025 08:51:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0768123116697531322=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v5] workflows: Add CI action
In-Reply-To: <20250422203243.980887-1-luiz.dentz@gmail.com>
References: <20250422203243.980887-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0768123116697531322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: .github/workflows/ci.yml: already exists in index
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0768123116697531322==--
