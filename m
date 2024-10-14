Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06614F21D
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 05:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728883314; cv=none; b=IK1NBYiepeRs5KC3MHbGZbcG3cMH+lOr3Hswl21UiY5d1mUe2VNxygoHU4ztJtYigfgvxVeZxcifp8pnDLCHuAl4LUOBwg6CkIlSw/EQ3yl7YQH79Bsvjuf7imXqfRxHrdDvy+WoV6ddKqoAuihF25eURwzB+vyUJ6lbVapD0IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728883314; c=relaxed/simple;
	bh=2+QidaCaScZAFIRIeBcVT/DqRVrEsCIfa2paa8AyXd4=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=o8Ik7IkRwz2iQFoHP/0Kp/GFOdhq+OGy1lb4ZlwVKI25ylfdG3eC8zqMHkdD07zU3vkopagqkENnZ11B1wBSp8baiAA4IVR/VvsGN1gG7e3VdnJ413LGEyhUC3kPyHJGJ48q0qO5O3aa58Osa0JZI1KjTxCwwY9Ql2K/rf6YX28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZ/c7FE0; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZ/c7FE0"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e4c2e36daso985045b3a.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Oct 2024 22:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728883312; x=1729488112; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CvpBiypj3guZ/4HohYrgozvY0hawK1YRk0OtuMnBQ10=;
        b=bZ/c7FE0BP0OKPevaHhYeajBHdEZEeWa2fz3hMu1cB5BgUgOHMlzHHZNGuceAOSNkZ
         CdAKuClraShg6pQz5M3+T9KFebARHLzoO5HjotGICsgjGU1u4S8REv2UbZBDyHlkV6Xf
         FaVGx9GO7K8GHGWk1UP8QgWIu8HD2wtUxV2sCCJ/qZsCeDGJ13GnfpDIZZC2EuoWTuTb
         TGVbZDE1TwNLKHd4Bd63RJwQ5ZpvZjkkTRo59XUt97ckF9Y/+MtlNPeljsdv2GGRr0Lp
         Z14JAhZPxfdT93tGRg9AToZXaPCJMPtdZxxUHVUF0j/CObfn4fQ++bqWqxlYKuMUiotM
         Xv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728883312; x=1729488112;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CvpBiypj3guZ/4HohYrgozvY0hawK1YRk0OtuMnBQ10=;
        b=WmmvuRw5XBPKzBMfJtO9034FiPn9W1ddkhpezIgOYrsDSKs5/2nyWK+FAWHuM8NRPJ
         jicm6OdX4V2DxV8diGEdLh3EYDpxc6QXMpJINZFfDJbwSP1ddKQ4ah+VMgyUH/voCAF3
         Lu4pOhD4PhJeS4EXeLa0whPap+qzkleSPOFS2bSC3RQ+A6h3mdqieDgyHPW19znMqaRd
         t2wm8fISAO/ksBLOhzuW+shYzPyQpwnjPxwEd419paK7lct5RcHqqSs/fkJqJibTaOmO
         XDGdU/Vim5gXmJeE+Ul7j3NTs6cGzWUOjx/cviY3LuDCBOrmj4dXC2j9+p6WpXigMcaQ
         gdEw==
X-Gm-Message-State: AOJu0YwnM4NtJ2fibEfKpL9sx4A3RGvZ28ELjK9YdLmGTBq8icqFDWEB
	LK0nIf+kLu2hh1IGOsWbByqn/NdKMGexn+O4RxKAtE6lNd9KZsTF60JZeg==
X-Google-Smtp-Source: AGHT+IEmpK9JTv4bNXmihOtJrxOPHHz6kX/aWciphuRTxxxwwgjSbg4EP/xy41oVPSlBo9F7Ge4zbA==
X-Received: by 2002:a05:6a20:b40b:b0:1d2:e793:cc0 with SMTP id adf61e73a8af0-1d8bc81268fmr16472215637.7.1728883311668;
        Sun, 13 Oct 2024 22:21:51 -0700 (PDT)
Received: from JUNHO-NEOSTACK. ([221.154.134.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea83fa6778sm1259269a12.88.2024.10.13.22.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 22:21:51 -0700 (PDT)
Message-ID: <670caa6f.650a0220.9479b.21c7@mx.google.com>
X-Google-Original-Message-ID: <ZwyqbHBI2yoRiqfT@JUNHO-NEOSTACK.>
Date: Mon, 14 Oct 2024 14:21:48 +0900
From: Junho Lee <tot0roprog@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: bggixx@gmail.com, tot0roprog@gmail.com
Subject: [PATCH BlueZ v2 0/4] mesh: Fix segmentation behavior of Lower
 transport layer
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

These is implementations of segmentation and reassembly, except for the
friend feature for LPN nodes, implemented according to Mesh Protocol 1.1
section 3.5.

v1 -> v2: Fix coding convention and linting error
          Fix SEG_MAX() argument in unittest for mesh crypto

Junho Lee (4):
  mesh: Implement lower transport layer for segmentation and reassembly
  mesh: Add mesh conf for SAR Transmitter and Receiver
  mesh: Fix inserting NULL into bool type arguments to false
  mesh: Add features of Segmented Control message

 mesh/crypto.c           |  69 ++--
 mesh/mesh-main.conf     | 107 +++++
 mesh/mesh.c             | 125 +++++-
 mesh/mesh.h             |   2 +
 mesh/net.c              | 873 +++++++++++++++++++++++++++-------------
 mesh/net.h              |  33 +-
 unit/test-mesh-crypto.c |   4 +-
 7 files changed, 886 insertions(+), 327 deletions(-)

-- 
2.34.1

