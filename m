Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E066421880
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 12:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780574470; cv=none; b=qbjmwmBdQXnv7J188cz16UlD/uWXEL1GZ+T9fATLqph3uk1sB0zxEZs4h/zRiziaEyG0wP7nI9pBrOtFpSp3/KmTHRQKf+h/Zosovau4R636aOqSqNlfU/UlyfXTmmJzI7qP+9hlzTdZ9Zh6SAttKTXknBZ/yKh/IE7OIyvIu/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780574470; c=relaxed/simple;
	bh=j/eC2/dbt9CIbIFm6eKWXQjCQfmLs7jNa7hl77obWPE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=saL71JhmQNubgfSkDj0Bq4gCMpQxp8d4uZhT/fDRDtz+2pYEjTtChKltoi8TQJ15iopGfgGtFl7iCOPP7IFpcKR2mrskBZVoKbeqmJ6lTFQlWdDHLK+1tEaPTq9G67cSFr8Pnznu/lRdW3/9qAVewzsL3pAdUdJkZy/Ef7OnSrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TV63uncd; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TV63uncd"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-137f0aa125bso1567759c88.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2026 05:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780574467; x=1781179267; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pXFshA2Osq1IzW9oZsHvbOiRf9jNUQTesRfUplN/v48=;
        b=TV63uncdCOkmLyO2iSaJoFQjbLtEjf1fkQgvzGM5/Ah7uqVwrtqwnKhYblfAUjkwNU
         eyHV8SojcQmaPFke6ssDZH41eGdwRKioskyqgeDpvCvJJF/kP5fszuCpusIgnhxK5tYr
         39TWJJMTkCJdVFjra3vscvcm0neWrL6EIa8GalZTA2h+GF6BUREXMVQ0Y/p+Fwt3lmE8
         PLNG7cgYOhKbCggdAHFcjhEWDd80Y+NYZ5cVx6jFeE8QZKOo6NERKlwmbBKFhqPlq+ih
         Et6sCF8TL22PSyRZjh17gD+BBr+m/qZkFzTpAtQcDyD6tbMm9k4OYW6u99DdUV2OhjYe
         IbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780574467; x=1781179267;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXFshA2Osq1IzW9oZsHvbOiRf9jNUQTesRfUplN/v48=;
        b=e1r6NaPsL08SBzxiQOOZPAQWD8kwQGJmSid4UfZ3ylDpND8oFS64NJRkvPMFohe8ji
         +QfAC/XJsowla8W30HehVtrHQzRK+KkDnWat60kqxrB6E+G59qcZulnFw5PXD690mDVs
         M3rTe/iW8LC9hjpuwu38GICEr9KnDMNj8LzsbGOpAygGCpstq2uEftXwrpeya4bILIk0
         lrAn9t2rRlH5Dx57T6ulEl2BHrLjy6BykkcxSwKIguvu5V7j0H+U0nhD5Slaa/1rR3Y3
         EYSaY7bktDDSx+i6I8AcvIoqhN8HUDYbaoiON1rz1TMGrFnj8EvsIYybxZaWq0NRvi8W
         xZEA==
X-Gm-Message-State: AOJu0Yz74njFieeKh9KTiQICA41/BpSIREou+QWeGtbM+YzklHopmKSj
	is1/IgznbdHC3TdULazXoKAM+RsK6nglmsczp6EwcbIXS8lsP3GCPWbMjNW4N3zH
X-Gm-Gg: Acq92OFJIxTbNuMjjiASjuI8nMbxoT6aXJera1RHtuO38EE3Hamb6MWDNQA75zjkyCn
	oH/AqIvOP17n1TxdudeomUQW73kl15nGN0GPdnWZrG3v2YJO91zbNCkfM1hquXkDtOBXe8qkaCE
	hQjtK6Xx9I+FZnnLm+VbWQYf59/XndGvR5jejMorMDy2ojkrThpKbnNPycQlUB4Z+zWXM5wkUjM
	IEnIlLXXKkWEVkapi+c9bFghsUQyTWXocTfFPVkrcjcDOT/fxPLkqN3SbZrjkvUF6cEqLbxznu5
	iINma9YXyNB4v/VOBSCuZlPDbuk+HW8UhHs8vKxM6UZT3BqbqPtOIguKnDr98U85NiQ66ib6eTM
	ci9R4c6JdOr+qUf5mv16VBFqlVWAp3iBst7SauiR7rWiulTRdwJ6sTHItd4kXwcHti+w8v4Hdxl
	DFYjOUq4in060+WCus9BC+ddbC7o6Px8I+EXFPF8uKISQ=
X-Received: by 2002:a05:620a:4493:b0:912:5d2a:4baf with SMTP id af79cd13be357-9158a84f2ccmr1157793485a.61.1780574457088;
        Thu, 04 Jun 2026 05:00:57 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.220.247])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a243041sm584782085a.18.2026.06.04.05.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 05:00:56 -0700 (PDT)
Message-ID: <6a2168f8.a4791f72.24ac8d.29ee@mx.google.com>
Date: Thu, 04 Jun 2026 05:00:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7394655043792635570=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, prathibha.madugonde@oss.qualcomm.com
Subject: RE: [BlueZ,v2] profiles/ranging: Read measured_freq_offset field-16 bit as per Core Spec
In-Reply-To: <20260604100233.4193077-1-prathm@qti.qualcomm.com>
References: <20260604100233.4193077-1-prathm@qti.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7394655043792635570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1105853

---Test result---

Test Summary:
CheckPatch                    PASS      0.39 seconds
GitLint                       FAIL      0.28 seconds
BuildEll                      PASS      15.92 seconds
BluezMake                     PASS      493.79 seconds
CheckSmatch                   PASS      252.60 seconds
bluezmakeextell               PASS      128.51 seconds
IncrementalBuild              PASS      486.66 seconds
ScanBuild                     PASS      713.49 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2] profiles/ranging: Read measured_freq_offset field-16 bit as per Core Spec

1: T1 Title exceeds max length (84>80): "[BlueZ,v2] profiles/ranging: Read measured_freq_offset field-16 bit as per Core Spec"


https://github.com/bluez/bluez/pull/2178

---
Regards,
Linux Bluetooth


--===============7394655043792635570==--
