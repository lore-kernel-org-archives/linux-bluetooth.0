Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B97151985
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 03:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747018806; cv=none; b=Rh4ZXNVR2KDzH+L7+hrdFOEX7aa3kXyo6zyf19y3UykUR863OBsvg1cA/2AcTvJioxAVEQV3yHXxhvJM0IXqITKgozwxr2VR/bnD6NK/WsF7daF0Jf+r+MMQWwdQqpEsMFvGj34OmjsipRoX6tmYDXqwwZVouWorrXD7I1bJttA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747018806; c=relaxed/simple;
	bh=LZEbYGQ0XcScbZvetMdTFq4Le8BIVtqKcFZyWXsa3gw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Zmzs3keA2wZoVBp/z4OYTkLbLaBNO18v5wt6kCLdk0H9DCTJhv/SPqky/3JCt40At+esMgjAfvkexEp2u6mTAL/AoUg9cKhs9akdOwz0OdnfW0+qJsCGOUsHaXzkr8dlbVodXMr83xyBQ9mVICelieKyzvhSUdX3+2zb9II/bZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlqnnBoS; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlqnnBoS"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c597760323so446127885a.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 May 2025 20:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747018803; x=1747623603; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LZEbYGQ0XcScbZvetMdTFq4Le8BIVtqKcFZyWXsa3gw=;
        b=NlqnnBoSNVLyUkn4Dzlf0eJBmM1cLddDJon4bAYyaizC5c8Z6/O3JORut6qWLpgxsz
         motakcn1eFjetEX91m+7qgBdDy5/Zyx0m5ezDlSaOaEwgf0m0SIcIW8UQhOLCCy0fSBT
         CBvoxwvNxr5p0+4rukLBpuY5Es2sFQI3L0MhRwfkzWCxbcgSCEACXxhtBQmJUvrI3E78
         FwqY6rOuuhg4D9Wvpf+vNaMYiVP95WRkbee/F3OaMq25qvvoyzJASJczZ4tdSRMGJlMV
         FhnLD+y5Dj4QwGq4AQ310MS17bFxD9pi2SjgO+3QMIykCip3zThMR+2OqHWGENmGgMdd
         qd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747018803; x=1747623603;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LZEbYGQ0XcScbZvetMdTFq4Le8BIVtqKcFZyWXsa3gw=;
        b=ZDK1mL1pmEUY7TJouqy+kQG0t23ZjQ3Q5a4HgXYcyXe1XsPJz516WjUl75piWho0Of
         SzBB+ymgbS/QwQGqAShTEg4mGBxRXi7eyYPOp5JuwAKWGJb7pIS4QCCVYTeRIUTKEqQK
         18Nc3xyqGfmawe4fveR+oQSeL0hsKL9S2ed1bI/WU43dR8nEDvvbN59ivgTxtBthcvfr
         UKbXk9Nh2Ypx6G4fMVtE+AWSKcBdeKr2elWZWcwFg+we5eR8pLzw4mU7AXpxPRHnKEgA
         5tRUyi+dO7PEkS4RPdRygHAvncfwdQzUuxswjhQgkmB9QWODEuQGRhVGVmHHAIEn2kpp
         Lm5w==
X-Gm-Message-State: AOJu0YynJYUTPGzahFpgHPjpIYOW4QAqEX67ICPrUZhGGhzij4swh4xN
	qMm9vWrlacBoc3ZPXa9g7BMKjDGZv+0omJQDMbB717i5vliGRY5Koks57g==
X-Gm-Gg: ASbGncuyW09kyPZW5bljfE2anqVruNwSe3GKtzu2SnTCPwlcq93rm1nWXu8douHMnOJ
	N93k9p8msnnFKlPPxAKea5Ms6mzIOImTugRzDnnKZxq4EdTzSBeqZykOPwwSCAQWffiDpXjmvlB
	vsMNJszAH8vgG4dA8Nt68q0jYzGyEg/0IfeVbjD599Qm5S557ZAuKTVj7RJIiknDS4zm/enw/pp
	o54WydGkNiJC3+f5XiEqow626DFBZgcp+GbyBTkOmPypklBSDkjMA9QZBC7b1NChv5UCv+vT+Fr
	Wz6rlmb81N/e71p0MwR/TB49j/0HtE75FWCb2qxf0Yw4FCsdQPMuis1Kkw==
X-Google-Smtp-Source: AGHT+IEsG6W7xGP+eTl89cZmpHvdZ0P8Qi+o7B86EMx5Lk5PuYgKLmFRQFp6ZCeBGKFkqn21PkE90w==
X-Received: by 2002:a05:620a:44d1:b0:7c5:49d6:733a with SMTP id af79cd13be357-7cd010ffad2mr1708820785a.21.1747018803290;
        Sun, 11 May 2025 20:00:03 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.62.134])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd00fe61d2sm479495085a.99.2025.05.11.20.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 20:00:02 -0700 (PDT)
Message-ID: <68216432.050a0220.24f059.77cc@mx.google.com>
Date: Sun, 11 May 2025 20:00:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3706509534391623581=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, sunliweis@126.com
Subject: RE: Bluetooth: btusb: Add new VID/PID 13d3/3584 for MT7922
In-Reply-To: <3fbcee73.2408.196c254dd8f.Coremail.sunliweis@126.com>
References: <3fbcee73.2408.196c254dd8f.Coremail.sunliweis@126.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3706509534391623581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============3706509534391623581==--
