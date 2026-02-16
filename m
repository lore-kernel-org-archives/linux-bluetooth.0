Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DCA17993
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 20:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771273711; cv=none; b=Ds36d4Z9szNrxX3yQS/SptFUNdqknhI6MP0WmRSBpYFLDXMUcoyAf1sSZqY6cT+MWp5m8J4W/FShHh3U3in4ez4wIXO88DMKrJhIo9FRQDaV6PnU9E58pvOrdXJyL/7NZWLYRIYx1mi1VhVMu20EOw2Dk5C3lKVVAndCy4F5jUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771273711; c=relaxed/simple;
	bh=ukK0Z8qvNH6WGMlHYyOTJ54yi46x4LdTcuvJc+KC/Lo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=jbeQo7E+Ybhask+SxKoCTyory7iUTcbM+F4+ShK9MBBi1kSDT0eCxKOHdZM1aXxXsJ53SnRVC8AwcOny2DmnOsNJA62/Y/EVIB+A4eoDxPYFRT/JAWYx1UMvp7TnWDcdFzsND+0ocgmzs4pvlaWw1gGrm9vxELS0jVImxrgqLSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZK0EfVvZ; arc=none smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZK0EfVvZ"
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-506a019a7f3so41103851cf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 12:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771273709; x=1771878509; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3dhF0tngP40TyJI7AHV9WCgDN4AFTTylWHHOEMo+BhU=;
        b=ZK0EfVvZGguLRrMZid4nd4I8OZOIXXFqgNvBllLaXA7K1HoKdUje9fl13CK8IhYNe+
         An88yhnUSsTfrHBq81J/ZJ3AAwnXLd4ESMLiH/WydpfuNngvD6sONxzhZWcdVMORve7F
         2nlkDUt512CYY71VtRob6FFn/HLQhMEqC3fqaiTAnpkNIvr/cw7++TU2dDbhOLmOvO8F
         YBmg2iWBqEzg6EqTxuloXzlJMizte2GvnnG+w7c5T3xKY7jfEjnuX0juyzpwaaiaKRi+
         HUgwphClhSTAvk+Xi6/MaUN/FE5tn2/H7oI2UW4OWKZ5+T/KO46qoeMWRjVlZZUVFQxZ
         u1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771273709; x=1771878509;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dhF0tngP40TyJI7AHV9WCgDN4AFTTylWHHOEMo+BhU=;
        b=aveaYw9heuiWegnm2e7lmAX3PI9S3cpenVRFp+ZxrYtK6Loi27shQK2pudt45Yel6C
         VbyJ8db1O2CXYtqaaQSMtXRPy8zPZtdqulconAMHIktQOlRBZSuj2+5NB0Q/pad4SyLQ
         C61ytW0hnlWBAXC2Ss1oA9Qb9KP5/GCkiFt1DFvI3mo385wsBGRr4NDqraDC/2vuz07p
         nC3TFDoa8PguwhhWVJetPEPjjO6Ypxoxfmd6dAPlTmHqXYrRij70DK+nH+EvWBfxd7MK
         W3yML4IjvB3ia9fXWAA/fVY3exbDvR6TASK8Bnpw0e13BjHNbXSoRomNXDOO5+wxFYR9
         YD8w==
X-Gm-Message-State: AOJu0YzEtA2E7mKTcVOEwURIssOv3IXlaH/rYf7iUOGrUiwXjSYoNq1N
	vfe3vNQqJRaJx/rUmxkZ0kFIoRSG78bWf298Iv/s1jUd1s+nMAzxlsgzpsyv+Aqd
X-Gm-Gg: AZuq6aL4wCRcKz58r+j61xlAV6ifJ9fz8x1Hc4v+oNbTxLnn6Y2O/KDy248Vh+Zw7GO
	ZByZnTr+MVk4w40siWpuvK03XCjwUqrG5wXLMNAXQGG7OzawJUfpUesaRhoG05LXprk+6kdApZH
	Cv93qCtE4dBY9FUwXbjvTVNDASE3cK5qhpiPWNviibgDVEELNJN6dPW2HyQgsoUASHi8VjwOaJp
	2pocr8Favnv/3lSbYqN23cYyKb028B6rWsgqKafhDc9zS6VJp+EiJGMGuKC300a7hk/26ywKuo+
	vGZuc3mHphi+frFw9tIt+w5eJaTzEv72/HMmyVhCi32464P1txrtLoM+nX1uEvQuyemfW02O/+T
	Ao/01LD4R6gV8tSLfTTQHwWZdpLHfYVqO4BjtFsKAb0y61TLZlJlUM5GyuBmnV1R0CDGek3uBrJ
	RZEtNevtffwojhvhbBq/8HBkTW2o03sg==
X-Received: by 2002:a05:622a:cb:b0:503:333f:9a25 with SMTP id d75a77b69052e-506b3f83104mr134937481cf.2.1771273709283;
        Mon, 16 Feb 2026 12:28:29 -0800 (PST)
Received: from [172.17.0.2] ([64.236.141.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50684bb9251sm138933951cf.30.2026.02.16.12.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 12:28:28 -0800 (PST)
Message-ID: <69937dec.c80a0220.2f35d5.0bb2@mx.google.com>
Date: Mon, 16 Feb 2026 12:28:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5192691353010722428=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v2,1/3] tools/btpclient: Move btpclient to client/btpclient directory
In-Reply-To: <20260216193136.292051-1-frederic.danis@collabora.com>
References: <20260216193136.292051-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5192691353010722428==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1054670

---Test result---

Test Summary:
CheckPatch                    PENDING   0.29 seconds
GitLint                       PENDING   0.39 seconds
BuildEll                      PASS      21.62 seconds
BluezMake                     PASS      654.76 seconds
MakeCheck                     PASS      19.41 seconds
MakeDistcheck                 PASS      254.37 seconds
CheckValgrind                 PASS      305.35 seconds
CheckSmatch                   PASS      371.69 seconds
bluezmakeextell               PASS      188.69 seconds
IncrementalBuild              PENDING   0.37 seconds
ScanBuild                     PASS      1065.88 seconds

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


--===============5192691353010722428==--
