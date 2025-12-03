Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D972BDC0B
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Dec 2025 20:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764794204; cv=none; b=WthkOwOF3po6sck5QgriyPE7A1awxmJOQMVBrWd+4IcVFlzE1ba6C/y6c1G0QlwQc74lQTD9ILJ+IAS9+IKZ8O6ihUwdT/++vqmuiYZlfwnhKW4JLROC8KE+xK1JkmbVKofD6RZvulEpOVkYPokqmYfexExsokP5fTj/QknwnVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764794204; c=relaxed/simple;
	bh=SbIzGMJHOvR0PUwPSZJw508/KYdDStsbkZMcVjLbdmM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Y/2lE2Wgj2kBQ2eXZF6JkeKA1EzVs5xrnbA5E1yLkhgVtoh9EQkJnlpKUblU1kWqqE2KeWVV2rsr33mPmwCaD5tDU+YNUk8tULUjGdx8oCYE2ohU6YjnRVLHnBrOBIChS6cT1ABgSTo/Mag8QM9CITexAD+SF3+MAVk8bQxhqVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LK3JVYRk; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LK3JVYRk"
Received: from github.com (hubbernetes-node-e9cdadb.va3-iad.github.net [10.48.207.54])
	by smtp.github.com (Postfix) with ESMTPA id 8DB704E1173
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Dec 2025 12:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764794202;
	bh=edFF64RU4ay2BiobUvlwbGwf5+6FmxuN5t/g8Y4Q2YE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LK3JVYRkGfpNYIV4h6QaPqNK0QxWEhCOL/qDxrlvpJto+QUrWlbXqlTmkjIKpoGgG
	 VQ3sMg3M0+oTDqiaQQELXwqluYxG2KYeNPKMuulmZOHb0Oral+NZzyt5L5zZdA4/hg
	 T8z+kee9b8q+hywMqvsGPtD7ccxDaAfzI9woNU2g=
Date: Wed, 03 Dec 2025 12:36:42 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1029637/7cb5bc-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/1029637
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
