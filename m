Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com [209.85.222.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB9A1DA60D
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 06:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766471277; cv=none; b=j298yYdi1nYpSwWqdQOLnd0U0TY2ugp6gh+jVA1TSKl+c+RVEX+qpR5hR/JvgRvp8yAbMg2PXp6I/PkEK2Xu5R4GbhfyEK9WRZy1LTu9ghBk+NjhblQTECOL/X1WWC/13j8CAhg5+GiOY54du4x97HKULNivL5LgxHDCObdS6Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766471277; c=relaxed/simple;
	bh=LW3DPqjWoWp3SMQrG7H5QX0Aa79TDRdoQ5N4BfBwkbA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UXyAitkmr4huayK2zbTA06Tw2REEdQ9Vx9rpItyotZl9o+9GsC2BU6pXWupB4lBbJ+wOVM1KNl9nUca+zfWUsh1WsT+CzWr4TEZU0W+IEYH82eRlj9AhIWq+QW7wzK0ztE8CguHWD/SV5iBqPxmZzUfK5HIr6kL28pi79UzXD2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=molQX+Ap; arc=none smtp.client-ip=209.85.222.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="molQX+Ap"
Received: by mail-qk1-f196.google.com with SMTP id af79cd13be357-8b2d7c38352so573077285a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Dec 2025 22:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766471275; x=1767076075; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LW3DPqjWoWp3SMQrG7H5QX0Aa79TDRdoQ5N4BfBwkbA=;
        b=molQX+Ap3B2ygwL2QWQSHAfBDFyubLZIWdkCv/5uOi1OuDUFw0oMzczVmZnqz2k7p9
         P8EJtSNVV/2JE7N+WNQcaBDa/KHz3bfYD+kiMkXufO4Ix5bfTTeWk9DvRYjAx8ELZKSf
         Izbex4ID0H0uHcr8OFeWThMYRKx6RWlz+BvtCrlI3NxcmlBmMaSQaaqX1L3KarAsd5Vx
         Diu91gZeWH7jck6nLVrQdtdUDRsLqoElrDo9UlTGw8bQ26bsR9jcrJPGyRrAg3fnF4VV
         64/W+d5quunLQ8Eu6b3tBp/VTzAeu0KYoiNRvLGPAOTCW4Ak9a7ypgSEj88ZwkGLv4BT
         A2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766471275; x=1767076075;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LW3DPqjWoWp3SMQrG7H5QX0Aa79TDRdoQ5N4BfBwkbA=;
        b=miv21/OyTbBUr5uMVJd5Y6BUX950GmA957dJzSqrgzgyk8++YZCwIW6pxCp0nQa+8R
         KuxdPWkzIyUOMpOBtqJtEml4L4N5LUNRcX+OFMhDsNMLYiI6UM2gkKd6UR7aHf/dmv5t
         vs8ULAhXv9k3RehzhxXZQ5FA/aSo1K7LGCXG+N/iWRFHr56SomycIQ1ca1VNQcw/7frT
         nvSO52ioUoxDFk4ZW5dfRvfJgnncoA6d+LYnBOmT2UfIIhUpAK3A4KGOsC/eFdPZb6Il
         EceaGwbAtISiycNzyENg5LAezTkx188bOHY52032IXgdatfu6qRXLnRSzFx4I/laM7aE
         048w==
X-Gm-Message-State: AOJu0Yw7nFvc2wNTEXI95EbzVu6PR3GtcJbOkLAo+X24UJdTF01d+yxu
	vRuQZJPMQMU4dWruUgCvawiE4//v1mGi7LgKcvDQfAAbygtkacW1bC/sHOnckI5f
X-Gm-Gg: AY/fxX6CbZ3YcX8m5YXQV0EpzZ2b9kLjazEksqO886zwZJ4C8QfvnKPF7LJvhUNPXB8
	cfDW0NIvlWxreKbEkHtXy3PZ8bOq9TyVwmubRAm3VyyrMuZNiOBIUTMwXt9Ml81+75hEhRdXJlS
	Wba10grTayA2JZIB1PwHmE8hl48y9LftAhUHyn9swgSsjumDf45W3gyNEF8Lr5UqX2QrdhLIM3q
	1TB3eO/QmWYstYXFIjjubbsb2ydQJlBZoPOg/lVmWvq45wEQeLY1FCVnSY552leA/CizLe3IQU2
	jb6NRTK9YUUZgZb43gFf1keoFyyIDXvWWBp2NCy28s7CGfo9GfpJ+H/7wyLC/qc4RLqx688i3C4
	twc0qfXXAuCpVV4ooMPly2LrG8mDU8GPqPkqV7R0yOgbAughINBUUTxzvIPDem5rz1ud0TPveOc
	Q0QMb1SbRf1r6El3Uq
X-Google-Smtp-Source: AGHT+IGpwFhcFmmk65y8XlqHoKwPcAPzXbS6bPqj3qfItyvUnrI579ZakaOFTDTyGoEszCreBw2fkQ==
X-Received: by 2002:a05:620a:2a11:b0:828:804a:47f2 with SMTP id af79cd13be357-8c08fc001eemr2167704585a.9.1766471275014;
        Mon, 22 Dec 2025 22:27:55 -0800 (PST)
Received: from [172.17.0.2] ([20.109.95.163])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c0968933d3sm1002057385a.22.2025.12.22.22.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 22:27:54 -0800 (PST)
Message-ID: <694a366a.e90a0220.1a6835.f67f@mx.google.com>
Date: Mon, 22 Dec 2025 22:27:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8709601329920469370=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, f-tornack@t-online.de
Subject: RE: Bluetooth: btusb: Add support for Quectel NCM865
In-Reply-To: <cadec64000688a541ece3f63fe41a9a1b81593fc.camel@t-online.de>
References: <cadec64000688a541ece3f63fe41a9a1b81593fc.camel@t-online.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8709601329920469370==
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


--===============8709601329920469370==--
