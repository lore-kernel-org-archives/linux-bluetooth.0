Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627E547B41C
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2026 13:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786626466; cv=none; b=q3F5QQ1NEdHPTR/lPhcF5tGf5yytwWmfJyNw+/edx0luuL87edOZIKmMfWwTZ+koHAH3BTYMjuF6sCy1hQWOikOFP0YtVtLruj/mTjTsmNzdOTS4asigLIMnWkVxmv3rLWpKtL3oNN5JKRqKPSijbxXE27iP1eivnTY+hldD1NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786626466; c=relaxed/simple;
	bh=PgCkBg+SaqY2ck5/bBDSS+1DtbuO8coJDwswlb7aiy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYmDNqf6Tx7g9AKLZ2i6dHrus7gbAH7sOvnjeLkQyPfPw/LBYViPVLwe8oyPlCkvF2CP0/Mq4f1fNR5iyRfbQUQhC2CkUlx+CFWjXDf8cRzojt+Zdnk+ZnUCG8WuEovkCFVi39IxifOEANBp0+95ERwCmyls4/Xu9UWkCQHpK8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EWcNec1z; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EWcNec1z"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso15070595e9.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2026 06:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786626463; x=1787231263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fMxauQa/lOA4/+kENFd3ICiTI2KeojXJKd2HkM4Rljc=;
        b=EWcNec1zcJYAmde1PZCkNdU1cZKydSyQN+a3KKI+2CXow72LAXSvzDW9boxiz5zFuD
         NxR4xD+SZwVHvLuTMvjcliRS6cyLgkOiB6Wvxag5oP6ao4UO8Z3qkQAHq2HR4w8mcsRB
         UnvUFCczQDFg/vRwVAvZ9UT/AfBP5R56hGPlqnKywwMt3vS80DK68VN+NIhy5L8/Bt22
         z7Q+aVqcr7vACoC6Qi5/95f9EEunmqUdu/s5lLuiAH1YouBsHmXzBQ3eY5mhro+kIGRw
         XU5oaRv9eZGQnI96hNxUqQv/H3Eh+kUMkPG5iuuO6htwC5S5Re6gD8gZA0b2PEi6o89w
         ewwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786626463; x=1787231263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fMxauQa/lOA4/+kENFd3ICiTI2KeojXJKd2HkM4Rljc=;
        b=DGCO7PRvT9Sn3u25MemFwl+5cP/sJb94K/ycEzNAS1MMDsv0EOLXtEUaofXUMbcBXr
         Th2NB4Aay/YI4eAcTEB5qGafNRa6fHdUTtfp6WSVdmYpxueGYEdnw0hyy88+MouKkWip
         V6NVna6vXboTOtOzuu6/Hl1lg3TffSUZGu5J6J2dNaNnvS35P/NnK7XY9e35/pQZqU6v
         oqE/ZQnu1YnVQjceHmiD5hYmpvjl+dd/MesUnYl1SmEARK27LUTFiS23kmGtWfyXykTn
         2sqkwhqk+SkWGTtUjA+WxvbR7WdNxoycoPUcvhVOxhnbsHSWGS8TnRTelMlYXmGTWMI6
         GSnA==
X-Forwarded-Encrypted: i=1; AHgh+RpJGekz+SvG7kVR7F3UDnXg2fZ3w6FXyIHXoPf7EF9NAXBU6nV0JEEl3F1ymBHqvjMADdV/dNbLiIcZ7PB/XAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpCxdH6t2BRU8Mf8wm6CbKHz1bpSJeluVL1BolbNx24sZQjdwt
	IRa/zGmeLqYttA2r0HhZeVWcHmulXm2fxs9saMBAR5kyPspJ+RXpAzzVRmGn2d8Q1bA=
X-Gm-Gg: AR+sD12d8cUsNXEGtvU2RklVW1olqDizvtqhANxnySp+ucFWYgCJwlXiZNpRY8j5Xnk
	tOifKo2uqYztUH40fc0OYPR9J69RUsSZdebb5BfUELjr8pUVBg5YVyqlF3+zmGIIG3jNkyMkuwg
	q0K9Qpg1oax8WOI5ljnJLDOUycW9Up8ejMxjwIBFTl7ND0m2KUkFppTohsVWGmsfCOmlOZJOEcT
	3Nxp8ruXWNYNjSOy7sg2qNBHjR6Vt1T6xeW2swMny47MFTz3pi98v2rQ6E+4eSq0sbj4kSjRzne
	VkOttuAWUI77FT6apdS930syym2zRzajmngrVrWsJNOm84axqbkuGB2yZObxIsNfDlCqpUtuqph
	tQ/jZsk1EQsfyj88gMYnxBO1E6nuTK7FNnSJ7i18r7y1Ayv2fO1BalpHptewvi1bggUaBIqC5tD
	5TWT3e/GPN0+yDLaWuziObsoPYSP+hv3x/jq62LACMLL5aJQ95IPx7vxpnM+r58w==
X-Received: by 2002:a05:600c:b99:b0:499:7a5e:4c3f with SMTP id 5b1f17b1804b1-4998215a94fmr60223455e9.1.1786626462572;
        Thu, 13 Aug 2026 06:07:42 -0700 (PDT)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981abd6desm72030885e9.0.2026.08.13.06.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 06:07:42 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: daniel@makrotopia.org
Cc: andrew@lunn.ch,
	dakr@kernel.org,
	davem@davemloft.net,
	driver-core@lists.linux.dev,
	edumazet@google.com,
	gregkh@linuxfoundation.org,
	horms@kernel.org,
	johannes.goede@oss.qualcomm.com,
	kuba@kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	miriam.rachel.korenblit@intel.com,
	netdev@vger.kernel.org,
	olteanv@gmail.com,
	pabeni@redhat.com,
	rafael@kernel.org,
	Marco Crivellari <marco.crivellari@suse.com>
Subject: Re: [RFC PATCH 1/4] driver core: add device_schedule_reprobe()
Date: Thu, 13 Aug 2026 15:07:06 +0200
Message-ID: <20260813130706.238544-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <anpxXANMYTlOHbPo@makrotopia.org>
References: <anpxXANMYTlOHbPo@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

> +	queue_delayed_work(system_unbound_wq, &rp->work,
> +			   msecs_to_jiffies(delay_ms));

Please note that system_unbound_wq is deprecated. The new unbound
workqueue is system_dfl_wq.


Thanks!

