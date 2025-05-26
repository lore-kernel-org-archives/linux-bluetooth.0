Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF4E376
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 May 2025 21:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748294006; cv=none; b=dsCpKfWS3lPZvfuLnklgvEnNFEuw+C3ZPOTLMWlVNP1A5DyUgR+5/WIXDFl9LPgsDeQYndRqf74nsqKovL7KuoQq6tPLSQPFSMfx8dJIaPaQOFdChNCUx9bI0Hbc24qEMEV/uXB5b5s51kz7r/lNqkyyYBQS35A3NbIn+Y2JHYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748294006; c=relaxed/simple;
	bh=SwFF8DnP2b5HYaQyf60WH3SFUu1qSQa2jlIIoDf73cE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ES9Mn9Pw/8F4m3epKHqh1uM8QGzU+cefmebpq0OfEbDmQJLn5cUQ7RyKhb8HIKsVuEZAuvLKIcLUeSFFGyLwCmEIK9m8kIdZCMo1qa3+PCDidMnTMIZK/aavZmjvPUK2EpgnXoNGu3vgtdKsyn52b6S918faFz1WOmJqzoYsfK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKJ/U7N1; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKJ/U7N1"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-879d2e419b9so1670432a12.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 May 2025 14:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748294004; x=1748898804; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yDfiDs5e0ywOg68U7Zt1wbbjHsdvlTT0MoaCXr6OFo4=;
        b=jKJ/U7N1rKLUSeode3Hqg8IZs55SM2x+3+BoMGkD1QoliUkukiueNPw9wILll+UKLB
         py3Gb5yQSktoqO7k+qYj9qbn7Y4Nl+Vhd2wOO5C3GghqZsl6AJNw/0+jlryYuDrwEfTX
         Qqv5iG+Q14JIa+oKOggTVltm6ZlBbxu3Q1zjiEfiXCpQ29gNoTX4Hd7efPlW/iclKrfG
         fMbG/M4Wvw+gWcrV63IXgwNzMNC19/nC1SleC2D0FoanYgHwmhg/Z4YDziLZEiD/Vu2L
         AVdiYgi8tdGnXUmwkaGwsvV9RxzqrW0DxF7tEALShUFy1WSc/+oA02E3Vun+f4sHB7/c
         hmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748294004; x=1748898804;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yDfiDs5e0ywOg68U7Zt1wbbjHsdvlTT0MoaCXr6OFo4=;
        b=mGU31BrF+dSiF70UovPYbXenh7IgRrVHyLFF5y7YlFLNTTwrPlohsGrcALttQfD/ka
         wfJxvvR4nQHGXgosEhfhUOctpStw3yFe0xpgX+VoyJLf8AL8QBxhydeG8vjpDB1UC0Qe
         zmkNwStrI/yYJpqKH7hYSiiXtjFzyChKEbGuQPFuu1UvG7QL9a+JWXQhzoHspjjzuU5d
         aITbqq6OGdTiMpMoLTtWfdaRRf5JLgNROqMlBevatwf5Za2Uz24elhMp1CXJ5t5KaKLP
         1Ly+XaLOa9Pb9ZJosamVwU4XBDX1eWK6j0bty27joxS7sueA/kGjDnGWWMuzPsQj32xY
         SuWg==
X-Gm-Message-State: AOJu0YxmnaLU7uYLuDtL2Z3XSvkZVIA1NfEAiE4CH1W0tq/qbp/JSOMj
	c32iVt7s113wiO74sXVPXOnKFHX8DbME56YrBNFvoYLFSJXb+oDHeeX68Uq8xg==
X-Gm-Gg: ASbGncvHJjPzladmlcbQ6T5/9U0mGk3qaAdgyC3IezS5Qcr7JrmucMj3QoFaASwBhso
	hep6ZEp9DjcZNv6xxIj2qmlmF0z7F6xz9D1UkfE+eH3ti7fJUmhxkHnLcjy0p7bD1AkUB8Ny7ei
	6me7HIS9LC4iy+etA4UqPjuTEXsDXVszo9PgMPD8ye9Tkxcrb77wurqAMmkfxkh4Ibtk0xfuvZI
	vDWGZz4QbsSTPi6/Pseozyd/d8BkdBexHKyCISnfeBV78K+CFybo86YBt416zjBODsRq3TsmpXr
	IToRooUe0OjUKbhZ9uaiUJbP1LP4gZ09eLLS5H3QZoEupZ5jA+frDLo2QM0wOfHDSQ==
X-Google-Smtp-Source: AGHT+IHxqWRsdikAz20gSrvqsxr3QROZtZhs7fy3kVuZz+Tjivi0lPl613oJ5f1qb5SfaTY9qEbYRQ==
X-Received: by 2002:a17:90b:1d88:b0:30e:823f:ef3a with SMTP id 98e67ed59e1d1-31111a46bc4mr12404014a91.30.1748294004120;
        Mon, 26 May 2025 14:13:24 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.85.54])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2c3b85d967sm1338597a12.61.2025.05.26.14.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 14:13:23 -0700 (PDT)
Message-ID: <6834d973.630a0220.1327fc.387c@mx.google.com>
Date: Mon, 26 May 2025 14:13:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6959550509221336940=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, repk@triplefau.lt
Subject: RE: [BlueZ] policy: Fix reset Control/Target/HS retry counters
In-Reply-To: <20250526194328.15875-1-repk@triplefau.lt>
References: <20250526194328.15875-1-repk@triplefau.lt>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6959550509221336940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=966495

---Test result---

Test Summary:
CheckPatch                    PENDING   0.30 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      20.17 seconds
BluezMake                     PASS      2674.35 seconds
MakeCheck                     PASS      20.15 seconds
MakeDistcheck                 PASS      199.75 seconds
CheckValgrind                 PASS      275.98 seconds
CheckSmatch                   PASS      301.13 seconds
bluezmakeextell               PASS      128.24 seconds
IncrementalBuild              PENDING   0.24 seconds
ScanBuild                     PASS      907.68 seconds

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


--===============6959550509221336940==--
