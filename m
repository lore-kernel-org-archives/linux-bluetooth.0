Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE8F1F3BAB
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755011632; cv=none; b=gspJc/K4aF35TAniMpzpIZ2HNlSeIav3n6E4C1jphwOJhtkNaGYOgQbnvfryHMntuvFN39J4Cux51CmaINU4lnsIAc/roodK85muYyj+OsSBZfLyDPwqDvzHAxJcCogSMFccQIbn0TPOxPd2ADS0e0VGWIC+6fxTCwc9RuzZTaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755011632; c=relaxed/simple;
	bh=MCUuY8O0piLnu/lrBBdq/B51PBUS3qD7ZUzlM6zBN6E=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=FCtofr0d8UmR9GtiwiWEMEp6cGkhdpshSgXc+stkGKJhkNNybaBIRU55rmyLogpd8z3YtkzOEvPnx9CX5iItvJ2weM0yRQi9ihbUFbqtoQKAH3biKghmhIw0NYKBp2KWupG3eTWMpwNxQmpQr8Nb+682H4HkcdQz+66QNJxCNiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MjbrcVKh; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MjbrcVKh"
Received: from github.com (hubbernetes-node-eb613de.ac4-iad.github.net [10.52.146.37])
	by smtp.github.com (Postfix) with ESMTPA id A680F2145E
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Aug 2025 08:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755011630;
	bh=TVKa5t3tUO9DV+9lBy1ws0s/gP4nNq3EkxtFm465nGQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MjbrcVKhWpcBmk7r/72gjhCWrjnIQE8Yxv05d2RiGSUqlTBYNGH1TZReBhXTkak2E
	 cqFHmmCnQMzbcMRTUY2HdM34YAP3/taMJrbQxw3BQ3/cjop9nhbLbO5J4khAhvo1Ru
	 odIESjwu5sDjMaDPgKLAR/Xuk5DPeDB/L37l4IGk=
Date: Tue, 12 Aug 2025 08:13:50 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/989478/d61530-000000@github.com>
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

  Branch: refs/heads/989478
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
