Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363DD1C54A2
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 May 2025 20:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746651220; cv=none; b=NLyqDQWQLrufMCfv5AYtaOI2/ahDy3SHk4rbtR2FcQCRODbxQqR8bYQ+s6DWrXmtJiNXBAqJ2F3EJio0UlVAjzOf0hkjY7ntfl/G8dtiUXHpxUp5Moy2wJZNFo6cTQMgCP1I/y8qS4jwWvnzsxt2RJ8lbYCd98g/Cf5el7/iNNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746651220; c=relaxed/simple;
	bh=2CvbpFMGwxNaggbx7YY0roXHYZIEa8E6ZTqx/Hapomg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=lvKkN6VqKdGg9/46YFvDP6DhnAdLUt0/FOuO5q2vBnR+epJQuvq9v+Cj6blbjT7zOe38umAEAcqNq4d7MAj/ZeyxnuvCTqw0C35snDpyV8iA5jzg5hlHgZP214T7gKFDG9W2WJGkck7I6ZRDQ1pk3wtCW0TAGDjo26KLgoaIByQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DLNfAQos; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DLNfAQos"
Received: from github.com (hubbernetes-node-bc9b7c8.ac4-iad.github.net [10.52.132.39])
	by smtp.github.com (Postfix) with ESMTPA id 38BB16406E2
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 May 2025 13:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746651218;
	bh=9WsLVzYx/8Xm1Op9oLbTxjcErRDANmmoFDqzGXip6k0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DLNfAQos+DeHPICvZLn+oadJdN88ExIEhTM/wsS4AaSVEpLwV1TNt2zCfrMuRwSvC
	 1ntH476DU2uDi9G4uF5/jE9ujwGW6iNZJLdSk7al0NH5p9//pvn+iTmcsKTpVbtGI5
	 RPWtv21uhO393S8xZNz9tjYKRuWFhrRqajH72Gwk=
Date: Wed, 07 May 2025 13:53:38 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/960563/c3d84e-000000@github.com>
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

  Branch: refs/heads/960563
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
