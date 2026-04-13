Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC6D3B19A7
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 09:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776072166; cv=none; b=oAjZMKd4zxpJFbpBCjTXNm263jEqWNPKu1mX4JUDpyTLD/wBXGhBqxdfeKNxaR4ZM5/Zz/S4LNJ6D/ug4lXwqAsa9L9cb6Hwr0Eb3xbZuPGsGSlGc+AX7iAz9lj2o8g3JKNV+dRQgSKqeeGg9zgZGaCnJD3uAVjbOSC4YItOvTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776072166; c=relaxed/simple;
	bh=ff1dSRVfR4/DyUy2BSJC3WIghqg0qTw+o6HfhJZcu5Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=p+YJDjFmHuSbErLEvfgNu28RNrGFDmHHetp790Z30QR9bxDMZyPKeyEsZuZwjzadowslIP2P4VNsEXjZlJGJ0WNpVhRys+lqowCHVkbrDFZkKMKhRHC7nrSBKUhokyyJ0GENNeuEcJxf4JgP11PdcOVliCuBma69iI3S7ViDTbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLP6hG0r; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLP6hG0r"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1279eced0b9so5620963c88.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 02:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776072164; x=1776676964; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ff1dSRVfR4/DyUy2BSJC3WIghqg0qTw+o6HfhJZcu5Y=;
        b=dLP6hG0rppiW7nnAjs111Kv0Q+YIm8K6NI7lKHYPZER32k8GAtaFBG9QzPM5Qtif25
         6utiO+6UkG7dcCiM4K2bln+eR5l6/UBPnkcQSRUBiEde1U1tUIVKrcZuacXVS+X2xDon
         +Zf1QZiQ1yB8y9F9V0h5ALhLV8a52xPDxJuW/j38o/12LSqocdBwS1ghpki5aXQTg8O5
         Wa5CzBZWp57r9QzRzqHKQA+kdTqHcaom+Y6I8+TW8UFRtd7cESM8N7TA8QIv+jP+gns8
         4Te/iR5qOBRhcWEj+F47L21L410MdoEKrBGUPY+lsYhQs2uV9cheyTRaefvhCTwXWi9p
         ILLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776072164; x=1776676964;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ff1dSRVfR4/DyUy2BSJC3WIghqg0qTw+o6HfhJZcu5Y=;
        b=s+n7M7MihLrhTPeVGml3wCJAQQYaC4sYVhgpnndpgyoqxUO4sUaMOwj6TsbdwmJDTp
         T5V7ZGCGICUmZIbEf+idKZg8MJIqBwVfcMED69ryhBEZXfShLuc6bCtdt90WXWGSnElF
         aMsRuDsLLTHqb9LLbyeu7RPVwISqQMjJSS5/TWLaUgXdr3004Gg/6vSDgjv2mNoL1Dvs
         2L4UVdAwerAlgReTjPjVYCsfRwjZ8lTYIwqM11HVjGiNqs48lCOWP/4ACjkRT2ODcZyd
         6HgNkoitNsGFieWAuHKgxsrSamH1gyL5UglfrWhpw7yspUWkwN9UYj5tCQ7wMruxU0Nz
         LlYg==
X-Gm-Message-State: AOJu0YzUCThyr5HYd0CLSYTuiLeOUZS/ZtLM3NhciPwwag9m8jFlORG+
	HPLlRXEaeDSujL3nyNklrlH5qMzkuqnnZ9WYSCDiu3z6SqVkdlocD26XHGeFDw==
X-Gm-Gg: AeBDietoIeVvGOSpYCSi6Pl+rEjgIJvj4XOHWfqB6Q+ZIRKuzi8f/MFI9k6KgGkfsF7
	BMz8Ppi9gJ9hgYYRNGCMVKPqaUt+nHI+oD1hHf0nV6wvw2XlDZlb4T9mTwkyu/kVrA7oznw3Ka8
	BbDFvXLz3fLV4SMB4nkbIzlyB/au/7dNrF37izpmP4mbvAKBdDW8f5ARl9Zy171XaBdvn/tFCd4
	uIQZMKPMar17nl2Yp0OCNxYc2K3XvUMdd0NhqJeJvd+Z2OcSJluKWLXGLOuAyOJwVejqkaQdddp
	+9G5c5NZN4nXKGjFPfD9fJ8mJvfQR7uKfgR3Nl+o1nBWX5Gz2ElsCSfXKvpx8v/EI70zJF6evt/
	qhiqGE7v+JtvF14knI/NqynbdItc25BTKQzkAv1K2rTCsgy6VJK18++SgcP1CNzC2QHy7ISO2u6
	XBK5BAvwGGH+AIOE/4UIsUlt3fEj2hx6Q=
X-Received: by 2002:a05:7300:2287:b0:2d9:db50:c6a5 with SMTP id 5a478bee46e88-2d9db50cd6amr635408eec.0.1776072164279;
        Mon, 13 Apr 2026 02:22:44 -0700 (PDT)
Received: from [172.17.0.2] ([172.215.239.53])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d5630ac330sm15324100eec.29.2026.04.13.02.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 02:22:43 -0700 (PDT)
Message-ID: <69dcb5e3.050a0220.5a47b.10f7@mx.google.com>
Date: Mon, 13 Apr 2026 02:22:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5752837602593824367=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: Bluetooth: Add initial Channel Sounding
In-Reply-To: <20260413080023.1455582-2-naga.akella@oss.qualcomm.com>
References: <20260413080023.1455582-2-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5752837602593824367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: src/shared/hci.c: does not exist in index
error: src/shared/hci.h: does not exist in index
error: src/shared/rap.c: does not exist in index
error: src/shared/rap.h: does not exist in index
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5752837602593824367==--
