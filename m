Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85D120DD51
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 13:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768570601; cv=none; b=P3Q1Mf4r5NOX/dTr39EmbGyJihUgzhlnFFiLnt0eZVEWkMfrV4eIJPYs7Btnt6n05QZnb2sHxBLlA9MHkNK3X9FW0E1zkE0aGhaEv8L/2dDkWEJEgosWODVYp5Yv0D/zpgODwvI20LTBAuOiOi0dJNYThiU0HRqlcuc5wY2hL7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768570601; c=relaxed/simple;
	bh=tQzDm5ksJ47Lxtqr2NTZ5oYXtOYq0vzcRE+LNA2OJe4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IEEMSqq8c7kJP235s2v5ePnD07azEt1+Y/6v1rM2uSFtj9hLhoQ1TPWO0BkANAJ5WJrVZrRW2WVE9ZTNnj8PU2MfZ6mlYif/8iuN38t7uihnL3b+8/26dI3G3vLbY5zgxcD7gx7emyOoRsvCNLV9rJI7937HQKcG9t0uhHkZWwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MluxLA9C; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MluxLA9C"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-12336c0a8b6so4105958c88.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 05:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768570599; x=1769175399; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tQzDm5ksJ47Lxtqr2NTZ5oYXtOYq0vzcRE+LNA2OJe4=;
        b=MluxLA9CdGjQpjSV0ipHQH+7wIpnEWj8h1p++H+BIPKzXyZZUqN9LPg4gOYqh0iLj/
         +gbzTwG5HRP9t1fP/tSbJ5iiVeZlXuW8yp6fPonCwJ3mRgND0fubTTveCYQDVpaD0Pjq
         JNQ5lzOhJfes03cbB21FiiNM9j4wWF+G3HPQaJpu9moOLQt+pAkJH+eru0JUmsOw4iFp
         aNrMcYXFTRj6zZxLhxS3SoQNb/EDjwLpXW5gOPk3lVgG2MoPoTMnWwPSwbDee6afTe/a
         utJhvZTwqrIAqkkJE7yk1eF76pzXH6YjmgO4G8vwshnZZaJtG782ZZnAhPpD1rl9kzAf
         FfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768570599; x=1769175399;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQzDm5ksJ47Lxtqr2NTZ5oYXtOYq0vzcRE+LNA2OJe4=;
        b=ehmwogyYlq8tuv2tVKMOntw3VkQI4bFriZo0d/lNQW/UvN0pUxtvKEUn4iAlYb+Cj3
         m1SkByFNa6cBzOX5AV3WPyIAsAKvBiP1e3B/iO2sULt2AJqPNR3wAgOgSezMdbJIboHV
         ri6hMcBONuz5lkaiEGofGaeOPEWSRN5IF4uZn7aGVzMOAij2Y98HBPOK68b3yKzHwI3z
         Z7ItmOKRDRaaf6MozdDdTRgGL2n8zdrGOxqZizKx4CBQG0Ytmk9xBo7Fz9o+FNACZYFm
         2zORB0iYnm39ZNhDg2DyKi9oR4JoHRkwJ2erDaY3xnUPMd9PckQ1+Xj/Nr3M6SqrCqmt
         dNYg==
X-Gm-Message-State: AOJu0YwKxhcXCqR2lNtYmCjiIM/ToAcDeN8GMTCX3rK8DuWJo9oWWJj1
	3lwg25aRnWl0I59C3UZlddHUrKNrSE29KoxcBfeMlVLD4xBHud+MbWrpyP5O5oRM
X-Gm-Gg: AY/fxX7ylig/F73fgAKNrhRbrKy7F60QRuQc1h2ZdWMIJX3dKgAuP9cgsqP1y64fiKm
	vG1I4vkQYNYqMdqQKlbaPN20gUVMOU8yiUBN0QdnkQDu1dBuXru1ZBWTIGbixXxPJ90H+E8Lu6x
	w3g7PJ4ZynSWlmDE09uWZYKFddAzA+SWEc2gSAY4++EgNyRdtfLIF401zqrkIXCjQTmV/1oDE1e
	Y+juLYab2tDOOSAtnYUa7hb2o9XwOz+vynsYbwlrzOI3ST+KvXmPYSU8GS6F+NfOpbeZN78UH5b
	QuZhQkneMCJL2oGSq3PMLPSwqR4PFBebWp684W3cHMqwFJ8T7rSrxeSd+LToYYcBIeLXlKXkLuZ
	/uOViVG0ssR55XOyGPg60jvHfqt9k5V2EZpmjpkMwvbXQlZDuI4R5IDx1cHsm7D0k3i/eL3cUq5
	vLjU11ouEwrk3y/DMp
X-Received: by 2002:a05:7022:2206:b0:123:3bc6:1ffe with SMTP id a92af1059eb24-1244a70d2e6mr2814420c88.15.1768570599433;
        Fri, 16 Jan 2026 05:36:39 -0800 (PST)
Received: from [172.17.0.2] ([104.209.7.232])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244af10e21sm2348457c88.16.2026.01.16.05.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 05:36:38 -0800 (PST)
Message-ID: <696a3ee6.050a0220.150ef5.4fe9@mx.google.com>
Date: Fri, 16 Jan 2026 05:36:38 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8342116290448063844=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: More CONFIG_PM* simplifications
In-Reply-To: <20260116125803.598552-2-hadess@hadess.net>
References: <20260116125803.598552-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8342116290448063844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: drivers/bluetooth/btmtksdio.c:1472
error: drivers/bluetooth/btmtksdio.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8342116290448063844==--
