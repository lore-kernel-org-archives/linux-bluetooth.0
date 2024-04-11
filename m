Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDC5145B3E
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 10:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830429; cv=none; b=WJjYotF3bmvsqoQE42/W9B9Zc9r167qsWqJ5AJjG5Xm0C4Zi5UO+zpwReDF9vX8bur9t6wAxxzwYaRsjz9rqC1jFuhhCRiZu7oHfaE79gIeXRooj7TJzU8wfGtldEeeBYZOWykpwprZJQJkI3kV6qBm+fDPwOLvMzg0jFBmerHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830429; c=relaxed/simple;
	bh=K7rYqTKtn3hlaooOWwERTTislMcVmu9byuQqvaMuEOE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=C2EpSt4A2EaHv3KiB2oBTwxHtJPqVeICqR9iqUeLUE3vLyuzT4EG2qZaTb1MmUQaZ31ePpUAa1jS9K/8Dq5F+qcw7lhum+yFGiJ1y+7ktiaORZEfuJNqYYFSMlhtMiZKrPoGx7apREHG5OGv9V1ZlDOHY+Sj2t4H1DxiwDb0m6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPXxroIr; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPXxroIr"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-36a138f237bso23600235ab.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 03:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712830427; x=1713435227; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=K7rYqTKtn3hlaooOWwERTTislMcVmu9byuQqvaMuEOE=;
        b=QPXxroIr/COixPtpYPMDwc/YA+F4DJ3n0ESnIsxx+dklOpKDm82SRfq7FJ5Nnyus3r
         O8h4szv09n1RJKl+1uzJ8ASEBY6aSlyru8t4zXXLUlBV09sfPcrH/l4D5hTi/2OMT+tW
         oURVMQ3tjQamSL+bKsVJ7jmkCfoDFi76jIXKLng1yo/jKXbFPWyMxsjLVdNDky8SQ3sv
         RhOmRMOL0h81MOSIwmLMOmo6StLZ3hKbsVDRdOyrEA1/0hlWCKophSWGwGBg5IBQQqmb
         +0CmVik0jVm292xiiEhASDeqb+wEkOML6+M7Nn+egnw04/IlJzkdfGIUA44JJ8uD2EtQ
         f3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712830427; x=1713435227;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7rYqTKtn3hlaooOWwERTTislMcVmu9byuQqvaMuEOE=;
        b=Phcp+f5Ls1FKZ2vU3ceGXtilqxYc0CVeNmy5643srO82vHj1SBaz3qduo7tRm9uCNY
         xWQbf51yH4yiWqvA5Nm8TY2xt6IIHnNvalvEHOcFvwN4blNAs6C+VqcEc0JncqubN4ep
         6GQQNebND3NKXm86XODRi6Rev3qT+CXi2xzLWzZv1g7zS4dChr089ISw2c5WxG76jbBC
         7cr2WscJrvar4Ivu/pMpig22vUAnHQOflFxmWvN8Ajbq/mko8kVGA4I1m/G+24Zk9i1z
         wntNvbzEgbq07tsbjAn7JUsAuT2EcEn9Gfg3evsPZWJzpPCaCEPETgy10QWy17RJ+C6p
         Qzsg==
X-Gm-Message-State: AOJu0YzqCWWTbpwzhZG5G8poVpQ9VDwM5S8v+aw8fYNGNx/T7Utd96Bu
	dpB3n3kATQavJzmeNv8Ui6SZHta00sepvOb7fp/LMNl91TODqa6aAaQBeg==
X-Google-Smtp-Source: AGHT+IHz9hOs8e9jT02FgUuUwJxqI6OCzhZmOzvPvBGSxhnIZAP8zwxIDYVhNSKSVnl680S5KtgdKA==
X-Received: by 2002:a05:6e02:1c2f:b0:36a:32f2:fc71 with SMTP id m15-20020a056e021c2f00b0036a32f2fc71mr5445117ilh.24.1712830426724;
        Thu, 11 Apr 2024 03:13:46 -0700 (PDT)
Received: from [172.17.0.2] ([52.225.76.18])
        by smtp.gmail.com with ESMTPSA id u27-20020a63141b000000b005e49bf50ff9sm804485pgl.0.2024.04.11.03.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 03:13:46 -0700 (PDT)
Message-ID: <6617b7da.630a0220.55ec5.1eff@mx.google.com>
Date: Thu, 11 Apr 2024 03:13:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0680270373565760961=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, jiande.lu@mediatek.com
Subject: RE: [v2] Bluetooth: btusb: Add USB HWID to usb_device_id table for MT7921/MT7922/MT7925.
In-Reply-To: <20240411094425.30550-1-jiande.lu@mediatek.com>
References: <20240411094425.30550-1-jiande.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0680270373565760961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btusb.c:616
error: drivers/bluetooth/btusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0680270373565760961==--
