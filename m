Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793346407;
	b=2hjVRMX4AtQXR6bl433u8hetYxmR3JSLWF+7VqCrilwY3C7oB2e8rI2h8pmN5ZCsSghS
	 URGyO1BovJHIaX7oFqsbvlNt7+6jZtcfATObalt1/sqoI4Nr8pyuO+pvsfTj8oYGi4/Cq
	 TPlDiT9KfVJDDtKGE3xA9wZKtW/c3mMHJdfG61L0KXaBNVMWs/UQQJdLdQnGEFBOuNSHL
	 ctfqOOHEhMDEZqftgO506EntuB68XV/CyV5jyg44qdfU2SUl8oCFh8cc0y/UdUUKXDlku
	 OxufWcJOtHi60FJ4xFA4plEKjxOHmVc2qZDjWdwmAaCzO1LD3vvo4ZtwB9hvDj6jFUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793346407;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=capiPQsUnJkJByX2YACWaLgkeymJ7zJPPUYdn1h0D1U=;
	b=q+/nooSEQQmyGCNh58n6nwUn5Ng61X8wX2XAY8lFHPAZrtwILzEoyA4BSP2Rz7Ifm3Oi
	 f8D31zZ32AkOX6QWDaxnuBCVqiB/Uy/QH9Zvwm1tlstjL3SvkkG+AFq0XofVjWa9G+SsO
	 TmRwnOsYKAzHl5+/dPQwHphWTI+ijLqlZJydPW/hHXOQUEp0WiTMDyv459ipwDAuS/Yqw
	 sHenWGiphZ5bDAhhQN06Svzy2zYUjqmHf4ysvWX4tKWPVl+T3E96/ytObd8qIJvoJ7XmA
	 hRYkuNjjae3o3iiAXFD8ON1J+MFsZ58FiXwAUNcUlYn/tT7PavtBk/QIwjME4n04exg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nd1Gd4ss;
	arc=none smtp.remote-ip=209.85.160.44
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFE0606A31A
	for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 07:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DFE0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nd1Gd4ss
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-49e08af5fd4so187740fac.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Oct 2026 00:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793346406; x=1793951206; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=capiPQsUnJkJByX2YACWaLgkeymJ7zJPPUYdn1h0D1U=;
        b=nd1Gd4ssrxk2AepEg7+Wf3QpLA/IxlOf30Feg9tCwgdE491aJQjIxtSMPlMC63x0M/
         gEb6iYBzs7z8/jJCtr4ed4xHclxY29W1VvJPluZABVaq/dfwxeQe/SFCGCYb/n99teDd
         aM/DJlXSGOmLyizTf1oEllCdiVFBQnK91kXg6qOWaBo+FbqAiPhDWVHi3PJOcOBZVCLY
         rkQAIyEsmSOgWPPoDV2TOpnoT41q6rOzLbaBGHc+Pc2n5rJytExJW+Is5B65sKSsWtRr
         uR6prD951q8Q6nzB1vfvDXqWH7ZInCwA3okmiIEWZH6wuqB/TIqSCPEeeQMUEcfNYHdy
         l+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793346406; x=1793951206;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=capiPQsUnJkJByX2YACWaLgkeymJ7zJPPUYdn1h0D1U=;
        b=GCAlMaxMW/l73u6LE/2o6FoGNHS7q1VBEfB4vX/vCOKgL8f1I6CgEKoQvEOEK+V7QW
         n+w4hhuKStU+go1ezlzGCtdoq8/ghPujYsfW7n61oXyNP6bVwOXVn/CsFe3d3YaF4fg5
         eax/4iDxVJkZtZHE2TR9RtYtcH3K8eLTIrP60us4yWgr2rfgxaAneQD6W6fgbG2Ynyke
         PB7bDSNT9ljW7K8eqxRZNI8aM2fGvrgp7P56mCNMksbkITTRhvVngtroxKoszybEPMlQ
         NSaamRYgOV0VfNBUKYGZSkV3gv1P5ZhunBsQON/YSuPLd7R8r5VDk/c6j6rzZaKLT51T
         qWYg==
X-Gm-Message-State: AFq9FYIKOd1JufGWUpxVY9XOYjHJck+58pCLIA5vwHS70r43xabGOF7T
	txtX91dpZg7HsITIP/wUcCmHSGvHs8cDYpGpR5A1/bZNC0XHCe+dAMMh1VmoAQ==
X-Gm-Gg: AYBFou33Dl9PzObd9iTjG5PDtJf+WTgtCYrRFJLNJDjv0sRZ2mFT/84q/fVG+XSr4af
	sYrOmTXzzE7nsNhUGrDepo4x+mST582vM5t5euUQypxWDfzcOTTWL9FN4RMXsI0hol0oCyXWJwT
	3aX/lEo/AKEe123r6fMqPbQMBtMdX4K3j8r04KfOeEaQ3uap9iCqtdluQJzUwDHLmETzpVZlWcS
	JLHGjAb66rLFXLSNgnPkjZRCbjTO+i0ZhdaWuVLSUF/WDYq4MGkomIrmFTADTQDVOkL25LBsHYn
	bXAGLsde5Mzgqutkmzm3Yw+QDz4qLTMdZCDVvHy17W3xaf2hN4O+KsU56etGZnLCOqym/y019RC
	fHsJ+v6qG82jvhJVAdctazhMy//xWP7EpcAX9CFqszWow0SMSO1k/zGTSuXkJxQ8wj8/4lU5yQj
	G8xrNMUbgAclakw0TY4uD7j9coY5YujMHttruLNMWQNHODUYWt5hSQFEMFeFQNdjiI/CU3NbOld
	1SHM+b8BLu4kZ0ZmfPVDDiabNN6J1u3wBL8G6lbxuDTkqLY5qSGI+sy/hCTWplA5Bi4P8gfhay5
	PmhsX4sFMg==
X-Received: by 2002:a05:6870:d3ca:b0:4a6:942c:7b05 with SMTP id 586e51a60fabf-4a9076f991amr942817fac.32.1793346406164;
        Fri, 30 Oct 2026 00:46:46 -0700 (PDT)
Received: from [172.17.0.2] ([52.165.250.243])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a90afa9d31sm1160932fac.16.2026.10.30.00.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 00:46:45 -0700 (PDT)
Message-ID: <6ae44b65.99d0dbd8.1d1550.9a8c@mx.google.com>
Date: Fri, 30 Oct 2026 00:46:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2591991551520612711=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, cochcoder@proton.me
Subject: RE: [RFC] l2cap-tester: Check compatible interval preferences
In-Reply-To: <20261015044221.55631-1-cochcoder@proton.me>
References: <20261015044221.55631-1-cochcoder@proton.me>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2591991551520612711==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [RFC] l2cap-tester: Check compatible interval preferences
   Pull Request: https://github.com/bluez/bluez/pull/2682
   Created:      2026-10-15 06:39:11+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============2591991551520612711==--
