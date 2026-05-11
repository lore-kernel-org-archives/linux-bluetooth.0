Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7284657CA
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 18:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778525086; cv=none; b=fII7uO0nIYC1QMVcrvKjLEb71hR3/ZgQLr2g6eONdm7eaYwCuzxW7i8zfSUPDBhLUmvK8nXdMB5g2YGRO/tI7HSTmwcxpaxg8DgHKgyqaO3lfrXcvhbJnl3DqSyzY+GKVeXlUfpqZQ2mcjgOY/ZxA579p//wQhnySDShUQQfeIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778525086; c=relaxed/simple;
	bh=4M7d45gKXVz73+mBCKUt0/fBRQweRKw0zE+EguxI4Vg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=azBJBAqy/Rb9snnnY3ww3OkdJ0GWc+XFsz6XHh78bXAKmtKWOtUfTyYS2yBK+9P+7H18GJv7JcE6gIbDK9u8KQ9w4rwPHaoTyCG/wHjgw9cNhpOaNsyPZSBMfDl3TFy3Srt9tfQmBiQ8LWgcGU/Oisb/qiRU+kxk63mwBbCRMJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s+wriYkU; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+wriYkU"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cb40149037so437788385a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 11:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778525082; x=1779129882; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7haYIKVjK71PsxEQe+9tK7TRlvzFafCiJ0y0dXsIktg=;
        b=s+wriYkUDT3IMOn+rpMS1/DD+RVLlgisM+DfK9UqGvYxTr1jz8ldRiq61vD69U/5bY
         htdTEaZYwaelSki9LSou5/9dJ9NUtQcTSKMkUZFYif30JYuo+k4xuky1j1AAf3499Dh9
         v2Muarq8ZVDdM0AxfoXaD+z5KQYBUd/hftvsKfjctXjMhMSRClfRopVivjRPm/kiSTnD
         Kxyc0hcdLnhm+Eqt3f3IB5Nczko0PBWtyuMnqLxQmI9yo8VhZnmkMyam7Uot7cHdBijq
         RdxwbjUIEBZiGIuPM9zQg6+HyIbhozdEcasyDRgDjLn4EVTlbIi1yZb8IG14k6FtIxZz
         AQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778525082; x=1779129882;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7haYIKVjK71PsxEQe+9tK7TRlvzFafCiJ0y0dXsIktg=;
        b=IQzI+fRfOZzpvBx1upoWIOjAUiK/YiVhvM2HY5TeSldKUWyXgFC1bx+zwfy4hKF5R3
         0aqYYmlvTSvkeigaXI0Okx3i1LVap2lQNo4V87CA9DzibxH1Er8cjO1KCtwzVDG2kjxm
         KH8M+2iMKhW1lknqLqefJn1LUXsRKZAI0M99ZIV2SvUyWEQWXKBcY1ALTmDEp/xkvgQ5
         /7Hv7FQ6Oaht218HKkvbjV9jbXh9H9IPYG3CBe9x7p5ZstNHpJ+yOroJvUuINMphUPdk
         5RWdJF0xuVcHmwU5rge9PAeDBl+itIDbe3OcSkk8r9LqdMVickZcey7k/kNjZg6HmW9X
         UYjg==
X-Gm-Message-State: AOJu0YykYrQIiCtlbPj5ZnpsmQSq7zNeYH4fPhenzsckYuunI/A5/AKy
	I9UdDYNoTbWOvsd9y0hJ8kRnEv7Q7zQI+hZE6VBkY7eNhPjv8VRGbbkeZ+AaME19
X-Gm-Gg: Acq92OECTsi2Vyfeomqvpttey7tbSQNnIP4zusPX5CfE8McftWjDA9TXFuwq8HeVvbE
	RY6QJ1kAXY7XCppkrP/Ed3rifkDon8PhlmJ15/xGkVFLhTkxBMLJBcrmcuiAEdGD1TAv2XHjFMz
	ynUIEmGux925MAStoPShMexImHH1njAnaodEt7PG4ZVrp2yBpRrSsotuLzG2R8tOZ2ieg8sN/s8
	sSgH9ZUS3lVoFfhqltodalJrJmbGJvBfBmWBnR2XzyVq+QfNDOxuOmM2sIuiRRx/oTV+mYqUh8V
	2q9Kjv/A7EAX1gbEtD/yLKRmRRF1Sy9bFbeslNY4Iv99rws43RmPP/9ipWS9i38UuZG0rIRuWgN
	iPL+qjWnQ24pss3PwGnr9iXMy4bFp94UHT6rx2eD5+13F5BGqKCBXj6cPCUB2sZ9Mb0dVr+Wbtl
	QW1YeEO3pdlUngoDXG9+AvtWwEPF4=
X-Received: by 2002:a05:620a:1989:b0:8cd:92c5:b3e7 with SMTP id af79cd13be357-907b9674e91mr2210750885a.18.1778525081688;
        Mon, 11 May 2026 11:44:41 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.34.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b87c02fbsm1203884185a.25.2026.05.11.11.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:44:41 -0700 (PDT)
Message-ID: <6a022399.050a0220.345f44.b072@mx.google.com>
Date: Mon, 11 May 2026 11:44:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8065445842628593828=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, rollkingzzc@gmail.com
Subject: RE: [v3] Bluetooth: 6lowpan: Fix peer and channel lifetime during teardown
In-Reply-To: <20260511172310.3723421-1-rollkingzzc@gmail.com>
References: <20260511172310.3723421-1-rollkingzzc@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8065445842628593828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1092992

---Test result---

Test Summary:
CheckPatch                    PASS      0.82 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.14 seconds
CheckAllWarning               PASS      28.48 seconds
CheckSparse                   PASS      27.47 seconds
BuildKernel32                 PASS      25.15 seconds
TestRunnerSetup               PASS      559.53 seconds
TestRunner_6lowpan-tester     PASS      50.85 seconds
IncrementalBuild              PASS      24.94 seconds



https://github.com/bluez/bluetooth-next/pull/173

---
Regards,
Linux Bluetooth


--===============8065445842628593828==--
