Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567426;
	b=dpHrM7PXd0SiHWkW5EcDW6wDAL75FkEhUjYnAvljDdUVz9bADPTyvpf7uk0FMZfv27qa
	 QC5wHXjU33RIZCVTu34Usc5mP00pAKu7Hr4YxBuc8rakSi7+3w3HqB84S+kTd9xpdLQbU
	 9xSmEzTe3WCnXHqaGPsd4WiYNr9naTFt4qy3XxCMNHwIS3+TsAvXIVLheV9iubKsjW0HG
	 ollTz5n/Q87UDP8ii4x6iNpc3tGHztNArZ8e8IjLM9NnOiQFRrvn5NF4qVjGABAv4dVRN
	 dQC6h8qpd9M6PNvf/tUCjvregeDgkTOAN1v1cohg5r19C0SyR6mAb1yLqDzzuT5HovQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567426;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=37DmMJ7ggGbWJBXsCUh0JtUMzr9M8WD8/0pNx5kPZQs=;
	b=UmPjNHtJp9LF1nepuFe8GGA6Znn6vwoIM4pw5ulyafaBLhePqy/DTh+3yidaR3ycmpQ6
	 hEPSCLxppfzqvPfrFLaMFQ6G1wJ+rSUzlaPMFHphKjD9UACVHyCOv+s4na2+n23l1T5ym
	 9e1Crut9T9VTgjf+k4jfRYYGpRVKQakVfLn9hyVylrXrxsiw3zR2WDx5ctbh/Pkw2obIL
	 ifXh7rCXcXeLu+l30zldi97PfL9zmjnS5TsnYG/sl6ZlLYvDcYU/0X9+hdv37D446tLsl
	 twzzckh/TzhdJwABtVYu9CgtpXsBGnMGfguY8Xgho+uvFAfARavtc7EWKYF61fI1xeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UJUgFKqk;
	arc=none smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B42606A321
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 10:57:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0B42606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UJUgFKqk
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b331cad3cfso5743527b3.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 02:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794567425; x=1795172225; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=37DmMJ7ggGbWJBXsCUh0JtUMzr9M8WD8/0pNx5kPZQs=;
        b=UJUgFKqk9q1pYT0gLE9FBy4i2SDHxfpgN3GA6b2Zx916tU1QKTSG+vnq1o9axF8hOk
         1TzUdi1zJ4nGtRO0gJgaYqLDideA38ud3l4Jio+oxTIU3iwy/HGqZj/PaxtxrOaBf3hR
         bT/jYArIx8du22xLCXDfYs0UdoTn23Y1+WuiZeXWvNoC/Kczau4YVLJAotFQ1oLhi5RV
         uMo18hk5m18Y84M/ISomyXHEmGvk1Ax6EdCLqeliU1II0GSpmcApTme/zRVjmn1kAXbn
         7TXSNyzPoY1iRkWqTrgSGBIXXbZpqZpAjJud810D9SvRACx04xq7dch6Rsclnt2Eta8d
         wK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794567425; x=1795172225;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=37DmMJ7ggGbWJBXsCUh0JtUMzr9M8WD8/0pNx5kPZQs=;
        b=x8mLQT/KRyyxVdp71SAgoq//F/dnJyPYjOGbfjwbR66KDYeKQ20s+KGJ7g3j8D6mC3
         edehZeMczyLEpSsS5VkcaV9LMyP++sMh8XPL4h6aNwv/+nQ6vZucHDPgyEoB7PAojvCz
         9RZoP6tAEJe5LkfVMLe3IvS34VZHfXUd+CN9c6NLYoM648WYyU+oEvg7NoEo45LvDnjE
         I+yHsbDcb+XITEMbgSlta4JjW8/OE8UxxuH6cC6/LmiqijrxZFug1/c+Wp+oJXWlkBL0
         BLKVRCjQn6XQtyP7gTc8YdaDvX/U6//ziBc9iGJJhDMP7mWnynGiEKi8D2jPnjiMrtm5
         6Ylg==
X-Gm-Message-State: APuU4Z/6JzrBFZAy2IdMrcnQo/+nAgx1FQ7smW70Vrx61UWKMzcQHZxD
	QYUIkpkWVGlrguck40beEGJE9771KX3wcw03Rpzl/5j/ZqLoAz/ypw65UY1nmA==
X-Gm-Gg: AYBFou36OxtPom2Rof2WqoHRU0pu8MC8LGQcxcgERE61uvCQXjLaViZ7N4OBtcUn193
	vA4zjhH2YZ8/rTbNI6Y7p5yinOwem/7/enUbs0iUxpdsCUy+O79CndB6azu2wpuD9xRDZi7FeNM
	CbyLpz5aXFkUydkO+IhPjfcP2fCS7XkwygRBMxU9ou2G7pjPB4aGi5NVIFP3m1ViO7prO4asKUZ
	U98G0aw7QJ1+7xgJEe5Mh/EENlpoivI3mRLDiAZiaP1+m22Jbd2ZSuLDTDc/UsM+ApZgOOqd2Mf
	qaiahZIeUYPozoJ+VnKWh2CLQmsoLHqtDEvx+5EjIQVkl2dF4X8Di8m8LQ5BMIcbc9jmfhakl5p
	7dz3GL2UL2yfDpktXeH7MctVu8erYXYJqXiY3qcSfs3Z002aNmfk2Adv91H1fyUGMALKUWwUmfw
	AA7EJ6aGQKRpZcNkOAtsyKlCqjurbLGBj8vwcbAEGLjxY3pwBfGHjCdko5GI3MGxQ+51Zw8MJmH
	BXWMUkoJCTSYQjMMgvmJdLGDYsWhfxTUYJfdzKpnQCj1AC9vZRbKUADMQcKwbo=
X-Received: by 2002:a05:690c:f96:b0:8b3:30e4:1668 with SMTP id 00721157ae682-8b4aa2c2ccbmr17557317b3.20.1794567424996;
        Fri, 13 Nov 2026 02:57:04 -0800 (PST)
Received: from [172.17.0.2] ([51.57.145.200])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aa96b441sm17174747b3.23.2026.11.13.02.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:57:04 -0800 (PST)
Message-ID: <6af6ed00.679b5be5.27cdff.67f6@mx.google.com>
Date: Fri, 13 Nov 2026 02:57:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3086143259497865911=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kevin@simpleble.org
Subject: RE: [BlueZ] bearer: Fix LE Disconnect for devices with a random address
In-Reply-To: <20261113042744.55832-1-kevin@simpleble.org>
References: <20261113042744.55832-1-kevin@simpleble.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3086143259497865911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1210153/

---Test result---

Test Summary:
CheckPatch                    PASS      0.47 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      19.02 seconds
BluezMake                     PASS      289.71 seconds
CheckSmatch                   PASS      293.34 seconds
bluezmakeextell               PASS      98.48 seconds
TestFunctional                PASS      1136.16 seconds
IncrementalBuild              PASS      286.75 seconds
ScanBuild                     PASS      1103.98 seconds



https://github.com/bluez/bluez/pull/2819

---
Regards,
Linux Bluetooth


--===============3086143259497865911==--
