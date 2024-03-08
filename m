Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DC15B660
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Mar 2024 18:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709922374; cv=none; b=WrW9pTG6dKH4w7V1dr7nh+JXhoSp7mWy4qRYPxk6iQpRlkQM+VqhtzNf/H+xy3Z8oucFAXe/FbS94vXEaBN8nJC/wrYdazLFSw9RcKzNACqOEB/vGCmrrpD+IpRlgFh6dwmuyjD7uugZrP0k0uAB4mI9FL/irqVPnJLXyucHuNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709922374; c=relaxed/simple;
	bh=HTRaUDTEx/zpmLDuNYt6ojhJ/w8fz5LCklkAorknijw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=R3rbQAgoAChpD2V+reSjuU0T5k91+hrzDTEpov2kF1OV6HOzfw2MPesbV5Cz3cW6kSA3dLt7yTeDw0/++EUIbj1giGWxetZhAtlZ3qotB2uDf4M/urqYiLtcc8/I1C20yxT8LglkV3zv3PrTBo8qM6VrrsHmxfKy4mkJ7UP14GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXFTyfIP; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXFTyfIP"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-42f2a4f77a6so4033251cf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Mar 2024 10:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709922371; x=1710527171; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HTRaUDTEx/zpmLDuNYt6ojhJ/w8fz5LCklkAorknijw=;
        b=nXFTyfIPp1FTCv+1JG/t1bhUfuKOxTo4LXrizsi1EtVH5tkSkvLwoAqe7V+akwDGFS
         E7+ONUCFNUnghRzsP8LJDSI61hP4YkZufvp2KMvRp9OqiVxTN/6lFvBGRGlbQp1eHhI8
         Iulpq6oVbYcW+MKFT+tI2oozESwKcP3uDW1LCeb97Io8CbCqRV1pl08Au9iAHElreBXf
         ZREDMDrU69A3I2gVTvrTl1GpMH2VXqCPrO8TTDyRzwoXwTyQXc2K8ZC1LPlidaVhucsq
         66/PU67MF+nC4T9+q7SkRpicsoIXm9PmwYUzPPnaRyKK5pOR1f25JrN6aouT7Gv6xioF
         P8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709922371; x=1710527171;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HTRaUDTEx/zpmLDuNYt6ojhJ/w8fz5LCklkAorknijw=;
        b=aaTAqNIVojEKEx8ZVPBwXxUr6SEP7TrG9BJKYBIb34ebrcGt51NtfIhAhmYPMGFL/b
         Tks5d7MXalA8HReVRoVCP5Av7F9RpBu0+E/VSMsL+qp9OzS/UqtY7Qpo+D5ZcZcR+AQW
         7+JjXBf5M073HHLRAuJdpgI8TowRyPB/ysE2ynQHShx4Zs+Pa0wSjLdJum53YXd63EPw
         gEKG0VFJaKdcLxolhsIg4f0ltBP3iST6Fu2YveA9ylGsowg5iFknltHd1yKrzXTHCjjK
         BEuArSIXjEl4VGGtHjrQnmizZm/fpsjAT5X3t/FWDcP3RFuRDFhuZU19RmQrTlucjrWN
         Qi+A==
X-Gm-Message-State: AOJu0YybEqrKqDkmtiziL/gtdRjUTt73SEwyHfKss6177BafOsShJEp5
	BephtfF/AcTV7FcN/J0AqeRMcGyJR0hLwViqhgq93pdyVUCKM1MeDAkxM4l8
X-Google-Smtp-Source: AGHT+IHC52b1ADc+PkzlXW/qgdFc0l4GAKHGMv5CVaeeqnRnOsBpv5jN6B99zH6BY1t3hQ38gcI41w==
X-Received: by 2002:ac8:5a0b:0:b0:42f:2075:9899 with SMTP id n11-20020ac85a0b000000b0042f20759899mr938393qta.39.1709922371559;
        Fri, 08 Mar 2024 10:26:11 -0800 (PST)
Received: from [172.17.0.2] ([172.183.161.200])
        by smtp.gmail.com with ESMTPSA id g24-20020ac84818000000b0042ef85c6a42sm21615qtq.17.2024.03.08.10.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 10:26:11 -0800 (PST)
Message-ID: <65eb5843.c80a0220.33446.028c@mx.google.com>
Date: Fri, 08 Mar 2024 10:26:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6795202876515844174=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ayaanmirza.788@gmail.com
Subject: RE: Bluetooth: bfusb: corrected mistakes in previous commits
In-Reply-To: <20240308180321.178945-1-ayaanmirza.788@gmail.com>
References: <20240308180321.178945-1-ayaanmirza.788@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6795202876515844174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/bfusb.c:274
error: drivers/bluetooth/bfusb.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============6795202876515844174==--
