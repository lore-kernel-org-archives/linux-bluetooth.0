Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231C33515C9
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785857910; cv=none; b=m+MPE9IcIpLHbwYC9yxThlJsi2UCxQSPOkPbW+ddxxZCVqtTBe50dQJ915CTTT2nuLrpMRULq8QspuiuuF4QetQ0di2gulr/rbgxoBz1oQUdkL9n8mQ/AXNRB89P/Zo69qi6rJ8D3qp6rTfzkXkMVoOMQZP1Q9v2L61Vra1d2FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785857910; c=relaxed/simple;
	bh=50du/WgdOibErB7BtRZpe2lscFFuEIxWHxVUXMGS5x4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OBVsOFADFsrjCLc0Z4tTNwAsi9Ztw8E/7vwEjLgCPR0sfFNgCO91O8fVhkEQQ5q8ve2l8mxrx0Sledsm33SAirCl5dUKZo6m55xmcjG8lVl20LDu/dmbuZ0kD2T2B6vIjPz7Mx74BYaZjqOaM/xmDk7oFsfhhl1LMt3RKFFFGeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cca5z4JP; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cca5z4JP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785857908;
	bh=Qwatb5NHt8AaWb7laZFvZJwdVg80ZQgoyeTZqhB2Rt0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cca5z4JPPTgQTI0Bd0LvEhIQ5cBYZ9TxUwT3uSzRicfyqBbhou/Lwgd8YyPMQoGYw
	 t73fojm3vTVl2dxNTKfo2pkzm2tbgEh967xUQxBqqwdPoAghKmjR6kDwFT1IPcn1fk
	 Y50d92gfQWvn/nUW5TRDQ9PzQKZhZeNLLFBN4OEU=
Received: from github.com (hubbernetes-node-7c6ceb9.ash1-iad.github.net [10.56.196.48])
	by smtp.github.com (Postfix) with ESMTPA id 292C152073D
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Aug 2026 08:38:28 -0700 (PDT)
Date: Tue, 04 Aug 2026 08:38:28 -0700
From: Elman Shahbazov <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1140181/000000-7cfdc4@github.com>
Subject: [bluez/bluez] 4c9e8e: avrcp: Split off name parsing from
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

  Branch: refs/heads/1140181
  Home:   https://github.com/bluez/bluez
  Commit: 4c9e8e655c8ca1e7bf762f2ef01c991a33edb2c6
      https://github.com/bluez/bluez/commit/4c9e8e655c8ca1e7bf762f2ef01c991a33edb2c6
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


  Commit: 22040db70404cb38f7ba3f879fdb56eb9eb0bc4d
      https://github.com/bluez/bluez/commit/22040db70404cb38f7ba3f879fdb56eb9eb0bc4d
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


  Commit: 7cfdc42e76c6ac511b0207230f413d5e04599b96
      https://github.com/bluez/bluez/commit/7cfdc42e76c6ac511b0207230f413d5e04599b96
  Author: Elman Shahbazov <shahbazovelman97@gmail.com>
  Date:   2026-08-04 (Tue, 04 Aug 2026)

  Changed paths:
    M profiles/audio/avrcp-parse.c

  Log Message:
  -----------
  avrcp: Fix Out-of-Bounds Read in AVRCP GetFolderItems parsing

Co-Authored-by: Bastien Nocera <hadess@hadess.net>


Compare: https://github.com/bluez/bluez/compare/4c9e8e655c8c%5E...7cfdc42e76c6

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
