Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28E217A317
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591232; cv=none; b=Wv4Odsh3ek9Y3t2N0cedaRhF6yg7ZTF23frHiNTca0NPBBYm8vmrO1nhUBzsgNXJT64+wLkEpTwUDP1BllNUkkb2fUk7PQSUOxwX1Fk0R5Sd317fviZJhYcewOyIhtDnOAotfB9YuVgHtM9hqP3+aI/gBTcB+3mRryT6b6dQZQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591232; c=relaxed/simple;
	bh=qOLCcg/chs+iUTHiI1kLdAoGLCELepFWgUBccHg/FNw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=koF6ZgamzvO7DF/CDEZKs5FgRBMoDcD00OMM14sKWC0rdX0PuoC5yU5wFqp2ssPxX3q/Tn5pmYV6QuLQ0I+zchGGsc8B5TgSivXfMqfcKKll2bN1gBsl365rR42VqLSmWFnhswNeX8sjm7riJ2n70c4Meigg+PbrUQiMRyDkfbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FsgzbqD9; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FsgzbqD9"
Received: from github.com (hubbernetes-node-be0fbbe.va3-iad.github.net [10.48.174.42])
	by smtp.github.com (Postfix) with ESMTPA id F35E8E146D
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 07:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752591230;
	bh=sXFzzMiyKKfAfaHgupBO0SYXoPPOCs5SBxBFgKy/gvk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FsgzbqD9T7kHSZN7oHp2hSqnQzYolWt8+l/vDWdiC5eZHtDU7oNim4H5cK5LmfCpZ
	 wyAGn9/yBNx4438JX0reFfQ7MG0WqxMgpa3ygh8Hjh2Pl+HLXhrCCZc6Q2S8OHq8c+
	 Fv317IOZGcz0P7Bk1r+qpsb88clHpQDE7HxlIwW4=
Date: Tue, 15 Jul 2025 07:53:49 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/982465/e4f87a-000000@github.com>
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

  Branch: refs/heads/982465
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
