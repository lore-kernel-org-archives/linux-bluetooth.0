Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795553526;
	b=xId+FXf4TwDW3mwHTRSux3tnCnY+1JJLC0Ii9heolooodE+z2Q0TykNVI/So/tPVro0B
	 3y3qUkupJp4P8ls8r63Ua71s0UkA0ebrdfGS/3G2ivFd5jr0ktaOX7u4S8uYPrr9PVbfm
	 hFkH2TJE9qYd68riOfPED7ON3qe8c1vRk+nntZKUjErT6PerUjE7Qtjp4MRX/0c3tVnxI
	 gCUKTifjue7WCiY5L0VVyE5yF/xKR9vDP5eNNcyZKDH/cZech6/49JTQ4OC4QpELQm2Js
	 Vc/WwILpYu+2qrfHLlwga9keOjJJj8HjaAaePR1qeRRDFwf98MjuR4K4D8zfbINf5ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795553526;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=OLlgY8c813bGJjbkN1vDhkOp2lkX3wKnpa1LA0DXqOE=;
	b=ENfG7fvRsV9G7u3bqS0pYjCD+NySMrMsDN1qJoYmj4vyxPfP9iCaTVpRRZnZGRmors4n
	 UhatbMoDsbD3osEM0eWGAsA0Fq3geHVX3g+6nD12RxQFdUQXySXKgtAOc06dJ3tm1we3Q
	 bgd1G55lI2sWEsBOxRXK/xxqlfo/lDSfre0dmD7hhzv/cOJIu6dsHz2YOsWbP7mvyeCCG
	 GpWYKgjn/2P/8zbOeUN399GJYSJZQooaGtIedvpwWpJTOjmqumL0jJUh0fns0911hCG4V
	 5/MP7Kb0FHj6Pks7gMmROo2t2QtPTRYWJ6jBJkIVW5Q1dP9q8YsUB69rbNRfPaNOBCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YXr+6Zep;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD05D606A329
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 20:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD05D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YXr+6Zep
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1b244fb7fffso4880973c88.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 12:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795553524; x=1796158324; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OLlgY8c813bGJjbkN1vDhkOp2lkX3wKnpa1LA0DXqOE=;
        b=YXr+6ZepzqOSpoylq0813zrqcj5ptUcytFwqVJKxBpUHkYb34WLWznQYm5eHhHADOW
         uRM8NTWQRjgz79NKBKHVosqo2Iy9HihznKNtBrGYaAV7u32ryD7fesXlWHcpAa2YqY1N
         cWWEk5S3JYJj53g/t1XZ/GzMrmUWsTmi5natPAj3GZV6gbluPK7m+2fq2WRymPL4ifsv
         yC34XYgfmAW148j4EY/ppcrlNip1nU/I/bRkAmJCDYuSdyYImC/XVhOP7q8bCfqM2zhW
         Z4RePQm3Ng2Ku33/HWkSt20lvbW0ZQxbpqHp9MSZyTYTzzQ6bH3ZSdCARI4Q9EVgvO6W
         vmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795553524; x=1796158324;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OLlgY8c813bGJjbkN1vDhkOp2lkX3wKnpa1LA0DXqOE=;
        b=QIBrlbFSg0rZJoLY6ZEcKICQVdlVEVTdaSs8QD4dXc+bi0J5oWib+ni4fCaXk1AQr3
         Ax98kukv1SJluOUh+MXTqdoTHfbl/+rlaYJ6vsYtSelfGUygOMhx4Xoq1qgOQf4pSG45
         aGvIlA7uxIrOKxgq+aD1v7UQWQaeC9fwEWYXtghA3/gpfyM40BzvIwqCzeEplKqcctjs
         ETe+1/IWsiGXnwmGPnEzifsYBQ3SW7vK38zWauVodKk2RNsb21zz81MBSTaHTLalI/wC
         oJ4OHPpV+WouDOvQqEQSVDHu+axbEVI9mB4wnFHj77f+DqNpsfK8sTxMeMusCXOmOCcz
         iJvQ==
X-Gm-Message-State: APuU4Z9yELyUM5UbNbHfkGELPar/g323Me9mmIUaja0C5nAMl65tHybW
	HWyhhR89JiD/JnIoD1kv+D+8y0in/IPJjs/cFWw1ct/TFO7r6kwH15c7V0w4B8Oo
X-Gm-Gg: AZFdTZfscaX59DGDB9mgcF+/Dk/WsIDir8PlEG7sIhWtZmzuPGqXfXpPcXxMXd1X0TO
	lVvbXwngSaxNiM4kVftkmEtTJB4NRrcOMq76ZtQPbwPIRf9T3l5JsyViM/H+jePTb6eU4Wp6oo+
	LGFceyqf6xx1ST3msYVztGFLPRhRHFdXlRV2eOCy9I5izw5mhx2rF0mdqRxPa17Q4qH50jmBZs+
	P0QZruEKBGlyoLIel2l7f4PwK2fcwkLGmXW4M6SWhSefR7Td4zcBL/WJw8z0Ye2cqz1LlXQFl6P
	0lpwcOYfHRHTbckbXsEuwgHwARH7pnhBMC9GHoMMmq4CsOiAP9L76uH95EktXwHX88yBzp4HqAA
	fDPmCaMx4mpkA6pvAcgvySV5b5XmUxlYmWDChy/XUDmeI/OZfISVbCBXqMI76HKZJmDSBac0L9E
	f7uJMNMry006T87DQocXZxhLV997oD02IKUJzZ+Boiy2Q0q3p1okyNcYFP76HsMUr2/uDvcMH0x
	JT5sItYZSg7KPzX1tLcpaMOdqJPPViBgnUxqNZGNnKpPU3ZZy2xXhzz2bzoJw==
X-Received: by 2002:a05:701b:2508:b0:1b2:3497:5998 with SMTP id a92af1059eb24-1b5568f03abmr14513404c88.36.1795553524271;
        Tue, 24 Nov 2026 12:52:04 -0800 (PST)
Received: from [172.17.0.2] ([20.169.61.204])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b56ef9fd16sm25710264c88.4.2026.11.24.12.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 12:52:03 -0800 (PST)
Message-ID: <6b05f8f3.a99d0424.24609b.9945@mx.google.com>
Date: Tue, 24 Nov 2026 12:52:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5538455408611877904=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: [BlueZ,v3,1/4] shared/bap: Remove broadcast sink PACs in bt_bap_remove_pac()
In-Reply-To: <20261124150922.341655-1-simon.mikuda@streamunlimited.com>
References: <20261124150922.341655-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5538455408611877904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1220993/

---Test result---

Test Summary:
CheckPatch                    PASS      1.27 seconds
GitLint                       PASS      0.92 seconds
BuildEll                      PASS      17.24 seconds
BluezMake                     PASS      238.56 seconds
MakeCheck                     PASS      13.51 seconds
MakeDistcheck                 PASS      119.38 seconds
CheckValgrind                 PASS      293.93 seconds
CheckSmatch                   WARNING   241.76 seconds
bluezmakeextell               PASS      76.27 seconds
TestFunctional                PASS      949.07 seconds
IncrementalBuild              PASS      267.67 seconds
ScanBuild                     PASS      891.63 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2909

---
Regards,
Linux Bluetooth


--===============5538455408611877904==--
