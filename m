Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8726C329E72
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 21:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765403215; cv=none; b=hPa/pXRShDtAvxmGccNYtsgCcV38H1/vGEMwPslE1BBC8TuDxeiGiMWrA+O/mw4HKVmu4ECxlT8WTjsBkYjFWgEatZG1cpda/0mcFpksDX2XjHbHiadcj2/p8w1Z+9XEKS/6Gh9TL20PD7ouEtIOJP4BUNRs7fosuqiNoPl8/fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765403215; c=relaxed/simple;
	bh=Tvv1w7TadOtU/tKbGIXZ9l/BvHFjUeV6F1wY1j7rr3o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ntIfAFrm9kPaPTTJgmBdnq7rx4diiltF/EREXFRy9AQjAANaxmWWvJHcFnF0i3loC7Md+qWap5TSOv73UG6Hu2XsIa2j6mIfgdsZ7ad00s/QoozGsc5C7p9tutpBq4A0lPvzQ+/4pOtc5PMjPu3L/5RcjNSS3dEntTfoAvPyAzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fc3P8WJ8; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fc3P8WJ8"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-11beb0a7bd6so1701734c88.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 13:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765403211; x=1766008011; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=22V4ueSv/OHpboUVOras6CSpClzQV10pCyNCyhsPgFs=;
        b=Fc3P8WJ80iQZnmaMdMKeK/kjfHpGmC2i9nC+OeGqERG0ttqAzJt8aEQ8OnSfLI5PiM
         VVAvbPUa1MmvvoHHwDdp6mp5pUyVncDKg7emYGLdKVFZM1dCsVVaSveBsi5Mhut3/U6d
         4ebXF4Wcxe1UCTKfDhEedzHS3OWWxuVCWnoFSHrSUGyhpf7u5crX4ZCyMncfRFidw/7N
         85SAbjlZqi8pIDilq/04ifR+Ne5T5tv/g9JbtUwhW3odI993jI4ViQrh5NZt4I5iQrPH
         2JY+pA0YvNQ2YGYn+XEXQ4iaSkPvfpg5eui3omTdjinY5IK+eAeZaNdanucZrAjxULY3
         Jdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765403211; x=1766008011;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22V4ueSv/OHpboUVOras6CSpClzQV10pCyNCyhsPgFs=;
        b=S4v0sOm0U5m2FyPS5T6RtWLJtxzgxdlfcIHOUSWO+vOE7+1BYSKlcbUcZeIC5qorX0
         OHpTNzFnGPQRSrJoiLaxMCwN+jZDb4eANzUKfXjuT/r1WcSY5mu4NQKXUgjKqy7Qb6F5
         jR6oq+RmHbfpOLtq4OjZzdFTfJfSxYAS2+5T0DLsTsQuZxn8U2JIFijdYYMWJo4JgEs5
         2gRXkJpfhG9DO5CNQtxVCa5PkCWs48K3Lpw7aWJI9OCdMhyHoVZ57ilQ89Rzm0092RHZ
         Cmrz7LdXWCaRYzO7Vp7OilgoWf2NUL43cVrXouUprQ9jeJ+xfuUGFyZQun14TfYxlDt0
         esNA==
X-Gm-Message-State: AOJu0Yydx8FfXGXH1xSf8aNDhhXRjXbdR42S4ogdMvhJKRT9aCHmgpcb
	2RpAIMkvuKmJDBI2GOaH1y9lxydHzw9nnKCkmq+WzWpoL7kNrc1Yp1H8AA+GPg==
X-Gm-Gg: ASbGncsOnLyQZTeDlUkVVLhxXjYqxlKvMvaDWKktKnsePAcHCUVdVgvj3YfBQ4Hfv+H
	Qldf7NiHVuskp82W5WB05MlwLhmzB9/wN5sGCopJiPi54HYfdITj76xh10DW7wWGgJ3umvnzAkA
	sJJ0QmS6kYvDOnyY/wWWlbTBuxDOfJV8+h1nsIIYZBkZfhf/UR4i+Pc0XTGZi8wSTDGmCNMwWh4
	cFJ8IWGa8aH7GeCm+XIp4MI6dAPzqqVPbM1We4j+0Ovs9d3AAjj1JUkxokAl6lfJhgMSFrx0BUX
	FZGgg7xEgCQ1bj5mw9c2spSbtPH7spZvxp1+kYSY5+y3BITFuqu5Pi5abuxeRCYJPmxNqvG1p5W
	2tl3nnMpcqz5t7DzsUKbD8ULq74FMSRChzeCy7o9Pz3FzQ765VGpeFrAi+87sMpuLP8xlDbN7MY
	q60bPMhTBLn22eCkUf
X-Google-Smtp-Source: AGHT+IF1u4oNGzMuC74r7/VqHMI/RYnFfIxOLb1aRG5llEYuSLV1L0pvZmS72oERy9tNdu9oKntYHA==
X-Received: by 2002:a05:7022:128c:b0:11c:883d:1ef0 with SMTP id a92af1059eb24-11f2e0dc654mr643846c88.15.1765403211095;
        Wed, 10 Dec 2025 13:46:51 -0800 (PST)
Received: from [172.17.0.2] ([172.208.154.2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e30497fsm1779777c88.15.2025.12.10.13.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 13:46:50 -0800 (PST)
Message-ID: <6939ea4a.050a0220.2dd6a8.decc@mx.google.com>
Date: Wed, 10 Dec 2025 13:46:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6286352049661081081=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] l2cap-test: Add tests for BT_PHY
In-Reply-To: <20251210204952.153725-1-luiz.dentz@gmail.com>
References: <20251210204952.153725-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6286352049661081081==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1032100

---Test result---

Test Summary:
CheckPatch                    PENDING   0.39 seconds
GitLint                       PENDING   0.44 seconds
BuildEll                      PASS      17.88 seconds
BluezMake                     PASS      651.77 seconds
MakeCheck                     PASS      21.95 seconds
MakeDistcheck                 PASS      225.70 seconds
CheckValgrind                 PASS      294.18 seconds
CheckSmatch                   PASS      327.84 seconds
bluezmakeextell               PASS      174.61 seconds
IncrementalBuild              PENDING   0.41 seconds
ScanBuild                     PASS      997.89 seconds

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


--===============6286352049661081081==--
