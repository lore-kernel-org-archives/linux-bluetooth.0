Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0CE42C508
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 13:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785849589; cv=none; b=qsA72lEZ+VzaBpmchUUXBvHqz6/D3M829riC2yzLp3gpSN4T5XavazfPCk5HLzI8OZvUPob75RKaEHcRduAnDStdhfihfkOpwti0PczM7kCTGzFWR1geWt2QThRNxB/MDXH/WEjq/2DTg5i6lOIXplpNGVIWT3jJRVHe4uNUQ8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785849589; c=relaxed/simple;
	bh=abjKN2N6QVzN/OhB0rUWi+1d2h86dJirMSlC9YwI51o=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=LOhJuAE0FLh6hiXMhhTULKSi6Y1aB6gd/wFMlOOR5S0bSEgzCQbcKu0gxH7eNW46RsT7mK3wvDqbJb0EU4aPbIMjKbGOGmLqMpqBYGzgECCDDuip4JgflUdalEoUWhGWwxmJlJPWD9UfPf+BsVWkcFa2xCHpEs6Vs6ygorC11fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=maOfjVtA; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="maOfjVtA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785849587;
	bh=VyqOTiuAd9haPYpNcnnNusCfCOmkXHhEHjSkhn3RMx8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=maOfjVtAvqW4HFjXnHycR89KhLrLy9m1auZN0yBVpIzSYqbpBrSceHWWUAWZjZexV
	 eEKCxlHqBUlBiGWTwNfyfJDPC2tU+vBsnNYVgDIwb6v9er62dZczIScoPB58NFlPjG
	 rcglq+IcFrbS3MCpcbFOjS6M8Icws11aTRrjoLpk=
Received: from github.com (hubbernetes-node-0701ae3.va3-iad.github.net [10.48.70.93])
	by smtp.github.com (Postfix) with ESMTPA id 5B6081813EA
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 06:19:47 -0700 (PDT)
Date: Tue, 04 Aug 2026 06:19:47 -0700
From: Elman Shahbazov <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1140113/000000-e454c9@github.com>
Subject: [bluez/bluez] 4c789b: avrcp: Split off name parsing from
 parse_*_element()
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

  Branch: refs/heads/1140113
  Home:   https://github.com/bluez/bluez
  Commit: 4c789b22745a0b7dce8084932fd6475977927271
      https://github.com/bluez/bluez/commit/4c789b22745a0b7dce8084932fd6475977927271
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-04 (Tue, 04 Aug 2026)

  Changed paths:
    M Makefile.plugins
    A profiles/audio/avrcp-parse.c
    A profiles/audio/avrcp-parse.h
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  avrcp: Split off name parsing from parse_*_element()

This will allow us to use the name extraction code in
parse_media_element() and parse_folder_element() separately, such
as in tests.


  Commit: 4093bc867ab2b2cecc857cae236ec7445b6d6432
      https://github.com/bluez/bluez/commit/4093bc867ab2b2cecc857cae236ec7445b6d6432
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-04 (Tue, 04 Aug 2026)

  Changed paths:
    M Makefile.am
    A unit/test-avrcp-sec.c

  Log Message:
  -----------
  unit: Adapt poc_*_oob.c test into a new test

Adapt poc_avrcp_oob.c and poc_folder_oob.c into unit tests.

Co-authored-by: Elman Shahbazov <shahbazovelman97@gmail.com>


  Commit: e454c9ca6555e997184090988fa1a2e2dcba27b6
      https://github.com/bluez/bluez/commit/e454c9ca6555e997184090988fa1a2e2dcba27b6
  Author: Elman Shahbazov <shahbazovelman97@gmail.com>
  Date:   2026-08-04 (Tue, 04 Aug 2026)

  Changed paths:
    M profiles/audio/avrcp-parse.c

  Log Message:
  -----------
  avrcp: Fix Out-of-Bounds Read in AVRCP GetFolderItems parsing

Co-Authored-by: Bastien Nocera <hadess@hadess.net>


Compare: https://github.com/bluez/bluez/compare/4c789b22745a%5E...e454c9ca6555

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
