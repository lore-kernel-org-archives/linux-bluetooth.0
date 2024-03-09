Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567FE3218B
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 Mar 2024 03:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709956579; cv=none; b=uI6OOLxgHHPflhdJfi0i/yNiyTxRo8+055jtDepNz59FgVbk7xgti4TbW8sTe4qIwTMk4SKcA5bJoU28NlMtjZl/EsbFTr2nTVsE6dcomgvb6FRlu5m+j5chnVwEWRsL5qsFcJBzgtqY9eefdF4tVg3tdwPqVXULTrI/1y9YEdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709956579; c=relaxed/simple;
	bh=CmoyDxa14ZkkJW90e1j+lTeIleICiah3tY/d5bHevw8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pB9rvRRFUU9L4LdsLoZIYIjv6A3baBuKAqHt72Ha68E+wxE4MYgq/Pkv5wKd3seUgx9YUKN8Jf+SLN/YB6unCOx26DethqdexDoMzJ2YAQTHXZzXyv0EUovWNOr4eHPNfIBrI8lo4Ue5A14GOLGr1d8l7B2c9Wj6jjiNZCFDsnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRRxM111; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRRxM111"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6e4f1660493so1234300a34.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Mar 2024 19:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709956577; x=1710561377; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wTN1hMli7OTRvN6U4De3Nz7jYJeaKzyh18vtco03SaY=;
        b=MRRxM111V6t6rE1OihzdfwGe7uD1cmuQpcgmGU41x10snr9Fro+RA5tQC5Bv4OkIrb
         R+IElRub68CHYdER0Q7XbTXksUHwxadrklNm4X1N+U80YrMQsuq6UvtvER86Ga2+k74k
         30RxXBaJr28tJqWwWywSDm+53HpI+5xOwGaclV7LneHtfLavvwlvINKoIKh/pA/NkH5+
         gjE/fnlosjvMdNxctfyAULtnTrW11Vahr+8ZekRsRdALmbDt+7nrcVeDM77enN7yP+T4
         6KHy7d+pfMsfd39zeTA4QiZaaUuBkVY+GUcf4gEZ4jueDzuBjt6esTsBY8JqwjQ46QH+
         oqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709956577; x=1710561377;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wTN1hMli7OTRvN6U4De3Nz7jYJeaKzyh18vtco03SaY=;
        b=HC9XhrZtXcHI94dhk+k+5t/mmQpfr/DT0Msv8bHSNhuQ+wiuDcQHmPfHfOnvEVyzjX
         fzkOyobbw+PRYEaKbsVorqgGy2/QOO3+cJ6bfCXIHrtpXK0MhosZSYF3FRgJMxfGXZJT
         R2NlsTaLj1p5pug36dSdePnyGeqQ6bYXBCYpn57sSQMeH+LLJgb3XYwEv+VnWDWPrcwm
         cQC/iZJHn/WexxMkAx+1LPzFFHducUTYRXSq+neKTiVkbXRQMo0C8+fOd3ReLnHpGnu2
         dzMe+W1Okp2QWi+AfDD7Eisk0tuB3lgPe/WSQZyM0rQq4/DYtsYFUrzIab5pG+xgtPm1
         dKzw==
X-Gm-Message-State: AOJu0YydFH+a9aLOQO/OgGl3TtIFbKMRzGl6CpLxiQY1WNMGRJ85Eab4
	5izJJk0GQgrGxZVIgtVEzw6yGAAXI/xMDGhD2jk51vW555gFllcdamt3FiqN
X-Google-Smtp-Source: AGHT+IGuHilQPj2kow4TegaOKohjHT9JHih2LBdOMAVR/gAFGCwrLhK+K2RSDLtUnI3pJEIxKbxBug==
X-Received: by 2002:a05:6830:3a09:b0:6e4:fa90:2ae6 with SMTP id di9-20020a0568303a0900b006e4fa902ae6mr1036918otb.23.1709956577107;
        Fri, 08 Mar 2024 19:56:17 -0800 (PST)
Received: from [172.17.0.2] ([20.172.43.100])
        by smtp.gmail.com with ESMTPSA id v20-20020a17090a459400b0029af5587889sm426622pjg.12.2024.03.08.19.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 19:56:16 -0800 (PST)
Message-ID: <65ebdde0.170a0220.9afc9.1e80@mx.google.com>
Date: Fri, 08 Mar 2024 19:56:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4498161332436201258=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, marex@denx.de
Subject: RE: [1/2] dt-bindings: net: broadcom-bluetooth: Add CYW43439 DT binding
In-Reply-To: <20240309031609.270308-1-marex@denx.de>
References: <20240309031609.270308-1-marex@denx.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4498161332436201258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=833965

---Test result---

Test Summary:
CheckPatch                    PASS      1.03 seconds
GitLint                       PASS      0.50 seconds
SubjectPrefix                 FAIL      0.37 seconds
BuildKernel                   PASS      27.67 seconds
CheckAllWarning               PASS      30.60 seconds
CheckSparse                   PASS      35.91 seconds
CheckSmatch                   PASS      98.04 seconds
BuildKernel32                 PASS      26.54 seconds
TestRunnerSetup               PASS      502.39 seconds
TestRunner_l2cap-tester       PASS      17.73 seconds
TestRunner_iso-tester         PASS      28.22 seconds
TestRunner_bnep-tester        PASS      4.67 seconds
TestRunner_mgmt-tester        PASS      112.79 seconds
TestRunner_rfcomm-tester      PASS      7.24 seconds
TestRunner_sco-tester         PASS      14.84 seconds
TestRunner_ioctl-tester       PASS      7.67 seconds
TestRunner_mesh-tester        PASS      5.73 seconds
TestRunner_smp-tester         PASS      6.77 seconds
TestRunner_userchan-tester    PASS      4.91 seconds
IncrementalBuild              PASS      30.09 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============4498161332436201258==--
