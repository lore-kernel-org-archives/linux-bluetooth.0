Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C9A45BF0
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 20:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397729; cv=none; b=X7zONrLFNGHs6BJBoXFFEI4AQfF7JcSX1lG7W/dFjqlbyqCdqgd+XRrXtJ2shjDrtSXWiU4Up2jyu/yuHVkbkatFr4yVPoTcicmaNkEkY124VxzRX9LU4aCHvf+DxSpCxdXzpd1bSnqovjcXMrqdhImDcVmbswftMFImg9WdfyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397729; c=relaxed/simple;
	bh=1CMHx0NeQjzug0VWBuxIUlDAYvn8UZVxUEednw7flKs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IotJVBV9K/XXTrKWZZa9KQzzSCb6PPtj+84bC5sEinYn4zqv9y65GQ29uhexa3+Rw7p+4x7N8VXEJNSvKnML5pNwa2D+gUGkiFPSf1v877MdhyupMFs+JS+dFKzrwXhoAY5XtjkDolNQiyvy2omur0XZU0uqZZf+3Be8VFHLn7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2xNQNl8; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2xNQNl8"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-78a5580333bso89331185a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 13:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711397726; x=1712002526; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OWmZ9yNhtHCvTyZkXKnnQjrW2wztRVat4YbFid2yZOI=;
        b=N2xNQNl8+my2lhVrSqByzPHI7C8F6mSTnSpz1C75yHJMjlVja4+Qalit40O5NrqNMY
         YkgYCBuCjsPhJNdTbM96/T8V/EMFOEdjrcF8Kv8yWSVPytPc7okTegd/9cZLsV5q7Orn
         hmVeCFzi6JvVpeHhsWwM/V7X5o4nUhB12N4i6zrpKPjeIvWo0LSaufp0ABCBLWV+Fwj4
         HOxk9YqeBQqZm7kgL3FkkXHMT7Ie1ndBVv5VZyqgKnN2IIT8RvaRBuq2mp/Ae6Jd2D+F
         lTSYKiGGvgMbU5+IMr19H3gn+WNwmlWbUYKsxEQCnENFMo/pne08BD+D74r4gHiPTfBB
         NKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711397726; x=1712002526;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OWmZ9yNhtHCvTyZkXKnnQjrW2wztRVat4YbFid2yZOI=;
        b=n2aquNFyKL6971X9el0cHnnJmP05tmitbpuB6p+6SivGJ8akocxnXwHjhHxO/FuAH7
         kiXXvfEquvgQdr7dtIIqEtfMHEJsxAVJAr7VSYuPMlQTY3xnojFgGSBzjjVPQ3lG/Cyl
         bEogg8lBMTe40jXvx/0yT5yOkmYH4h2WQcCBEItseVyQF8LW+C+RJPzBxrMqU0QcmJuW
         0uixFeHOiKlmTJI7E6yrR79I7mNMXNJGmwx4Ol7zhzu8+W2kdShwhWGP+Rcox7Xr+10k
         zG6DVbMChJbV3CWo3Zfnr0astDNLhzYi3aBRLs3y+TVFhTmiFMAejWJd7Dfy8RbYSC2n
         FchA==
X-Gm-Message-State: AOJu0YxP1znauKCI+2zJ6HY7iT5icJ1rIDu2Ra+sl5qFbIMxZUcd78xx
	XO24eoj7aEmddj4rf5aYsKww1MCXBHGK0oklQ0OT8PTjR3ha5o+3+n91eQDW
X-Google-Smtp-Source: AGHT+IF48byH0RwFF5phE3Fo+V6+IYokYSxN3Dg0KncKhhLhCY+So+KzPzfgXP8AINa4ttOcRKdP4A==
X-Received: by 2002:a05:620a:8527:b0:788:2fc4:c3ff with SMTP id pe39-20020a05620a852700b007882fc4c3ffmr7417420qkn.31.1711397726534;
        Mon, 25 Mar 2024 13:15:26 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.154.103])
        by smtp.gmail.com with ESMTPSA id cz33-20020a05620a36e100b0078a3afff77asm2411744qkb.8.2024.03.25.13.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 13:15:24 -0700 (PDT)
Message-ID: <6601db5c.050a0220.570a9.9e3a@mx.google.com>
Date: Mon, 25 Mar 2024 13:15:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6107907135862787983=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v3,1/2] shared/bap: add bt_bap_cancel_select to cancel ongoing pac select
In-Reply-To: <afc30fd4d201bdd92ffbc682ac66f472ce837814.1711389066.git.pav@iki.fi>
References: <afc30fd4d201bdd92ffbc682ac66f472ce837814.1711389066.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6107907135862787983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=838006

---Test result---

Test Summary:
CheckPatch                    PASS      0.92 seconds
GitLint                       PASS      0.61 seconds
BuildEll                      PASS      25.79 seconds
BluezMake                     PASS      1832.67 seconds
MakeCheck                     PASS      13.67 seconds
MakeDistcheck                 PASS      188.76 seconds
CheckValgrind                 PASS      260.94 seconds
CheckSmatch                   WARNING   370.41 seconds
bluezmakeextell               PASS      129.74 seconds
IncrementalBuild              PASS      3157.23 seconds
ScanBuild                     WARNING   1070.47 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
profiles/audio/media.c:1046:7: warning: Use of memory after it is freed
                if (req->cb != pac_select_cb) {
                    ^~~~~~~
1 warning generated.



---
Regards,
Linux Bluetooth


--===============6107907135862787983==--
