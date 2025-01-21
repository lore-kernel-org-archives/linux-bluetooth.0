Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719491DF96A
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737463655; cv=none; b=gdmGKishFpJBEz4REwbRqbQr+lo7a9MUPNrVBhkb1NoW3Opq1r9O80ik2s6CbMqSWIXGEsaEZSJKz7Y0d/VH47nNV2+2tYuW5ygqn0lhSEpqQ5I1B6/Bur+3HJi52H4n+9+YaRQyJ9ybEwStU8wPMq5oGYbETZmr1PF/a+/aKAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737463655; c=relaxed/simple;
	bh=SQL2MFREAWaN/4qHvshr+g3otFmRHQoEYRL1Fkod9NQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aGK+Us5AWyFwaIk+GcmypvNxRgp4vsI+hZc7dkmCncM1OSxtQdOPZ/wgFHbPDevmfNXj/WPI1jBW6ig6RT4F6jEM3ioLUjWACRTtPg+ivzK/xwmGfhqDCLgKa00LdDChyM6jQk0Q3mZ3fOGtjPBYJIW7Nbkk3m9ylkHGOidxuYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=b+VXVUPb; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="b+VXVUPb"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d414b8af7bso11638153a12.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jan 2025 04:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1737463650; x=1738068450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RDcGfR7+757tG2ZQQaQktSJRT6ekJ2eQLa8owa3MNYE=;
        b=b+VXVUPbsiPzjtSpqN5lx8O4sXJe3mfcuV84zHBqeOEhIBcbD0OkaH6/QolmKloU/9
         eBCRmY0DGft++RiSLpKnkPMD8RNbp5BPzZ8HxVhsEEoQV/2MSG7xAo2fWx2Mtc6CO+eS
         VjFKMiV/9P8yxp07yFhaNRMZ4Qx2POjPYU6Sg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737463650; x=1738068450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDcGfR7+757tG2ZQQaQktSJRT6ekJ2eQLa8owa3MNYE=;
        b=ES89u8ipGhdciR6aQwYyiGpiF7ZIyJU14HjhXrMXGY3c73UqY9JEpNbdwr/ZsjiO4P
         EXi+3atngBwX1nq58eVz0tcgGhpQ1Ug4mm0M/e7vG10tWaKhgwFUjKiRHqVz8+1H3M0N
         3TySqYJPEy4k0wottIaATQ5CVw+R6NpwjboCX4cG5SN5IFFy/W+sQvT1VKO+AIy+7y6s
         //jBm5QYVgd3qZbKFqT9NWSeCIEPP63qbKodFea6z4zOkKLGf6vmJ7jIo601bDIjy3SZ
         lCIbHMMuomEaU9y8/GnbbckJPPXV8hV1ui+5xKTamhdZZhh1QqDakVcyaklOQ0pnc+5N
         2HZg==
X-Gm-Message-State: AOJu0YzSxQ9838sY/AHCupA2ES3xAsgVSoE+nLl6/AmB03dnaGgwIyF5
	7AJbul12Ncj3tS2D1ebrNKNkoeEsR/92y8lXCYUoTiIGwmvu2CclwjEqjeYkLbudenFHwvudbdg
	=
X-Gm-Gg: ASbGnctxrAmC3MJ8meYH58QWMZZxWOChktJsYyaStz1VTUUrliIX16vwHJpe5HTWHOS
	4BQYjQ/pzNl8ghdTSclkke18kaAT7MUvNU+/+SCPjybfPKY3ATYssEMeILKETA4a8dU+t6eVYRx
	wlBn+geIS0K/C0aPKn5D+rWWQ9h01aeCuE098PgwsW5NUCZrbVAtfMmG+WAge0TNx56UcVnV9bB
	aYdYHHXt2fiDqguiciYwhFbCpmqA6z3NRk+McnASTbDbaZdluwW90nnlhn7TRwvdZ9gD15PQbbf
	gRyDJljutls+Arh+O6jwx6WZJ2Ysw+usc9kixpPHckS8
X-Google-Smtp-Source: AGHT+IG8dXe5YFcyLOkHyreno+MCzom8EEv3WVlyc5TO+IlwatPE5+lKrRLep7CqJUPE9rsXdA4bvA==
X-Received: by 2002:a05:6402:3509:b0:5d0:cfdd:2ac1 with SMTP id 4fb4d7f45d1cf-5db7d2d9958mr17453612a12.6.1737463649881;
        Tue, 21 Jan 2025 04:47:29 -0800 (PST)
Received: from great-eastern.. (public-gprs172205.centertel.pl. [46.134.11.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73670cf8sm7153591a12.19.2025.01.21.04.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 04:47:29 -0800 (PST)
From: Michal Dzik <michal.dzik@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Michal Dzik <michal.dzik@streamunlimited.com>
Subject: [PATCH BlueZ v2 0/5] connect VCP profile to MediaTransport volume
Date: Tue, 21 Jan 2025 13:47:13 +0100
Message-Id: <20250121124718.3995904-1-michal.dzik@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I reworked my commits according to Luiz comments (thanks Luiz).

Michal Dzik (5):
  shared/vcp: add API to control volume on VCP client
  audio: connect VCP profile client to MediaTransport
  shared/vcp: fix memory & connection management
  audio: fix VCP connection management
  shared/vcp: control volume when acting as a server

 Makefile.plugins           |   2 +-
 profiles/audio/transport.c |  37 ++++++--
 profiles/audio/vcp.c       |  73 ++++++++++++++--
 profiles/audio/vcp.h       |  12 +++
 src/shared/vcp.c           | 169 ++++++++++++++++++++++++++++++++++---
 src/shared/vcp.h           |   7 ++
 6 files changed, 274 insertions(+), 26 deletions(-)
 create mode 100644 profiles/audio/vcp.h

-- 
2.34.1

