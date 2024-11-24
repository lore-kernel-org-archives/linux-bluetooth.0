Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A927C18872F
	for <linux-bluetooth@vger.kernel.org>; Sun, 24 Nov 2024 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732467380; cv=none; b=sPYgsujebP/QVQSl0j81ZigguR6pB89G/OaLF9E1tf8jiIPkiEpsAkUYhNlBI3QxkahGEJ6/k/26YnpvxD698P/7Dj3Qjp6Rl8A6mcUC/9jnPwfWYdbRsPRlF1jCLVjmqfJ6K9LvIxbeX35ALFyuzKVIbySOozd6vU59YWC9bQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732467380; c=relaxed/simple;
	bh=YYZqBRBm0rWyaNBGgGwnZE3W9nk3jTfF8EkfNxZmiSs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AdwPnTifk09iuKuzR46afbYMd8gJtP7V82usVx4NqHn47gJReJPkgwBpSdynkm0xOrkp5u7DtWoaGvFJ61KcyPOvQQivVe2Wlk9s7HZvwLKrqhwB0g1E41ZyEHVj71Ar1y5DfPzux6twc/uTG3Jz4OpsL5dyk3tXfDGKBaWAwo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFl8kDXu; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFl8kDXu"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7f71f2b1370so2996788a12.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Nov 2024 08:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732467376; x=1733072176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CwcBrsmEDZnt6aalpixZ226v/pEWFHGKMENTA5N1x58=;
        b=EFl8kDXu1RBFhEDCQmLwKGq5Mb3ECywllvTa57fscFVOOJc7aihWadSRnPiuf80q+i
         KSIopsc1Ig3bOW9uE+Vt51tRU4sGgMU0qjrZ8XHuRhG1C4EMmUw5cMIz754qzZZOmcZi
         gU7lbr8/rU3w5C9sdqB0oDhz/FVYZZomQeyxAlOvv4P7w8L9uuuearE8OyCm287QbU//
         zWShKDDPd+93SFVRjxh9Z+IIzo4BL40gAa8iWvQ1k4wURzPamKCVxTswWW/JUOpqu8Lj
         Z4BOyvYvY1m3sAqR7KQqkKxMOFeycpdP+pjjObb5oXScyPHNiSGu42+O0g4fBdVq42nm
         gwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732467376; x=1733072176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CwcBrsmEDZnt6aalpixZ226v/pEWFHGKMENTA5N1x58=;
        b=nnBlsSoPym+unOt6OlI5DkEKJIfE7FkHFn3ypYz8WdjldscG5Vnq6ZUpjathIbQlrC
         OlH7PzlXrQb2NTJGxa4h7vQ9HZlUTi1QFv3YwdBWKqZhsNidhiKNKsX/72aLYdVXP48Y
         ZTIi02SoVfrC2GaLhJHw5dDFOnYyTDn90lc35Mm3Zczlzf4dHEShX1ivmE1KTk13wlal
         /DL9m3lLcoO/Ssi2zcgeey2Hsnr7R7kqxQ9CP+xuhPlJnqfmhbd4BSSU5VFVipLFcWmB
         9dacbZbeLHisHRuIxe2gHpKIZjyIwokmBdAy0weeoUxxzY9T+xcoezbGb2nJa7e2B0+H
         +o5A==
X-Gm-Message-State: AOJu0YywQi6tluu0j5Z1FTIOPhZQcmPt6dwe1ntMAYTJnA7bkmZBpZ70
	Ev0FxyUDeW/sDvkfvgcq+1Ri1xpWE4omc6f9VsocgYVxe7k2aRDf/g/WxA==
X-Gm-Gg: ASbGncsrCuSU+LqJsVvpdO7x3Kcmc4RksaMMQQ9qJhGLTmrEL2OR2v9h7jV2hvVLphh
	QmHEnDKzmaex5FnujIPRRGqrDedCOatMvn0gzDOCBfPNuBIxrQeoPweKuqiZ5BRqfwJUyk5c3m+
	HUKy9aoWxYh8vg/guXZ8Du3lR0vSLJG3HTe1SXM82Y3PgcipkB8qlOJlk15dR7rU9eYoH8AREHh
	s98kFhtRAP+PQrtqU6MM1lFZ6Ye4+YDgHzndBHNiFt3dRRgOg==
X-Google-Smtp-Source: AGHT+IEtuPUedzoOgwinO9Sk7a0RvLbmomYKMVhl8wYqHv2QEqN8lGULk5ZUPS9ndft5EFdOYQQKfg==
X-Received: by 2002:a05:6a20:9152:b0:1db:dc37:4f4b with SMTP id adf61e73a8af0-1e09e452659mr16624945637.24.1732467376507;
        Sun, 24 Nov 2024 08:56:16 -0800 (PST)
Received: from [::1] ([2001:19f0:ac01:93b:5400:4ff:fe77:2098])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc1e25cesm4986381a12.28.2024.11.24.08.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 08:56:16 -0800 (PST)
From: Yuxin Wang <yuxinwang9999@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Yuxin Wang <yuxinwang9999@gmail.com>
Subject: [PATCH BlueZ 0/2] advertising: Add scan response data handling
Date: Sun, 24 Nov 2024 16:55:37 +0000
Message-Id: <20241124165539.2913146-1-yuxinwang9999@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Scan response is already supported through the mgmt-api. These patches add scan
response data handling to the DBus API and bluetoothctl.

For related discussions, please see https://github.com/bluez/bluez/pull/1012 .

Yuxin Wang (2):
  advertising: Add scan response properties to LEAdvertisement1
  advertising: Add scan response support in bluetoothctl

 client/advertising.c              | 486 +++++++++++++++++++++++-------
 client/advertising.h              |  25 +-
 client/bluetoothctl-advertise.rst |  39 +++
 client/main.c                     |  95 +++++-
 doc/org.bluez.LEAdvertisement.rst |  37 ++-
 src/advertising.c                 | 132 +++++---
 6 files changed, 645 insertions(+), 169 deletions(-)

-- 
2.39.5

