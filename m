Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23340DF71
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Jun 2024 13:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717509222; cv=none; b=GxYt5IIfU0JmW0TMrYRDOkBcz1H1QByHgYiKXeliDeXob7ARoDmnDyx1O24H+6XFIG6UUBCqw4nNwdhr622UbWn5arcvq+Fl5XLEcxMtPkuXL1L1alYruVJ34rZJ5s429751D+NAEKgCI+Vg5lUYE1EOMp3PnHojbv5HEyueXfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717509222; c=relaxed/simple;
	bh=VgrccqI1yVTTWIBrqGvFDhYZjVZK/HiIcixGuCQkLGg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=D2WfydFEFENaFZjsHm/1pqOSH0iE5f5oRo1okvp9R3WcZ+dJynPCK8rR++r4W1b5oXttHBxv5Y2JUNkLc0JJhIiFTVyAb3wjJQoYngvkQJNsljF/Yy8NBGSa6ocF4C2qUlz3gfelaQRRehfbrotfNd8yUd8MKYQhQLrcFNw+3Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=go0y4dHC; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="go0y4dHC"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6ae102523a4so29492426d6.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Jun 2024 06:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717509220; x=1718114020; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=psG/G1/4f3EvyhB8UhclcksbMv8q73p0B0Pbw/HNlX4=;
        b=go0y4dHCwlLRA6KL3/6/nceA88V10r1U3NP7BZVo3ukS98qcNEEndKIcyBtERzzSbQ
         yskrSKJPnxorKj6WnksAAB6kBrARjRdzu3ATVS31Idwpe80v3Vjt5Fh0Zo1yOW77/H2B
         mLUs1DujjOr5sVwisrqIMjmN31RO0jqhV0zoPeg/3/TGUnaPvQCA6EAhCWLXaDLkeuQW
         g7OJhYheRhWQwclJM+vlb9Hj1QZbPJN/FPbf8fOU53a0icCA26C5xzOaQGFJ6ysVGaUt
         OgINmRtxElTc0UEVGTZ7caouRDvNxXh7tt/iIbyoaK60/0JmtBDd2cdF3+CFxHtv5B6C
         w0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717509220; x=1718114020;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=psG/G1/4f3EvyhB8UhclcksbMv8q73p0B0Pbw/HNlX4=;
        b=F0cdmKtxvV96jJpzbBvGeQnFowBC9x6wbTPAtrggaYt/WcxPSe0EqHM3JrTunR5mtv
         pJPsg4uCuHDKQSflFIYrfeVmTIccJpp1HT+dSvIzEeoxu7/kiviSzy+rND6OwFiD4IPi
         g0puqzEf3fni5wzkQsVdlIZaln+fr0a1aMw89ydsiQOW4AoI0p0Rd4BDUwGpC0hPym9C
         FNHsqgHEDFcltDIrYwQh345wST3/DWvri2nVYfGkUt7x5aR+RXwWMyqH5Fmn3T72AswL
         5JSsemuzkr2zLbgVKsHLEswhDm+JnOQOKbZaX6VWXBKlc5HreW+igzYtMQhCWBHUl7T2
         8QQg==
X-Gm-Message-State: AOJu0YynJF8sV/OE8QtGrdumaFU+mCVZleYc2rm4/MPAUDcPJQLMCvvH
	vXLnPXtSnT7dghEnU6nM0df+Z/dtWMUVh/gTg75258iA53Nnjui05jvY5g==
X-Google-Smtp-Source: AGHT+IFnzu6Vr0o4CpwWafjEkJEfk7r3x5kXBPTCecouqMgFqtPKsYlwkSro0zMW509RtMnNTnUkZw==
X-Received: by 2002:a0c:8e8d:0:b0:6ae:ce63:da3 with SMTP id 6a1803df08f44-6aece630db5mr112413946d6.0.1717509216640;
        Tue, 04 Jun 2024 06:53:36 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.39.159])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4b4065f5sm39061606d6.101.2024.06.04.06.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 06:53:35 -0700 (PDT)
Message-ID: <665f1c5f.050a0220.9d9c6.183c@mx.google.com>
Date: Tue, 04 Jun 2024 06:53:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7740102185717767384=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: test-bap: Add Broadcast Source STR one BIS tests
In-Reply-To: <20240604114708.33423-2-iulia.tanasescu@nxp.com>
References: <20240604114708.33423-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7740102185717767384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=858634

---Test result---

Test Summary:
CheckPatch                    PASS      0.58 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      24.74 seconds
BluezMake                     PASS      1624.07 seconds
MakeCheck                     PASS      13.53 seconds
MakeDistcheck                 PASS      178.30 seconds
CheckValgrind                 PASS      252.45 seconds
CheckSmatch                   PASS      355.04 seconds
bluezmakeextell               PASS      119.85 seconds
IncrementalBuild              PASS      1468.10 seconds
ScanBuild                     PASS      1011.18 seconds



---
Regards,
Linux Bluetooth


--===============7740102185717767384==--
