Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0CE143881
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720456874; cv=none; b=RyoRnF4g9rm93ZW45xuHSMXmzp8LxSdrlBaWs7AtPw3TrXWpMCPFlNDqHjF0zQeSNNSVtgXjmqk7DwGU9pFg/NhaTi5TQgpFhMQyNiy1lp2MiUXGeTNXRKauSnQJcfvOGWQAAvApKZtXyGb/TKZrw30vjuIitFrTwHsMmSNX1FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720456874; c=relaxed/simple;
	bh=mGy9fdJqdDtPeEyFasqUgRSqSSR1kKvu+fnkUh/lS58=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=to6SwCJ+zZlHPdMPejOew/l22BFx3qPmlLe6RnG8+OG8pG0p2s+aJ7070/I13XDSYyKSUYFdUOtKYhUKHKdz7Yg3zQS1ue9YQyzUKixZPVxDAWM/BMWH5pl0Ri0jnqv+4pyzH6XB1gcTTxvz4iDhwL+Hc/hENL+nfRlBC+zbhEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQIzk5n0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQIzk5n0"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fb64d627b0so8190795ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jul 2024 09:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720456872; x=1721061672; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Tlz0hnqM8T1fn3Cplk7tbkScMh5cu+NJOgfJgMvTxi8=;
        b=eQIzk5n0oQ09AM4B/AWN2hR/OAqAt/+R6HkTB55mNkKjS3FYCTk7Kz3EsQvL6CUUDf
         l7OjrVbGo/2A62q11FAoBoc5OQ+/RkqEQd3whP6NZ3DFbesPjJZnKWl6gu3tVjPtNi0H
         Nlid48kh9Vty1F7V6XyS4kIvhegehysGghjJKQ3VAjIoWkQiEs5y0n5+Dxe/GRS5ESDd
         mpY7qlKCe+flhkXSXBZm6koKirEu4PoPwKrEAgtAho/L5h3Z/35plLdSrrhhrizl7qzC
         nLVUjSjQ2kx8rDcO1lowqZUoMGJv9lgMsdFfyPJfWSKTSKbFP5mDUC5AApDPhtOARhIl
         ukPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720456872; x=1721061672;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tlz0hnqM8T1fn3Cplk7tbkScMh5cu+NJOgfJgMvTxi8=;
        b=B7Hw+7t0dp/tW0/dqVMdxgFE2AT/x/j64e1YGpjxe/alI6/lcl5Hc3L9s6tGTnzPUg
         XX2mLJEQII1br1u0G7ROLDTCcT/jtAgAFRTKip3i8tlpAOHLuQJdChFxVf9US3R5haQ5
         5cn5UEw9rLAaA5K0SYdsbGjaOEFJk7o9UlYl0Qv2VcKA8Hd3xe+c5RK+Vd6NaONwzJ6K
         Y/59S9Pk0xAAkToGcQu8mLOOSFrBTHt5LxJ/g/dEV9Tk1I1F4dSj5+rySTsCIx1uXAju
         UoPUIYo/xcvcM0wtsL5++LVmJs3SOiW0hSKSCOuaqlLOS5Wo981vnvVdG5NrrOiplGiQ
         82Pw==
X-Gm-Message-State: AOJu0YxmHtWEJ8CAo5QS6igzbyVni4s6ArajuXYjdErRSDP7I15ebNhr
	DxC6gL13IdGsLIEpwdPHmImUZ1GoutUVXN5jGFUDX/Jne6fZ0DC5t86ajg==
X-Google-Smtp-Source: AGHT+IFghEWIknysVK0x4BHm1Ps/X1FLA331zwYm+eWLB62o4D7pRVqStdGcKrE4PLT8lxMz6g17KA==
X-Received: by 2002:a17:903:1252:b0:1f9:a8ce:3375 with SMTP id d9443c01a7336-1fbb6ea4187mr462675ad.50.1720456872285;
        Mon, 08 Jul 2024 09:41:12 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.36.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a0fc62sm812455ad.40.2024.07.08.09.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 09:41:11 -0700 (PDT)
Message-ID: <668c16a7.170a0220.68661.06f0@mx.google.com>
Date: Mon, 08 Jul 2024 09:41:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5493678894964072366=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/gatt-server: Fix not using correct MTU for responses
In-Reply-To: <20240708152823.2726052-1-luiz.dentz@gmail.com>
References: <20240708152823.2726052-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5493678894964072366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=869329

---Test result---

Test Summary:
CheckPatch                    PASS      0.32 seconds
GitLint                       PASS      0.18 seconds
BuildEll                      PASS      24.65 seconds
BluezMake                     PASS      1673.25 seconds
MakeCheck                     PASS      13.07 seconds
MakeDistcheck                 PASS      178.50 seconds
CheckValgrind                 PASS      253.43 seconds
CheckSmatch                   WARNING   375.14 seconds
bluezmakeextell               PASS      119.80 seconds
IncrementalBuild              PENDING   60.41 seconds
ScanBuild                     PENDING   1085.53 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/gatt-server.c:278:25: warning: Variable length array is used.src/shared/gatt-server.c:618:25: warning: Variable length array is used.src/shared/gatt-server.c:716:25: warning: Variable length array is used.src/shared/gatt-server.c:278:25: warning: Variable length array is used.src/shared/gatt-server.c:618:25: warning: Variable length array is used.src/shared/gatt-server.c:716:25: warning: Variable length array is used.src/shared/gatt-server.c:278:25: warning: Variable length array is used.src/shared/gatt-server.c:618:25: warning: Variable length array is used.src/shared/gatt-server.c:716:25: warning: Variable length array is used.
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:

##############################
Test: ScanBuild - PENDING
Desc: Run Scan Build
Output:



---
Regards,
Linux Bluetooth


--===============5493678894964072366==--
