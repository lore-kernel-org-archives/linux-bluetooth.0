Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DA84F648C
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 19:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791575558; cv=none; b=R/4Sbwj9eqHbXFZWcViw2NyfAAETGJONm4W6pZVh5xUzzbcsTVdoRJghUWMGPzZ188LYclwQSvEEvmZRPcMPZMjXzl6Cj36jjGO4Cg7sv++Xc2mJb1CIZ9+7Iessp9UpM4hC4a0CeKoAax3tU+Yk8Zcsbnwy7e0zDTs9i7a/WHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791575558; c=relaxed/simple;
	bh=e4VMpQX5DLuIgM76Kj8kvFq7leW3vs4PcqrnCqAF15E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZubyJySYTGsZ1yHAWpakY0EwVPJq4w9NywBJNJCwSoPnlretKkUsBYHeMZ2nOl8dZUC4MC5QhwuqWIR8rA7SVXaCj47Kc2+7BfchUy2snk33e9xtRnduPOFQBJfNRAzAezl9aPFjAI4PwgHrMA06id9Z+LbAed3+p1hYdJQLv7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4wi5NZk; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4wi5NZk"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso155959eec.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 12:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791575551; x=1792180351; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=epZhhGFyQ4bk7GenY0war3RKzYRWEHtHcSE4CCmJO8E=;
        b=a4wi5NZkqVp0hhePxWavAq7/Svmd184Zc/Mj6JX0I3AvroRuUpb/9wCcTvDf3bbcb3
         er1CCn5rQuSndFeR0paHC6djSIs+hBA+2NyuW7SRQnUtpGDQz478LlO8lWlopTtZTohk
         HCZtsJxAzC4tOfryP1z0NFVDWomYdQEsK36GM14dcRwTMZ4vUjr0sRiE3qSD7G9/caV+
         4LfzOXcrSU2FKi6QE86kCZiVR6nHeq98lCQjLjwLJ2RnOZf5n5cTkt+cAosKO55xBtzE
         gpcyS6XrlzoG+ZK2dWb6vHoGBopcGWX6UbbPSwpXBezNkMkbQ52VkbDpjrq5pOGi7Hzk
         btdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791575551; x=1792180351;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=epZhhGFyQ4bk7GenY0war3RKzYRWEHtHcSE4CCmJO8E=;
        b=iz5/U8zPLG0aCO/U++ZCl+csdZWcIDnqDY8oIqa1CzA3W+CBgGUGDCrduCDwtma1mD
         gQBjhPxAHLg/MpDi9ZomZDHOFlysQdYp6k3nFEmj+yYr0qvT96Hr7bNqoupdLg/Rn+Q7
         V6W1doHJF7ZSUsfNxUofQ72C3Wf4TY3HZP5fyZQhkdQy8MtpD3KW+3pP3vAoB4welJpS
         8xE20l6GOG2/N5za+yVUKjxem9DrFI2AzwneQr1dkvQgU1oxdKFCM0N7li9TQDYx71sz
         u3IskJS8y4ubG43+tHu8cbDDfTTsCzmkThZzVspWI+NfWvNEWH6605xG+uHo7pG71byH
         eKKQ==
X-Gm-Message-State: AFuF++lF2bCOlj/VyfOw9kdyGfL263v7n3+O6SIzn2bL1ivUu1NX4gjx
	WaKWB6fTdS7fh3abdRB243zzjyE8iqMD0R108X6GkBA5NjJWgcV3AbKl6cju6g==
X-Gm-Gg: AYBFou12tIRJTyd8GBmaGb4vUxKBGnc4CA5IpglF9VTf8ZwniY/L7sT1BJWTwFYApTJ
	KTIHyo80ojZSax0dLrdmGJ5Nu4RQ6sTYOCkVDlgB2XhwnFeuAKXaDegtio0n2OAfHWF5M7TErX7
	2KkEavRC722NpyZvfMJAf4PY5oFCHnOXFZJF3/WDh2yjdwpWfg2mRMTtYMwzCU75/6+WVN2Pjbv
	sv5xX2D0Wk52oZQlHJq9y3x67M8rqHVMv+Gi5m08U3iVR00mwcax9cT3Ht893xshoyn1F0qOwFT
	rHNRAs1fR+paXmo6VtG2g9/6MR6kylFo183RZmgbMNnHXQ9iiE8Ga4f+n9+kMMotCQb4ZAFUciO
	wng5Ss1XWXNWZbUsA8P93Hr7uUsxYJo8OlhwwtYaJwEORmobY0m6RB52CED2XjiG5pb+RL+c0qa
	DWucjHsAM4+vE5A6y17Yr/tOSj1nIYo8lf8wTninmXDTjCqsFx/FNu3C8FPwwFENNrL1kAxtEiq
	h5YFZfztcGyS5KBw+A=
X-Received: by 2002:a05:693c:87c7:20b0:351:516f:7576 with SMTP id 5a478bee46e88-3537e01e8a0mr4016939eec.10.1791575550728;
        Fri, 09 Oct 2026 12:52:30 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.210.246])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca79536sm8244389eec.16.2026.10.09.12.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 12:52:30 -0700 (PDT)
Message-ID: <6ac945fe.be2e0958.2f6bbc.5b5b@mx.google.com>
Date: Fri, 09 Oct 2026 12:52:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1482986591777902072=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Add HID over GATT functional tests
In-Reply-To: <20260924154631.369299-2-luiz.dentz@gmail.com>
References: <20260924154631.369299-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1482986591777902072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       Add HID over GATT functional tests
   Pull Request: https://github.com/bluez/bluez/pull/2580
   Created:      2026-09-24 18:32:17+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============1482986591777902072==--
