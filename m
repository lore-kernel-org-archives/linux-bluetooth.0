Received: from out-40.smtp.github.com (out-40.smtp.github.com [192.30.252.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEAB3E834A
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 08:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779180669; cv=none; b=si97pFQu13pjnNhopGmFvaC59cVfWHkGeBngGoSH6QMXQgEnDct1DWoJfKX2h2d/9g94EEFjEXQfYXqYlFUrx62k4nCcWY0hn0jXepxiDRSxwMeFx+2MctEWOmAGz9xsfm1+kWv833Ho1I5NyF9sqV3xVhPVTN2VLGvKhgJq1p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779180669; c=relaxed/simple;
	bh=WlUd6EXlnS4QbE3ZB8RecJcjOU7DTrboXhvD/k9j0MQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Bn+M0nbJBbO6g8RTFZ5qijcK2Vdiu6vkPq/4n//rjspyhgfrAkBPgkUQg0LM2JK4ogL9h0mn9Wpoov118gE+ktWAOdVZn3ciUBPPT3eftx+yNSnSmOgUkc/N/ofHeMSYqd28J/ejqd7atgV4fJrrHW3InDHhJGxLYpTkDhWqpdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ih5gs8uQ; arc=none smtp.client-ip=192.30.252.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ih5gs8uQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779180667;
	bh=+wJWsvItUox9QorukhbYgXuqlMU9dpaBydbXBmRzBoY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ih5gs8uQK4Yg5vAgBv6oHKuj52W/R72X/H7O93t8TmEM4LrPRPN7F44sCHYjwPuQJ
	 RKMV/eosvIRBQMZ/wsYPfbHEVXswzZlo/hqK2kHByhlymvrsfQ4rzYj1DhCbq2sFMu
	 Zp+I+f2NQBd+VTsJKzHTHEE7PHy5EB7bw+MCKYx0=
Received: from github.com (hubbernetes-node-15f687b.ash1-iad.github.net [10.56.128.72])
	by smtp.github.com (Postfix) with ESMTPA id 57380921166
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 01:51:07 -0700 (PDT)
Date: Tue, 19 May 2026 01:51:07 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1097130/000000-e9de59@github.com>
Subject: [bluez/bluez] f5cc1b: client/btpclient: Fix GAP unpair command
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

  Branch: refs/heads/1097130
  Home:   https://github.com/bluez/bluez
  Commit: f5cc1b488ac39a1b869ae43c66cc68c667f5f584
      https://github.com/bluez/bluez/commit/f5cc1b488ac39a1b869ae43c66cc6=
8c667f5f584
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-05-19 (Tue, 19 May 2026)

  Changed paths:
    M client/btpclient/gap.c

  Log Message:
  -----------
  client/btpclient: Fix GAP unpair command

Fix unpair_reply() because the device is no more available on
RemoveDevice reply.


  Commit: e9de592034e48ad7fc0a10329e41a12ccd0c5c9d
      https://github.com/bluez/bluez/commit/e9de592034e48ad7fc0a10329e41a=
12ccd0c5c9d
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-05-19 (Tue, 19 May 2026)

  Changed paths:
    M client/btpclient/gap.c

  Log Message:
  -----------
  client/btpclient: Don't remove all devices on GAP Reset command

Currently running auto-pts remove all paired devices, instead of just
removing the PTS devices.
This removes this behavior, expecting auto-pts to explicitly remove the
PTS devices using Unpair command.


Compare: https://github.com/bluez/bluez/compare/f5cc1b488ac3%5E...e9de592=
034e4

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
