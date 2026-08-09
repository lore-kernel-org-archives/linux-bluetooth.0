Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E7A12C534
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Aug 2026 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786297591; cv=none; b=HDRnJzhTxEAoWuAMcKj3xR62LceuS+AnQj1sNpeQjWHskJOEDlB/I7wRJejb9TgAtnR0V1dUIv63m0h8tZmRX1Fta918GtRfvulCXffkYY/RdUPZ3qDRixShN350Z204b47Xt0TOz+V51FeX1BrowDaeYv16kVmPQNei6yhJVCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786297591; c=relaxed/simple;
	bh=CGjWG3GSSBfjv7ylEtH1FCh5Ziv6l+yXy+0SCbi4Cuw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qWKFLFNe0PJQmVn44Isd5quJnM4ydjUmoJaTEc+P/Wi1AePVd7ybPzKBKd9LcfVUxWybSFQCDzhYYFPx3ymSTEGu4apidC/5hO+ErsGsV13LADwUMFI/8U3A3DCatsJWVm2nFsJ5Noz5MZeqZNCJJc+jC6Xj/vEQ2EE+dyn1Bac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUOfPq4P; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUOfPq4P"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e65e18969so72229785a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 09 Aug 2026 10:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786297589; x=1786902389; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XBaJYpd06XmfF91ilgl7x29bQ8gsfCtEh1IoeIt1OaY=;
        b=GUOfPq4PDugctSlD1CxDgOX400ZwyHLK1fmIQnE4VU3LTQtoH2qgrPfieJ+7BCwhDY
         hmQcB3OQHhTmePwYNymWBL3znrAjBRVtS2H41ze8tDJiT0YeOllEaZZ1gMtAfflKbRb4
         tN6I2rBEdlNymMdwxQGjU20m5RkKoDyGUJuEXW2sCWj7jSkOk5kS+vaFNOY8t5JDau5H
         KwMkEgKo6YoqWgCwDMtPALOAw56HC5OQ/Q6CXg4+PR6EhoRw8j23yYLV5nAoJNT/c9uL
         bCusn0hkfD9+8SzEnWiDHGwzJBy95SJnVvkAXWL8ShfLA2r0X1MnoGrD2KQseMpcBXvD
         RF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786297589; x=1786902389;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XBaJYpd06XmfF91ilgl7x29bQ8gsfCtEh1IoeIt1OaY=;
        b=d1brDYStmCucZgY4QvPjXWgLlnG3QNqTMxf8ep0ALSdB+vjKfYsWoqXi2eLSgMPh6j
         HbPihPQSizXi68A6A2APQaH4zyyd26athQAubcdPTnUXwfLgPQhAGUVxvHzc0azh9mbv
         2zxlFVj8+eMm1IEVgIFJNHkMFeR/1WLAp4vJoelwxJVlTkZ62MTLnHci1PtNW5/6bYdH
         SUTNmz9zuwa/w3Vv4eigh3xqv+FUgZJXXSfDy0FqNAElv3VZdKSuQ/FqCC/imy+/mj0H
         74wYeGl37I/cXtJ8H4E8nUYS8KaDsbb118rFSQIHuwLxC/4Dh2PmJkW41DcH78h9uaX6
         750w==
X-Gm-Message-State: AOJu0Yx+Vki1f68KI2fCHrzOtUcky9x1Ec56lMJxAgYJy2n4WxIXdOkN
	/BXJKiABKCtsWK8h7OkxH3uMkjIe3m+67Sb/OrFu43ckFQmILhDzPjI2FUe27w==
X-Gm-Gg: AR+sD10QHDm7JXrwOwROtxtOlPCf4+2JxrQfQjLhM9bpGlWu6lijAtJ9ndglA4UdWuv
	vjBuw9aWAdGYA+PFUIwwwm8GrFuqWd5PEwTRMsVXBvFZfDBym1jsEF8ObkOKZZd9XW1LpqtWo8k
	zTP0P4wzQDJ4oL/rv5R4DX5lTkHjSHaE3lx6z/mpXlQC86nA5Ha7SHom8MuTtGNTGJf0fSlohvj
	guIGcTvCrDrrITuIWfW/aCecr+3O9tbQIzZ66ItAE1hMVKZF0DqO8ZlEeyZMbrNU3PLm9OqoVAd
	g8iVJjytBYyBtv7pgFCHbqHeQrBZZ9msacY9aXsloQCSh2mntv01oBcRAE5mt5W7SG8/B6gkrKL
	a/ChO2wBBuOMS4UnEaIc9SoRCTu4P5Jl2BUJ4XqeiVKqsLsO+C/pnjky1mGj30fu52FH9HcEj/Z
	SPy9aSqe0R4m8xZqZJ45dTmoHGaewpkXBezl1i1VGHpQSn5C68q/FrD8rr7Tzfcc2aiQ==
X-Received: by 2002:a05:620a:6a04:b0:92e:5949:3567 with SMTP id af79cd13be357-9367b640713mr1378031385a.14.1786297589183;
        Sun, 09 Aug 2026 10:46:29 -0700 (PDT)
Received: from [172.17.0.2] ([48.214.55.72])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9366e22695bsm607839785a.25.2026.08.09.10.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 10:46:28 -0700 (PDT)
Message-ID: <6a78bcf4.04986471.15b811.3022@mx.google.com>
Date: Sun, 09 Aug 2026 10:46:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8476127209825044420=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] tools/l2cap-tester: add tests changing BT_SECURITY after connecting
In-Reply-To: <b85da0d5625e37d6289be01e3b83663c115420df.1786293828.git.pav@iki.fi>
References: <b85da0d5625e37d6289be01e3b83663c115420df.1786293828.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8476127209825044420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1142951

---Test result---

Test Summary:
CheckPatch                    PASS      0.54 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      22.79 seconds
BluezMake                     PASS      561.45 seconds
CheckSmatch                   PASS      298.67 seconds
bluezmakeextell               PASS      95.52 seconds
IncrementalBuild              PASS      546.05 seconds
ScanBuild                     PASS      871.80 seconds



https://github.com/bluez/bluez/pull/2393

---
Regards,
Linux Bluetooth


--===============8476127209825044420==--
