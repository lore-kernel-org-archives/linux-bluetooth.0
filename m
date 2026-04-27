Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73183A3E6D
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 21:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777323676; cv=none; b=GnOvw4JbpM6aY7Yjq7s9IIfpq1Vh3obKmh8C0oq+93RByzGfHn8yoi8coNHTAaQXS47uvzX62jXVLWTNPip54DMzCIVg/eWNvuGXy5ysm1JmlQdWR1BGGz4XWxFmy7gOXLZ/XcRsR5P3M4T82gE+3F8qWg+L1wR8mNVSB2lJCHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777323676; c=relaxed/simple;
	bh=owWZ51jMYUeX4BYTKX544crEduol0d2NBETM8vIMf6w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=b0IPskxIMWhAo010BXM0k8EHG/EbW13M2q14sRVt5z/N3smoecy/uJQGil4Dcihzb6BiJvJhSkLjLxMU2qZAAxtSCncq9kggrE5qRmzkjqPkiNNLEDgbzt8g629H+H63L2Hv/H5eIFLFNTKwPSKIi+FISwsrf9AU775xzMPZH3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=saxn3kaQ; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="saxn3kaQ"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-12c565dd3a7so1294330c88.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Apr 2026 14:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777323675; x=1777928475; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XEuxqFef1FP5zhHzHb5fRCH7boC247r5pOsLsCq6a+s=;
        b=saxn3kaQ4sFlYIvHZY2SXmERCOrO9T+KVxZYO80xgQAJC2XLO0aBLlTpcuo2y32L5Z
         PBCSCPQFCj5mkjbSFnKWzYeRJ2M1oqQ8LsuU3P0/Cvt5LtG9ogDU3JIY08tK2BJQlnAm
         odYlu5jgbclkpUWTkFIy/DudlzgaPSJlx6FLN+3Mw39PHDzS2KpVJxhDLSt7pXXKBGlw
         6KxAdhUrYq7ULG8Hac0cDXUIrU4s2LbFjEaZ2IZERZnIQZRNkQaBsVwyMEwDo3RgyVhM
         SFzXjD1+IRJAlI0bk6lbUKQDCJDIWW82KkS2su7BguV+Q3bvJ2R+vu4G6iuhMh9Hny+L
         2Yag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777323675; x=1777928475;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEuxqFef1FP5zhHzHb5fRCH7boC247r5pOsLsCq6a+s=;
        b=nBy1s+qRDIY+mggaOcpdhWPxvtL+0nky31JiGBm5odU+iyGVraqlblUggmlBSQMuUn
         iZAR1isgTVEtjPINVFzHdcoTN97IfY+vpic8MZ+zC7mR9ANFE/ZBKA1QS5Z3DXeYx4Xq
         i+DgGUTCt6k7s/u5yezCTfyDPj6ZrOWh+Rp/4DQcOttycIKSEIJYtLSruOlONmv5lh0x
         54OI6OR905Bo9eFmTOC1F0KRVNLqMwseG8xR1AOST9EvvZsej548tyW0s8fqZnT7mvmU
         3r7D5gFwmPbiUwfJK7ibYJJi7iRBmU06W2NIr5qPmhYJqvGBpmccH7I6hddXVYf8SEGZ
         X7NQ==
X-Gm-Message-State: AOJu0Yw+FVlTbzxX3mroZsdNqbOVrCIdsPKCw0EfiMIEa/EbIo/OTgKo
	8A0GCR9atCwecC4AuvWe4m1bNbA7bdIA751nNF7VTGB3Q+bHWT/xCjjrXsaBqQ==
X-Gm-Gg: AeBDievm0yHIoVVSwddHWLkIToa/gTqKh4nBxq5ui8zlyDMapY1XZFJvxyRBig73GI/
	8GJa8nXG3RTrMXqqUQ4qpS66hEw3jmSIJpWcj3ZqS4QWlFmd+3K9r+DljuONnImsFcLaCAfOskE
	HnYcW+sQbMXwCdxkE+D7dZ/zY7HMQELPccGrQPBQl7xWwjiK0kLhkUJQkiFhGMAtyS47B8XBIcx
	FvBOlaFAXbXHVDGT3qXQidI7qYyCGeoupSCtPWCIST8hhBB/duALeAFXm4tb7mI8iU1BaetAb/F
	+bOUafhegoR0XXEsVbZqHVVtrHxOg8sG4O41qJOC7jD94a5VlLB7BM6efpXP+gb7vaw4B10plVz
	Eb4phEFFVEu5LKnjjiOkSJfVTr2UvZikRSa2XnZzmYbBandLwYkCWjLZM6UrZ8gjX03zHzbZ0vm
	rpsWVvb2gre2GWswFBfrSAFj0SiAETN41iZ2DJu4o7
X-Received: by 2002:a05:7022:4584:b0:128:cf86:d1e8 with SMTP id a92af1059eb24-12ddd99f547mr275753c88.29.1777323674423;
        Mon, 27 Apr 2026 14:01:14 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.75.144])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ddd9a64desm733779c88.9.2026.04.27.14.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 14:01:13 -0700 (PDT)
Message-ID: <69efce99.050a0220.85c94.1d61@mx.google.com>
Date: Mon, 27 Apr 2026 14:01:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2195733491307199960=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, prathibha.madugonde@oss.qualcomm.com
Subject: RE: Add RAS Packet format and Notification support
In-Reply-To: <20260427170007.1282289-2-prathm@qti.qualcomm.com>
References: <20260427170007.1282289-2-prathm@qti.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2195733491307199960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1086284

---Test result---

Test Summary:
CheckPatch                    PASS      1.60 seconds
GitLint                       FAIL      0.45 seconds
BuildEll                      PASS      17.63 seconds
BluezMake                     PASS      609.86 seconds
MakeCheck                     PASS      0.84 seconds
MakeDistcheck                 PASS      220.24 seconds
CheckValgrind                 PASS      203.58 seconds
CheckSmatch                   PASS      308.93 seconds
bluezmakeextell               PASS      168.18 seconds
IncrementalBuild              PASS      642.41 seconds
ScanBuild                     PASS      929.86 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v4,1/3] src/shared: Add RAS packet formatting and notification support for CS reflector

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (94>80): "[BlueZ,v4,1/3] src/shared: Add RAS packet formatting and notification support for CS reflector"


https://github.com/bluez/bluez/pull/2076

---
Regards,
Linux Bluetooth


--===============2195733491307199960==--
