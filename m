Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1961821ABA8
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 20:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753820522; cv=none; b=lk2pUh49ITqp8lDZAtPkVezJoGqlGsLl0GSdP4JvXK22FGx+2FT/KAkgofweRBKpIAx/0T4wsfubBJTL52xyVXrzN6XPkigYAN/1wd7TvmV68557ajhqVua1ZTx0iMSB/Z7S/YuV3uRHyiuGcp7rU+PzyDLulDOqEdHQH3rN9CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753820522; c=relaxed/simple;
	bh=mftAWjmOcoDXPx2k7BuTh3mOHwvvfPSscCBvqM+1lRw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MylFi+r7+q09Wuh8Asyv6PX9UZC9nnWfzLIWVMslE3mRYdZk+L8iwij8RXMC7qRDbgd9/C+ymhaDEiRCDngp6KXTUxIVNqMEBdCONrZZjHtrl+FyUh/c6gEHZ9XjO514YQLhNq+cOmGXuenRns66gMtHmcV5vKPIZPNgEhzLYHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S60ej25n; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S60ej25n"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e34399cdb2so30879285a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jul 2025 13:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753820520; x=1754425320; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Shbi6OENEauu8/WPl+wpxFjlxv7m5Qj0nM+6jjlcEDI=;
        b=S60ej25navZMIvnWo/I7TiJv12eEaW6vNj00ARPjbpi1EMpQ25UNZH5KXMkIvrkUTQ
         xshTs3S11DBIAJKLUKt73kD5s8zos95fHvx2i/NcI4v3VYUTC8akkArS2cedDOni6jdO
         ySMX5MGOX4GgI15ou7f2LdJcypnN+p1XeXEWvXyVTmBZccsBHEmtEPZmR+ToZfrqbT+H
         fgeQUAocHPU4jtioJBZRF/d6bgyMvoXx6AwXNcC5QO5WrmvlBEbLxOlGYI2gtymM0e+Z
         Iwr1woxzIUa2zQJ7XTZzSaiAuhSqZxRAPH5J+gcPEO7tL9pltvy/xVUxMdWNkt0F+9Rb
         6yhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753820520; x=1754425320;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Shbi6OENEauu8/WPl+wpxFjlxv7m5Qj0nM+6jjlcEDI=;
        b=Oow+F+yh0KlRoQSJ4qgvolZgxax2wYVlT2yB7SHE5zh91YHcJ9C0bgajYq2rEwfMjd
         T3caWuTp0BS/gu+znuX7lI2Vek/xvMLY4MTavWULVEGXV8iJGCy+tfJHV9SHKnJ8E/vq
         3+PyKIg5S/+H5CtZLD+na91OZ8vCeqIEHIIefcx3oRikAunzN2Y8KoOKJKr8r8RT/27Q
         eJsmiuyjhvEyC+YzopaXokHhdoVWtiAGd3cp//wvMezwLZ4mSS66QyoNTb28DBNPSFt6
         /QS0KUwGj9IO7158Y/Ee3f4/yQxH5sbd0XAHFgKpTx3BzFgh1uMZiDS9UX/jwhvSu7xV
         PHMw==
X-Gm-Message-State: AOJu0YwbY3VDdVkqLB+urMBTkggvBsirnXZryo0XDtJbc7XatbzfpPBu
	rC/m2VzZ4yx/777+8MM/fysfhgt1MOkHfgjyquskPA19OjnbKknFpQskUMnZyQ==
X-Gm-Gg: ASbGnctl9CUonIuTu2yCxUV6dHcFT/YCkqMfB8VhfqfGoB6WGgTDdNjx51isamXMbuj
	QSi+H9l24YY3oXb7TsOHqxHlelHJj3Xut4bp2/aSHDMo/CMpcifhUYVdIWQluNYknEzkKn9yOL6
	a/K1x3q4YHvgnM6zqjwY7FK0ktcDfkxvW7p/Mlrgk22DVM/y0RAHCjRca0KyqABYXJ0ZzjSUzQl
	gcRB4BmDJGt6+kapu0fihZ7sSWV+sZ/zRX2Mo2NaAZIR92v/UKmzg6KSe8q7BJ8RQ/B05fC8kv3
	zKrlHDpQ8CRJ+uaLt2JId3zROnTxvRqqZYhhcXW9+ypdd8ImJaK+1oOS+VwDyCKT4d5KBHmC+tT
	M0fDHpbvAqboAg3pLKApRATNZoezsxQ==
X-Google-Smtp-Source: AGHT+IEUILi1wdjVBNWzFBA0NCJvnWkhDNY8eZvQzyk+5LLDB3cpCvGqCSqjeLCWkOQbitF4RJdHjQ==
X-Received: by 2002:a05:620a:890f:b0:7e1:38c7:d073 with SMTP id af79cd13be357-7e66efcf3cemr128181485a.14.1753820519645;
        Tue, 29 Jul 2025 13:21:59 -0700 (PDT)
Received: from [172.17.0.2] ([48.217.143.101])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e64327de82sm458916885a.2.2025.07.29.13.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 13:21:59 -0700 (PDT)
Message-ID: <68892d67.050a0220.22b39.7202@mx.google.com>
Date: Tue, 29 Jul 2025 13:21:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3742470465335788203=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,RESEND] profiles/battery: handle reversed ordering of CCC and value
In-Reply-To: <ccfa6652c4391fbc7d403f3e5208fa1cdfe983e3.1753814700.git.pav@iki.fi>
References: <ccfa6652c4391fbc7d403f3e5208fa1cdfe983e3.1753814700.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3742470465335788203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=986817

---Test result---

Test Summary:
CheckPatch                    PENDING   0.26 seconds
GitLint                       PENDING   0.31 seconds
BuildEll                      PASS      20.29 seconds
BluezMake                     PASS      2842.38 seconds
MakeCheck                     PASS      20.22 seconds
MakeDistcheck                 PASS      184.50 seconds
CheckValgrind                 PASS      236.17 seconds
CheckSmatch                   PASS      305.71 seconds
bluezmakeextell               PASS      128.51 seconds
IncrementalBuild              PENDING   0.24 seconds
ScanBuild                     PASS      905.08 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3742470465335788203==--
