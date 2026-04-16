Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512AA330B15
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 19:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776368217; cv=none; b=XGN5sSveIicsafoNcvwjEzDql+Lz22F3tErqd+tEKZD4iauIgulCWYEJnxcdl+zGFxEAn4F2TALkisNez8DnY5hU40CJfSXx8mI6uwJOqzg5+C2l+/qRS/BR1Q2FuuuseD8HwM7EwwtPAXj8655plhi6GAPMs87DhHRrFtu7Hrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776368217; c=relaxed/simple;
	bh=5NwQho2UbPYkR0oY7wJZK1a3qbq+PVhw4v8Wz7yt+EI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=nGRc/NvG7VgfK6Zm7yuEF/d3kOuAV4GTWJKc4vfA6IAK+TdRXxS37VM9yjD68dkhGk1WI8tB6ldVmdhwxP3jx+YtwS1zCCiVbjd1kAYE18KnjOBCnSZ8tIqobrLx6vWbvu6zmHSRO/zkNWu5LDGZfFXpHCRFxiSYi070vhKl1mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cp2t1xuT; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cp2t1xuT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776368215;
	bh=mxj3zXs/F8NYf5P60pZLtjNXhdHRsrusBvxE/EzCvV4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cp2t1xuT+wp2x24ZT6xe9UL9BCAh1l4cOO7oV5J61s6SVCv3CPlaLDdswj4+eAXoI
	 thsrVWt1BtZZ7+nY3VrWrzZXq7JeLVzHVoisoCffH7CIveC34QNkcG7dE+5/C6qQ0J
	 wWb/BCKuk2YGRdtmzynqyV4zgt/Ogyo79Sr8bqQw=
Received: from github.com (hubbernetes-node-b7b39d0.ash1-iad.github.net [10.56.200.77])
	by smtp.github.com (Postfix) with ESMTPA id 74E5036107B
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 12:36:55 -0700 (PDT)
Date: Thu, 16 Apr 2026 12:36:55 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1082170/000000-3573e0@github.com>
Subject: [bluez/bluez] 3573e0: client/btpclient: Add GATT discovery supports
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

  Branch: refs/heads/1082170
  Home:   https://github.com/bluez/bluez
  Commit: 3573e065d76b748d7872f5e12c62ae2d3a517e3d
      https://github.com/bluez/bluez/commit/3573e065d76b748d7872f5e12c62a=
e2d3a517e3d
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-04-16 (Thu, 16 Apr 2026)

  Changed paths:
    M client/btpclient/gatt.c
    M src/shared/btp.h

  Log Message:
  -----------
  client/btpclient: Add GATT discovery supports

This implements the following BTP GATT services commands which are used
by BTP BAP service:
- BTP_OP_GATT_DISC_PRIM_UUID
- BTP_OP_GATT_DISC_CHRC_UUID
- BTP_OP_GATT_DISC_ALL_DESC



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
