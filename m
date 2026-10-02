Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E7747533D
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 11:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790940041; cv=none; b=qHEJNpHqo+sol/Q+Cc+dZv+jnhjHtmJ0tJb0vCKbkspCSutQkNof4Nxadz6fij8r6O+V4xgggb8T/1uzDdn8Y/jsAO4SRJWnmqumFgv351JaFX5Z/nQREREFgEyTGoni48dy1oIG2vJNnUN8pJZc9QvgSLnK6FDAA7hzC0eeT/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790940041; c=relaxed/simple;
	bh=5cqxFBsFxe4b2zObbCjrV+D8H465PHrbcFhTY/Zklek=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YOY7oeT4fOYRAjnGpj6lJQGb2xRQlTMz3FU3VqMbqAhEBNMQCH176uF67dXqVDqC73uYmoH8ikibMRiU67C8NFdGGQCZl4BTPeuDfebL1CawTDhrwg3ahGZZ47Q+oN+0vuJpcTfi9paITxM7r5/lOZVJlTj5CNRBVTbHiTvGKPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=mpU9rQfv; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="mpU9rQfv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1790940039;
	bh=E4umNAqttB+yIwZB8pd/OWW5U6BuaQwovn7Vd6a9Hsc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mpU9rQfv/0feMYl4WtTK80nTgUfSQfpCnwWTJXdlXgeWu0yzgXkJ74VVuJiAxaPeN
	 f1aa2jFC6MWR68EaumQBIViZmYf47LBIL2OItH3eunV4uH2UGJhQA8wF8CVclRqz0/
	 +CI6GMLG0/ehID8lfMlM1SEeK/HcTwLDYXSVktcen8yAkdh+e5aFsA6FBEoowORoPe
	 CF6hyaBbfFbW0QfsC6MW6bdkSqfjEFhh2oxu5k+Q4XfcF8t9wIpsbKWpq3oMXfRtqI
	 caYNTaRRrgzDWfAMfmbeHIaRpQgTuRFlc1CPvn6vHJtCVlusSx/wwxUApQQ0HGC7Nb
	 k/jqewmdkV5lQ==
Received: from github.com (hubbernetes-node-e5c78d5.ac4-iad.github.net [10.52.201.60])
	by smtp.github.com (Postfix) with ESMTPA id 3EE63940CC9
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 04:20:39 -0700 (PDT)
Date: Fri, 02 Oct 2026 04:20:39 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1175652/3ea197-000000@github.com>
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

  Branch: refs/heads/1175652
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
