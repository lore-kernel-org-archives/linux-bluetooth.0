Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45023450F2
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Aug 2025 22:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755296232; cv=none; b=eCjVbdk0A1Sd/OwpCrU1ACt1YKTNDxIdM5mnZiOCx/iQwpbXPDJgn8jOVW3CsXehiah06u/9YO+oDg9W9GE+RxtwrIP/L1Ud3BuC7sSmT6xZSipQTMIJsa7ikrRLyCUL0C7xyFlkdbVhR1YRTqiXbIZwdUIK4zFeXyK2q5WDVAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755296232; c=relaxed/simple;
	bh=4c1/SJdhCOosUZtTWW2OINHe1RaTktufPc/2DP9JAyM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rXbNUV9VC2X5J69TZ5Qtjgu/vSRGTIpS2zgYOkwUlw4ScAZaPNlWFPAsAotWvgU/A59MW4luY5VGGCRVhMxA0E9E5PT0KOQbEXvfY46JSCQ4icpLMWvTrrfASRTFcRndcVnz0sh/sqXSg4rn/AFPrR3/3W5uSAaGuDpCSpnFHW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bePO+w7+; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bePO+w7+"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-74382002fa6so1118818a34.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Aug 2025 15:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755296230; x=1755901030; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4c1/SJdhCOosUZtTWW2OINHe1RaTktufPc/2DP9JAyM=;
        b=bePO+w7+rlnK+Ps+PDNnZXG/E6ALaAqJfNTco2R1ljxx9zOEWXPJgm/YWPMNQwFv2C
         /Fy8GPj0uREgiZCDeyTbUFmcBvSvurfj6zHCZypsPYyREG8M7iR73HCkGISsAVlSkxN2
         F8Gq91Y/zHxIUaOV4kf8LOOreo23CD3WVjaY1g6+oGDOsqBQTdBdjTwUaejEw6ZADO4u
         3uKvlWQoG1wrNuH22j+tcHy89JBhTmmC8sBV2kgKhKsXEQ1MSjJBVMss0nBhC5cyj+Pv
         PfFbH7wHPcJk3x4kNllrj0OwPigly+m0zklTPxVxlQPbv867LXynqaTGKNi+HQl+ON9l
         o5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755296230; x=1755901030;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4c1/SJdhCOosUZtTWW2OINHe1RaTktufPc/2DP9JAyM=;
        b=IXwP0VTFAC7M75n9GZMeLiS/i8xu6PcLUVCXE40VT37WHULub1CPwfUU+uFeuj/2DU
         yR5TtbzvLrZ9ETDiwc+I0StMR5b5tzJT5RwZoODxaiQzfxEA5lvpzaVZgUYlfUWPEdtZ
         ICm7Lr29kqk6EnAL7Gfeg0RHi/9siLXeltDRsmTxl/zsR5gDZfF7vAx4Zfsmah1zFM7C
         CW5z7ztj3YPG9JPmTKjaIR+tVq8TLgXcGpfzduAvj75l2SvnIG5zNY4bthfJmNG1WYkf
         r2bm6PSFQqDIkRz3Oi/ZpaY0tPTB2Lv1938lgZdbGgtBgZ5iarB1N67OvnlYUOXm04sU
         BfDg==
X-Gm-Message-State: AOJu0YxH+lC1+ndxpICQeyDeZeM+VdE9QkPQsussOi+zOu48YZPZ55P9
	Ip+qApDkrVBb1z3PIjCVbSSXl23occNvNkZwce+046UqZOhQ/NbxHGi8a8KdfsDc
X-Gm-Gg: ASbGncsrj026obvRmhEerFr7mmVUg+J8bDh7JpCpwvLlvSVBOG7ci7Ur+QWz8raEOp3
	R0JataRuqMRMrW99SIKWuXXT6kVw21UskQYJHsY9Y1v3aMNYu18NjBuTVCjvTi0JZV9F0080UJQ
	zFedOXRlBLx3uFUwIBgO2BbKdimwmQlRBNshOYEDgLe+uxuKweQkO9YHlqeAbHFESqxIJhEr8mf
	iQjTnalV42K2n6TqitWTHUPtl8Clw2hVmTbd3Jz+WwrpOY0h606ZnH4zQOgohabXkDUzxCs2vCJ
	f+rjzijbS+Xo/l9zGbjSWkQCKxY+vYe+KJylKE1cLm3Upki5a5qatPUXAjJbEeyYf5kGHgqjlb3
	HIXIuGANPZ6NHpkAfTfIphwu5hWcM+rHY5aJzqXzG
X-Google-Smtp-Source: AGHT+IEobOjbd//s7gNQp1Ouz/zkW8LS+l3dA2wGI1XKDUrLuXc7H1WHajVOlBC38JZVMG2gHv4znw==
X-Received: by 2002:a05:6830:3107:b0:742:faaa:d9c9 with SMTP id 46e09a7af769-74392396b18mr2145626a34.1.1755296229983;
        Fri, 15 Aug 2025 15:17:09 -0700 (PDT)
Received: from [172.17.0.2] ([172.212.167.81])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8843f9c3334sm87350039f.22.2025.08.15.15.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 15:17:09 -0700 (PDT)
Message-ID: <689fb1e5.050a0220.1ffd84.1ab0@mx.google.com>
Date: Fri, 15 Aug 2025 15:17:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1884602802592408868=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1,1/6] Bluetooth: hci_core: Convert instances of BT_DBG to bt_dev_dbg
In-Reply-To: <20250815214406.514260-1-luiz.dentz@gmail.com>
References: <20250815214406.514260-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1884602802592408868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_core.c:3763
error: net/bluetooth/hci_core.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1884602802592408868==--
