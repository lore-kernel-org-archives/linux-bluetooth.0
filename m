Received: from out-37.smtp.github.com (out-37.smtp.github.com [192.30.252.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D8B30F7E8
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 01:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791509394; cv=none; b=eQrxA+5VOhoKBVdbhVBWOC009bJFDaT/N333zJAFJ6hjyoVALvQPwh7VavDWfaRKezVWIG3tr8/KsWepqh5gIK7iBaxIC6XOQTF4vM2PI6CjJcBOWoZttUvwfLSXA9D1W/EBeWfLYx2ptAmPfqT02zB9iFotEqngfxDUTGA6uWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791509394; c=relaxed/simple;
	bh=ZSAV8ruJlb88WWN2TugmJ988Wj2jaCz7DmAbWRiXhQI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=EyH82RaszRB8UhtsLCoj1UXJYIxzakbF87l6oThmi9VE4V/BtHKwUKxvEHEr63Gj/aK9QBcFrlUWJlJtPgGFjpmwVNOtj7pWOcNDcIY1IucMwp1MtN0UFbj+QXYZEAwXJYfDrgeE22WjOrJyQao5dgjsAHHSJ9oZ26TMYGrA8q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=lGNB8Xdz; arc=none smtp.client-ip=192.30.252.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="lGNB8Xdz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791509391;
	bh=2L/oKAPnDTD4V8QsekKauorjX4xPMqYJhOMBiA7hBKw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lGNB8XdzdLDFkInoZxNmMGVHu3Bz466XRx0q504DJmZBPfcQ49U/sBcbdoyT3ycwj
	 8xg4duKL8xJLzh1VRO4AG5p1QJUwyBUa/nZYjoW+tzA1uD3vQWYF1+Q8CkC883U+o0
	 Bxe8hUNgjovJW7ReEJz7d8Fmfv3dOTf70zMsrqWeFKFk8mArzWbHrMCAhG7vR23e4x
	 vE/pA+1co9SRQEoam2q8XAgEbQKDhoYZKoXBni5sFcvV+R0eJySoRzWCeAqSPrMiTe
	 +pn+9s66U25NFU7jcVupvOhid4iTKpJDWOv9z8gcuBOklq+/Gu+NJlFa1OLevzFMFc
	 Pk+YMVtmBBpow==
Received: from github.com (hubbernetes-node-b784ab1.ash1-iad.github.net [10.56.147.46])
	by smtp.github.com (Postfix) with ESMTPA id CD18B920752
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 18:29:51 -0700 (PDT)
Date: Thu, 08 Oct 2026 18:29:51 -0700
From: Hitalo Souza <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1181897/000000-39fe2d@github.com>
Subject: [bluez/bluez] 814e34: tools/sco-tester: Add test closing the socket
 befo...
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

  Branch: refs/heads/1181897
  Home:   https://github.com/bluez/bluez
  Commit: 814e3496a888f127826ad931f085391278c165b6
      https://github.com/bluez/bluez/commit/814e3496a888f127826ad931f085391278c165b6
  Author: Hitalo Souza <enghitalo@gmail.com>
  Date:   2026-10-09 (Fri, 09 Oct 2026)

  Changed paths:
    M tools/sco-tester.c

  Log Message:
  -----------
  tools/sco-tester: Add test closing the socket before the link is up

Add a test that closes the socket while the emulator holds the
Synchronous Connection Complete event of its setup, so that the kernel
aborts the connection before the link comes up. No connection takes the
link then, so the test expects the kernel to disconnect it, as the
controller would otherwise keep it and reject further setups for the
device.

eSCO CVSD - Close Before Complete

Assisted-by: Claude:claude-opus-5-5


  Commit: 39fe2d600d0f3c8c96580cebf7bd75b44c40d483
      https://github.com/bluez/bluez/commit/39fe2d600d0f3c8c96580cebf7bd75b44c40d483
  Author: Hitalo Souza <enghitalo@gmail.com>
  Date:   2026-10-09 (Fri, 09 Oct 2026)

  Changed paths:
    M tools/l2cap-tester.c

  Log Message:
  -----------
  tools/l2cap-tester: Add tests closing the socket before the link is up

Add BR/EDR and LE client tests that close the socket while the emulator
holds the Connection Complete or LE Connection Complete event, so that
the kernel aborts the connection before the link comes up. No
connection takes the link then, so the tests expect the kernel to
disconnect it instead of leaving it up in the controller.

L2CAP BR/EDR Client - Close Before Complete
L2CAP LE Client - Close Before Complete

Assisted-by: Claude:claude-opus-5-5


Compare: https://github.com/bluez/bluez/compare/814e3496a888%5E...39fe2d600d0f

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
