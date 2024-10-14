Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B6314E2E6
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 07:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892435; cv=none; b=HWhIybiY8dMTZpBYheXxVWygxTLNEdijISLb++Ez0EoI+8YBE4F22qLlwlZDWs32XiJcCfRelktQOVb1+tgGpTF+YrArosKd7SMXWENmGcHDipBXP86+eywkn1nGhS27T4AAdZgl2/2nb0ned5YQapvduQCBsIie7CIF6B7IuTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892435; c=relaxed/simple;
	bh=Nz33znAN7wAi7ok9+rP0GbuQ4yB15DbWhKhJ0sqJtwA=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=LzVadJQNab7W3n1GPt0A3c0yiSy59+zl4XZaaKrPcB6SA+FtA+chqWEGzBlA8lWomaDxl2a/9LI5DyU/pV9icfcuLN55JUcQKVT1jHwMCPxosUtTwSdkbhEBq8qcwy1q4P3bHdwOuzsFcdVpi+aAIht9uNir5jNf2XohiwpEhGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFRMY0St; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFRMY0St"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e2a97c2681so2854997a91.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Oct 2024 00:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728892433; x=1729497233; darn=vger.kernel.org;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NdOh9e/s2+7QueLDAcREye0e4tDqhCQJ4Y3zsC/NSgI=;
        b=QFRMY0SttZi40IISwWD67OkIwTwKs5uqqIlgtt/cH61iZjo5INcBtl+KNQdhMyky7K
         dvatAy0fJbMg+jcntjpswcV2H7rd7TVzEbCFpMe9E+E4sm+suALCpY+269yhu7LUcmtQ
         nUZaMITvJpYDgmmhxfJ3fWoigCi4dj5gdTlRFpHvuf7PLaCPtYsX8tHYzq2IlqT6Bjud
         9oAb7dGTxM4tKaE1zyiJhOoGXUctCDWxSQMmXUwBhouBmHLUUUFZSmJzMdwnI36lAVG/
         ke/ZtVueUBcpA18oV+CX3k+MfRoOVJxC2xjz9an92mJs7U47l9O+SqNjrwUNMB08hLxj
         qisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728892433; x=1729497233;
        h=content-disposition:mime-version:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NdOh9e/s2+7QueLDAcREye0e4tDqhCQJ4Y3zsC/NSgI=;
        b=Tb0NXJtqADe86AmdnNI0UEoAuSdkeEjezZWWMvojdZmcAZkJ0MZc1PHo5b7evN+QRH
         GmNh32JIHTBYRCGWaHexPyq2Ig1UBC8ZJ6TRy370eQ3zaDDa7mE+RspwOTZlAY7gWU5l
         RafFmeZuDEwxcuQwYg+IDi8tEeMzPETIVmEecIkI2TTXIsO7zCPmZV+cj8o9f22LuEys
         6yN/sZMRmksxw2dM/toJJBdauWufUfKU7d/P84qjvr01eqRGUizkwl1Su1cNEbKh5V3x
         6TGgQTCLXsFMAzTJoXD0C8B98gGnh7ernOrqVzpBA/bSJGnboC46o0btj7peYsPh/4vh
         7emA==
X-Gm-Message-State: AOJu0Yw0OXL5meCoiKYcfRcFEJ+YnIcdIPRCIb52l63IwjGAj7urfYl/
	Yrh0XEE05Dv91/yiFLpJoq5xDUiqp9TwwO6uRqpQb5Z9g/EJF/BmlvbJDQ==
X-Google-Smtp-Source: AGHT+IG7/JitHlqPu+o45Htem81fMmzI43vREyIOieiqnUJSQpwN7wReqPqWXQyYLXPGaXiTgtphxw==
X-Received: by 2002:a17:90a:68ca:b0:2d8:a672:1869 with SMTP id 98e67ed59e1d1-2e2f0d7b6cemr12366626a91.32.1728892432756;
        Mon, 14 Oct 2024 00:53:52 -0700 (PDT)
Received: from JUNHO-NEOSTACK. ([221.154.134.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5fc57desm8112972a91.50.2024.10.14.00.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 00:53:52 -0700 (PDT)
Message-ID: <670cce10.170a0220.1255fc.6625@mx.google.com>
X-Google-Original-Message-ID: <ZwzODSKsHXg6zU1A@JUNHO-NEOSTACK.>
Date: Mon, 14 Oct 2024 16:53:49 +0900
From: Junho Lee <tot0roprog@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: bggixx@gmail.com
Subject: [PATCH BlueZ v3 0/4] mesh: Fix segmentation behavior of Lower
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

v2 -> v3: Fix line length


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
 unit/test-mesh-crypto.c |   6 +-
 7 files changed, 888 insertions(+), 327 deletions(-)

-- 
2.34.1

