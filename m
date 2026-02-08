Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF69A1F0991
	for <linux-bluetooth@vger.kernel.org>; Sun,  8 Feb 2026 06:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770533533; cv=none; b=Nzj52mth7+xqWVp5BITmhFKo6xywsteswgxToEFnUoKyweerfA5wkSOXKNEIcR63emuYpLKGiGhSP3EluQo9mveoivV8gLlrp9/nd3zJXGiRPDFnRZWsx9ObMLaFwXT/DR15Xf2UOf/YlXSV/jz415TyfKiKMZnOcoPB9/Sy7YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770533533; c=relaxed/simple;
	bh=mfqepqVh410kekvqUWLEl6K43Bk46Z6yG16epmAtI8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i0IbNObAnE+Uw+l8i8RgfqveuXonc3bhDSUiMidDvpfW2zkIUiM2DuGFxLKEiYmjvJGdMzf38x8yD0lq9gY3r9JmLjJOudFWkiJhO0ew030KHjfgt0hwVhuwm0RLW1qHbXy0xkuG8x7O1g2KTBYTEdGYIQev6wkjJowhLiGtqtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiTWD7NA; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiTWD7NA"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-124a635476fso4694363c88.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 Feb 2026 22:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770533533; x=1771138333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mv3fry291sYoZ4hHtfAa1hrVQuBP1G3ltB/IXaIIzZE=;
        b=eiTWD7NAOipnlKqLPSKMY2tCxPv5AocnFqLzK9RYzh2Zm+snr7zxhflAA7gqSkdlHD
         XHBXAi3AMk1wKdyJAIJnRL9YbeYpRH6tEVj4RwOV6AYWpqHLu0sAl/vp5h6itSvHkKRO
         0bYQQHBOKBNHQAbuuemGdcgfFbut1hcKpRh6sLoth6vGuZ7AGMRthWZj+Y0nOQKdu/O2
         WDu2Ki9mTWsliUoHxfcw/hEV4Fy2jttB81266hC7+69S4IRZVtWqQYGlh2XfOcOfvplc
         DDIEkwUKJ10BYHf8r/ONCsK4wzYZwv3oP1SSOzM1SnJ/o3wemi07ASGlBwfhVamHV9E1
         mTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770533533; x=1771138333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mv3fry291sYoZ4hHtfAa1hrVQuBP1G3ltB/IXaIIzZE=;
        b=C4Pac0SvI/nLYbLE45tnCGXhoYAJ2q95Q3WJ5IuRE1q9jagC8e2Crgr9k6k/BABjZA
         sLg62yo7t4K2mEYWWJ1BAriIStZLQ1PXRzyIIrS7zt3XYKiyCh03GD5l9epVkTIYgTG2
         A4EP7LIKj6Jf7sHfmgsjZeQaF61O3ErKid3BBOQSRzIOA73oN9EwcTYFsMBJxpLHHktN
         zZQUgrEpQKW7VO8sMDiRRPiWF9ORE8UkWsSt3aA4eZS1SYGAPSVGnMbigDytq3+/W/jy
         yWJFRdu9mcXoahYTC+Eup/a7C9gA/hm652IrlNmCF2wOSTfSojcvCuPkAKcoygWHOMHg
         2oZg==
X-Gm-Message-State: AOJu0YxWucZAj5Xk8LHabZXrQHW1ILCLNwKTOBRaqlE7e4KX6EynvSld
	Mn4Xj89nM7RpKmS+GGrOl/eq22taBjxui38IHovlQl/xcpZOWHOl4TcJgCmIaQ==
X-Gm-Gg: AZuq6aL7OQeYE6q2xC8r/MHE1z+ikdTPy7DUK9C7e1P4+WMejcCo1Wh5tYmmPGEIy+o
	8Ukqwlq71Cp2CO6eFamHOLUqxyj5WUdOH9CSXCx2ayAalRlvo0KNiJn0TY2k56TKd/4N2HrGyGJ
	9Be7cHYcRr7Bnh3Z8Ym8TtWVa/WiDPk6KI7R0YpOLo8G4VfF+gu1IffIyvbMhiD8Io+Jf+Bbq44
	YdEXH0PtpJhdEkbWH7wILSZLskClAMXK6lStlkC6LrTK+lyW+DP0qmRAGOW6FDINXCHmDKtIWgO
	8b92DtBb+WYJ1qW6Zo4YgnTA3E+InKiKa3yhQF6mYrcnsTANlPuEDBLehHQUCdA7eR6i2kupvKg
	b/U7o9NXAlGI675M4NM3iBQBbD/UdE7GDz+ST+15jn9KGp8DiGfDmxGRy895wKZWI55PBpQ5apx
	Qi2dUc1ltejRIewAyr0uALR7d7mY/9WAzXfwsZF1Fk0XEDltn/lkJSGpZms76IEZXHbl/n
X-Received: by 2002:a05:7022:6185:b0:11a:fec5:d005 with SMTP id a92af1059eb24-12703ff495amr3706888c88.10.1770533532722;
        Sat, 07 Feb 2026 22:52:12 -0800 (PST)
Received: from binary.. ([177.39.58.68])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041e5460sm5673025c88.6.2026.02.07.22.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 22:52:12 -0800 (PST)
From: Maiquel Paiva <maiquelpaiva@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	gregkh@linuxfoundation.org,
	marcel@holtmann.org,
	Maiquel Paiva <maiquelpaiva@gmail.com>
Subject: [PATCH v3 0/2] Bluetooth: mgmt: Fix heap overflow and race condition
Date: Sun,  8 Feb 2026 06:49:48 +0000
Message-ID: <20260208064951.41392-1-maiquelpaiva@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 addresses a heap buffer overflow in mgmt_mesh_add by validating the user-provided length.
Patch 2 resolves race conditions in mgmt_mesh_add and mgmt_mesh_find by protecting the list operations with the mgmt_pending_lock using guard(mutex).

Changes in v3:
- Added Fixes and Cc: stable tags as requested by maintainers.
- No code changes from v2.

Maiquel Paiva (2):
  Bluetooth: mgmt: Fix heap overflow in mgmt_mesh_add
  Bluetooth: mgmt: Fix race conditions in mesh handling

 net/bluetooth/mgmt_util.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.43.0

