Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB404C9D
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Nov 2025 05:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764135391; cv=none; b=DIh4WVTn3Q4nfpynCY8u73evyXqhN3KmzLNUX10uWLLgmFqyQcctUGTHmkRdxXGpZLiY8REB0D53Sz6bT+vqCbyK0w09tGL2XV+cTEgXimui87doHw0Gq0KYIY7rkYZF1nyo5eftHcHGXSpzF7stY1UXF+P4JB8JDYB3jqNAU/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764135391; c=relaxed/simple;
	bh=g2nctGeeSD1KWTqDwSkZtu+T7VB1EI7mnoWgaW74NsM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YpjslMp6FrIB77YtFlltnoLBM8gfEafdWR5gfls5d+NZD1aqYjPHiCrCrscrHWJn8s3WA/wjJ5eoYiCcWTLtsDKrk6uELfLtALn9I3Nzc2Gi9SYgZeUG5h6JDC3KVt/HtMF/1v3DDt0cSTy5IIiLaWNKlO7slr/L7SaDojvxJbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SoUCrixI; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SoUCrixI"
Received: from github.com (hubbernetes-node-1fb8caa.va3-iad.github.net [10.48.131.36])
	by smtp.github.com (Postfix) with ESMTPA id EB9E1E087F
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Nov 2025 21:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764135389;
	bh=6NYCbpNtBIDho/8WJ8xWHUmE0Y8HNwtSyiwbYRsJDoY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SoUCrixIiDw5ZZ26QgtZEkQtOZhHkOohU9FSaw4GeuSNJrFrD7IAKNqZs9XC52jWe
	 BqgZretrvx1JSZY8OQnpU+4RnEYbDdEjeVlqPEoMOOTUK9kdCAj+q3xJIInSlDNLiv
	 ywGeAjTpx06RqKqzdNp225h1WZuLSINblL8r9xIU=
Date: Tue, 25 Nov 2025 21:36:28 -0800
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1027639/000000-c63271@github.com>
Subject: [bluez/bluez] 56fe51: profiles: Add bearer field to btd_profile
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

  Branch: refs/heads/1027639
  Home:   https://github.com/bluez/bluez
  Commit: 56fe5116a58947212abd8cefd022861dd4511e0f
      https://github.com/bluez/bluez/commit/56fe5116a58947212abd8cefd022861dd4511e0f
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-11-26 (Wed, 26 Nov 2025)

  Changed paths:
    M profiles/audio/a2dp.c
    M profiles/audio/asha.c
    M profiles/audio/avrcp.c
    M profiles/audio/bap.c
    M profiles/audio/bass.c
    M profiles/audio/ccp.c
    M profiles/audio/csip.c
    M profiles/audio/mcp.c
    M profiles/audio/micp.c
    M profiles/audio/vcp.c
    M profiles/battery/battery.c
    M profiles/deviceinfo/deviceinfo.c
    M profiles/gap/gas.c
    M profiles/health/hdp_manager.c
    M profiles/input/hog.c
    M profiles/input/manager.c
    M profiles/midi/midi.c
    M profiles/network/manager.c
    M profiles/scanparam/scan.c
    M src/profile.h

  Log Message:
  -----------
  profiles: Add bearer field to btd_profile

Add bearer filed into btd_profile to indicates which bearer
type this profile belongs to. Thus we can distinct the services
per bearer.

Signed-off-by: Ye He <ye.he@amlogic.com>


  Commit: 4bb560b89c5418d4d77cdc0e34c67bef1b17e66d
      https://github.com/bluez/bluez/commit/4bb560b89c5418d4d77cdc0e34c67bef1b17e66d
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-11-26 (Wed, 26 Nov 2025)

  Changed paths:
    M src/bearer.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  bearer: Implement Connect/Disconnect methods

This patch provides implementations for the Connect and Disconnect
methods of the org.bluez.Bearer.LE1 and org.bluez.Bearer.BREDR1
interfaces.

Signed-off-by: Ye He <ye.he@amlogic.com>


  Commit: c6327186cfa0132344cdb3685decff9731395b7e
      https://github.com/bluez/bluez/commit/c6327186cfa0132344cdb3685decff9731395b7e
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-11-26 (Wed, 26 Nov 2025)

  Changed paths:
    M client/bluetoothctl.rst
    M client/main.c

  Log Message:
  -----------
  client: Add shell cmd for bearer connect/disconnect

This patch adds shell command for bearer connect/disconnect.

Signed-off-by: Ye He <ye.he@amlogic.com>


Compare: https://github.com/bluez/bluez/compare/56fe5116a589%5E...c6327186cfa0

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
