Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8F9200110
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Sep 2025 16:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757002700; cv=none; b=pyacH78Q6QhG87dDCEUYDQ/aUPKSfBkYkMQLdaa3NB3kWvRLCEt+DudgqL6CYStujBhHMJ22xhTKFYkCJ2Cmy+q2fAIic5aOExlS7PukQbMPzzokhQvTekIrZhks0BGi0bg2NNeu4r76aTPZy5lx28ur0AZPjsWTXIM5lYMfsqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757002700; c=relaxed/simple;
	bh=qXckGOD87+A1gcfuJVrpZDEg/qG4/3Ts5zgxcFMQnRE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JsYXCiDvr0Cx6NzuJO5P2mDDh7hTFEHLSrcOwJVgu+LnJhaUQNe9E5FonoBY/A+2WPwFwUaxamoLyZZJoG2h29SkZtc7LjUDEiUez46bh/sKQvCZjjTtPl1fBWzYHtPF6PwHC2jtQv4jDdKdrFi1SG3PQxq08AbfTadLSLgL1mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NgmCWoEv; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NgmCWoEv"
Received: from github.com (hubbernetes-node-9174752.ash1-iad.github.net [10.56.184.39])
	by smtp.github.com (Postfix) with ESMTPA id CA49A9212B0
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Sep 2025 09:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1757002697;
	bh=B7YZzXtvWRXKGrTu8Pl4RuX29Vhfe35Ywrp/AjDLByY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NgmCWoEv1LfmyINIAfCuLOMynO2ESeM5LJymOrghbERsrW8E/X9QXZY6TlZr0rPgd
	 W8XTN4paIrNyQjUFYw1wJcBqL31ALnGj5Q4gT85GaW4GK9jy3jgAlrKyR6jWknhzqT
	 CdPSoucbKK8cwOcX73bU5TNQa0BxXFuEbrtENAD8=
Date: Thu, 04 Sep 2025 09:18:17 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/5d4efe-f9a98f@github.com>
Subject: [bluez/bluez] c779eb: unit/test-hfp: Re-order TS tests in
 alphabetical o...
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: c779eb8183a7717cb43267c167e038b6c8b23853
      https://github.com/bluez/bluez/commit/c779eb8183a7717cb43267c167e03=
8b6c8b23853
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-09-04 (Thu, 04 Sep 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Re-order TS tests in alphabetical order

This will simplify when looking for a test.


  Commit: bef16e9c4d8d1b41b221628ae6ac29b34ed5e190
      https://github.com/bluez/bluez/commit/bef16e9c4d8d1b41b221628ae6ac2=
9b34ed5e190
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-09-04 (Thu, 04 Sep 2025)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h

  Log Message:
  -----------
  shared/hfp: Fix typos


  Commit: f9a98ff26e505abdf55845a5d80a57a5defd6299
      https://github.com/bluez/bluez/commit/f9a98ff26e505abdf55845a5d80a5=
7a5defd6299
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-09-04 (Thu, 04 Sep 2025)

  Changed paths:
    M unit/test-hfp.c

  Log Message:
  -----------
  unit/test-hfp: Play PDUs up to the last one for HF tests

This will allows to create PDU set for TS tests which may end with
events not triggering actions, e.g. when receiving +CIEV:<callsetup>,0
where call status has already been updated by +CIEV:<call>,1

Free context->data only after completing hfp_*_unref calls.


Compare: https://github.com/bluez/bluez/compare/5d4efe960fd9...f9a98ff26e=
50

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
