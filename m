Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF784746D4
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 11:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787313104; cv=none; b=GMyi9D262DSZFoLIemrqwEQ3HrCoOqtO/YzBVvJ2GocwUY0x8BF+WFoh55q6BceTbKzIEvSx5QwWdF3xsIR5h2qRbHJ5XUwdp3EJM661bry/IRiqlFOP+1u9DImnA5MN1ydK9nePiXGbcoA8fJmAhGJIej08gyWq9zPEGfGZM1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787313104; c=relaxed/simple;
	bh=ZIyjQNd6f4y2aRlqn91Eyk0wX9JniXlwB/Ul4PAeDhY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LIodvccX5MS3fwjE9nZdvvIX4uyCCbmoM4rukNrm4JoIA9BxEehhfgZOyQOPOkx5pmTReQY5BSBLNQ2+ZsdTazlkGRHF3peXlzfy1dQxLK7SWX7DFPWbgeRHk/unU/yWoSUOEwwq1CQfFXVf+OQwf/7jWyGwdFATh4Nw0vanau4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SsdoW4Zr; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SsdoW4Zr"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5276d598b96so4343801cf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 04:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787313099; x=1787917899; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XiZ41KYPtcd+aMy/vJFv/xmy6OHvy+8LBJ/frxdKZnU=;
        b=SsdoW4Zrdky8oFrZspXIkMnlN8dz9jjV3qRthhF708cRgakU5KG35BMYr+sfIL3DnL
         4a6fNVd/Ze5RM674Qw91mq0cmWNQsaZl53SdfwQBsntmKcYmsz+2D2MZ16nfE63MoQUu
         eTsmYp8YJS/IdS+mRBH4ajYVuLaGpy9FMZBSvisRO7bmvjlxEtWu0J6maiFVgOTuvXRs
         2sQyrs1ffYJ++LdbNGwnuEVIvNFpe47Y0pgELg+6O+nfjQzpAfYmijof2rC2xwkUB5pM
         YD/e8IY+jPLN255WSDgBX1+PqQMzwN5PDPsl9MkmkUfedCo16kmh5F+Lg6iWtAtVlvzc
         Spzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787313099; x=1787917899;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XiZ41KYPtcd+aMy/vJFv/xmy6OHvy+8LBJ/frxdKZnU=;
        b=jmWWsoXpviyt952lKEKkHy1jMxPZ3CTdlUkSyBFi3eHQDCIy5ME/GED5O89w/aC/iH
         KPDgYx73irhZH/E6IwIXHGIP1w2GGBC1+HsYwx3eqbTWJphNBZSxSJbajNPqqj57f7D/
         6TV9N5O5myoByJKM4b+spK43RvIbRp8zYWp3yYwWVi2zGXmIcRpDgshVtLZkeo+Tskfw
         W3jWcCsA0mGiK6Kx8w0EqemlgDsgXwLRbjMosC5Q3Jvssvofewi8pXvItQD1XYg/moKn
         ohcWuRcBIDUZjgs3YwcrMBwZVFzhmnxvvEMEw2aKi4Urn6Jikgvy07//yVVZUlBly/Jv
         Ws/w==
X-Gm-Message-State: AOJu0Yzp3QzXKT8AXtAKDu09RUD0XQtraK/hpe6YxbyPONLyb1cA/3Zh
	Hw06wfAZvNzAl1+WFwLCMzHGfaeh5kjHFZ0xX5DEyoBW+1qotl+I6TmWsOlLo4ZQ
X-Gm-Gg: AR+sD13p088TtbYYTKL2Yr+rmYYReACH8XzmJ8MgNXAaYyKJ6I8LCwDSpKjGZ1fLCbY
	wxD5lmE7AgrkwWFIotapUM3bZrt8QO4k8BEOpPJ9T5trHkdVzKdJGyF0+nlNtwivbEDhmmYaVDr
	iE/rV/+3d4PCXEgy6jWuVBfqG4tyVs/2ukw31Hd5lCvOkAnWRPH9YfTeAeTfXnkHAd5N7CV02p9
	cgrax1YLzX9Y6VbKetkSj2vkViM3p7n+iWQEbt9p8kah0kpB02ztelU9W7RD2FiG2DWCEk/1jwN
	j2CK2YrghnFQXF4C8FpiYaySHAcDgcStEaiREDHnll7T+HJqxdIpTULqTWLMSNSrpgh19RBAyzK
	LD30fT/BVimyR2M1PLi58D/MyfmqVMYN7FzY/aTk0BXaIsCJs4HZgOGUOjC8HzCJbkt1RpwSKne
	MTLC+XsWlfaCWyelMmFbGojpkZCjA3E4if0HmADsJJTPfxQUqlOaqO6h9SftR/mUaS4O4=
X-Received: by 2002:a05:622a:4a8b:b0:51c:f3:34df with SMTP id d75a77b69052e-52df5a73050mr46964321cf.30.1787313098647;
        Fri, 21 Aug 2026 04:51:38 -0700 (PDT)
Received: from [172.17.0.2] ([20.127.247.37])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52dd85991b1sm48209171cf.10.2026.08.21.04.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 04:51:37 -0700 (PDT)
Message-ID: <6a883bc9.403c09ca.3038c2.e5bc@mx.google.com>
Date: Fri, 21 Aug 2026 04:51:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6392677806861641072=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zuohongsheng@kylinos.cn
Subject: RE: [v3] gatt-server: Fix integer overflow and 3 CI VLA wanings
In-Reply-To: <20260821104213.131920-1-zuohongsheng@kylinos.cn>
References: <20260821104213.131920-1-zuohongsheng@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6392677806861641072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1149710

---Test result---

Test Summary:
CheckPatch                    PASS      0.48 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      20.20 seconds
BluezMake                     PASS      610.40 seconds
MakeCheck                     PASS      1.08 seconds
MakeDistcheck                 PASS      157.84 seconds
CheckValgrind                 PASS      159.36 seconds
CheckSmatch                   PASS      311.31 seconds
bluezmakeextell               PASS      102.68 seconds
IncrementalBuild              PASS      608.94 seconds
ScanBuild                     PASS      971.03 seconds



https://github.com/bluez/bluez/pull/2425

---
Regards,
Linux Bluetooth


--===============6392677806861641072==--
