Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2E54E80A5
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450521; cv=none; b=olFB99GMA9H4cjl+WC+FjzQm+HqRlF5hnu19YRkwrqUaDJnAJxUxP4cgaIYFQQMjmOYPRwyxiqoT2t8RiPwmgVoKzSFcdv9rGy8Kwn4Oeee+1peqANJ2JRoOms3z6WIJtISJSmzlTVl2irMOhWLAsvv9LQLNS4flkKfG3VNxV+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450521; c=relaxed/simple;
	bh=V+ZEGljiATW6O+kxWM7GXMa0oBYss40xRb6AcH2YysE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AohA+CjxbaHPuHQFhyETawbeO7kVMTHv2aOGJ5TNnHCf5IFtAhxC8BMN/C8QhsA2Ifh4t4y704qi85S/1L1JYl99rRDKaCvvsiOK6CRPiL1I/hzmhoW9Qn+UKm1kZclGq5elvScvQqFmqoVH0Z14CSzipoNYcl5OGrze2XGkTV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V58OBTI9; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V58OBTI9"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-9103e193381so1457756d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Sep 2026 08:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788450518; x=1789055318; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Zlbyi4425yN8cqsNYCAe4UsWoHSjLn7ym7y4dYdIehU=;
        b=V58OBTI9ANCCbzjA6Mi0H4wh38FGjvfIYjDYoKVIlDEVX8HqTUp0dIaxehstbEDs75
         UiHj3GViY+8KVcIakBA1aFuHS6UiR9cqtPRpn6//Bi19upuKaFZsVO9nNSvXvxXa6hTz
         f2vV3B2uxd2JzXAFV687OK89dVU9aRALpbflkEg7at5RNjHwpnRFjMf3jVSG60hQS2ay
         wnR7g70v10F47Bj+Tk2UAmCEGpZCQXO97xAI4SrJKXttdlrmSQMZXY/EwjdjNcFwaZf2
         QZPh7aciPdfo31q1l9h/g4Ca3feApgTUt+TJ8ezGdWimE1TBVdu7K3mQ+Y4VTtg349A3
         kuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788450518; x=1789055318;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Zlbyi4425yN8cqsNYCAe4UsWoHSjLn7ym7y4dYdIehU=;
        b=elKglnbh21cHEQyH7sT9DW++IjJjvwp8daYgr4C8CCyM9JnnJQAOs3fFAO4Oabm6jI
         PgjhPH40Ot6xgk12pcsGPJtPI99CRWrsyXZQE7PKpXzLsS9glOVs1t+G81BPc07U9F/y
         XmgHeZSzUhg8xkwl+0lb+Dx+lGiKe0y3wn4ePeNR+JERkFSbECWajaGA9L+TLMf6XLb9
         zTQWh3qmkMhqePIOuSlKcG2aTRq2AMp/b1hGf2vB7l8k2VdMFcUaSIoQBAp/c3JDdwyG
         qLK0Tq2O0qssKmZpJtYiVAe7uhCOGO3siOyIBz87NmYnNGW97/QVvn8VnarvM/uR5tyD
         aNXQ==
X-Gm-Message-State: AFuF++l7j2cMK5UhazTrKIiM2RloslEyK2hrHpdOdMPQG1drKWonSXzz
	xoF5075gOolv+/0ow8OvbFN0vWCR2UmTWsQe7PZx35/rLuK5C2m1iIlBEk373g==
X-Gm-Gg: AYBFou3eZIW82merSwyJFyRQrSzr463bDTX7MsxuoClwxNwqVWPFc7p/X6be3eKsbOu
	p5HL+/7pWClykf0f3SjsaItcEwKlo1m7FtpBpK8lv46m5Pn+2dZTLYB6wlsfgcOtLMWKEa0ganA
	HY2Df7mPf2w4TRUYFd0kKBzJLOk8oaEyeHisbNx/RFaRXkBBHUWzUUnUukpc6O3yTtvTxbgqDgg
	//J2UUmpHEUG0LnJt0wA51QrBkGVoMIDX+pN9vttv0sol0mMwmlVITYESPClw8dxpzJ223lbeoA
	tvmHpTcDTT+V+eRERo6GRAN6cpxtHEZ974Ms7SYxCm2+uDi8q8osSFojJVSbkqrfElzNbVkk7Ex
	PEgCc2UI3Bri0VJIqsgwYcJQ3sHR17L25OBxc6f7vOsZTHsGEX93n0RKlvQmJxjyEAYtFl3zvAw
	07jmNFVVzerIrCeOL7wSlKNWmOeYdEk+J3sErQmqU67nqbWWumrvGygPt1LmeyIYMEcidloQ==
X-Received: by 2002:a05:6214:4601:b0:8f0:3b2c:a9c8 with SMTP id 6a1803df08f44-90e9f25c224mr179092436d6.12.1788450518252;
        Thu, 03 Sep 2026 08:48:38 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.166.195])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9102ec700a5sm37607306d6.5.2026.09.03.08.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 08:48:37 -0700 (PDT)
Message-ID: <6a9996d5.4bfec62e.81ec1.4ab1@mx.google.com>
Date: Thu, 03 Sep 2026 08:48:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8940077401634580485=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: input: avoid NSP1 disconnects caused by Sniff/Exit Sniff churn
In-Reply-To: <20260903114849.777525-2-frederic.danis@collabora.com>
References: <20260903114849.777525-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8940077401634580485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1157040

---Test result---

Test Summary:
CheckPatch                    PASS      0.99 seconds
GitLint                       PASS      0.66 seconds
BuildEll                      PASS      20.29 seconds
BluezMake                     PASS      568.29 seconds
MakeCheck                     PASS      19.38 seconds
MakeDistcheck                 PASS      156.52 seconds
CheckValgrind                 PASS      224.54 seconds
CheckSmatch                   PASS      298.24 seconds
bluezmakeextell               PASS      96.20 seconds
IncrementalBuild              PASS      572.67 seconds
ScanBuild                     PASS      900.81 seconds



https://github.com/bluez/bluez/pull/2480

---
Regards,
Linux Bluetooth


--===============8940077401634580485==--
