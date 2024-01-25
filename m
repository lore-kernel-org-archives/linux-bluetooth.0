Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92FD745F9
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 20:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706215008; cv=none; b=AnkEi9KYSmZTQZ/lSpi89SLZ2EoiV+cm1TWdyfnHhTE2P6GT5FltxHaAQ1KarWu4Ng7oTmhdrXy61myCzz/gEv1ErgOK86VqEOoblwAJjG7i9kowemYgEU5g6GYvTNQmYrwZ4uIysBHbw2KcTB6FgA5jiuBsecdmP9OvP3RkFC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706215008; c=relaxed/simple;
	bh=fJKjvCw/7Q+cwzG4Za/p5eDjYfUOppyiMQFxQwc+SIA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uRAtsUZk025VW4SuxYAAzEAbKqY8wHY0DYzuQXQEw825ETU+iiTgi7D4lKU8/G15aFZ1sFqEZCxSp79Au/PIoDhQERJWkIU2U3yNMtz6PU09VX+lY5q73gLhwAZMkFdIWTgubRq/bAPi90bxkhNE1hQy76ghN/e6mvBlPeUfyaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TV0sS55a; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TV0sS55a"
Received: from github.com (hubbernetes-node-50bb8f4.ac4-iad.github.net [10.52.138.36])
	by smtp.github.com (Postfix) with ESMTPA id C32776410F2
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 12:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1706215005;
	bh=XY/zle35mwwkzRfzWhiP0cuB7y+PuY7xf23mjj2Jjco=;
	h=Date:From:To:Subject:From;
	b=TV0sS55arAHNQqdtpivIHK3mseUWeTD08wNOD1m3SWa6Cn+SLisXZ3NL6Cv9X3FD1
	 cxxx/BuM1uWhON6VTkA6uByYjDtP7/OkZPZRUk3r9/nl0vBtpcALGHafHgbfa7nBRC
	 cMbBKp4eXUEvVvjuZ1/JZoENE9mtXGvqbI3mMj9w=
Date: Thu, 25 Jan 2024 12:36:45 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/1cd6c8-d39719@github.com>
Subject: [bluez/bluez] d39719: bap: Fix crash when attempting to set device as
 co...
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
  Commit: d3971990d9268afd3628996876c756bf15849c56
      https://github.com/bluez/bluez/commit/d3971990d9268afd3628996876c756bf15849c56
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-01-25 (Thu, 25 Jan 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix crash when attempting to set device as connectable

Broadcast source endpoints don't have a device object.


