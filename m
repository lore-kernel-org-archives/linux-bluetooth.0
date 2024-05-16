Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADA61392
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 22:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715898965; cv=none; b=OhBlQT+l+Cq6Ly30CRrtt46QY1tP3ejJzA+ZFCmsHsUM8lk7zuJzT1qqv0NAozMXwMSXxEbun6afAknbVqqotPzNPYJTznxJEpc4UEpgOrqkwC18UFJG6DuaTr1cGsR6XrLa0ZNjeqyyQWMQ6O18vctB27MHhrbMkDySI46IYgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715898965; c=relaxed/simple;
	bh=YH0u57DWcv0maVtl4JQ+ulDs8omC3wDu7mXjMTtJI3I=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=QNdg+es6MDV4LmZB84zrcNIHoJsujqh6mhIVR6qQH0vLY6AVizZcHRmoMDW9WY5PbsGm/rw7yidVxg8B47IIsVU2EK4IyLthSkTjpKm6UFFfWin8uEeos4JxmcSxPddcWGhz4f5gjnCZkt2P8GI+iik9+N4H9UPhI6sm9wsbbUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=OE9EjDTB; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="OE9EjDTB"
Received: from github.com (hubbernetes-node-491a198.ash1-iad.github.net [10.56.130.36])
	by smtp.github.com (Postfix) with ESMTPA id 514C114108B
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 15:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1715898963;
	bh=+d6C3oWwok3OEOmB4s6vJ22RCtBkRpfqOHQdS5gYkuU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=OE9EjDTBDbeSvNQyx4rs/7CXfncIylJ8H6lRr8Lpzk5+T92uAFyQ3ghFfnYADDpou
	 A84IC9/RtPZgz64jdR6a8XvTGStH1Wgls8om/reunIeEdlSp2aGVJwNTukIksZWiH2
	 gZ41XpFQrzZJ0U1KddDbNteW0T82UK9eFLApABK4=
Date: Thu, 16 May 2024 15:36:03 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/tags/5.76/000000-36c2a2@github.com>
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

  Branch: refs/tags/5.76
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
