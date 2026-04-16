Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1668E311583
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 06:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776322220; cv=none; b=AGjy9jD4ndHyy1TyghySsoqHvUBqcVI/C8V+/Usyx4yFVTB+Vc9S6sXWvKaQLLuqtOUF7zkSJ7ehIx6AS0bwXdI1xIisDkUhd7JrxHIXeQoKdse1QnYGq5pkBVRP6UXHoNBYlo9pcPutqFbzccqi2keR0xNrb0BjEGdNgNwV41A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776322220; c=relaxed/simple;
	bh=ycIh7uvn7w+G7G3BbUMtjB1cWOAL/ZwyV/x3D/GO9Yo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=qK93IN8rqN5YXDBl56Zd8S68Ki8NCmdkwoCiLENzOP3QrZonWwWMuoPls2koX86YfRCm4++uWlGrgVB/gaIYauEsSQThU+3AT00JrIgrCpqD8SJpidDCQmPxk14niL+gEqqQUupBtBCXNx0bx6zBrxw0ws3W/Q1Wx9OkSIHmJFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p/yQLdjc; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/yQLdjc"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-464ba2bb3aeso195149b6e.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 23:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776322218; x=1776927018; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gqo8KsmiKUOhu1h1Tv8pIvb+DrQNCIhkCo9yGzlYeNc=;
        b=p/yQLdjcRW7NoEc7ApT1FUcQYDDIW3l1P50qxljaAI/awWAHbBSvxyQm0Hukp/q/dL
         fEuvIcmI2AyeauWfzHAqNu6PqWMYYmhfBC79NlXMZ/CwD24r+J0eCg2t167kPLvetQfe
         2NvRflXfeOkb6Q6ibRECXOa9JwX0BU+fxa0bevv/9bDw8J88ZqXL+qMWYeWyh/DEL0na
         r37+/XQJOVxEGtl1FmINY5hBU7h6hKWqge7aTlOGD1cfuD2xvah805spCAdkvbpyoDrX
         ici2+cuhxumS/0vPPkMpAeZUiZ3Up0RR+q+XjXJWpTAof1TQr6NrD+hlY21VyU2BBCLS
         POkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776322218; x=1776927018;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqo8KsmiKUOhu1h1Tv8pIvb+DrQNCIhkCo9yGzlYeNc=;
        b=PE/RtfQeu3Z7+9ksnxPwFZZLLXdYE7Q+nuBCpFJrD+PzTpIjL/T8qKPuSh+SH9YNI0
         o09rLYQTvoue5jmsk8Mq73jYQm9IQ8gFNMyuhQZco6qs+fZNKHJw2O3ByNPq8/s4XvCL
         R9TRiizRbQv2cPtG73hb35VVuCLwVHIupwg4pX+bWa6DiNdzV8OVsAghpyl4Geugc7Ev
         dQ3N3XLiPcpkhD8dTzE8xukakGRk540SorRclu2b9nncIp7YF1OaiAoqLx9DjEMzSkqy
         rTyhP/WYhwez3NGwVXwnPxZJ2SoBjNywRtrT0pBSpTDocKYKt8enW2OzNS13D8MVkun8
         lJJg==
X-Gm-Message-State: AOJu0YxV9xih7WJ5P8ih40BgocsEFAuauUKsOSRn7gFlh952or5zsNmb
	MlwuMMYWl9FDOaoL9kH7csGmGXW716ZCNDjChGtac46QNxTsixzlcBnoKsdS/Q==
X-Gm-Gg: AeBDietQzoS2+iWJXKIGKS4UGCgLjfUH+2CAMGhB7CelBvPcbXupRLt4tAqWRslN/JP
	Fw0/tRWhgIQmeFOl9HAbHOIjy7FNnrLnAZTT1ykLuv7ppxurmBP3ecrRXqfxOGh3ykR+xRsguem
	HDKEnqcS401GBvAM8i69v3L31uSlm/RUG0CwgfLrP3cJz6+5TMyUrKJVRTdpnpI6x/Xv7CTH54s
	Fe/uhUIwpBu/7BHEM6jKRy9ocKQrcnCnr10Y1Vm572zZvb9je25IEX3/rXQLzrHr8jyOG3SGKgk
	WubXZIquQ2Bt7Bh72vWTn0PVS33+Z8KrdHnApAH6fNQFcPNUuYz+9Cp6kTi/5HVCm7152ydLl0a
	Xb88B1S/yMWzH6iaVSWQLW3aUyO6pK/CFLyi8S0z6NS0Acx/Dk16jAV1pPCM5qJjsRl3yNDIuob
	CYSmAAt+3myJL7cdI1wXK+dKJIcgXvYaCe2wv4+Dk=
X-Received: by 2002:a05:6808:1a02:b0:467:e1a8:2b92 with SMTP id 5614622812f47-4798e18d013mr180210b6e.10.1776322217691;
        Wed, 15 Apr 2026 23:50:17 -0700 (PDT)
Received: from [172.17.0.2] ([52.176.37.67])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4797a4dab6fsm2100886b6e.9.2026.04.15.23.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 23:50:16 -0700 (PDT)
Message-ID: <69e086a8.050a0220.190378.3ff0@mx.google.com>
Date: Wed, 15 Apr 2026 23:50:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5573620173745676262=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: Add initial Channel Sounding support
In-Reply-To: <20260416042012.1204688-2-naga.akella@oss.qualcomm.com>
References: <20260416042012.1204688-2-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5573620173745676262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1081856

---Test result---

Test Summary:
CheckPatch                    PASS      2.25 seconds
GitLint                       PASS      0.79 seconds
BuildEll                      PASS      20.23 seconds
BluezMake                     PASS      647.34 seconds
MakeCheck                     PASS      18.75 seconds
MakeDistcheck                 PASS      244.38 seconds
CheckValgrind                 PASS      291.23 seconds
CheckSmatch                   PASS      347.15 seconds
bluezmakeextell               PASS      180.71 seconds
IncrementalBuild              PASS      690.91 seconds
ScanBuild                     PASS      1014.28 seconds



https://github.com/bluez/bluez/pull/2043

---
Regards,
Linux Bluetooth


--===============5573620173745676262==--
