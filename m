Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2297F148FF9
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 10:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669020; cv=none; b=H1c+jYH0879CnmMvuz3MvaHYIOM1Y6lvXFOnoK/92/ElPLQtz1fyTgab/VIa6OysgXT/dBayfGycnidAMCmklFAsauAZJO+Uc8n9oagN2eCKXOjvt5AuJG6d8A6ro4oPaq0EaWLP08Q0alheP/GQpuYJfFHSJi/P6NWBmdIxyao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669020; c=relaxed/simple;
	bh=Q+KxmoByYjm9EbqC+PV0Q2CdvUyaWJNKhiprVub8Dy0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kwgjm3pbM8OivRAmlgITHiM7seragDrJPKmCpl3JhqZlM6gL3oVuZP3DIV95QOSVkKFlDmmZhMTL3ZBSda3+HKr/Ei5GZbU7maGamVPC3opGtXAffzYZ+nmFLAjhb0l+ajKZHYEnvDtyi4zjg269m8oJ4OXR4uiHanx/JhB4MC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnWWbVz/; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnWWbVz/"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-709428a9469so3943199a34.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Aug 2024 03:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724669018; x=1725273818; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WDJ/G1H9Q93FZJoQA+NpEGWM7uAH2/SupUzYa1tpRsc=;
        b=BnWWbVz/rXftGTFxAyQxSF7i4WtyID7y55drAIOK3zD1xLoGD4inka9v9N4pN34iAv
         +GaT7PvzXT0oAWPS4YYkssss51FzjiubuHrWdf3mu3+NBIhQdklczh9i9fIUswY9JcTq
         7XxWozcw/VZ316xTUHE8qYj1vCJZdOXadjhZRdwNMPxyV0f/J8ig5C68fC6uxziqhZL1
         pDT8F1OU/g528ZLEXpG54EBcrNIvoNquCkXEIZKBCgQDA3ugKQsPwl1X2d/JjU4lA9Zz
         jltXIy8fnnv5/JixnS+AX7s3mKJKjYR00kRjLkudphXJySWTLHkAAJvHcIyCKHludevF
         2C+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724669018; x=1725273818;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WDJ/G1H9Q93FZJoQA+NpEGWM7uAH2/SupUzYa1tpRsc=;
        b=rLZfYxUYUkyKlmv/VtL6FCdsHLMgizgl09D9nUU1x/UNtw2zWaaJxsQS7Bond2ObQR
         SgmUfvt2UPzBFmJIF5oA4iRkMUy7Kn9RDWCkQYVFxaxgYVNnQihhGe0KbYzlac11JEFF
         zblNyRuSViYcNSXqGuzdA9OlyjgLJeyaHSVcAoWCea/aLmwdDLkajD0+j9+CGhzxLzab
         i5xV2eLnMUx6Oi91HLsalvefd5O3y1W9LaUinOTB/f4fl2iE3Rsg8KsghstUlhMpcq2a
         G8+3XtPT3CaE+PJfvTqDpjxaeTGuLtvjLDbhwMTUN7dcNyNjdHG8nRtFtARg7kQA9bMO
         hHRQ==
X-Gm-Message-State: AOJu0Yz/ihPA2xhjF2zF7eVeI2u1k5RhyPSxF+wGoH+GunP1Cax/a1Hy
	9LDQDEMHa8RzUcM9GcOuZ+hKzbY7LdQ8iYWz3gB2ZDYwB0d9CiiZpRBngw==
X-Google-Smtp-Source: AGHT+IH3m3e2/wFIzRpBDWH2D62pvhRZ/GDzgGxh7ZHzaMvbWzhUhWxbb5CznBfRq284IyC3eFGpWg==
X-Received: by 2002:a05:6830:2682:b0:70d:ee3a:ea5c with SMTP id 46e09a7af769-70e0ec1bbe5mr11283540a34.28.1724669017847;
        Mon, 26 Aug 2024 03:43:37 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.122.155])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fdfbfb57sm42215551cf.5.2024.08.26.03.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 03:43:37 -0700 (PDT)
Message-ID: <66cc5c59.050a0220.d3fde.d1ad@mx.google.com>
Date: Mon, 26 Aug 2024 03:43:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7811289941830989454=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, quic_chejiang@quicinc.com
Subject: RE: [v2] adapter: Cancel the service authorization when remote is disconnected
In-Reply-To: <20240826090044.560142-1-quic_chejiang@quicinc.com>
References: <20240826090044.560142-1-quic_chejiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7811289941830989454==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=883234

---Test result---

Test Summary:
CheckPatch                    PASS      0.41 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      24.55 seconds
BluezMake                     PASS      1728.48 seconds
MakeCheck                     PASS      13.32 seconds
MakeDistcheck                 PASS      182.69 seconds
CheckValgrind                 PASS      254.20 seconds
CheckSmatch                   PASS      355.43 seconds
bluezmakeextell               PASS      119.41 seconds
IncrementalBuild              PASS      1507.74 seconds
ScanBuild                     PASS      1003.07 seconds



---
Regards,
Linux Bluetooth


--===============7811289941830989454==--
