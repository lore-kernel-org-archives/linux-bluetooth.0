Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C993C13B
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Mar 2025 18:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740938731; cv=none; b=jIQapcJodkJKznm+GaFC1HIye9PGA+w/DTsTgOgC2fM8rKUi8gn9e5XUb9ypJt8/ptbHKBC9h07Efo7AcpgoRb11isazejtVIh8mlywfQMZ0Mdaz49QRSJY76P+IkO3LKWXZq1HHlenRaU/UK1pqE1ejQE28id17oBX5Kf1DoqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740938731; c=relaxed/simple;
	bh=ca/uE1aC3a5MruYv78M9xPRI+Jkx7uQOT+fNx6JClpE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KOxwW26XzuZdhKf9EpsM9UyUOjv3GtgcjM9mdl/1JTho3DIF4ivwU1xp6B765wmnTZHc1yOHSXv6hnAARKAOIi3z8yGGx4TfbyCSnn7zNf35pygHO9+l85vg3ewdSlK9IYaYRtoELzQax7zRe0DQOxFcZ9EG3ojJKPgTb2hXvvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i87rt4x5; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i87rt4x5"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c3b3e11f28so70176285a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Mar 2025 10:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740938729; x=1741543529; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BzbNlZw70PhskVzN7XHFXvX5JW8hCwlDU4Rx07VayjA=;
        b=i87rt4x5lFNwBDuQAkJeaoMGWwGxyFzivLt4eI8zH0qBDKVnGkkdUtcTMO8GWmbFtQ
         6YRs7pCv59GafiwTS8TP11IQYt5GF+8JiRBqX36RrA3ud4TxUp5ejn4PaQByz7CkHPbh
         B1jDvq8AltmCy4kvW8p6RrfQ23kQa0BvtB1Ynkp21kokSMxdnD4AArbxam8CK3JQvn07
         mqhOYeHdb8BA3gEdGKhjdqkECh8dACjfwRLp9zi0wYohnXkt5S5ZdW82RRVThqHTWiCP
         rcnWhP72RO+Cy95L/+p5bMRnS0XhXuaqcwIIaMh9zVSlsE0KEt8xmctGeEi9eyosnwCp
         dlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740938729; x=1741543529;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzbNlZw70PhskVzN7XHFXvX5JW8hCwlDU4Rx07VayjA=;
        b=rC9Yn0c2/WGZdUiXRmgmSj1HZQvg6B5y57c1JpWmK8VQVl+tji0psOrDYoUJCAuRnt
         uB8nRl7CL0SrDYS6Ne8pCsHsQomAtqIMMD98n9KDGUiXWL0vFet7KMGBXg1K/FqKKJ95
         BIds3MCp5e4C7tKzmtfSU4wP8dC6V+Gt+PYcuv3AGzXl/w2xhPqoaogvzst7jqBfSaLL
         Q/yeWAoo0d/JdcX9lo1lkP6GHjMjh54kpsnQGROHrvEzEzUPCk0+roBtwRIbQGvRH4gH
         QQtWXyoqs5vriJ0CRHpmAMCas9K209EPeku2BxxCuQZynbTaILGGFnJuIDhaUv8s3Hn2
         +EuQ==
X-Gm-Message-State: AOJu0YyCcOSsEI6QtNrz/PyYLLO6VfsoNIYCoO8e4biWj75+hYaeXzCH
	FSyrYW7DXpMrwIn94Q+ajn61Z8/D1OXmh1GBrMpCvG9qGV23ohNnIp5RtQ==
X-Gm-Gg: ASbGnctZCyI7cyqAUUgQlRN6lUGIVd/rCdzvOC6TgtqWf4sLKJIaxB0GrMZtrvwY197
	IdC5QxK+NQM48Q+/c83JxhpD5bNGOlilnfBwnaxEUYl6OhbrezOVNBpKKbVv9CaPxZVH3lZnKw4
	sH9LVhr+uOuhp0G76bwkRQHDrr+lmu8e4vXs7MAOCVBerStOexpEbALj+BUvQPla5NLJcH7xOMw
	X40gmry62XBOYEhnleGYfKcs/IYNDqvqJd63Mg942aPGR6XFQxdGQ65mQK2INY3Hf+n0xg1CMHQ
	Nnw67iOuuoJ+E8cdSrZC0rzCc6MgTKQ12Zm57Lajfcval0KD2ZA=
X-Google-Smtp-Source: AGHT+IHdQpm/Ljww9dCLjy+ky7k+OU6exhmWvOoqEoMcUnUEe7dToscNAZ+MmurpBqYIrtncJQU51g==
X-Received: by 2002:a05:620a:c44:b0:7c0:b2ab:2693 with SMTP id af79cd13be357-7c39c677674mr1625896785a.49.1740938728765;
        Sun, 02 Mar 2025 10:05:28 -0800 (PST)
Received: from [172.17.0.2] ([20.102.199.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c378da070dsm506258385a.72.2025.03.02.10.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 10:05:28 -0800 (PST)
Message-ID: <67c49de8.050a0220.362326.269f@mx.google.com>
Date: Sun, 02 Mar 2025 10:05:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2408503015073257447=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: [BlueZ] client: Support single profile connection/disconnection
In-Reply-To: <20250302164736.22101-1-arkadiusz.bokowy@gmail.com>
References: <20250302164736.22101-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2408503015073257447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=939378

---Test result---

Test Summary:
CheckPatch                    PENDING   0.20 seconds
GitLint                       PENDING   0.22 seconds
BuildEll                      PASS      20.33 seconds
BluezMake                     PASS      1436.96 seconds
MakeCheck                     PASS      12.76 seconds
MakeDistcheck                 PASS      158.28 seconds
CheckValgrind                 PASS      213.64 seconds
CheckSmatch                   PASS      282.65 seconds
bluezmakeextell               PASS      97.53 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      858.16 seconds

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


--===============2408503015073257447==--
