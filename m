Received: from out-7.smtp.github.com (out-7.smtp.github.com [192.30.252.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C2D38F631
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Apr 2026 20:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775679832; cv=none; b=JIgBiV2uQvW8K0N8t9kITpnjg3UWNAqU3V6p6x1B9JL9xGe3Y/JUb9YEGSTz1qShuAKj9ALw0SzCLP828jucspEJi+5pRWQjh+1HMYqqKSb5WxJCKYX/R6nCKywKeVE1q2CypJ1icIgRF3WKF7CyLG+JXKKz6lxw+y9FDAW2/Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775679832; c=relaxed/simple;
	bh=ZYQ8Du+v0+ipLruA5lgMLV1fJL09TyJxJaa2qBYFBgk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=svd3Rmvzar8gWF09Dqn6Ck57Sp8RjzGouX1RtQzbyAhDyYQl4YlCpszoRsH+YhdjdbAyBQxr1pmTBo0CzpTo+yuHTv5DVLEOoPt+9yuA2gsxn70atV75izZqS3Eb+O1DMcunNaZSLpgKUbemGjpXgeM97CgKnsh90fSX/B1mAL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dtf2hSko; arc=none smtp.client-ip=192.30.252.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dtf2hSko"
Received: from github.com (hubbernetes-node-a3f0794.va3-iad.github.net [10.48.178.35])
	by smtp.github.com (Postfix) with ESMTPA id 408419010A3
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 Apr 2026 13:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775679830;
	bh=8/wpa/y7+IEHQcsOZ+gejhqZ7LirVhTBL7qM82sM8EU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dtf2hSkoddSRSVyClaBNP8lasodqplpDOrYJAamstl1UEf0uku0PJwKJXX+N2uFQr
	 He5P8OttP14Vvw3oEww2mgMSwWw4wTrGnmxeKDGot4cJCLf1cWUMhMZq7jvn3kC7ah
	 wNFPjt5HsiLJaE1HxxuXLQn0P5jJGBiVW+n2jmEY=
Date: Wed, 08 Apr 2026 13:23:50 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1078904/000000-24385d@github.com>
Subject: [bluez/bluez] 5930ea: shared/gatt-server: Add
 bt_gatt_server_set_permiss...
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

  Branch: refs/heads/1078904
  Home:   https://github.com/bluez/bluez
  Commit: 5930ea25375b48af63d3319da6036ab6e1be9ce5
      https://github.com/bluez/bluez/commit/5930ea25375b48af63d3319da6036ab6e1be9ce5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-08 (Wed, 08 Apr 2026)

  Changed paths:
    M src/shared/gatt-server.c
    M src/shared/gatt-server.h

  Log Message:
  -----------
  shared/gatt-server: Add bt_gatt_server_set_permissions

This adds bt_gatt_server_set_permissions which can be used to
enabled/disable permission checking before operations which can be
useful on testing only environment where encryption/pairing is not
desirable/needed.


  Commit: 24385dd5330c0c2309bb8082024a2727ee61b29f
      https://github.com/bluez/bluez/commit/24385dd5330c0c2309bb8082024a2727ee61b29f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-08 (Wed, 08 Apr 2026)

  Changed paths:
    M src/btd.h
    M src/device.c
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  main.conf: Add GATT.Security option

This adds GATT.Security option which by default is set to auto to
detect if encryption/authentication is required on demand, but if
Testing is set enables the user to enter a desirable security level.

In case the security level is low it then proceeds to disable checking
GATT attribute permissions for server operations.


Compare: https://github.com/bluez/bluez/compare/5930ea25375b%5E...24385dd5330c

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
