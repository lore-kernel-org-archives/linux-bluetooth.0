Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeEJ6QNs"
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967EDD54
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Dec 2023 05:16:43 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-77f04969d2eso31110585a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Dec 2023 05:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701955002; x=1702559802; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+a3KgfGoENczqns+5sY8RrJWh9nELvK33BhQ6aSCBbI=;
        b=aeEJ6QNs9qYSaXNWjWrs1giW9JFSQ29I/2QqnhDkJLZIP7b/gT7Bf+tO+i/fLS6N7x
         ZqS39tY+Icr27nY/YeGpRG4x4wTheCmi4aAT0nn2YLOvCQVZFYeWsa5C/4SEj/2U3nML
         8FZNeB+0Zb8Dg+W8d2VOp5Exj0rO71cxopBv5HS9xoQh+7rDRf+Py2cKj71YnhEwmN0w
         N7EMYrZ6D5kVnWUCu2odPMOAarO/g8aQIH85Oue/Dd7cwNf4MR/TPabDd1gJ5btWbqVL
         uPKQ8uF2WgAymLGobM0LOSyvpdhuUgfEPq5TdSFz78ohDX+GLsxq7oxL07oPyeYVEGUO
         p8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701955002; x=1702559802;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+a3KgfGoENczqns+5sY8RrJWh9nELvK33BhQ6aSCBbI=;
        b=UpgnNF5sn2sWy1SPXbXyfT5Lk2osYIvehqSHTu/mnbytLcWx3RhPHMPBq3itwEmeAh
         jdBxWWwjCd1cE2WrYvf+u/4+i3CgU2ywHWv/YVpPNQnmE2HEAHkPtS79sZLpkMLhEKDP
         CF0SEtOB0o4Vs9plYJQl8+tJa4Hwy/DD2kKdArkoYT4J35S/35ZDtEKtZ1xpkvD/7NjI
         q8u1aKw6afWEqsQVQWAqgtRzfVFqAzQjQi4p1yf2rJa4qhmKPHC+QpH9TLtl4Qo9fo4M
         sHzBdZJR/LVUb82Y5JyEAyaKtRv30q2pk/fuceECJ+YdHdeOjTInjlYeCQefGf7i/pPz
         44tg==
X-Gm-Message-State: AOJu0YyuLlkwVxkKqsI+wgZTqQX9KWz2QU1I0AZ6TvBJOSUmByUG/lJA
	n7ObkB0L0DLQ8I2/od0E5BDj8RazGko=
X-Google-Smtp-Source: AGHT+IEmoC3VfxqFAEFF1ug3gg0tMmFa+jvEeIfIrxX2q7PwrEd6K2KsBdXppM0kh8EAZpNMkuClMA==
X-Received: by 2002:a05:620a:1477:b0:77d:cab8:d56 with SMTP id j23-20020a05620a147700b0077dcab80d56mr1160942qkl.3.1701955002568;
        Thu, 07 Dec 2023 05:16:42 -0800 (PST)
Received: from [172.17.0.2] ([20.109.37.6])
        by smtp.gmail.com with ESMTPSA id m4-20020ae9e004000000b0077efdfbd730sm389825qkk.34.2023.12.07.05.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 05:16:42 -0800 (PST)
Message-ID: <6571c5ba.e90a0220.0908.16cf@mx.google.com>
Date: Thu, 07 Dec 2023 05:16:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8697556003744447728=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, stu@metanate.com
Subject: RE: [BlueZ,v1] client: make ad_clear_data() clear the correct structure
In-Reply-To: <66D06D2D-01A5-4ED2-BF1D-EDABC9F42146@metanate.com>
References: <66D06D2D-01A5-4ED2-BF1D-EDABC9F42146@metanate.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8697556003744447728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: client/advertising.c:757
error: client/advertising.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============8697556003744447728==--
