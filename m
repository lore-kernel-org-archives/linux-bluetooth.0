Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8E42F5E
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 17:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752255970; cv=none; b=b81Ds5PStWY5mhWb+ur8V1odggymo5uxWKqoeOThYmO4V4x+jBNDApYERgDyQMVHfo90KkU9xhQZaLPUG+TZE3ETjMpadWFwpHosPbNTfnM2h2jVi0yzYqQ93lSNXPA8VvgOtYVr+ueKGaNz3UxV8MF+y2dB/uUucilgv6fJ94Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752255970; c=relaxed/simple;
	bh=28dzVq9Tsu9P0H5sJH7Hymajadz7bWkCoNu3RC9Mxbw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=C5zDZC++Fb2HeShzzMos4QHb5g7aZB+merSfdXQmSyI9b8xrZMIE9/N7xq1XlFy3VznuybqjuoZhprIfNb0r73STckFNTIY8GMx+yjxIpf+GnwMMyf7i2eBZJ+jtzpBj+k+YEKPGdsGzHoKkK1BubX7QFh3wXRcujfJ/UXRC07A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=nBK/dWH9; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="nBK/dWH9"
Received: from github.com (hubbernetes-node-034ac76.ash1-iad.github.net [10.56.186.30])
	by smtp.github.com (Postfix) with ESMTPA id 827761411AC
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 10:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752255965;
	bh=pL4Bbx2hhDGAbePZm1rm6rOIYv2o2LwHRQz7M7Dt+qM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=nBK/dWH9+d0yysPDt45dIB/d2jaqhggaaM1xVI294rNr7dJGee1xn7SCkYntK/yfb
	 p5IcEjJWfGqmLhD7pWRcuHl9nSzQp4RhTeysLPPVzgAtaAqfIep1U7SeQSuOgahnBO
	 V1e5CFHOiECobwOxNXou3yZjmUqkQhjlH8uuqlbk=
Date: Fri, 11 Jul 2025 10:46:05 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/981617/000000-140d3a@github.com>
Subject: [bluez/bluez] 140d3a: profiles/battery: handle reversed ordering of
 CCC ...
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

  Branch: refs/heads/981617
  Home:   https://github.com/bluez/bluez
  Commit: 140d3a65108e5c7c3f1fd137c04f437ab5e9159d
      https://github.com/bluez/bluez/commit/140d3a65108e5c7c3f1fd137c04f437ab5e9159d
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-07-11 (Fri, 11 Jul 2025)

  Changed paths:
    M profiles/battery/battery.c

  Log Message:
  -----------
  profiles/battery: handle reversed ordering of CCC and value

Order of batt_io_value_cb() and batt_io_ccc_written_cb() may be reverse.
This causes device to appear with 0% or missing battery percentage,
because batt->percentage is set on the ignored update so the initial
update is lost.

Fix by saving new initial value, if battery is not registered.  Also
downgrade warning to debug message.

Also check data length before parsing it.

Log (Sony Linkbuds S):

src/shared/att.c:can_read_data() (chan 0x7c31eea05c50) ATT PDU received: 0x1b
profiles/battery/battery.c:parse_battery_level() Battery Level updated: 87%
profiles/battery/battery.c:parse_battery_level() Trying to update an unregistered battery
src/battery.c:btd_battery_register() path = /org/bluez/hci1/dev_CF_D2_4D_EE_A2_1A
src/battery.c:btd_battery_register() registered Battery object: /org/bluez/hci1/dev_CF_D2_4D_EE_A2_1A
profiles/battery/battery.c:batt_io_ccc_written_cb() Battery Level: notification enabled



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
