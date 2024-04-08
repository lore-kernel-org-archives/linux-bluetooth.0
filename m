Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3AC1411C9
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Apr 2024 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712592193; cv=none; b=BwrAF9GNw35VdCiqIXF80jEfE+wBAykRYtfsKEmi4qJqVqjm2ntKlu6pvcyIX6GTtQ9bRQLi1RpOSkTYl5Cftob4yB26Vc9bdmdOQFB9uBiuaEdh+FuZT4xOBwZVNLjUHlkH4HaF0nGtTExZlEhGqbGG4LTvJd/QT8xHJCLtiw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712592193; c=relaxed/simple;
	bh=HcW9lOIf3souV2Q5dVCM90kKKA7t1f6IyIqWkBQI/Z8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Bwl9SrpD3Ixbu5CwVPNqjlI8bMtVp/A3As66A6axq6yO4KwyBQgwTlUbgLEpyhTLYNbZFOKh1ny8L25EeSJMfjGepgycq4sDSC6V28ko55ZQDzYd9+oo5+YPpj65P3GhkKYc8V5XSRL4M/4tBEwrR+wxW17uHIjyFhCewqj4PrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbunekgW; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbunekgW"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-789d76ad270so288146885a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Apr 2024 09:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712592191; x=1713196991; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gvjsU4oWyvMYuE59leCXCsAhJ9Cu7vqriapxhIHbkkw=;
        b=JbunekgWFLS+xcyhb7OhUWIXoJGOg8bie8cXQ5p1d2soDHqxFML8MwcLBN15I7INaP
         nQNGZPOLUh5Yj8qwa1pwW4YVeuYYXSpqLWdUum8rw4JNInfVwFkvebugIrPIHMG7g8Y4
         kjzmaBM3p3aEJM625IMT/892lbDLymTJJlZw3pdYiATOUOcTAKQ1D9iYJW6rl93kexlL
         U3V5tPBgJxNOeFvmAUMUmglrsguile1iDOFbg96ivCWxFObyv8Q/8p20lGheFeMYw2do
         l2ZMWJK0gHBp5LQ1eP6rEvwa24875m0CU8HKV6UiMVFsc40X6peJoE7YuAqWlC1kCZTl
         Oa4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712592191; x=1713196991;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gvjsU4oWyvMYuE59leCXCsAhJ9Cu7vqriapxhIHbkkw=;
        b=WvpdZP9vv33CVH+2VF7tg2P7HkwCl02B3IuMX4wEHE8uyQttu/+Fq2oyP+9nsNwi8m
         NlttNewNAUoKnVW9b1N1+d06t+m+u0hjPFGT8TfKHJ8vs2tCAlCk0igqBbXRpM+pBBqK
         VDDXBe7X7hj795b5J8bJ478Tsa0alsYJbJ+6e/G+aO6f0X+JO8ooqJG9LzYwmDAK1q6X
         vhBRovMEbdUd0RSFHTUKAXAmvzxBfqKNnVfhzXVxr8wqRmGEnJA5PUAw4qY4N29OSy9X
         7KM7+AIRKx4f3IAweU9cJhqjkiZsgXZF5Phpi+whVQqxQqPE8FTdmCfEXI5iAEnJZR9n
         23aw==
X-Gm-Message-State: AOJu0Yxa0m1YDrSoQ/5uxs2Uj2ZJg+pl38HWpHIbABY8/dhufRwbZq9G
	2JdlvOPaO/xs2nwhL3PejcUCLuDrsshI57+ulCHWIWDgypkOZ9EUX+v1Uh3RaPg=
X-Google-Smtp-Source: AGHT+IGIqgUry6LQMPCz6U/l3LME2lY7BBItFIfrugunGpIOACQjPN26eLcQkbrs/bm+kBpK4tenyg==
X-Received: by 2002:a05:620a:4304:b0:78c:4dbb:678f with SMTP id u4-20020a05620a430400b0078c4dbb678fmr10721148qko.77.1712592190818;
        Mon, 08 Apr 2024 09:03:10 -0700 (PDT)
Received: from [172.17.0.2] ([172.203.152.170])
        by smtp.gmail.com with ESMTPSA id h16-20020a37de10000000b0078d340f3801sm3323003qkj.87.2024.04.08.09.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 09:03:10 -0700 (PDT)
Message-ID: <6614153e.370a0220.6586f.1d8f@mx.google.com>
Date: Mon, 08 Apr 2024 09:03:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8474156973181028093=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: bap: Replace global bcast_pa_requests with a queue for each adapter
In-Reply-To: <20240408142724.12511-2-vlad.pruteanu@nxp.com>
References: <20240408142724.12511-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8474156973181028093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=842492

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      24.95 seconds
BluezMake                     PASS      1693.79 seconds
MakeCheck                     PASS      13.53 seconds
MakeDistcheck                 PASS      176.18 seconds
CheckValgrind                 PASS      245.13 seconds
CheckSmatch                   PASS      352.83 seconds
bluezmakeextell               PASS      118.30 seconds
IncrementalBuild              PASS      1544.18 seconds
ScanBuild                     PASS      993.72 seconds



---
Regards,
Linux Bluetooth


--===============8474156973181028093==--
