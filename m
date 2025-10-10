Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C152F1FC7
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Oct 2025 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760105687; cv=none; b=qZxc2cINdEpZaj4u1ohKb5ry7HZjh2yp30RiqhTXTY4CRsLCGSDfcM8moOkPDTMd54+Q8ppAGZdJwzN9bwfvd56rU+M7mN0yu7amCEh8Is4+SxUfBsZDGENwb871eQ9PDbGCfklo2B/1VxSc1NXa6pV7deeX6LgvILvQQf2w+YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760105687; c=relaxed/simple;
	bh=lMKY8BbnPEpRg7LUAK5PI8lqe0pRWOMrjtkxaktTBEg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=lddM0nwwYv4dvquGEW1GLz+p+5xOGiJWZQ2D7rwd5suDHsqES3uPhLtclZBDKEC6BKVc2l3PcwXOgy704C5AWTEHBvndSd3OLujOiv0sIia+nfdLbPwGvjeXcXWmPVWwlQARY8efRlGMGvMNpgSr/lDzWwDZXMUdkiI2Vh+3704=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Vb9TKb38; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Vb9TKb38"
Received: from github.com (hubbernetes-node-0f776bc.ash1-iad.github.net [10.56.196.49])
	by smtp.github.com (Postfix) with ESMTPA id 28F4F141371
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Oct 2025 07:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760105685;
	bh=KgERaKtjLKlZ+3o1MhJVzQYFjMoKM/6l/HaHyqX+etc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Vb9TKb38Z9jiW8J5Z/2L/mHhEVHBUFcAchHPrI4gyaQNzCUZtchmj+36pGQn7L9vk
	 vrZZbEL7jmwzFccZ68ieXIZfMZ8ldBosl8Y6n7ei1/q0QaFGjflMBORUaioLu52yU2
	 7AV8bN/yTjbYUzXuF1wmaff8XKlN1gp8/HHlzz/w=
Date: Fri, 10 Oct 2025 07:14:45 -0700
From: Adrian Dudau <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1010113/000000-a0533d@github.com>
Subject: [bluez/bluez] a0533d: tools: Add raw advertising data support to
 BlueZ
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

  Branch: refs/heads/1010113
  Home:   https://github.com/bluez/bluez
  Commit: a0533d5282ad0e9736990abb81d577737707dc65
      https://github.com/bluez/bluez/commit/a0533d5282ad0e9736990abb81d577737707dc65
  Author: Adrian Dudau <adrian-constantin.dudau@nxp.com>
  Date:   2025-10-10 (Fri, 10 Oct 2025)

  Changed paths:
    M src/adapter.c
    M src/device.c
    M src/device.h
    M src/eir.c
    M src/eir.h
    M src/shared/ad.c
    M src/shared/ad.h
    M tools/btpclient.c

  Log Message:
  -----------
  tools: Add raw advertising data support to BlueZ

This patch introduces support for storing and exposing raw advertising
data from Bluetooth Low Energy devices through D-Bus properties and
internal APIs.

Key changes:
- Add raw_data fields to eir_data and bt_ad structures
- Implement bt_ad_set_raw_data(), bt_ad_clear_raw_data(),
  bt_ad_has_raw_data(), and bt_ad_get_raw_data() APIs
- Expose RawAdvertisingData D-Bus property on device objects
- Store raw advertising data during EIR parsing
- Update BTP client to include raw advertising data in device found events

The RawAdvertisingData property is marked with G_DBUS_PROPERTY_FLAG_TESTING
for debugging and protocol testing purposes. This enables applications to
access complete raw advertising packet contents for custom parsing,
compliance testing, and troubleshooting scenarios.

The raw data format follows the Extended Inquiry Response Data Format
as described in BLUETOOTH CORE SPECIFICATION Version 6.1 | Vol 3, Part C.

Signed-off-by: Adrian Dudau <adrian-constantin.dudau@nxp.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
