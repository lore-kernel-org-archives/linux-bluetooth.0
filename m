Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEBF346E56
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 05:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776318714; cv=none; b=j4wBs+3Sf/5AXm3h5BRb9gDG28SW5Hanf4c7/LGWa69nQqw5Kp3184smyXY1gkyMKqAuEwvDjvFyNLuOc1exaEw5PNSQ9H9t0a1p/pycfbusRZkzWBwaQHupHkCvX/y4Ye7eqfwk8zcYDfCSpGdJhEv3yOHF4FLQ0mTivkOT45U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776318714; c=relaxed/simple;
	bh=g0nbspvoijTJic5YNYHVCQttTS57N9jppGesZtKGCbA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=SyFFGWgtRXXdpeFq9r5Zuq18HMqBnUCxLPEc1+zG0Q6E5WJk8YAfeEQ3UZ+AiBriGMLCMYCYvAeRQp+ocv7Tt2VhhwexRV9Dr0lFUz2q1E5b5CDOL89UrYpuSXg7iLDKVb09B1RRJogLvu2zftS4EFjbiL3G8xCowwsEbujHa68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RQjojkPR; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RQjojkPR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776318712;
	bh=K4+tnq0bhSRgO5s8hneiDFNHQ6vlpCCLYDg+4OPYhKQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RQjojkPR/XJNFniX9niiC/zmLcIVOWwXv8YsBPJqUNiAE84cCmMEzG88Jn7IuEWtF
	 ScMhLdJ4P3KDEgqt7KCD+oQW8xKEKGYs/uIBcExySAlJ8AirJV12K5IVyJacdE5dDH
	 C59hn8vFjRZkjF1jSeROBn/PVFToJicmscpVxStY=
Received: from github.com (hubbernetes-node-a3b4a53.ash1-iad.github.net [10.56.212.97])
	by smtp.github.com (Postfix) with ESMTPA id 3E9FB36102C
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 22:51:52 -0700 (PDT)
Date: Wed, 15 Apr 2026 22:51:52 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1081201/7f151a-000000@github.com>
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

  Branch: refs/heads/1081201
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
