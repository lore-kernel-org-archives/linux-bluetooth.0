Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA7921CC71
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764686488; cv=none; b=sLoFdZh6SHOFyPkRo2zRqJ//ekdrMZNabAv+vXqqozmq9wFOg9A/oAYX+VWXzAN/DTJIPSa+6mnmpvq6gLDeXNSQPGpDanTgmL/nxxD9N4XU88fWW1i5wwEgc09FaoQsa/2wkG0ggXkMUUfPN5bLesHYItS96GK6XKUcTVGTqgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764686488; c=relaxed/simple;
	bh=rqWd2pxJ5Le4269Xxydc9EoIbr3/bt/4rYPKHrwc570=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WSor/WTvEXbPsyI1GVKgbaCkqHSGMNjjWSdLr2BxCH8XC1WVYcgqebmY+wSkKrrVlBNqXURBSo+UUJcVScJvKWZu7tDioaPWZbeVWXmC1+z5GRk3AEX9H1GMJJhklIjSWniXMZzR+1LCcpq3BppqfrwlzS/1xLKeLJBzSUANMT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BN2Zr76e; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BN2Zr76e"
Received: from github.com (hubbernetes-node-cc418d2.ac4-iad.github.net [10.52.205.63])
	by smtp.github.com (Postfix) with ESMTPA id 45F3B401240
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 06:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764686486;
	bh=MR+wQ4tCI9X8nDHTV7JOP6jKLh0rEkGXPyuByg2gcwM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BN2Zr76eqrvJIR4J1jkdmvCx7Te1oQ3RSjUmLMhypNMBGsu6nGT3yYAZ/biS6QEk1
	 7vo4LTrcAt2bdPzvJ9baneFbcMDqpvoUauApt//8WRlXdG0h4VCshvpHA7Sw3BSc5/
	 bYoP+lRFf/XBpnA78FVt8G2IIOvyrado7HGvQJ6g=
Date: Tue, 02 Dec 2025 06:41:26 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1029386/50b506-000000@github.com>
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

  Branch: refs/heads/1029386
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
