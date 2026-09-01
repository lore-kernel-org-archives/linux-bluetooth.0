Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4586036212D
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 14:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272311; cv=none; b=XGvSyElJPht6B0ZMy57kwQnPDj99AUYEaqX3Q4Gequ6+rASC/4T+ibgYAp53ZRPtBDFl44mll6vw9umtEwbi49pkLGPftKXOlK0caZNQmpkCNmp5kymU7jkFrEYchgTLA2qHKvtXb21PUSZpaoyEW2/tJ7lghs8n9da6mGIow1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272311; c=relaxed/simple;
	bh=8UR27s48PVwH5K4u4xwZZY1j+rszTzNsGyU3vofTJrc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=POGbPEFPgdg98ip62N6kYmWqNbReEgPH32UnKCiQT/izUEq27EHUvzEoxt2otExDErmXhaOEp0TQCmtBdUpZBwjniZnIBoCD3d20y71XhPjHmm7qJKy84+b3/r5/qRFvBwbt0zUN8e0X2uIJap2he2tR7N/Ei10pErN58ELcZD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LcIV1Utz; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LcIV1Utz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788272309;
	bh=em8JSoHKsuQjk5HV6l9UiOE2O2Jy/mazfK43Af302Z0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LcIV1UtzEJQ5sClu8VPLjSpM7C5qx87jkk4bU+KS5Q/Q+tymRgsaXhkSpgSBNsTeL
	 9nmP7LI9TmGRKLpEft8NpAQ1Z59dHpg44k8NgsKg0DkLmhxWG4+uLwWEtkDsmrP1rh
	 2Y6muuAD5hNErUBIry1PbKYqLAW9mNMcoXrYRGD0=
Received: from github.com (hubbernetes-node-f10bf6e.va3-iad.github.net [10.48.178.43])
	by smtp.github.com (Postfix) with ESMTPA id 16E291813F4
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 07:18:29 -0700 (PDT)
Date: Tue, 01 Sep 2026 07:18:29 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1155344/000000-dac453@github.com>
Subject: [bluez/bluez] dac453: client/btpclient: Improve GATT read
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

  Branch: refs/heads/1155344
  Home:   https://github.com/bluez/bluez
  Commit: dac453e07576349465d89a3bbc266c463e750711
      https://github.com/bluez/bluez/commit/dac453e07576349465d89a3bbc266=
c463e750711
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-09-01 (Tue, 01 Sep 2026)

  Changed paths:
    M client/btpclient/gatt.c

  Log Message:
  -----------
  client/btpclient: Improve GATT read

BAP/UCL/CGITT/* tests request to read the different Sink/Source
Audio Stream Endpoint characteristics.
The first ReadValue call triggers read of the other characteristics
and PTS, which tracks the read requests, may disconnect before the
following explicit ReadValue has been replied.

First try to read the characteristic value from the proxy cache
before calling ReadValue explicitly.



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
