Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D1D19A
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 00:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729729808; cv=none; b=JSrmTrEWZl37g+p7gr7en8mJ+drggghWAFv9y0hIe/r5IK3xUsHFYe0MMwLbqRin4d6ltmKBkgLg5kD61GOnndao1bSxXo5Dz+p1FQkNOikwMFxnS4A8+GGl3h6WKhBmKSUC1YouTQL8/rQqXwYWealn0F5ZulVtQv7M5JYW2TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729729808; c=relaxed/simple;
	bh=CpkY1ZkGKzh64OJLPG3VQ1reB3v5pnsIFBFXbHD3R2Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CfzhEbYq7oQ214CUs9oApRKZ7dlScHai/uMShfm3QWFLFkA4+wE+4SS+yc0qW9449q9An3jVEqJUg49rKpAsscORKRmhV6j7mjK+3zLGSEvtC4IOkeLUHhJjZOIPYQ222AmUTNWrSKkdXzdYaXYWWyjQf/drsXrPM4m/hKmkjWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZsnNOSR; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZsnNOSR"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-46098928354so2036561cf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 17:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729729806; x=1730334606; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yMZ6LNpRXao/o5KcRCvdqn+VRyowpm4zBwxo5Xpb/o8=;
        b=QZsnNOSRxLMzVC4sqKEas8GWpbcbDxeWvh/+E1s5Lunc2UGl8ye3M4AWG1RwkZ4TuX
         /VJs4J/v2NSI3OTgUEVxGUq8JVxP6dSUGLZea2Y7IFy0opbRyRc78F2Ld2P/Igkh2GPr
         fBvNIsOEAdo+lQR2ujqW7P6qljFR3KK1T2M+8G3AV6JHL0osHuOg9CehPG2NtVTxH7f/
         slV8U2Oik1cHAxdtpFHL9nFoqJ6gqWTQpJ5lBeMfJU+kXx93eTt81BP9eOcFs+YsNaOA
         pf2sqYvboIY/bIFBcKscRglJD9sStkhgDknY73VkIsSXv8gt47cBSklUpr6wC3FfLxZe
         RWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729729806; x=1730334606;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMZ6LNpRXao/o5KcRCvdqn+VRyowpm4zBwxo5Xpb/o8=;
        b=f6eM4CkP3Hl+FelyYwY4QsQ161lZUPawndcUc4IKAUXGTCCKo8gyMFOPpKjBnOLy7J
         AFgg7iptR1hMy1binPvAgnKMxBEhikJ72D+4iSsCR6hvqtLWoIGRPKbZ/pvAsRkY/GQp
         yX1iu0Tps2ZSOlLS/BFQELoaQHStsKEm78wTN22x7D5YzGxiQ2kbE8cFCtzwHhYJDluQ
         NWuWWz90anDauUvWFAImol1xL3cc480XytCuvy2+SQ41lwLGSEnfjpYpfq3nx1MLDZc8
         5CUnkfAg/vCx2iv0kCTpXedIJgOZspcIlN3X0S6zarQ5UaP0MkqSQzH0MYY80DjqHJZj
         PGEw==
X-Gm-Message-State: AOJu0YxU5u8HsO/ujP1rpmXfo1cTifSznNvLnHll2YQIgx/qCiQTPbgW
	ddJZ1vXskCSPXnQ7zTmlq6slh/duxgiZvUfmGlzDANTrTp1onUpfmi9www==
X-Google-Smtp-Source: AGHT+IHelYE3tt6zjFKCj7TScjPPDOrtNPKwEgHldGrZf/6ka/ocKWsX9tnWaPel/mKPUDUvpE28fA==
X-Received: by 2002:ac8:574b:0:b0:461:1c70:616 with SMTP id d75a77b69052e-4611c700c69mr34657571cf.51.1729729805653;
        Wed, 23 Oct 2024 17:30:05 -0700 (PDT)
Received: from [172.17.0.2] ([40.67.142.65])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-460d3c62e9esm45526151cf.27.2024.10.23.17.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 17:30:05 -0700 (PDT)
Message-ID: <6719950d.c80a0220.3200b1.0062@mx.google.com>
Date: Wed, 23 Oct 2024 17:30:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6058162563198662869=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC,v1,1/5] mgmt-api: Add Send HCI command and wait for event Command
In-Reply-To: <20241023204705.2422998-1-luiz.dentz@gmail.com>
References: <20241023204705.2422998-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6058162563198662869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=902407

---Test result---

Test Summary:
CheckPatch                    PASS      2.33 seconds
GitLint                       PASS      1.58 seconds
BuildEll                      PASS      25.09 seconds
BluezMake                     PASS      1735.43 seconds
MakeCheck                     PASS      13.38 seconds
MakeDistcheck                 PASS      182.52 seconds
CheckValgrind                 PASS      255.39 seconds
CheckSmatch                   WARNING   361.74 seconds
bluezmakeextell               PASS      121.78 seconds
IncrementalBuild              PASS      7884.83 seconds
ScanBuild                     PASS      1024.08 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1868:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3606:52: warning: array of flexible structuresmonitor/bt.h:3594:40: warning: array of flexible structuresmonitor/packet.c: note: in included file:monitor/display.h:82:26: warning: Variable length array is used.monitor/packet.c:1868:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3606:52: warning: array of flexible structuresmonitor/bt.h:3594:40: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============6058162563198662869==--
