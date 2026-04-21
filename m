Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F712459C6
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 02:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776739890; cv=none; b=sKJDmkqWOBqU1ykx8sDy7kZH6UxFBTOo+iyPkaCuInVMKL9IimGWE2WzCpoxhfxkUbxnZsNlXikbZtuRYVCVzW9J2RFtVv7sD9b4IeTgA4TjZ7HQJro2JwivVjXwrPZNwr0Uj/jy8JJUWrkUPTVI5pcZE4XYh4r5YaXt5q+xmKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776739890; c=relaxed/simple;
	bh=VqSBexJMNIHC54WdCID6u/xPpx/3eQos31xFOQdy8sU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gZWEl1bVwBxKmufY/LhpCYwk5F/aqNBWsTKvCIl7Gtf6yMPB+CT7/RDRmL9Op45diUMrDU7df+1np4PgEQK8D4oYSMe6vTzZTjdech9/868lyGoN9WyNa068czTe6c2t8tKi1QgTGNHLh4r+MDmCG9ynpf+rnBZw1TfSfor644M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bp6ezImD; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bp6ezImD"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82f0884bcfaso2736799b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 19:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776739889; x=1777344689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xpaxH8+vQYVlcVoYKktqzw1Wuz9BvpJGipAw/vPCovU=;
        b=bp6ezImDvVc9Z9cW1v/Tk+O7IU486/vJ7kpwQLHpgTOOu1lyZAGBTCHSi7M0jnQ5jQ
         zDbmk2SZ6ooRPZ92w708eRu7kfNdBbHznDmuVBgpOEHy/2XqUCyewLgjs8ogrlSH6olP
         BhM6QRyQNjCEbr4MtUaXeJLBQE3q4d+EBtcmEdrlASqDKty5Bf4ZLWxADKQ2n2F+/HwT
         kmsJCU622x4gg3vCDOEe1oTwH5zidwM2QZMVuUsPRAXXE1NMzgoaRlysyZ8KrZWA01r+
         OwTWjZr0RzVUI1w3py4g4dKjTNxJ1iELz94qhlFXdnjKUH7YfQUR+SFMB2cUXR8o+1q2
         CtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776739889; x=1777344689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpaxH8+vQYVlcVoYKktqzw1Wuz9BvpJGipAw/vPCovU=;
        b=IgQR0glwB8T94gzlhhWDTW7v+g6cihjTpo+lNMWbdjKSNjCg9Vaz8iuFvrBM+E2EnG
         53ug0ohhDUvs0fMJVqpFAvGhAYuNV5Kn/vLVqM9Y32CpOyeScYs9nubLVWa5Z1pPCP6W
         PtvLWKfqvBi+WvUm0DpB/H8bRW025i6ZhNIyjbSg3dQNGa+8QS0gByV82nyBR8sRR2PK
         mJzKH+eMbhy3iZg7YFPg8iwnz/q3XvDVo3ekJkHMfkOqjqPWJwGcw8mNTiT1LEf4tX5M
         hPB/eIotXmx3OWYc8wDp8cS5D3ewIIarKw/+vmvjemSi0MLNywHy8TbX5CbKslru4E1F
         JR+A==
X-Gm-Message-State: AOJu0YxcABRhvkFf6SJLfcP82lm1vT7Rx7+4WEwlahKb3+weDgGTBgjg
	QKbhlVjm9Mu/OK17JlzdycmLGY9QhpkFqqTSjDB+exIDq1DOqD9E/mJv
X-Gm-Gg: AeBDietBx8vYIsRFVay0krV+fMASZxt7ghLUsnSRnsflcplLl4OX3PgsOkUNmD5yMPJ
	pp6K8+84Ee1mJCvl6lrqmd/Bp3xkB8QpSJbr0Y+SaANzNi86LRCoPaFjZNWlItkB3Zjj08n6FXr
	ocUXE/RY8pwBfqU/qPVIb7ldgFCXCZDbkJkbNF7D65LeoaNeI0UOdf8qC/Ja1TsD2J1/dKZ54TG
	yU19xs3t/0CngqcSVfM8SvwRy8Qw7O7NhmQS0y56CLlEtlnuM2C+kFdXUFsCUvr3ZVBceufHRkm
	3AWVHd63LH6T3iqf2RPJNZBQ0OWt6l8FO15zZYBnxs6nyOJCjP6SV9/K//FFFMg22eN8zFn4Ht1
	mCLy2g2wglW4NN8ROtfpL9ihgj4b7OgKODFvqyPpvS+cA6D5DOp8IzkHGKe9nVBCJ5YdYv9xq2S
	TrAV+4nfWkLF++Kcqq14htBgyyQCqU3BT721s6rbGpEBDlceEzyY9FeC5eRCUvt1D1t6+z
X-Received: by 2002:a05:6a00:3cc8:b0:82f:1b50:d2f2 with SMTP id d2e1a72fcca58-82f8c8335fbmr17014982b3a.18.1776739888830;
        Mon, 20 Apr 2026 19:51:28 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9d9a1csm12823502b3a.20.2026.04.20.19.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 19:51:28 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: luiz.dentz@gmail.com,
	marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	me@brighamcampbell.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH v2 0/2] Bluetooth: ISO: Fix KCSAN data-races on iso_pi(sk)
Date: Tue, 21 Apr 2026 11:51:20 +0900
Message-ID: <20260421025122.55781-1-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Found while auditing iso_pi(sk) field accesses after a KCSAN report.
Patch 1/2 is the reported race on iso_pi(sk)->dst in iso_sock_connect();
patch 2/2 covers related races on other iso_pi(sk) fields accessed in
iso_connect_{bis,cis}() and iso_connect_ind() that were found by
inspection during the same audit.

Changes in v2:
 - Patch 1/2: Use sa->iso_bdaddr directly instead of caching the
   bacmp() result in a local variable, as suggested by Luiz [1].
   This avoids reading from iso_pi(sk) entirely for the broadcast
   check.

 - Patch 2/2: No changes.

v1: https://lore.kernel.org/linux-bluetooth/20260418053239.128190-1-suunj1331@gmail.com/

[1] https://lore.kernel.org/linux-bluetooth/CABBYNZLBoU3byfK_G+=sTkBx3wNwEh2X6_7dG4+4LFtrc3Skpw@mail.gmail.com/

SeungJu Cheon (2):
  Bluetooth: ISO: Fix data-race on dst in iso_sock_connect()
  Bluetooth: ISO: Fix data-race on iso_pi(sk) in socket and HCI event
    paths

 net/bluetooth/iso.c | 56 +++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

-- 
2.52.0

