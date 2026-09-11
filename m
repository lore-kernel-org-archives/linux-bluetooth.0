Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AF2414418
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 23:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789170969; cv=none; b=RbTCVosT8+bkY5VCL/7Mf0R09ODSLfZ+EkWIWujvFGstrRHT48BDRmzurNCw52uJ+qVdkXxvlg7kKksMMDtRL9a1pE2TYWrfzVevjsA4BC/EDssI+BO1vK70K5WlTmPEMsgSQ+0/D6oPXEwlJsZ9KeOdBw7gb2e7prZ5mG96/oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789170969; c=relaxed/simple;
	bh=ihmmtkJYBFmBbX1rgRpyGZlpK4POQyMlQ2Hf3j3mXzo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=gqytrtnYzo6kLluEHKeiuJITStaFFmQXuWMZ9LDb11VhXE/9WM2ZdreR56ZW+5NLEfkwLj9mgh2ELfYOdPdrUFNTrABNMeBzoFpQmn8j7PyoW+T6pSYRQ+H/5UJAR0Wube65gd2myxHSKbIU7mOwzOIyHZ8XB9IDztR9nQ1sOHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pT97YCEG; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pT97YCEG"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9399daa3d43so121329185a.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 16:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789170961; x=1789775761; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lI+9O9lZMKcr5HQfXTMWTp0fWuOk6JaWkF9bkwytQ/Q=;
        b=pT97YCEGkPquFkQKwR5u+uTJS31pL+VYcpXvJI6vN/YNjvITZ3oADTjZypNjpCZfTm
         Dr5OEdDgee4zxV7t82A/KfYOwHQFv6SuH85PkpJqdAjYLe4REiMTc9sQwCsqVdKkn17p
         c2NlKubGubw9qcLhd7DFnZyYIGTlulQ9U1xW0+SdHqyLxyvkUqAruQf7QjixFDW5t5DR
         klugBmUaNSekNK8UYc6OlVuMyeCkbtsD2SdvP1VxNz6u20PlUSq6uHhLvEij2u9d36Up
         DomYYMgr3QoBO9yneS6F7DdRMgTJPV6gP7LQivMshJoHgQOXO3+Tg7ntxN1Wz7MZGGpu
         9DNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789170961; x=1789775761;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lI+9O9lZMKcr5HQfXTMWTp0fWuOk6JaWkF9bkwytQ/Q=;
        b=WsUojDQ4nn/3dBYetiJYk1VhFmSMwrv9cR5OFY/FAI91Il0V62kmA3FdD2hNdsU+c7
         fzBPDooak532SKJcS3n643vsnrhXsLSzAUw+T3Ljy/NJ1XshSrdIO4EIIaWbfGGxFXaO
         GTADpFgGDgLQxJNJZu2709WPzDgd/lI5yrubDUsciErNQGP6K7HfJVelErLKBW9kikj5
         SdRvyO0C6ruPwsg4njZP8+K9pcfmo4oMP1sUE3t1yA65uOitpUkTysS0Om7jJLpmzKvk
         kJCJOXBDT1B3OKVpIePX8cKKbudLZVmzGJp4zCblMUhd5KAqKtbG9wZ4Iko+jzoLhPUY
         YKlQ==
X-Gm-Message-State: AFuF++kybqhWJN1e47zjVJGNBs5ASYEkBXYYlkTkDJ2I/YoEacH10r0d
	vP51CMFwhXZaH+2RXHCK0irSaZZHV6JsVYSN7QJhR0RIoa6/m97Hc2h1fVNbiA==
X-Gm-Gg: AYBFou2yBqaYc+1JM8C10aOiEMsYXh0kjAwsnD8A5bVFDOHWvtoJzygKVxQLVmFbbq7
	YnHLmRdk8Qw8Di1zUw53wBaJZ67T8o8SJ0OyoWGy9Ye2c3ZX/RG3OdsrWD3TIpX0PA+L3HTJC+O
	BFt1OgYJk70MNY+/6ZEcbynUKa/VKtMD/iuNXwhi1YIpd8+ZMGVphVAZVpWv6P1QxuQxb+yAZ1I
	s5SKjU1JA5sk9FDBGBqE/qJtLtDGRNiJZWE/emBVYc7BiPkjbkIC4bNdQxgoWj0Xi/FwJjZY0I7
	Sxza3O7DcMpVx7efH+Wfx4VPWRH6HRtkTPbp3ntdZzjLFxbI5TosK6MlC1HMbdTAs8nFGrov+lt
	XpvQxNRGVKstndUokmFbbzxaFeAaNRQmzSZeQp22DRxx4zAPUM+JcmjyxOzTIEgboDUNLC0QrLo
	XsI4xnaiK+53JtnUhvBJKXLRxqzXLQrVF+v0SzSsWSTFLdhWN5yutoslk3GPcIoSSXMbBxPakEX
	CbkE96lj8C7ECGKRwc=
X-Received: by 2002:a05:620a:6601:b0:936:9f46:cec8 with SMTP id af79cd13be357-939ea1568eemr866835585a.20.1789170961394;
        Fri, 11 Sep 2026 16:56:01 -0700 (PDT)
Received: from [172.17.0.2] ([172.174.167.17])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939f1dd527asm240707585a.16.2026.09.11.16.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 16:56:00 -0700 (PDT)
Message-ID: <6aa49510.e947ddf1.e37e3.a3fd@mx.google.com>
Date: Fri, 11 Sep 2026 16:56:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2871810222255387826=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dev@grantmoyer.com
Subject: RE: Enable D-Bus activation of bluetooth.service
In-Reply-To: <20260911213253.766659-2-dev@grantmoyer.com>
References: <20260911213253.766659-2-dev@grantmoyer.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2871810222255387826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1163256/

---Test result---

Test Summary:
CheckPatch                    PASS      0.42 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      20.00 seconds
BluezMake                     PASS      380.72 seconds
CheckSmatch                   PASS      296.26 seconds
bluezmakeextell               PASS      95.41 seconds
IncrementalBuild              PASS      383.42 seconds
ScanBuild                     PASS      1141.33 seconds



https://github.com/bluez/bluez/pull/2520

---
Regards,
Linux Bluetooth


--===============2871810222255387826==--
