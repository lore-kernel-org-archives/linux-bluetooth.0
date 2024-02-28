Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ED97E104
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Feb 2024 10:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709116365; cv=none; b=qBV4ml4tB131iSPao04DKw5Hh5gq0eTPWz6uV+rUbB8ScQJ7vB56eoPBPRLmxw45Aj7vJxbjvfUXNX+xg1NXLA1dfvTRSubPCiBLxSdPEFFQAmOUHg09x/mx5TsTvSr8/2Iicur5SfMxLwL1n8+/6hI6UerQ+GhfnhLKq5iehnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709116365; c=relaxed/simple;
	bh=qWBHxDbfBzQD1z09EOXYuCcINirvbtgIWqx0HuJieYU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cI8a/cDKh0bR9FDo8D0WBWAQ6S6LNqGGWQhrYaE6owlV3MgRIP13QDOdiQCk+kWQPqtxaH1rNrNq8WTzOyJgLnr6q14p2P82ajSce4oJVkf/v+nOBx48tEWIG5L3ZTLK/TUin/s4YIqVXPVY8EV1SjLNOKabA06nvlIuAJbzAs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPTV1pa8; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPTV1pa8"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so4359225a12.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Feb 2024 02:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709116363; x=1709721163; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oFX/GmpvzUSVxg3aHS5YYDfec7P/hfqwzm9qf3rFCX8=;
        b=EPTV1pa8wbRPYmYyRRJOXtQw+thJnlkQMSaZRBuF3ugi4ItSycee8juv1IcCpx+Haa
         ARI8OJmZcrQBoJA8gY/83YZqVRcRNH/ZPR6aa/CdLk/MKgxYk0YPTatrkcrb71yLedaY
         uUpSRazojBPGv330j6qKELb1+UgEgr8Vr6Io/EuvfyQbKdeW64+OFnDaPC6L5hp+KUsb
         z8+uHbSyfSnZJIjlNLBba1x2yfYlZYPu3v+N/6FY6nCUl8ENYWMOupqKZnrxnvvc0wi9
         QxqynEn87Uf7wGqkju906QmennxtSzdQXrpgayikN7mB14lMP8ZbNAEccGMKnJd5uAtF
         3ofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709116363; x=1709721163;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oFX/GmpvzUSVxg3aHS5YYDfec7P/hfqwzm9qf3rFCX8=;
        b=u7qINyRxG49SfkM6l5y0uUwFr6jGCinkK89KE/HRSpWi5Dhlo87pmqLUNAu8ko9JJ0
         /Y926JefW9awnuQGgffLmP4tKIM4LhItMI/CKm4aS4iUuvopoaddxiP+xhVdq6tTi0l4
         zTuExL9xPNG8eQC0tnGKv7+4CZdXibXMy2T3k2/nD/KiPo4AU933HDNugZgBS/B5tR33
         sRFEPoJX4qVEMhY47o/dKoy+EFdEIO0agBCWnDGMsm98nNkAKJinzjwm1PTugCqiEUC1
         beSzGJJjH3lX7ZvHSkW+kNeZrzsPtZeAcrLZQoRpBJdNEkw01vOrJVN+mxKRzL8XHfum
         VRKw==
X-Gm-Message-State: AOJu0YwegdVeZrdalajZulUNkPTS/fWkG+f6d5+P5fTdHyiWP1RT1BNx
	F06rXGbfeLZ6mRs3mWM3X18nFz5FNBqPX9soIMOj1A4uWy53V643xtjeFmMA
X-Google-Smtp-Source: AGHT+IFS5FJG3J6zAhf9p0AHLtpZg8euv7JT9uNWlHNtpwb/tiE1AeuHzeJ1utIdpi07C28+gtDSnA==
X-Received: by 2002:a05:6a21:1394:b0:1a0:ebbd:9aeb with SMTP id oa20-20020a056a21139400b001a0ebbd9aebmr5294082pzb.5.1709116363361;
        Wed, 28 Feb 2024 02:32:43 -0800 (PST)
Received: from [172.17.0.2] ([20.171.122.34])
        by smtp.gmail.com with ESMTPSA id h8-20020a170902b94800b001dc96292774sm2962234pls.296.2024.02.28.02.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 02:32:42 -0800 (PST)
Message-ID: <65df0bca.170a0220.c554f.c450@mx.google.com>
Date: Wed, 28 Feb 2024 02:32:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2655878911585837289=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] monitor/intel: Add decoding of firmware SHA1 in read version event
In-Reply-To: <20240228092504.3716904-1-kiran.k@intel.com>
References: <20240228092504.3716904-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2655878911585837289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=830620

---Test result---

Test Summary:
CheckPatch                    PASS      0.31 seconds
GitLint                       PASS      0.22 seconds
BuildEll                      PASS      24.07 seconds
BluezMake                     PASS      715.60 seconds
MakeCheck                     PASS      11.37 seconds
MakeDistcheck                 PASS      165.02 seconds
CheckValgrind                 PASS      228.11 seconds
CheckSmatch                   PASS      335.99 seconds
bluezmakeextell               PASS      109.15 seconds
IncrementalBuild              PASS      660.28 seconds
ScanBuild                     PASS      965.89 seconds



---
Regards,
Linux Bluetooth


--===============2655878911585837289==--
