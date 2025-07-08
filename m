Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6B92E172E
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 15:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989397; cv=none; b=EC8sKWDXC+GRUnaBXMW9/AT5HBuCDOZOoK7BuBb1IBZf1D+DEWi7ScBBk1015YiMj6Nl6nIVFU3vM2aQsKA7Z9hst5jLTbYjNy4nivomqEPSC+Be3jyMIe51PJ9zdyaq9YSjrgr2usnVbzUeYy069wbwwhH0CB2JTZqncPOLs/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989397; c=relaxed/simple;
	bh=Nuk3pBsbGsGuzTxXvSQ4KczQYCy5qNYwy0mslyFiuNo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=DJkx1x8nXwW77TrAFB3SUNg4c229xNaJsWhf25Qt8BOfNL9Nq+ABxOrIO81SJe8qAGhDgzhpc/sZ7SxRwwtSYZSsOSSznZ/ESrVeDQ3hRZ8leumPzkjYXVZhw2Kcw7wuuNA9L/k37SfpqMD4KE6rDHe6TGrw3EwokLcuyPDrCoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DB1iXWLf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DB1iXWLf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751989393;
	bh=Nuk3pBsbGsGuzTxXvSQ4KczQYCy5qNYwy0mslyFiuNo=;
	h=From:To:Subject:Date:From;
	b=DB1iXWLfmZgWT1Zp1pUDCMj77h5InjjD3O1V6x80fKF9eZrdvfcopdz14P8ateOLW
	 RnoRav387JtKKlKE8FoU1cd9UNzx9lRvfb+bq2EsnUKh85VowjmG3UvY565GNj2voa
	 R9HNetOfgQqhGgfeX3aJNda9mNSnqERbj7B9aR4W1uFAKglJ1sdHGMaboEI8yvCdom
	 ou+Trdn8dXgMX6NHJhF/wqClrSA/oMsE1Is3r6ChlTQVmTvhchqudw2J6yYTz3PH9x
	 P2HxCYaR3NCvXTpHS+uOI7FkMRIhDungPlMD7PkEGkBWi5MpWVW1xbw8S90znhVsTk
	 Up9b1DOOoau2w==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-af44-1001-a903-aFF7-d14E-7699.rev.sfr.net [IPv6:2a02:8428:af44:1001:a903:aff7:d14e:7699])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2B35B17E0CF8
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 17:43:13 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 0/7] audio/avrcp: Fix crash with invalid UTF-8 item name
Date: Tue,  8 Jul 2025 17:43:00 +0200
Message-ID: <20250708154308.238963-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

As stated in AVRCP 1.6.2 chapter 6.10.2.3 Media element item, for the
Displayable Name Length property, the target device may truncate the
item name:

  Length of Displayable Name in octets. The name shall be limited such
  that a response to a GetFolderItems containing one media player item
  fits within the maximum size of PDU which can be received by the CT.

This truncatation may occur in the middle of a multi-byte character,
at least with Samsung Music app, which triggers a DBus assertion and
crashes bluetoothd:

  profiles/audio/player.c:media_folder_create_item() Din Dhal Jaye
      Haye with lyrics | "दिन ढल जाए
      हाय" गाने के बो� type audio uid 1
  profiles/audio/player.c:media_folder_create_item()
      /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item1
  profiles/audio/player.c:media_player_set_metadata() Title: Din Dhal
      Jaye Haye with lyrics | "दिन ढल जाए हाय"
      गाने के बोल | Guide | Dev Anand, Waheeda Rehman
  …
  arguments to dbus_message_iter_append_basic() were incorrect,
      assertion "_dbus_check_is_valid_utf8 (*string_p)" failed in
      file dbus-message.c line 2775.
  This is normally a bug in some application using the D-Bus library.

v1->v2:
  - Introduce new strtoutf8() util function to truncate a string before
    the first non UTF-8 character.
  - Use strtoutf8() for AVRCP media element name
  - Use strtoutf8() for MCP player name and track title
  - Use strtoutf8() for Audio GAP device name
  - Use strtoutf8() for EIR device names
v2->v3:
  - Use strtoutf8() for AD device names
  - Add name encoding tests to unit/test-eir

Frédéric Danis (7):
  shared/util: Add strtoutf8 function
  audio/avrcp: Fix crash with invalid UTF-8 item name
  audio/mcp: Use strtoutf8 for player name and track title
  audio/gap: Use strtoutf8 for GAP device name
  eir: Use strtoutf8 for device names
  shared/ad: Use strtoutf8 for name
  unit/test-eir: Add name encoding tests

 profiles/audio/avrcp.c |  4 +++-
 profiles/audio/mcp.c   | 11 +---------
 profiles/gap/gas.c     | 11 +---------
 src/eir.c              | 11 +---------
 src/shared/ad.c        |  7 +-----
 src/shared/util.c      | 42 +++++++++++++++++++++++++++++++++++
 src/shared/util.h      |  1 +
 unit/test-eir.c        | 50 ++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 100 insertions(+), 37 deletions(-)

-- 
2.43.0

