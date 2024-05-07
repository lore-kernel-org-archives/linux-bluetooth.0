Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A4071739
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 May 2024 22:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715121343; cv=none; b=glUp17rqmJ0Ps3W7Ek8BfMbgLUtfvryp3gH0ckEI5ecwd4t2cTA1O3v0E0AoOmPfmeAL5jLgHXcuSUqKC5ztDTrZOBxOSojyyNtjzg7cOGkfyIwKhZvdK44JI6sNtvNlXDi6+I6WdAbIZhblFnPoh3qjZavkN/dxm00jVWHA4KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715121343; c=relaxed/simple;
	bh=phY2s0jemcaHmeMm57Q4o0ivu54ayTI9il4YgsfmRvQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Kw0QheLmqMmKTIswPOZ8KGCqFT4pPqFwMrc7dnNfG236IW52OJg/hLR9KXcbCLueSpQ9GodglQ3fUNHXi0/YbX3lrYcNQrAMb1rmvATDflf129IwZKdvSMCoUyn4x522MDl8HTL7hwDbjCeB90R1lkQ0RFPxujvw92dKYf0MsfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0wzPoMD; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0wzPoMD"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-69b47833dc5so10607446d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 May 2024 15:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715121341; x=1715726141; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KP50mV39MRifWGPm8djFXhs5LKtW/OYZFoPYdisJ7fw=;
        b=E0wzPoMDOHpGPmzeL3glsNhxe/R4Pv/Is+kp1/G4qZ7Q/2uUOQoagc0RpyGwMrTK6+
         Nw7c2YpIEBDEXztk38LT1O4QMOZ9aLxxbmZo0GSPxm+U8c7EZR3ELuiXBNKRMhtuDHwT
         L/mAize4csQDJsVZ7t4R6BXFSr8II4vdCknY1gYJ1GTSEgj/nPMrnr3W9beP4yT68YvH
         zGwsxMPL7SKYgOkM++bE+RsdEzbgcsdsSku8ZAOFMgTh1wBhHvhdqJjT25/0bUAyJdhn
         s84u9kun83hj7CFHT6smw5+oVbOHGYe8QY0uFVG7F2vSCIiAvkQ4xt9THYpw2JCQHVha
         7bhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715121341; x=1715726141;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KP50mV39MRifWGPm8djFXhs5LKtW/OYZFoPYdisJ7fw=;
        b=VV8ISV0lV+owjNKgzE86RjvdfY+DnmaWTyQ04YUbdNC5aIPHIdtC7RCOY7h5KIezGD
         GYw99GCSLjks3Wjf2+zWeWnDj8uCw0qKnZy5092MJabsG6g5f3e+D9XqSTGBLgFkeXK4
         wQhnYC34IMud2EM161qdnrzkCGPM1iIvqz5ith2kiWS4qahfllbNHb/nqgljL/YapXbg
         VbGa4aOIt1TyJTOSE7boVgYT6+LHwXyhu9wioRFkiZI4aRxBL+7KuN956YPp1ZEoAxOh
         JQZOWquf4j2P+MPtF4bzV+xFzksW3CKpNmqeIJUKkXK/PNdGbAqxp8vXPau8NIaFOXgc
         LNiA==
X-Gm-Message-State: AOJu0YwvIqrAJ1JTYC1+wAxXpDvgVB91BHgxvKxUiAJc6T32jtpXpRDH
	ziJR0daNW5a+OOTZNTf7EPOm776jJAFKQLnoXJOEPPkfMtda3BbZQmvr9Q==
X-Google-Smtp-Source: AGHT+IFJpktkt27w5WkvdU0g7SD5RP0hadiCkd+BOkEKRdSXQgLWMG5Ydh6Pxd4SSN3eT6syDuAziA==
X-Received: by 2002:a05:6214:1c84:b0:6a0:cef7:c54d with SMTP id 6a1803df08f44-6a1514e845fmr12882856d6.56.1715121341165;
        Tue, 07 May 2024 15:35:41 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.54.157])
        by smtp.gmail.com with ESMTPSA id y1-20020ad445a1000000b006a0f1d8f718sm5017536qvu.92.2024.05.07.15.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 15:35:40 -0700 (PDT)
Message-ID: <663aacbc.d40a0220.6de83.2d9a@mx.google.com>
Date: Tue, 07 May 2024 15:35:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8905304124497463462=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/util: Fix build error on malloc0
In-Reply-To: <20240507204407.653383-1-luiz.dentz@gmail.com>
References: <20240507204407.653383-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8905304124497463462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=851339

---Test result---

Test Summary:
CheckPatch                    PASS      0.39 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      24.43 seconds
BluezMake                     PASS      1629.76 seconds
MakeCheck                     PASS      12.91 seconds
MakeDistcheck                 PASS      174.55 seconds
CheckValgrind                 PASS      245.00 seconds
CheckSmatch                   PASS      348.33 seconds
bluezmakeextell               PASS      118.12 seconds
IncrementalBuild              PASS      1401.47 seconds
ScanBuild                     PASS      977.73 seconds



---
Regards,
Linux Bluetooth


--===============8905304124497463462==--
