Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C7425B1CB
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 08:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751876669; cv=none; b=Fs0phdDyISHsSzvrJBej2gG/S05eF5Wv656Ot56AZrl8/oxH8cnuZhmuWtmpbKcI3nHGql/uKbhxXlSIjN2UTcZuHs7TJr6Cli2+r/5094FHAGQiUm9+KYQR7cg+i3lRwDK3Vl0xqHHHrs4R7TW0xchZOXQTj8BGB9R8Bjt5iGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751876669; c=relaxed/simple;
	bh=tMsL6FtEqPs6jHPbTwHcyGVxxwlqA4FPociGEGM5sFI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MYaK/xgDv7ne3tdSNVxlfyleOnvfK5jyXyhaimKbixEMwhf73kTrUaNUgpXDYjrKy+rY62Hw1Pb2FsAj4Y0KJAaaa7xkDXje5N8ACv7fv2aXrgdmCX7j/dTwtZpp6zHQGgIXKz8v+plTR5MRT9RVK18+Y5eR6WfmO+474fPp4jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PN7UxFMj; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PN7UxFMj"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6fd0a7d3949so54463176d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Jul 2025 01:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751876667; x=1752481467; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tMsL6FtEqPs6jHPbTwHcyGVxxwlqA4FPociGEGM5sFI=;
        b=PN7UxFMjrII8UvviZXFXjT+Co5Hvvki1BUuu99r4kahcUpQj5FcOV6q/UYWZw+lILu
         l3oLk5UaOhuqgCMWtD/bcY5rsvhMfNBUnpyr0Q/lY2PyYTmXgYcg0FCh1SzV3pvZHZ9R
         LWwDH6rlO4nw1Fuv0mZI9OZJFD2fSUPPtAE5R6Y3S/XupW+jigSXSHfOtCUwNXhUTHdK
         0kZBRQ85U4dzrTznikYY/WMchoWwDbdoO4tlIBeQ7S8DrvCadbLu/ja657XZglze0GXw
         r9mGWz7gl6sA9NDlNpOfBMym2hMzFYge2Q63ouHNAT1EwttBOQR5qZNpAGGVkb2wMN9z
         Mv6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751876667; x=1752481467;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tMsL6FtEqPs6jHPbTwHcyGVxxwlqA4FPociGEGM5sFI=;
        b=pfge/UxjLTlxQTN56TV2JpXGH8S3b2Rr+oKu2V+iWMaAYafUIaJO4GkaQrRByY2aM0
         ROT02L21QN/4LdEwvbEJKcovdS9z5iYHCd7y1V186RUDZy634dN/RqNUm0ref5Fv/jra
         LWf4vSqfh+oPUbMsk9ILR7aUJgZayjxJ4Jzw+gxPKaz9rraPitsscd1dhtaGCNK7NJrq
         5UrUNPquzwcB+ZupfMrC5L/BH7W9MBYM82JTDBH8I3Dy/+Fnw3U8Ru8xWeCVXbXANJCT
         P1uJ3UhhiKifFBVyvpJsPJ2Ihy+zpBvKucBHgpuomMCgY54vDDO7Bt7OE9TDrDvAdc1b
         O3cw==
X-Gm-Message-State: AOJu0YyMO30r9Ry9yg5feRfxDg/IDu5+i+FpGPiLsCts85XUctChJxUH
	5594iQgdlLfTco48WLiN3sLQZQ/fTjbL8Am3bSW6gM5FijkjAOkpcJnXLJNltA==
X-Gm-Gg: ASbGncvjfjfdLUC5WwpeVsDezjfFUGrXOfNEu3Zab+03KXetKRovfIrQDnR+gnANLO3
	nyj8yJaLKpXMWXAzsrTILocwwlxxi+dap+rZ2Ja09205RZBKOyKkgG/fglFNkw/BX7aBGoF/rnw
	8Fp0sxKu+E0PtkpeYZ/deML1xRXMM2JdVyf/YiPEyx118j9HZ5wIQ/NB+WOU2VmRRHyuAw7TY2W
	/GRNaIVvu7n6KcwT90AVw2HLaG4Ft0PNRZLQAb7cXpviPmPnbPlWER88gXyO8k4CGjiKuyyd9Jv
	JzkU7xG3EB0dDiPIMxwBEnIDH52r337EpAMXflQCPnphVX+jOpHFwQ3M8gUDCiLMGzsp
X-Google-Smtp-Source: AGHT+IGgRWj54wan871CdLt+5tCgKqV64ZY7NRlgN/ULKvoTF9aEmYnzjB5S958N/3rXIkCfMHwE7A==
X-Received: by 2002:a05:6214:1d2b:b0:6fb:17a:c428 with SMTP id 6a1803df08f44-702d1535449mr122684676d6.16.1751876666887;
        Mon, 07 Jul 2025 01:24:26 -0700 (PDT)
Received: from [172.17.0.2] ([52.191.68.218])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbeaeca7sm558332685a.98.2025.07.07.01.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 01:24:26 -0700 (PDT)
Message-ID: <686b843a.050a0220.33b437.049e@mx.google.com>
Date: Mon, 07 Jul 2025 01:24:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2351357964283582740=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ceggers@arri.de
Subject: RE: [6.6.y] Bluetooth: HCI: Set extended advertising data synchronously
In-Reply-To: <20250707080204.21335-2-ceggers@arri.de>
References: <20250707080204.21335-2-ceggers@arri.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2351357964283582740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_event.c:2139
error: net/bluetooth/hci_event.c: patch does not apply
error: patch failed: net/bluetooth/hci_sync.c:1224
error: net/bluetooth/hci_sync.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2351357964283582740==--
