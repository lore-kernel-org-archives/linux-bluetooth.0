Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B051DE4FB
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Sep 2025 14:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756909027; cv=none; b=iaL49bGVueyB6w9jctuwwvSjBMP1GGATYfAzZVsoadYOhfTIJMpEYXkKQoUjDkCZpQwwIW33TrcYDCsZMn97ex4A6dBUS3yPfGmmfV0/xxRYBmbWLoGAZP8zf436XjLWlBE4J++k+6t3on6BJDCU+sRE9LaDvbfUNInCAtKWsqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756909027; c=relaxed/simple;
	bh=JatAPhflkJ4JWJqptV08mpKUWDcUr9jONKOq1H3KVwI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YA7jU77G0bmJj/RoSm0Bhre5UnKJxD6a6G9AEXFzf3kNBlRJxsuoP9gXNZJaPIKVcURe2LubnYwc0jhXUkpU4sN9oDJMh1SGtuNHM5kAI2sArZVCihFC4N0B7lZS55gconiSOZqjJk4ABpTgPXgIv3yBXmo/Iprg9vsLQ9rgJqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqfLHacD; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqfLHacD"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3f4d7feef27so22080425ab.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Sep 2025 07:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756909024; x=1757513824; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JatAPhflkJ4JWJqptV08mpKUWDcUr9jONKOq1H3KVwI=;
        b=FqfLHacDYrToh9M8lT/8rbOUTte9Rcw45yPokpjeHA16bahEr7FDSvH3ru7GsqkULu
         FkB9FRDraUVzlv96UnppS6kWBF+wZZMREwqPuWqNBrMZHyyWz3XsnftADt2BjKh9HALq
         RJhWAojA0ocKjSCFwPEYaIbJYfTT/vr24dWFIwmVzffBwNtQ8iGutmSJfxp3T7NE1Ifk
         ycuz+kFOLl5fp7VRkZXRPvu4DghG+HQbBEgpZMgie6sNbNwLWiMDC4oq9eHifC+INrwF
         g6cKTeny80frR0+u2iHPmpCzbmPba1CmRPpdXy1JskEq+Rc5qtXlU3aWAmQWg50s7MKU
         QD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756909024; x=1757513824;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JatAPhflkJ4JWJqptV08mpKUWDcUr9jONKOq1H3KVwI=;
        b=hbK49t1UAUNCCJpfnybHgCUNevwjr3VqfhsQHQQArVxqnLYJIpik2RRspV+b4YBzaP
         uzT41cxBDtJCqCpZlKbqaHdVMe+Y1EpxpHNrFwNz01peFJLEFeI1kOnYWIHr1biSk/xf
         w7mKCc8LeKmqTmN9oQLQr8uqn+fIf2Vl6V7uzBcX5UbGIsEzX4I4lzkf0w9uCeNWZrI0
         wHx0U7Q/K08F3Zl4XgADprTWDQK3vahsRhrSWsAo9/l7SRwAETAptZOabgWAAeISwkmH
         nyunq5zsX2cil7SQKo2W/TFoZ7DOigZqpaD+4jnRyKELnWww+IxogyVuic/cKEqMvc5k
         nyow==
X-Gm-Message-State: AOJu0YxwRY6iWsgjceTcvpAJeqMr4a50ISl1+oCJG/8viFraa+bc/tFM
	xp9axA1hET9G47Yzh6KhapOce+QQPNM+IMF1d0znmxM3in8531oSDM6WjpQpLg==
X-Gm-Gg: ASbGncsp5WIKaDJ81DICvF70JQxKLSdoaqDjelQBhc1tB84IGbwS4JGybLc/REzvArX
	jct1nNrprLNDQ/nC5ISwmvERWYwFw8h6KOs2MHvRRbS63VyAK8+zJJh9BVJnpF0Yuoyx2FxwUNC
	cHOp3eLbqErijQefsmH2iEigcRBbS8dF8MZEpjARfLuiY+V+bJC/mYT0EXWE8AQHuAeX1CbNLN1
	qhnNtiCKuqA9dbUqk0lH+ZdWVMfJbmZN15rtiJ3cgT5YjU7HMUaZwVXURQVgXZgN3PTkTN1t/XG
	AH7RfLi5yBR1sfkG4VFh6N1Al/JUS2zOwymo7DaxigcIDMLi4+gxxDhtJG3EhiBaQDam+0clxMk
	xOft5ngqodTvx+HomOleiOGTt59heua01fTEBBw==
X-Google-Smtp-Source: AGHT+IGp//cheLlxyuRd5LC4iazIIFh5/SrnLujgV7x+eIyifXItjlMbmuQwI34yO7Qi0eobR564hQ==
X-Received: by 2002:a05:6e02:b46:b0:3f2:70a0:3b50 with SMTP id e9e14a558f8ab-3f4024c81e9mr268973535ab.27.1756909024434;
        Wed, 03 Sep 2025 07:17:04 -0700 (PDT)
Received: from [172.17.0.2] ([52.154.20.58])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f35cd6dsm4104480173.58.2025.09.03.07.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 07:17:03 -0700 (PDT)
Message-ID: <68b84ddf.050a0220.11f5a2.7933@mx.google.com>
Date: Wed, 03 Sep 2025 07:17:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1091109368994873642=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, calvin@wbinvd.org
Subject: RE: [v3] Bluetooth: Fix build after header cleanup
In-Reply-To: <aLhLTiIMRnjHfvOn@mozart.vkv.me>
References: <aLhLTiIMRnjHfvOn@mozart.vkv.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1091109368994873642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/Kconfig:312
error: drivers/bluetooth/Kconfig: patch does not apply
error: patch failed: drivers/bluetooth/hci_uart.h:121
error: drivers/bluetooth/hci_uart.h: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1091109368994873642==--
