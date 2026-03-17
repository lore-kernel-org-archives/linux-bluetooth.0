Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A9F1FF7B3
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 05:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773725062; cv=none; b=Me9Nawd7YpY8IHy6CjsKXHXuU93g2zpuEpjrEwp/bdXgNz/w9dLye9p4Rbam/jWjfL1z0qG83Q536fYT2BN0A42oM0yUu74xOumZXwhq4Vox0WgnkX9LnKsy3wRAo/3mxG/f7vbDwXusgAFodZLaN4rOjVMxxvI2XjhyP6hHm5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773725062; c=relaxed/simple;
	bh=eOBuizjhpjNaCnoAjTH/ojHulOTUkCsqZd5nc14yKl8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=T/IKSh2T5mzXYaAX+V92F0HScsaR3FyVFE55cunRnbV0OYQpb027XYEBEgNxcsjSf8XL1FqOJORrN5Wh6hA1PPadNomHQtEOib7pOJRAVC5xfMjksZwre9zZ9QPniP7qrIsQa0F8QVSNqV0hEsC5WBCsqmX8NVHS7VsGr906Vaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvp8CNKh; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvp8CNKh"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-509061dab77so51554471cf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2026 22:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773725060; x=1774329860; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eOBuizjhpjNaCnoAjTH/ojHulOTUkCsqZd5nc14yKl8=;
        b=mvp8CNKhDWQgAO8IJD6tZBEbarSiZN4cEASocdnnBWs+XCP1X4n22s16KS75+HzSpG
         WunrIju/6IsS80qzMqSAGfge5FYBKF++kJV9dTD8FtI4Ygf/fDAbj8tecFqeonzYtwyx
         ekg/Jl3qmiM2P9D0eqwd6tR0eerTRjpQ0/YlQL+QLykzbMn/2QikLO+I4+t/IBZCO62s
         IOqaRE9ZlflXGtnBx/l0YomsAxFLL9jtIEIG/7hle9YFNfigr7Z12i0qvbyt5JhJkb0Z
         YBfxo6SKEUARdaF1KoQLzkmWcg9ftkaAQbePmcTzzJMHba7XaOl0t7tKQSs2jXToCiUx
         GHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773725060; x=1774329860;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOBuizjhpjNaCnoAjTH/ojHulOTUkCsqZd5nc14yKl8=;
        b=FuV79KNmFGeqr+rJO8S7S4ZbUzKn5k7kyNVoYOVRZbdChoJcq7LwJkWS2VRnqAYLCC
         o5EYZtJUdiE+rVKtHJH+kRyodlNOUcc0iroUH+WI9AmR4Ul6JFW7rRlSmKjKuQNs4f+Q
         ZFuvkuMr3BFbMt5983CmHt6xJSPivBkGkH4lXlVr9OZRYmgxVTJ9SgKIzI9d7+f3TItK
         czP5OsCynf6wmyJlDv0W8yTZnyOfFtwXQxwpJi1yMIhYp7wCA3OVRFiCLZkSVmX+Xjmu
         fVKihK+3hRPfOUUHtNFCH5N+J36uK6Oi9+qDmQhdrNoXkwv+pVRUzpzxQdI3sZntL6IO
         402A==
X-Gm-Message-State: AOJu0Yyxkw99o2Culr0oIAaIra5bb354Jjw7hepcncDBEqOZmDRPpb5y
	lbZMNi5TmTPm8TeTFEQRLpbOiKIHEkFBPx4Gw++BJxYAvnkg5yi+nkZflmiYow==
X-Gm-Gg: ATEYQzy6OYGWbvGdxBbC/z5xInwAcOBJeEjHxtDA5ctHLCAkN8Yk5gtW80gFh/wLw8h
	PUKzmM5L7IozOofXAezUlhnNra6iSV4aZKC7uoj64O3ct3kxQ2oNJf6HIVCKaxVfY8pQOjH+Oxu
	e4I6uohQ0AAV3LedPkwcna/L56m4v2aFMHKahZE2OL7P+0K1lyUMuJ7rxTCkN/WFAZQfHR2IvxI
	mHTHUsdWSxvJ9I3WZ+vwIcMjeDmRRJ6p1wyQv+u62Uez2JDiAExOvotQo5DbYxsew0xMwppK4vL
	CPIQyoDX9sFAKvmmcb0/uOL4IydMk4cLbyo8viImSxrDjlbIdgXjBpb5XUrT2/P7pbO7ga2JttW
	ytI0txTTVixAhgB8f3RPqIir8cCkcrToRlteKmJ7My0QV0vKZhsHpJTpBEKID6he2pxOvIwS9Fd
	mA5shTCLGacuXaXLSxWDFZvBxN+kCoWLsxTCBxtv/D
X-Received: by 2002:a05:622a:1196:b0:509:61:b22 with SMTP id d75a77b69052e-50957e5cab2mr197175221cf.57.1773725059777;
        Mon, 16 Mar 2026 22:24:19 -0700 (PDT)
Received: from [172.17.0.2] ([172.172.87.194])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50939e8e4b6sm128969371cf.1.2026.03.16.22.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 22:24:19 -0700 (PDT)
Message-ID: <69b8e583.050a0220.a4d31.2cd1@mx.google.com>
Date: Mon, 16 Mar 2026 22:24:19 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4346729724146781485=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, manivannan.sadhasivam@oss.qualcomm.com
Subject: RE: Add support for handling PCIe M.2 Key E connectors in devicetree
In-Reply-To: <20260317-pci-m2-e-v6-1-9c898f108d3d@oss.qualcomm.com>
References: <20260317-pci-m2-e-v6-1-9c898f108d3d@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4346729724146781485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/hci_qca.c:2421
error: drivers/bluetooth/hci_qca.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============4346729724146781485==--
