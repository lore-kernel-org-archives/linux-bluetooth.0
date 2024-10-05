Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FF716F908
	for <linux-bluetooth@vger.kernel.org>; Sat,  5 Oct 2024 23:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728169211; cv=none; b=ci1+/KbKTTAQZ5PELjyUU7pIxi+m/dk8NivR/X5xv13DjPAJbu9RL5rI6Cy3bBMP2DeWdcZbkFWrOzjt9D92ulYZYpze/QCVyIdTK20nDVLgo8Cv9MnzmAfqtH6SuMcXIaTZ3+qbYu+aCZpIiHB9tl+THttuoQVUnhkB9dsyKfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728169211; c=relaxed/simple;
	bh=TbIynJxZv10BqVhkMKP4hx6JDf4bNlq+xeyqG4DwjiE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=o6oa37ywPzfIh4N3iu3DJh/boOcoWlRQZXnNuNTlUtVZ4MoEph9OQ2iVKSQ+HtrZHeh5tYQRCBoYpJFTyjKMbiPdNGqqnSsKi+39SVpJH9ZOCFLOU/Yxle7TbbdrcPm2nfGAFPUQ13/0io5yWZW90FMpWzaKRL/P/qQJZAjw2aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZETcMf/v; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZETcMf/v"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a9a7bea3cfso196147585a.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 05 Oct 2024 16:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728169205; x=1728774005; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BJaEPEOyuyxL6SOADp37+RIBFORQNZvx11isJJMqmRA=;
        b=ZETcMf/v0EJ9/mdDNTHZ1+UTkqLvqdv4mGuBBnd3/aNtHiViR1T7Rs6mwLMjXEE5aE
         oZHRsmVWD5ecH7HN9fp0nHwJuV5xkHNPpj0nng9ZJjXoCWXSvdVXsGmQpZYw34KBlSUQ
         vAwLkG1tMU32LOgC2QmMBJvvZrxWX1F0MJCzJgfF3T3QJzSLvTjiGuAnpIM9vK/CTp9U
         A5eFACQQAsuoiyQirzU+nKnfEvj5dOVvR1SmThboag/WiB8MdI/QnLc2zhhy04x/eJBl
         ygOTuV/kRQCQl+zD7fr/wvb5/dudOZaJf4RQ8yebIl+vNWGDL1Dj4iiAsuTfmxWzJMqB
         y7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728169205; x=1728774005;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BJaEPEOyuyxL6SOADp37+RIBFORQNZvx11isJJMqmRA=;
        b=HwA/FvlPJHMvQa4sz5+sfCuvJWssdgYmzyt8HlHxipxvjFgZZAKl65jdhCCuceCcMr
         mSnGJOFwW4vfxCCLiOyJdGLHbkogeHC9zfCs+VVIPQzNykUijsSdFWtPOW5m7adMsJqG
         paZ+Jd8ZY+bQPriD6kCotKG1HM8bQwY8F8w+j8P6yXjUNI50MjU20HpGMCv7bwwoogO+
         me6TNifofzK2Ry/B94YS+Emnr9UXdnwam/02odtXkxVfNyiJvqAJSqQnuoI1SGQo3fVN
         9J6jpmKZQFxlNgEknDuZW9NTfb7I+bWAs8rlOMovWkfyTVN+H46XECfuDa4PriOlN/Z6
         xUBQ==
X-Gm-Message-State: AOJu0YzZoG2tTcNoAX/ABuFz8XGg9z3Gu17TjZcgCEfb3dTahblyz+sH
	zgTz9dqZvOTkcimpfv9Wg2bf53LmHuCK+sBbETwy/+5WuLytLY9aVsbmcQ==
X-Google-Smtp-Source: AGHT+IFZE3EsYfqT7VeehPrXafvPrDjRgTW4tz5PJI4Zxg0EjeixBItps98Yme/ePw7ILB7Y0j4mwQ==
X-Received: by 2002:a05:620a:1911:b0:7a9:b021:ee6 with SMTP id af79cd13be357-7ae6f421a8dmr1075768385a.11.1728169205322;
        Sat, 05 Oct 2024 16:00:05 -0700 (PDT)
Received: from [172.17.0.2] ([20.51.206.231])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45dae2be1d6sm6120331cf.56.2024.10.05.16.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 16:00:04 -0700 (PDT)
Message-ID: <6701c4f4.c80a0220.27527f.1652@mx.google.com>
Date: Sat, 05 Oct 2024 16:00:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6444383404581711996=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: [BlueZ] avdtp: Fix state check before sending delay report
In-Reply-To: <20241005211510.409471-1-arkadiusz.bokowy@gmail.com>
References: <20241005211510.409471-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6444383404581711996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=895894

---Test result---

Test Summary:
CheckPatch                    PASS      0.45 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      23.99 seconds
BluezMake                     PASS      1517.49 seconds
MakeCheck                     PASS      13.42 seconds
MakeDistcheck                 PASS      175.51 seconds
CheckValgrind                 PASS      247.86 seconds
CheckSmatch                   PASS      349.28 seconds
bluezmakeextell               PASS      117.39 seconds
IncrementalBuild              PASS      1389.91 seconds
ScanBuild                     PASS      1007.73 seconds



---
Regards,
Linux Bluetooth


--===============6444383404581711996==--
