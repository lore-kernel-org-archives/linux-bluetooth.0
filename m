Received: from o11.sgmail.github.com (o11.sgmail.github.com [167.89.101.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB12341074
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.89.101.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765828228; cv=none; b=W/+pvzwPc/y7xqVK/cmHiwnKDj39wZc3a+gft3aAljwcrwa8qlvbbqC2sWtqoOhIvpADgbqFn4YnGMwt80+Gq6xNTOzj3W6bPlaHwmvfXnCDZanHU84WXckH5PfyBcqBkFcCyJW74j3kTWp5PBBPHV+ld7dYT4rTrgrjVOATrIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765828228; c=relaxed/simple;
	bh=CaONE5bMxrglNeJycPZ/XbAfeMzn7r2HzqRHNVhzzVU=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=HdqaMfLdRo4pUWVuqANQ0xwC9XGq/JPCJhGzAhbN61n7r4qjpZn2ooeCyOsyQTpnWZ/QZ5pmBQeksqh1EhS0Pex4RFE+I7k0nakTXsa+H26tOcxESIdhazd5fwPlXcN9K7+LUzKQtWrnekWir1kgPL5mZSu5pGMkHysl+UKIV2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Dxp3HQ55; arc=none smtp.client-ip=167.89.101.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Dxp3HQ55"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=date:from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:date:from:subject:to;
	s=smtpapi; bh=VzHTFURO9EOGK0CHATUHKUYPfiau+jp7zHz53t/dLx0=;
	b=Dxp3HQ55m3lrkqh3qdOs/bPAqrUYpe92buT759WCUR5QrF3cbUMUeH0hX4hOqpWIcMtK
	D9UeU+2cNMDBb+FvzMPhaXbhSlo7We5RSNTZL+78oF8WgzXndg9R1HIZUVLWuEOuyr3lRs
	HkwzD4GR6hdObRi+oxQOQgVDjyl4dh0D8=
Received: by recvd-8dbc85b79-2fmf9 with SMTP id recvd-8dbc85b79-2fmf9-1-69406681-36
	2025-12-15 19:50:25.604292853 +0000 UTC m=+2406295.615313812
Received: from out-18.smtp.github.com (unknown)
	by geopod-ismtpd-32 (SG)
	with ESMTP id E9jQxds8SP2nxlo0w-YaqQ
	for <linux-bluetooth@vger.kernel.org>;
	Mon, 15 Dec 2025 19:50:25.584 +0000 (UTC)
Received: from github.com (hubbernetes-node-9f5cf0e.va3-iad.github.net [10.51.97.32])
	by smtp.github.com (Postfix) with ESMTPA id 44ADCE076D
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 11:50:19 -0800 (PST)
Date: Mon, 15 Dec 2025 19:50:25 +0000 (UTC)
From: BluezTestBot <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/1033107/8f3f8b-000000@github.com>
Subject: [bluez/bluez]
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
X-SG-EID: 
 =?us-ascii?Q?u001=2EyVDaIUJfOTIVaBYkJvNzXFDwUvSfXABmYIMG7o2yQ0XjHiQN8HeKlKfUQ?=
 =?us-ascii?Q?+TD5y9uUDiSc3WCQ=2FbFOxbFL1vD44A4NnHkC6UT?=
 =?us-ascii?Q?+hIar1=2FkWa2hE+6C4HqmykH8nqxCxmIkktW3z8E?=
 =?us-ascii?Q?XYsGo5PfKTCY8C6BmlL5dUEK8Fan5xWxNCZ7r=2Fs?=
 =?us-ascii?Q?JH0Kfm9f=2Fx1KwsDOpxuRn5T6ifV+q0L5LjYGz=2Fv?=
 =?us-ascii?Q?DftNiNL+14vvgantd3ID0Ul35F95KGX0QwhK+KA?= =?us-ascii?Q?Jt24?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/1033107
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
