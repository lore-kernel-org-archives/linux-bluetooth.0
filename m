Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FBA36A01A
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351752; cv=none; b=qSyiujeFVNqsgQxaIRbmdt+RsGNv9jYSmbl/bfNj2DR3U17y73hAnrHRofYSB7iQe1GbH3uqG8rsWo9q+EjzIVrKY9BnFFY+WUwxSsEMz8dg6ygBrEvNCJvLYr29TIaoC6IwOLB6QJT/EQkB95rDBsREpXRLOrI7GeC14F+WhWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351752; c=relaxed/simple;
	bh=L5Ew98csW45N4oWF/eAZOUeRCw0pTihg7QlJjex2ybU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=M2el4lfYspzEiF7u2q5kJV0VNPIBp5rKO0JYhXmNPJNGZoHcFeTqHfGhoxlwRt57aSbzZAPtOfZl+im6+WMllK7MC3zpXCDAA8q1ZORuwW6iHTYpFgQSh+GUmf9HuWSyuRYnuz5OD2sDVfhqdMXuyuRYH10TlDqsTWFZQA2xhBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6P7nLFc; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6P7nLFc"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530d8a00bcdso8253921cf.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 08:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790351750; x=1790956550; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=h15qIO7VDGh3ggyYmX+ZFY0Ueq6e75SEd7rP34Se05M=;
        b=Z6P7nLFcBiD4CAbmZomL32QWTznoA2VOI502GV4JZcJkGjsNhDcGbKEAvq3Z397d/U
         RwdmSPX5hxSlvySSfbnlLT2ZCnPx8AgI8GUIbv4TfgapSqXNa4qfZX2CIncLTTUhN6RV
         RMQVGnIePCxVCpeyG9kuypVgaReeoGjXpdie8AhH6Qq1r+uCTPrH1VN1Se6wZsNmx0Fh
         nJkVgwblBp3OmlPMw8EjArWVOdb+SlhrBzLzqgU5WZgIt+e4Y6UiPZQu8YCC6qZWqwam
         z3VZtm1LU9DLSXGuvzLTYv3wvfe8VWdQ5j5KVx0UwDBapwKw2j4KVOPrBXHbKgmlYgO6
         fXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790351750; x=1790956550;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h15qIO7VDGh3ggyYmX+ZFY0Ueq6e75SEd7rP34Se05M=;
        b=EzLa2JpkXoFsvRzcI4eAhxomzPibqhcXsIjFAIlcag8G5SUJ68B7FAfRMo3ItNUL3B
         ZZlBwGKPwc0ALLXVck5NqsAB3a28d372U8Z0nZf3x9GZbNwvZgfCfGMbUg7EVE3XIDDt
         XCx8iPVhm+t8vXYfs+5E4DvR+PE4GCmsl1Vddhqki8z1jmsPpcAtIyzrLIqzgBPg5P9Y
         /kiOwFWWOyaHlUD7e7ZcPvqWtkHPw3d8Cg3HgUMU9gD1D48lUAAXigurLzoDe3o8zdUs
         cr7xLXCb2QFaH9z5eedMFr20CmBZNfscWWQy1uhJy+HxNv4voC+GM7gOLdkWKvXic5lj
         8+qQ==
X-Gm-Message-State: AFuF++n6bTCNNd4UG6mWZ+hhF1OFJFce5kFunN70TkO9GxyNu6UklaIF
	/Am5o1cK9pksivVFL4wMNO/k2KJIcefCS+bPThUra4noFNrTUOR9LzAWH21vFU3M
X-Gm-Gg: AYBFou1NOxZuRLXhFx6cgGz+UHLi+vMsEZQTQhm1howLVIaaBT1GygJkGuvcngrn1JL
	1A8quQV8RiEyqI6jfKRiBfPu2Dgpsmb+ucD300rAyV4dsL31xjDJKgnpAzO7slICIF39qWYCY49
	jIyRndh2ZiEyfpfmKpo1I7eEInA8g7r/efjtBDKpS4OSEJFCrzsNORVo34rE1c12Hw89Ori1Jyi
	MY038Xfxv8qIvTNo2cPvU0pKi9f1XI1tLAtVKmmncp9nEBUjx9OYrSpkXHzk3OFBhAX6ZdUPW+E
	W5JA9BOAWEcSSv4s2do64RVYcbPhLsFb5qvx+VpcIQvaj5LExbARCHp7JSPCCNyfXOde6b1lRWa
	etCgokYTAvvOMrZbN0J4YFHlfD46xsJfi29+QwQtBDqm0kx9ZAYK/4iEfqd/+4K9Y1yVC8Ig/wO
	AT9MA5FpaIx7Up4jmgYX465VGXPG2EkVrv1gIeqqrt7GFAz7xn4i/tlFwuaVNFpJo3wj5WvCDhW
	qwxYIKQQVSBxb54
X-Received: by 2002:a05:622a:5145:b0:531:23cd:8638 with SMTP id d75a77b69052e-5330b6ee491mr42966961cf.56.1790351749822;
        Fri, 25 Sep 2026 08:55:49 -0700 (PDT)
Received: from [172.17.0.2] ([48.217.227.83])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5330bb99592sm17948601cf.4.2026.09.25.08.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:55:48 -0700 (PDT)
Message-ID: <6ab69984.3c73b1f2.1b3f28.237e@mx.google.com>
Date: Fri, 25 Sep 2026 08:55:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0664673835555224224=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,1/2] doc/qualification: Add VCP PICS file
In-Reply-To: <20260925124343.3344864-1-frederic.danis@collabora.com>
References: <20260925124343.3344864-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0664673835555224224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1173745/

---Test result---

Test Summary:
CheckPatch                    PASS      1.18 seconds
GitLint                       PASS      0.74 seconds
BuildEll                      PASS      19.67 seconds
BluezMake                     PASS      394.27 seconds
MakeCheck                     PASS      14.51 seconds
MakeDistcheck                 PASS      140.45 seconds
CheckValgrind                 PASS      233.42 seconds
CheckSmatch                   PASS      293.27 seconds
bluezmakeextell               PASS      94.69 seconds
TestFunctional                PASS      1138.32 seconds
IncrementalBuild              PASS      395.15 seconds
ScanBuild                     PASS      1139.31 seconds



https://github.com/bluez/bluez/pull/2585

---
Regards,
Linux Bluetooth


--===============0664673835555224224==--
