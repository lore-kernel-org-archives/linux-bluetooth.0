Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2E0370D77
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Mar 2026 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772556579; cv=none; b=HjxOClsA3KB96cR8quKAJDZqWlmfyr+E7YrvHHSWkw57nyuC7VgYO923P3aoShfZw8FtVqSV2n8Pllgy/kRcoHmh0Qekz8eCPoplOWwMAiZg27A4ByfgwJPKcwodYw+9Y7EWY6RbLYYjHiEiVKBQ2Jcfdrhtbw2IrmsuPC2iqro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772556579; c=relaxed/simple;
	bh=ph2TdA8KlQK6NZdR47Ul1gUjTG/Tq9VnIxpy3ODFXIQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fiX6Ke3ft+vEYBhThG4n0+Q5hgbj3d6bAIa9SyfujH1CpuwlThREG7N/vhl6QhMYSwE5psB3WIa+BObQmFQnR7yjCdXlEzvDNVk5AHkCkpn8I9QXYqcdIeLgpaFslp66pKMxMtmoGnulrciZtEkivtJ+bUuOh0asrLfJ4PGq7AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from msexch01.omp.ru (10.188.4.12) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 3 Mar
 2026 19:34:20 +0300
Received: from msexch01.omp.ru ([fe80::485b:1c4a:fb7f:c753]) by
 msexch01.omp.ru ([fe80::485b:1c4a:fb7f:c753%5]) with mapi id 15.02.1258.012;
 Tue, 3 Mar 2026 19:34:20 +0300
From: Kirill Samburskiy <k.samburskiy@omp.ru>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Audio/Video protocol tests
Thread-Topic: Audio/Video protocol tests
Thread-Index: AQHcqyWNl3DhnOuG20uLaIZVyD5Saw==
Date: Tue, 3 Mar 2026 16:34:20 +0000
Message-ID: <b658b4276fc54ce2858b33d1c4215d83@omp.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: msexch01.omp.ru, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 3/3/2026 3:14:00 PM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: InTheLimit
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

I would like to ask about the purpose of these unit tests:
 - unit/test-avctp.c
 - unit/test-avdtp.c
 - unit/test-avrcp.c

I noticed that android support was removed from bluez starting from commit
f0512114aacfaf82fcd06e086884c0478c4ae124. At the same time, the aforementio=
ned
tests were kept, and even some of the sources from android directory were
re-added to ensure these tests could still run.

However, it doesn't seem to me these tests are relevant anymore. It looks
like these tests were initially meant to test sources from android director=
y.
This is suggested by both source files listed in Makefile.am and by list
of #include statements in test sources themselves. None of these lists
include files that implement anything related to A/V protocols *that are
actually used by bluez*.

Please correct me if I am missing something. Otherwise, does that mean that
these tests should be removed along with the android sources they depend on=
?

Best regards,
Kirill
