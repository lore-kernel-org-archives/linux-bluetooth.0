Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86BC250BED
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746450026; cv=none; b=ZCG8NW0M+einR6205fAxMiNUp/PuGVQB95NrtYVcFTXwPAC7yfTbHmwF4flmYgZ6eBJT2AfZCSUF/IW/07xnpQ9XDERPBNZySMsLX1WymCcsaZKXSOY5eJExEX8gvG/ZMEHfRijk0WpBQN5/R3ex9kySp/dsHlg1MJcMti5VniM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746450026; c=relaxed/simple;
	bh=qfiTdoN8eECNf6Y+dDD3bWO+nDC1fmSZz6K1NDyKlHM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pffTMSxcRpKqx6qS9pD5fOJR6qHRidZeV+EvvtO7Y09sTVNd6r0qdZjYPp6DxjZSUFK/ZHEtbSKWQINxLhRUOEx+vdxeHPVrrqTXgbGxPKDcCGkIfPPecbDF3BLBJdLknC/HTFbe+/DCsVJpzBnjSyaAtQdewCOVgJLUO7sn8cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ck7g01JP; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ck7g01JP"
Received: from github.com (hubbernetes-node-2d3656b.ac4-iad.github.net [10.52.143.17])
	by smtp.github.com (Postfix) with ESMTPA id E165C640BB1
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 06:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746450023;
	bh=1L1oHeb/fEoHiVr/nZhmIomsRXoO2kEMWGfNfB8dYzE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ck7g01JPe5cmo4xm+OQZnB2DCQuxWufoacReIB0cTixyQvyDdJp/vr3e5jr3ItU5v
	 wYMZA5n7lWESpJlmwekIuekK3Y8R96eDBLVCSX8c9QAUcFdFeyAtjvc9o0CPElliCH
	 md1IfoV/vThsCbfQCpoYjJ1lvSKVfUjKi+6WEZQc=
Date: Mon, 05 May 2025 06:00:23 -0700
From: Christian Eggers <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/959619/000000-bd6c47@github.com>
Subject: [bluez/bluez] bd6c47: mesh: acceptor: fix endianess issues
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

  Branch: refs/heads/959619
  Home:   https://github.com/bluez/bluez
  Commit: bd6c47de3daab92b8d22776b4a5040c39bf8077d
      https://github.com/bluez/bluez/commit/bd6c47de3daab92b8d22776b4a5040c39bf8077d
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-05-05 (Mon, 05 May 2025)

  Changed paths:
    M mesh/prov-acceptor.c

  Log Message:
  -----------
  mesh: acceptor: fix endianess issues

Members of 'struct mesh_net_prov_caps' are in Over-the-Air order and
must be converted to host order first.

Fixes: 838ddc931263 ("mesh: provisionee: Check prov start parameters")



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
