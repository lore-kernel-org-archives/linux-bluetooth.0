Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B1B32E136
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770749441; cv=none; b=ZbspXgQNAwZtfvDSG+MpRMRLT9FlekVXGVTvTv3brogqoCRjvEsI64rbRx1YYxlqoUrWD5OMXfdlbBQ++KDQZ/mvTEX7mKGVaui5tZXsTYeL0yGzDDdWGkG4/8HC+jbz/pw9OvrVCPxGRA0Yr6dd9M4zcgbyGUzB57OkdtL9Blk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770749441; c=relaxed/simple;
	bh=kYp4u/Jw5ScMWCTqgBC6ac4JLjBAi2FtZAHkD+33uSI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=iY2dsax9r+gFnPJJqIJWswQnmrCKhxX0ArVRbCsBxLpIZlrkC8ieS+SgS8CHo8iIHbWx/75Y8CXxHHBnDr+tZRwC+s+JnCRlL3CXkEE8iWhne25NXuVlEl1beP6yRBvjDXm04exqeFePUM6Ven+DTT5HT5ZrpIUDQpHjCLgslV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PLNsvknq; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PLNsvknq"
Received: from github.com (hubbernetes-node-e9f81e4.ac4-iad.github.net [10.52.183.52])
	by smtp.github.com (Postfix) with ESMTPA id 19088684431
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 10:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1770748817;
	bh=FLxgNDaG6z2VxEweXxYZK7aSsSqcEbYjp3MpvPQQIfY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PLNsvknq49WqfMBwYh03rQe3UpUtJsPKnO3tfOLJFpeJ+kCAylg0+2pW+rKLh+p1W
	 k6WGUGkF4sEk0dEET2GE0CV/nsfkJ3soIFMvXB5sR7Fs1gMYXjqEYVTzhZlqm+OBTo
	 4QOwjhKjq2vwb5oWsd7+PDGm6GTwVgWl+fjxmGYU=
Date: Tue, 10 Feb 2026 10:40:16 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1052360/1b2869-000000@github.com>
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

  Branch: refs/heads/1052360
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
