Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5721D63E6
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 20:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746477174; cv=none; b=aElx1cUy3itYUm6B+ni2ikBanFRDe6IE3U1Gj60ZifKilkOUZadMNmsU5Q2yZxfuE4nLSgigFQDxL3khyE+6Z2LE6OpWlHXF2LZrKW/iJIa+gSz5Mz9w05inS75ce+3u0R3blXkEuXt6E2pFMfFaZqu1M0TcC2pfTgYuGqKPBoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746477174; c=relaxed/simple;
	bh=YCIEWiG4JYOhe3d2EgB3Sx35v7MYyh/pZ3rgl4+AjfY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=aL7mdXQ2l6ntFW0kylnB6I1NBJ5CJ+TYgQgqGn+1NNm7mmJ0/OytF0M1bliMMi7UHpfP3sRVFAKVL5soijT1cTbE+QkHStHyuPZfjRjXvtqkJGwT0TReX78PJlA9SSpbUGRHPd5NjNvnzUuCpubJF70/2dOstGIS1mWWyOdtHL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MFnqE/85; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MFnqE/85"
Received: from github.com (hubbernetes-node-adb7b9d.ac4-iad.github.net [10.52.163.23])
	by smtp.github.com (Postfix) with ESMTPA id 0EACC700459
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 13:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746477172;
	bh=KMi23hJvkIkmEKt0QcT4OOms5NHlgs82B9fIYO8D/7k=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MFnqE/859LwOdoMYthSxpfnR/KDukgoPu2Uf9E2hjOjGI664iKBxOzvBi3R1WJwxi
	 y/fTLcTW+e43XEQV2ORzt/0aLLY4uIORbxn35IweuJvnXSPHo0U4HOfJExJdvmUmuB
	 3ZeX6XaHSlRNET12HX2cbQvUfQ246eOUc+Na7mow=
Date: Mon, 05 May 2025 13:32:52 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/4bbfd9-57df14@github.com>
Subject: [bluez/bluez] 57df14: mainloop: Only connect to NOTIFY_SOCKET if
 STATUS=...
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 57df14b8f8b15e7936568694bba1f1083c7e69b1
      https://github.com/bluez/bluez/commit/57df14b8f8b15e7936568694bba1f1083c7e69b1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-05 (Mon, 05 May 2025)

  Changed paths:
    M src/shared/mainloop-glib.c
    M src/shared/mainloop-notify.c
    M src/shared/mainloop.c

  Log Message:
  -----------
  mainloop: Only connect to NOTIFY_SOCKET if STATUS=Starting up

This makes the handling of NOYIFY_SOCKET conditional to only when
application attempts to set STATUS=Starting up which means it is
intentionally requiring it.

Fixes: https://github.com/bluez/bluez/issues/996



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
