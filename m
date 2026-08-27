Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAF248A8CC
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787847713; cv=none; b=QOnHpiJSU6z60GM3zxAFWy3iDVh4JDzEsvcX5PT0zm8/lqCNErm03KyKsZxIiLPJ7Dg2E15NiavtrClNw50g9yGXw4zV70GIzSKjrtpLg9KRILLGMf0Jas1bJraJSZgO/4vUbz4tFA2fAFyzuI+oAS6GTrxdLLBlEnAYG46u24A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787847713; c=relaxed/simple;
	bh=+aPPpeQ9LINu1PYSIaa1vMKc/lRHuza6J7TrTnjv3Wc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UoNYgEs8dbIcshdPXjIj39Cs4NyiVQTrjtcRVHPdPPTgB2uFwqTtS59LuSXHhhXh6rX+Kv8hkOTs4IbNSFJFWDusG9On31dMMAtmi182/ZVnHLgJ9xME8qP4ldWatqYNTW0A+s/ejROwQcrwdrubjQBtR9DSLJouUF32FfhfupA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AngEpxjj; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AngEpxjj"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7eb5bdb50fcso59136a34.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 09:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787847711; x=1788452511; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KR8w1q/BOdpH3Bl5L/wbecYVephkSVr0CDo4BjrSFqE=;
        b=AngEpxjjKhTPVFUsIZQVRpSqmjsYNZCt+lmmwHkUYmXZg3970je+CZZpdmZRmwKIek
         gakiQuo17ikDJxiskXpNjW8AImW0pCVx//5IAkQF9RrnTHaR6ofPpUPRpzd/14oQkYOX
         QtJHmDy1MpFbua7l1bG1TSgipnEhZ7rKL/r5ZI8o/2K833x3bokpARpalb9FqAWa7aJm
         hackuDE/cu0TGla6vcTBCsuK1e1UWxtDAnYwBxy4xYD9P6b0rKU2XO7qznCq+v7ArZ/S
         M4W8Py1XRH9cVFsKf4CTCLONy1SAnIIxaKCiX72/oLdNOvbOIFSr8vWmiBwqTW2d6IJV
         ps8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787847711; x=1788452511;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KR8w1q/BOdpH3Bl5L/wbecYVephkSVr0CDo4BjrSFqE=;
        b=nEGKN66iL6MnHJ1G+gvojyfPPym4nFvHDgEoU0ikv64+c/C6iCdGqufY2ybAGu7c8k
         GcYTv7AzOBcRmqJ95ZQvz6tbeaD8GMCZrtOg9UIRizx2xNE9dYDkJCjz+nBW+klkxtCP
         IJjY3NOQhE4kUE2WAgk4LuHAQORMpZSwbPtg8pbpvLipXJimS6e4JdZ08xBHho1FwuRX
         XTwkLK1TtnGjq19RSaNZ4pSmzXeRafxe6Gh75SxO6kzhxS8oiKawdNOK6rPDjtvacFfm
         6sU/9mmkppwxlwngLdHw74gh1rpUHv8u/umgcpnzRu6XrK8liNUFLeKJTavC5YpWyaXn
         xH2Q==
X-Gm-Message-State: AFuF++lWPdH4OvcjtfIVwrN6A+2iTvwUBghckuv+JMCxiNIQI3PK7VO+
	oGntby3+eSdm75ySAMUkL/xn1Z1c8ibWx2MSBtpfvu/WuesEuqnr8hY3LUiumQ==
X-Gm-Gg: AR+sD1316CP279tErdJBkuXCmtZUxZOS4uZrF/cohjFezldHRAlkgEyfNx3Z4rH/8+R
	XZEyhhUIhOhHNh5U7fik1Q5s4Hg7sVk8OXf899kw6EXQOaU9Z3AD8UjW1EB7m3kJ1zmy0Qo4evi
	juHXdeiAbzMSGE5owYuBb2pTBJLVKXWRrzJHo/FPSeIpY7KI9UAyXzBeOwPfu2xeev3tHOgW8+9
	Kyf6UE+h93942WPihnsCIiNLVTs5OGkfK2X9xrBIbWc0uD9Wg7Z9CUducBA6fG1PxbPVYCNUrja
	WFhlq66+XygCNhCQC6LV/GWECs/bhoC18Dz7WNU6p0ZLt8zXVCjIxddiysSwiCKMHOj6bP+S4bD
	kKk/OG5f/+nGn1hSQ9qp0hnBUxFVRBdGU/Jb9JvljYWHrk4/WTUg0TirNNUiH6Fmr4bs13nhGHS
	uP/+QjplNGrZVmTu5W5Lt3V6fONUl+OsAVFjpRU+7ual8/XPGrq0LEcjEtWrsY/bKf0kto
X-Received: by 2002:a05:6830:43a1:b0:7e4:163:49cc with SMTP id 46e09a7af769-7f4f225dacfmr531762a34.7.1787847711111;
        Thu, 27 Aug 2026 09:21:51 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.219.81])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f4c8183544sm4334002a34.1.2026.08.27.09.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:21:50 -0700 (PDT)
Message-ID: <6a90641e.0e8df0f7.2b3143.707b@mx.google.com>
Date: Thu, 27 Aug 2026 09:21:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3121769128317940394=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: all: Fix typo in AVRCP_ATTRIBUTE_ILEGAL
In-Reply-To: <20260827145742.1568129-1-hadess@hadess.net>
References: <20260827145742.1568129-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3121769128317940394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1152689

---Test result---

Test Summary:
CheckPatch                    PASS      0.87 seconds
GitLint                       PASS      0.48 seconds
BuildEll                      PASS      21.43 seconds
BluezMake                     PASS      650.17 seconds
MakeCheck                     PASS      18.92 seconds
MakeDistcheck                 PASS      163.82 seconds
CheckValgrind                 PASS      239.06 seconds
CheckSmatch                   WARNING   319.49 seconds
bluezmakeextell               PASS      104.14 seconds
IncrementalBuild              PASS      622.09 seconds
ScanBuild                     PASS      1006.35 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
unit/avrcp-lib.c:1085:34: warning: Variable length array is used.unit/avrcp-lib.c:1583:34: warning: Variable length array is used.unit/avrcp-lib.c:1612:34: warning: Variable length array is used.unit/avrcp-lib.c:1638:34: warning: Variable length array is used.


https://github.com/bluez/bluez/pull/2442

---
Regards,
Linux Bluetooth


--===============3121769128317940394==--
