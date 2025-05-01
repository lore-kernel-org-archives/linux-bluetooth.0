Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9007E211C
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 May 2025 01:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746062059; cv=none; b=dDzA+QPJxcaPxLOZgIVmLnEOzLTTCZeiNmUyX4bTm44uFz8ij2Jf+A6CWHGuCqEvpv6QdPqpn+tBCSogIfHMojkz8UghcvKdm2f1u9orNs3pnJx607S51HYfqh+xPY9pGpMXJjKjhkVDi4VYU5sO3jKQsMiyyHJ3uI8jW6UATYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746062059; c=relaxed/simple;
	bh=vTZahRBHlwIOzYJDE09zobZVQafU9eK1Y7yEjCRN+3o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SFFm3TA+OGas8h+ACLuLPJIvXOoLZ+stGkgf1PL5smVa1w0Za7ToCNccLR9Fz2ocE5HLCa1ePLQ/tITYLQTcAlp0ouk3f3qwxxhsu9l3MuGwImdfDOeb3erQzdDPG39aPwY4nStdD7GbTTTrD97E0O/NwFypFZTXkKxxlp9046o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nX6L377U; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nX6L377U"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2295d78b433so4702585ad.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 18:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746062055; x=1746666855; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vTZahRBHlwIOzYJDE09zobZVQafU9eK1Y7yEjCRN+3o=;
        b=nX6L377UxD1ErzaGHiEXsPNdqhlFMO5o4ppFnEm9i9qjyabdnzIpjQdKU7NElRHarg
         dnjPzXaxHlYP8wxmzwNv/QoREQlnuspcRxS/CUt4SMX7Uerd+2t67GLL4wlHlccu1ZTR
         2VuQlRN3kGVghj94k4+fLfQL3x4Tp1VT+dGng8uc61Z+tWT8OAiu2MblcNwsbmtQQ4At
         4t2KceIYhmH3xlopJ0nonr7T/ZRCTBZiHSMJyT6xm91mfrX5tH1mH86oBTsd5n/o2lku
         5jizQ0VJ+RxHhbo6Sq0sxJ8XYCLVrqtABz/Ij6EClPBLtojA2vTwsE+yDdwlmRknmSZi
         vKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746062055; x=1746666855;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTZahRBHlwIOzYJDE09zobZVQafU9eK1Y7yEjCRN+3o=;
        b=C/fQbNT7V/1xOD0u3XC2quE1fC8l05Gml2KH61ywJl+CxAFVZMfSSFjCHnfYtcT2ul
         N/+C8dS6GBwU+kcdkTmtCIlx8RspFqsPWXZE1nEZjWtVQ1KIk7zWVLkM9NPx91Zl65U9
         Lk8xZvn4trIfT0+Lhn254f7k5sjCtzFueKbG/h/sZGD7M7azjhutMtiaILUpjJec1p0z
         DwaFu8FGRLmsjfzXICB/2fTFM04mr8J+fKic5YHST6LhWgR8eDtWOCcOwPcjCrFmXxNf
         GEZ3yyzi+pJ6XChKpPLuIN1Q8HNSQHaMU4VrKkJkO2T/yMUeyN1FrPbKC4gumvVbSAay
         qLNQ==
X-Gm-Message-State: AOJu0YwE+nc7n3k/BlvfBnhuIEB2xh9ydibkXm6W9XD1KVIIUzeIouh9
	SfXkjrQkUyB1oqgGMc8GjlF2CMZ1GGWxQ/BebI4BYTvBGwEC7lu8p9OwCw==
X-Gm-Gg: ASbGnctb8U3irqyjIvDtHs85NAHf60xdxUNTP/tpzEaeDH3fJmgOjq63Z5brtovyBQo
	RDt90C+uYpgX5kDcUeG0c5yC2IeTENAVU6xTaXFc2/uSTvLXaJ5wTAZI7C6AwyF0n0kJG/Z3KHD
	S1hZNARVma/3R65lFRF/RUwWW5JlDU2lF3xJu7Mue5aEKIePqCFF6tb2IVHID5GELjlQiZpthXV
	EPfxSl6ddYOy/IW6rWnEjnSlU1NCjauhu11yBxOFiGg6inVsd4Kkp5uDqCFEfWytM3KpqXDBfH5
	bSdl3tWfMmgxMve62mX18JVqIn3fOuPAHm6H/2r8IG8W3eA6tFhnzA==
X-Google-Smtp-Source: AGHT+IFKIwypxjdt+dSXbfcDTD6gs8OT2MLL8JaZF0NGY+SRkIfU27jcPc5r+M0W+d+MijWjfkL4AQ==
X-Received: by 2002:a17:902:e54b:b0:224:160d:3f5b with SMTP id d9443c01a7336-22df5839ef5mr68753125ad.49.1746062055414;
        Wed, 30 Apr 2025 18:14:15 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.7.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d76ce1sm129571255ad.40.2025.04.30.18.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 18:14:14 -0700 (PDT)
Message-ID: <6812cae6.170a0220.48402.5c79@mx.google.com>
Date: Wed, 30 Apr 2025 18:14:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6810753423651398383=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sunliwei2015s@outlook.com
Subject: RE: Bluetooth: btusb: Add new VID/PID 13d3/3584 for MT7922
In-Reply-To: <SY7P300MB0829AE8C53A9A35F9038F97ABF832@SY7P300MB0829.AUSP300.PROD.OUTLOOK.COM>
References: <SY7P300MB0829AE8C53A9A35F9038F97ABF832@SY7P300MB0829.AUSP300.PROD.OUTLOOK.COM>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6810753423651398383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: cannot convert from eucgb2312_cn to UTF-8
fatal: could not parse patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6810753423651398383==--
