Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C7F2E92AD
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751036393; cv=none; b=ZF6zCDKMEn3kfMTuSpKqmS8e5aLYW3jhSq5Is1JPZvn78sgTWZDQPZzxi3zMAjv3K+++TRUgg4lXXsgr93dXR0iPpqerNZcXzEWyM7OQ9AEUKFJ/dHJXWaXGhf9vkvdJ0jHPkuM+DmA1EN6YV8HGRdakE3AT4we4D145oJdZVu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751036393; c=relaxed/simple;
	bh=hvVXV8cOnAam8RBWyKLvzP9DmIwPtQ/ppBFnTTsHWHU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JXisaZfE3cFHnUTnfpGJTIHOnusTa7aSvYNmZup4jSmVHJ2NhpajN+yNeBKrSD88Y5/vrKfuUFN80HKGzkuRZUBtOsDRlGRAr10l/jWloBk8d2kNAepq88SkjkTQOzpMWLvHIis+REVKun29bj3EpvnZsZe6dR4mbycxGrOEFGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dRpVu0Lu; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dRpVu0Lu"
Received: from github.com (hubbernetes-node-2dd38b4.ac4-iad.github.net [10.52.148.41])
	by smtp.github.com (Postfix) with ESMTPA id C0ABD7007A3
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 07:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751036390;
	bh=7kSSc2zQaeSr8HAiDkLM7Kj3iYpBwGd3qIYMfvupCDE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dRpVu0LucZm1KNfsm0yugDecgOUG4oCPJPcO1UwQj1btQUU97bVv73J9eSkvm407p
	 5GBpNuREOqpDoA55UNt7pN0NCnUnIz2ze3RJolume9KsH/OvJ9WwZbmp7p+s5dEM5/
	 4P9iI7GlPIWRyFsK5kfPkep/Mr395MyW7NpfD7z4=
Date: Fri, 27 Jun 2025 07:59:50 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/976686/000000-15a4e9@github.com>
Subject: [bluez/bluez] 8d5d2e: doc: Add new telephony related profiles
 interfaces
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/976686
  Home:   https://github.com/bluez/bluez
  Commit: 8d5d2ea9668840b46ee4e6b1b66e2519cf8e5d9a
      https://github.com/bluez/bluez/commit/8d5d2ea9668840b46ee4e6b1b66e2=
519cf8e5d9a
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.Call.rst
    A doc/org.bluez.TelephonyAg.rst

  Log Message:
  -----------
  doc: Add new telephony related profiles interfaces

These are interfaces are meant to be generic to the telephony related
"headset" profiles like HSP HS, HFP HF, and CCP.


  Commit: e0266dd91bb7a5570b0342c1fb6aaed6771ee4fe
      https://github.com/bluez/bluez/commit/e0266dd91bb7a5570b0342c1fb6aa=
ed6771ee4fe
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    A profiles/audio/telephony.c
    A profiles/audio/telephony.h

  Log Message:
  -----------
  audio/telephony: Add shared interfaces implementation


  Commit: 8f1559c7721c9d197dd4c95135c92cc8d9fda6d0
      https://github.com/bluez/bluez/commit/8f1559c7721c9d197dd4c95135c92=
cc8d9fda6d0
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M Makefile.plugins
    M configure.ac
    A profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/telephony: Add skeleton for HFP profile


  Commit: 8fe346c6770b1ffc719aa0c80ad6608c53f2fd74
      https://github.com/bluez/bluez/commit/8fe346c6770b1ffc719aa0c80ad66=
08c53f2fd74
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add HFP SLC connection and event support


  Commit: c6257a2b4b7e039aed629e7054709ed1c07cc8f5
      https://github.com/bluez/bluez/commit/c6257a2b4b7e039aed629e7054709=
ed1c07cc8f5
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add dial support


  Commit: fe0396196a13f95657f721fb7df8591101d1df22
      https://github.com/bluez/bluez/commit/fe0396196a13f95657f721fb7df85=
91101d1df22
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add hangup all calls support


  Commit: f8897395ebdc632dc563c4b7c61ca90238a4b058
      https://github.com/bluez/bluez/commit/f8897395ebdc632dc563c4b7c61ca=
90238a4b058
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add answer a specific call support


  Commit: a1477f34538b5654c829bb3a75f512626e7b6cb8
      https://github.com/bluez/bluez/commit/a1477f34538b5654c829bb3a75f51=
2626e7b6cb8
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M Makefile.tools
    A client/bluetoothctl-telephony.rst
    M client/main.c
    A client/telephony.c
    A client/telephony.h

  Log Message:
  -----------
  client/telephony: Add new submenu


  Commit: ada916d72159848b75d58212651fccb50e7ac443
      https://github.com/bluez/bluez/commit/ada916d72159848b75d58212651fc=
cb50e7ac443
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Remove call interface during profile disconnection


  Commit: 3c2d347a8511ba7106bf5460658896c64f43cb42
      https://github.com/bluez/bluez/commit/3c2d347a8511ba7106bf546065889=
6c64f43cb42
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Create existing call during SLC phase


  Commit: de88d6e01dd93903b3fede19297740cdecd92d12
      https://github.com/bluez/bluez/commit/de88d6e01dd93903b3fede1929774=
0cdecd92d12
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M profiles/audio/telephony.c
    M profiles/audio/telephony.h

  Log Message:
  -----------
  audio/telephony: Add hangup_active and hangup_held functions


  Commit: 5a3f65f98a157cae5f9be453f240099cf4cec397
      https://github.com/bluez/bluez/commit/5a3f65f98a157cae5f9be453f2400=
99cf4cec397
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add hangup_active and hangup_held support


  Commit: bc94b61c152899d79399dfc016ba5d47223aed9f
      https://github.com/bluez/bluez/commit/bc94b61c152899d79399dfc016ba5=
d47223aed9f
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M client/telephony.c

  Log Message:
  -----------
  client/telephony: Add hangup_active and hangup_held support


  Commit: 97bc41aba305b676896d190326295e6f9f160c70
      https://github.com/bluez/bluez/commit/97bc41aba305b676896d190326295=
e6f9f160c70
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add SendTones support


  Commit: 0fd51e35cfd5800869b51c3daddc42431e57fe39
      https://github.com/bluez/bluez/commit/0fd51e35cfd5800869b51c3daddc4=
2431e57fe39
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis.oss@gmail.com>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M client/telephony.c

  Log Message:
  -----------
  client/telephony: Add SendTones support


  Commit: f15377a039409e8f6bfe50a3a887149b6eb0ed27
      https://github.com/bluez/bluez/commit/f15377a039409e8f6bfe50a3a8871=
49b6eb0ed27
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M doc/org.bluez.Call.rst
    M doc/org.bluez.TelephonyAg.rst

  Log Message:
  -----------
  doc: Make telephony docs more generic

Remove HFP specific parts or explicitly point it.


  Commit: 8dbb360de530e0b0db299095ed13e986a0d67320
      https://github.com/bluez/bluez/commit/8dbb360de530e0b0db299095ed13e=
986a0d67320
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M client/telephony.c

  Log Message:
  -----------
  client/telephony: Remove IncomingLine

This property has been removed from the documentation.


  Commit: ef48dd690776d1398456d0bbd1c10e90176bf7ac
      https://github.com/bluez/bluez/commit/ef48dd690776d1398456d0bbd1c10=
e90176bf7ac
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M profiles/audio/telephony.c
    M profiles/audio/telephony.h

  Log Message:
  -----------
  audio/telephony: Remove IncomingLine

This property has been removed from the documentation.


  Commit: 9d706dd645ea935aa51254d29704f4b7743e3110
      https://github.com/bluez/bluez/commit/9d706dd645ea935aa51254d29704f=
4b7743e3110
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add HFP HF server and SDP record


  Commit: 21b57f18a6239fb8ba17391ac650477d4d6ccbab
      https://github.com/bluez/bluez/commit/21b57f18a6239fb8ba17391ac6504=
77d4d6ccbab
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add operator name support

This adds the AT+COPS command.


  Commit: 3f6fd4d7cd550297b546839f44ca26624e70b678
      https://github.com/bluez/bluez/commit/3f6fd4d7cd550297b546839f44ca2=
6624e70b678
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M profiles/audio/telephony.c
    M profiles/audio/telephony.h

  Log Message:
  -----------
  audio/telephony: Add call line identication property support


  Commit: 7baeefce86e1deb2e95ab094d69d47bfceec5477
      https://github.com/bluez/bluez/commit/7baeefce86e1deb2e95ab094d69d4=
7bfceec5477
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add call line idenfication support


  Commit: 77222588fdb356ea3fd2c4a407cb35b862809323
      https://github.com/bluez/bluez/commit/77222588fdb356ea3fd2c4a407cb3=
5b862809323
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Disable NREC during connection setup


  Commit: e47f0dd200509bdaeca8962810646b70d7cc0c36
      https://github.com/bluez/bluez/commit/e47f0dd200509bdaeca8962810646=
b70d7cc0c36
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Enable waiting call if supported by remote AG


  Commit: 5eb250b9ce7279d63fbbc24bc3416f439a48c7ec
      https://github.com/bluez/bluez/commit/5eb250b9ce7279d63fbbc24bc3416=
f439a48c7ec
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Enable extended error if supported by remote AG


  Commit: 2ef1979b629c465edbc334fc8a2246aad496d4f2
      https://github.com/bluez/bluez/commit/2ef1979b629c465edbc334fc8a224=
6aad496d4f2
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M profiles/audio/telephony.c
    M profiles/audio/telephony.h

  Log Message:
  -----------
  audio/telephony: Add call multiparty property support


  Commit: 15a4e9b961364d5b2e9e282b1078a03573ac84d6
      https://github.com/bluez/bluez/commit/15a4e9b961364d5b2e9e282b1078a=
03573ac84d6
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-06-27 (Fri, 27 Jun 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Enable enhanced call status if supported by remote AG

On reception of OK result from AT+CLCC command, and based on the calls
listed by +CLCC results, this updates, removes or creates calls.


Compare: https://github.com/bluez/bluez/compare/8d5d2ea96688%5E...15a4e9b=
96136

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
