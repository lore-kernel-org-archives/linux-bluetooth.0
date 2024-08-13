Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78691A0715
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Aug 2024 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723565359; cv=none; b=myhwYAYG0k/gdBX2S8LT9Umm1FV+w8O/mFi8L04Xq1Dv68LU6BnPVEzT8AsF2hAznCvDrDrYqPDo7UvgfwsBUVMWG5reJhc1vQtXAHWZDL9Ztn936KskCXoOU+VUwdg8uNghj6XHu3Sgyho+6RESxuTL0dwGN7NhjWxRPWYN368=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723565359; c=relaxed/simple;
	bh=cwFxsAHe9jlDsQoejiIpjnz6mgrsNcCTSC6OZghLNKM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hpceKKvpPHNhhlIJfvWlfUvpjo+GZt9JNWNMcn4n6i0t2HpS9HsZH2A2zdGrkvb/S7gEL0zy2KRWs66pjqcf8mEuhO0G0uBRFhWR2Yn+RFmyI/83RQ5D1xRt05E8TUzlkQY+ib9Q0BuNuos/W8K99InmWeT/BW2wdX1y3tITgnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=c3+kzQMS; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="c3+kzQMS"
Received: from github.com (hubbernetes-node-0531bd6.ash1-iad.github.net [10.56.147.29])
	by smtp.github.com (Postfix) with ESMTPA id CCBA36C0545
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Aug 2024 09:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1723565356;
	bh=n/07vxWcsICRzW9N10qOzGbumf+PUeS8K4SyeDto4Q8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=c3+kzQMSr1l1daXtNy/FLiPdQ5WwlMS0huJKQvwW/XHZvmTNVDSR7EsaVF0gXHeWA
	 WRQhZlqkAf+9DvtwjtI7AIPRF73KW5ILHfrKpwlnZMKBIq4vPy/0F+hp7Dqe4uItx2
	 xE5uoo5kDKJ6Jf4M6huOFCLhhBwndeiyJGbUnXaQ=
Date: Tue, 13 Aug 2024 09:09:16 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/40621e-537e39@github.com>
Subject: [bluez/bluez] 523680: org.bluez.GattCharacteristic: Add missing link
 opt...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 5236809407c9f041e102de6fba7a40b8b2c318e5
      https://github.com/bluez/bluez/commit/5236809407c9f041e102de6fba7a40b8b2c318e5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-08-13 (Tue, 13 Aug 2024)

  Changed paths:
    M doc/org.bluez.GattCharacteristic.rst

  Log Message:
  -----------
  org.bluez.GattCharacteristic: Add missing link option to ReadValue

Just like GattDescriptor.ReadValue characteristics also support link
option which indicates in what bearer the operation is taken place.


  Commit: ee39d01fb9ee3d0953641a6681fed212ddb8fb0a
      https://github.com/bluez/bluez/commit/ee39d01fb9ee3d0953641a6681fed212ddb8fb0a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-08-13 (Tue, 13 Aug 2024)

  Changed paths:
    M src/shared/uhid.c
    M unit/test-uhid.c

  Log Message:
  -----------
  shared/uhid: Fix registering UHID_START multiple times

UHID_START callback shall only be registered once otherwise there is a
risk of processing input queue multiple times.


  Commit: a13638e6ae38f4f5c035bc5fd2532f73f10888b6
      https://github.com/bluez/bluez/commit/a13638e6ae38f4f5c035bc5fd2532f73f10888b6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-08-13 (Tue, 13 Aug 2024)

  Changed paths:
    M src/shared/uhid.c

  Log Message:
  -----------
  shared/uhid: Fix not cleanup input queue on destroy

The input queue shall be cleanup on bt_uhid_destroy since that shall not
be carried to the next session even if the input node is not destroyed.


  Commit: b752f760da474c53d66cc4b137db0838aee3c953
      https://github.com/bluez/bluez/commit/b752f760da474c53d66cc4b137db0838aee3c953
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-08-13 (Tue, 13 Aug 2024)

  Changed paths:
    M tools/rctest.c

  Log Message:
  -----------
  tools/rctest: add NULL checks to main()

It is necessary to prevent dereferencing of a NULL pointer.

Found with the SVACE static analysis tool.


  Commit: 19ff9ab9151205501025a8bd061da022bb44bd58
      https://github.com/bluez/bluez/commit/19ff9ab9151205501025a8bd061da022bb44bd58
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-08-13 (Tue, 13 Aug 2024)

  Changed paths:
    M android/avctp.c

  Log Message:
  -----------
  android/avctp: remove check in session_browsing_cb()

session->browsing is dereferenced at the beginning of the function, so
the check can be removed.

Found with the SVACE static analysis tool.


  Commit: 537e399aa0960d57de5ba958ed4ddde713cd7ae2
      https://github.com/bluez/bluez/commit/537e399aa0960d57de5ba958ed4ddde713cd7ae2
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2024-08-13 (Tue, 13 Aug 2024)

  Changed paths:
    M android/avdtp.c

  Log Message:
  -----------
  android/avdtp: fix leak in avdtp_new()

It is necessary to close the file descriptor in case of an error.

Found with the SVACE static analysis tool.


Compare: https://github.com/bluez/bluez/compare/40621e269287...537e399aa096

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
