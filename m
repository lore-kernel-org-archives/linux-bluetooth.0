Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EFB4776F
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 19:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707766467; cv=none; b=QxHGR621GS7OkJuB4I0S7q51jRlzwP3xY0sWecWvGRTIpreJPtVQTG3H7cPgnjWzgefqIyD/NRV90/zEFB4np9BYxlhdUYQm5/uwHEHsN8q6Beix59DaNnYQ9IwdeDILFPVskGKdxLrAIyo0dSU/XGWccAuVAkE/TLId80ui4yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707766467; c=relaxed/simple;
	bh=BfK5RmTNJTH5o/ScZd4dB78aCrIGRjll6fTtcV9huA0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YqgPkkySYrdFwjV7YlQKyTG10jMFiwRyDoBcX1kuDTKv1wu1q78x6MDk0sQ1Rf5F9B/coN4V4+CMbTO/TIIKMmTos+j1Q/Swyo52hJks/MYoO+bsTiggXCeLjSjDDdnBnyQyPdmF7lJGTFWsoL0VSO2TFrrOmImXDju0ZwHlzVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A46Y4zMm; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A46Y4zMm"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6860ff3951aso17777816d6.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 11:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707766464; x=1708371264; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mtDyUpwyPZOy/6kUdZhimz//miFdbYaeeN7RWX1I/oM=;
        b=A46Y4zMmzNzh3HyAFi8gD3skGHUfhhk2FOjvqpdGwVDND2D5Dk+0VES02wg7ZYvxEv
         yHr0xIolBfGpyh2kyL9eupvixY0oHojEIjlMGIIE+W4nF14s9svET+ibyYCL9Am/PzTn
         6TkttDxjWXylsdSjk+ejl4a9Gs6X0C9GKC3oS5d7M0MTV3AUjVrPd5VX5QGZCDZ5fZSu
         jOql/La1JBnejnMd+trB3WlAMWK5UaAA6BX1LAb5FrsgonBy+NhHlB6Yb+eJGRpCZbbX
         ezWW53CD6TUUO5/Hn+oVr6eP4gvvNMYY+SGQsc+gGtXfc21o7kZWLjbHjaKoaqNa0oZe
         foAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707766464; x=1708371264;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mtDyUpwyPZOy/6kUdZhimz//miFdbYaeeN7RWX1I/oM=;
        b=ju6RX8B3BBk3ApNIui40rE9xafLuBrkc9WgKpJu7QdQ0RQVdZ2muQB2jSuI/wBQ6xx
         Q62GufPp7LdXD1ft7F6Q5M1sImZIE6bQU5/jqX3S4HxPZKEsmsmSfxnPjlWmrDloWUyu
         TTVcQReKwoWInd3g9g9v3GR5Y4X0SsbASxnCM2jN7OZANNT3l5F5ykES4JWb0Hp5lY3g
         MTaEMEq5DJsF0x5HrHSf18vemXVF9Z2sHHS6CTPZ20LyYjNtp3NHXsb0IP5QgMtztwty
         c73tPRyNQYeWqaXt8qbqQFgJP4DN1BJ++ONk4TJw6qhjeqjAIdnGlzbQW+W5iccPQGTV
         TdUg==
X-Gm-Message-State: AOJu0Yy4O6//iOl9i1PxyHYn+NOc9Ry7XF+O4lEB8GLOuc39lfyFiUgh
	ljiHcpF9vjt/YxDt2hSrhrB+dLw7VW1lP2bjTlwZW3GiiWJQbP/PncFTCKh/8aI=
X-Google-Smtp-Source: AGHT+IFh4BmpoQk2Mk4RYk+TZsqnPBWZIgj4aVZshzM9XXOqd6wP++Tm0cAHUTJjHnVhZCMeYBtHQw==
X-Received: by 2002:a0c:e2cc:0:b0:68c:64d3:d98c with SMTP id t12-20020a0ce2cc000000b0068c64d3d98cmr7894897qvl.53.1707766464413;
        Mon, 12 Feb 2024 11:34:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWwwVs5gZC0CY0unST2C5maTS5/lrePVRVS55h1KIw9Qunur5AhqHgq5Z+2O0JG0JkMbYCknAoEh2/2HhfYJjdTXxuZLg==
Received: from [172.17.0.2] ([23.96.249.170])
        by smtp.gmail.com with ESMTPSA id oo12-20020a056214450c00b0068cbacf7327sm457795qvb.107.2024.02.12.11.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 11:34:23 -0800 (PST)
Message-ID: <65ca72bf.050a0220.e1591.3f41@mx.google.com>
Date: Mon, 12 Feb 2024 11:34:23 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8185093916255391985=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3,1/3] hog-lib: Don't destroy UHID device on detach
In-Reply-To: <20240212173910.4061556-1-luiz.dentz@gmail.com>
References: <20240212173910.4061556-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8185093916255391985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=825316

---Test result---

Test Summary:
CheckPatch                    PASS      1.25 seconds
GitLint                       PASS      0.89 seconds
BuildEll                      PASS      24.49 seconds
BluezMake                     PASS      735.31 seconds
MakeCheck                     PASS      11.79 seconds
MakeDistcheck                 PASS      162.84 seconds
CheckValgrind                 PASS      226.50 seconds
CheckSmatch                   PASS      328.83 seconds
bluezmakeextell               PASS      107.23 seconds
IncrementalBuild              PASS      2067.00 seconds
ScanBuild                     PASS      921.72 seconds



---
Regards,
Linux Bluetooth


--===============8185093916255391985==--
