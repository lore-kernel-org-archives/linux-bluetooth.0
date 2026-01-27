Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112AA3254BB
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537716; cv=none; b=fknS6Splea+YLX6XgadHwo2Cv09ddJtMqwCckwWQ46QhAN6KMwYFJ+/o59MYnbTiCkcbWbzvKvs45/YIXxBrt5dQYE90FWxJahYftloAjeoL0F8vjMEUnhCj/l9nxXV+bQJ98waZASVEa50dYsC8y3OcDotinfPUKaSHdOIZEvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537716; c=relaxed/simple;
	bh=oAhkNPiiafX8Oz/9Qd0ZEm0RcUhUgMCJzyXHazavq/4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=s+yVn/abSDJjSGR+qENG74e2S+i8vm5Y+l9W3pnpm1dz65neCFE4ohFiYXz3Z54EcXgCtry1EpfqP/63vxaQxKkywIP1UfKMHcxW9Xb/GzZOJ2PQyMhf/Ly4BRNVe9XKuEwahMaJFjcDEojRqY/LWWv1+h7FmgB7oETApV4yEXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TKXH8722; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKXH8722"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2ae2eb49b4bso13573423eec.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769537714; x=1770142514; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RzSE3jhdYEgv12E18vreDhDX/KshRN9gB9qmmSxtPac=;
        b=TKXH8722ylL9paX9GkMlmgdEBzalyapFOZRLUZtwvalXtTRRnSxw7H59lUgVp/umbS
         DefppLEt69r3qFkWo5C+oNc6eTRpHt3iI4cvcDG898pKrPLYFobSYpeqSgjirQSS5fle
         5mv0oydjzpa963y6F9fW1ktn50H2JPLhbZPaWXSPl7/ERaW48f46nImqT0N5MSYuF67o
         Tc8hRr4XKI0Mh4/i0s6SszSbuMEHy78nqdWEuzXo4rHcM3dk8Kun0k3kRzGDtuJkNpnR
         CYeukiEdb1sY/1Bzz/FZ3OA0TlA3gdM4srRcaIbp/MUtFA3xXvHosId/IUxcsdKs1UMN
         oupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537714; x=1770142514;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzSE3jhdYEgv12E18vreDhDX/KshRN9gB9qmmSxtPac=;
        b=q8q6nIWaEzUUxZ9ZOvcOXf90Uu/VrxksCJV2Sqt7fktOxwlojAK9z3wLee6mcifqw4
         PlCO/SqUPOeA/OQoTSQmyxH5KWiPg9l9I8wq+uLAI+Ii/bkDECbQp9CghO25h4K8t9q5
         lulqzWXhNghmdsoQbdy6A2hI7r2sldpgQQGDNtuSlrwBja0jTghc3RgjjpcdI1aCrtHq
         z/8Znkhmf3B5ujDa1HuF36dGGJ440sMefOhrZVJFSV0Kkz/Pc6vyrjGWH5PzNiBwNAuu
         PucHqCpDL1PrxSUJ7tq2OaUfOWUzbJVK+F9prxRwG+aaJDWpA5Y/ZAGWl+QgclkTsJwQ
         Turg==
X-Gm-Message-State: AOJu0YwB0xy32z+dOpk+4EVO2QKis33Ns+brDcTtX0yrWWJezReaYF7n
	P12yB4v9ySDgeRtW0vu6uy691GKk/NECKOaYKdT8xKxTbdR40W0eV9rACBa2RMB2jQA=
X-Gm-Gg: AZuq6aKuuWdy200Mx34kkAT+O8vT4W/ipQLjrxoFQtX2kXqQR8UAfDNZLlvw0tKRXJx
	W9YZakPvES6owtNiD7/yrRb+dbVT7ztShcg2ZV0b2vsrGji+40mifzXlASnvhbTJGrj8iBFJxIH
	DNp+rPolqToQeHqTUPSaRynF9BV7Oe1qfbQWRHiLMzpg0XIbHD/IJzu1SXO+ChJmiL38+Xt/Kw3
	HGqOkSxfHhSYxzUbW2BpqP80xnk6mnMNVNzL5ALgI5ne8W2ZVBAFh+7H9Cpec3C9Ae0FE1duLKh
	yT9ExZ81TcvKKNH9QOWLFO6NN0ukI9ygUU+C9L6/dR5fMHCfnQZrmKDWJeabGOmbhYc34tDf6We
	A668coMQXX6NkDafnP/0z4D5YygXVQU9JpvyihjKlB5xy+RODHu9GeW1NX7yiaEWA4KrhFKg2Pt
	E3R8B5lA1WtO3ApBAm45Em43AmJ90=
X-Received: by 2002:a05:7300:d718:b0:2b4:5b59:af52 with SMTP id 5a478bee46e88-2b78da0f553mr1510775eec.29.1769537713548;
        Tue, 27 Jan 2026 10:15:13 -0800 (PST)
Received: from [172.17.0.2] ([52.225.29.100])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b79caf7387sm244128eec.23.2026.01.27.10.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:15:12 -0800 (PST)
Message-ID: <697900b0.050a0220.3bf63.7f46@mx.google.com>
Date: Tue, 27 Jan 2026 10:15:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2989999058434529164=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] doc/qualification: Add PICS and howto for the HSP qualification
In-Reply-To: <20260127171613.151644-1-frederic.danis@collabora.com>
References: <20260127171613.151644-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2989999058434529164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1047701

---Test result---

Test Summary:
CheckPatch                    PENDING   0.50 seconds
GitLint                       PENDING   0.37 seconds
BuildEll                      PASS      20.26 seconds
BluezMake                     PASS      653.76 seconds
MakeCheck                     PASS      18.63 seconds
MakeDistcheck                 PASS      244.61 seconds
CheckValgrind                 PASS      296.17 seconds
CheckSmatch                   PASS      352.95 seconds
bluezmakeextell               PASS      182.84 seconds
IncrementalBuild              PENDING   0.39 seconds
ScanBuild                     PASS      1053.18 seconds

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


--===============2989999058434529164==--
