Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7686B47ACE4
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Aug 2026 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785943525; cv=none; b=Ui7OYPPn79zVkIWeTXAcSMpcocZPYg6l5xTZa1y2l4nd5kw36JrvEp1BScBRuucKrheROYP6dRJLB3dhvj5fpOlW4BdTAJym3RUY9m/2Ig8+sh5qFG1cwutrtpUdLnrR8xvHJIRRn6tOtzNjN7QAh39MT7lL1oduCKN3T1yhlNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785943525; c=relaxed/simple;
	bh=FHmwCbvcfzgC6ktCxiQ+oQIIe2vkN4p7sazEzaWwXu0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Vqnefk0A8f/uab2GUsFyLzUeviFHpDXS3XJtM2qqDkLc7vlsKcKo/SV4drhB/7vFRHzRsIjefwKuoIIhq8/hb6X1ZAboiV6WErO1Udpw8J8XKJH3CNi8r9hbsyuOM0LwRgxNVHXFVP1d0ezNRTd3Ih5/Kwykx4BkWcuDxWuOIXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FSNjmZLz; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FSNjmZLz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785943512;
	bh=9s6gkZWSk3jmbwsmdipvgvCn9NsAfNxfYzIXdEta4lk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FSNjmZLz47vQ+MvVwhTW7p8OJzT+PHwQVwTUtbVM7E3BrlsEa3AQaA/w39U64xb/Z
	 qZjciioJUi43pxRvqB175ih1fga9fktNXj0XEIEwf4iZQ795JZnXu4139tY6z/ugHH
	 UvG8alT+cqHinBVHgGTq/eypvVNC85e/eJmRyiIE=
Received: from github.com (hubbernetes-node-76b9019.va3-iad.github.net [10.48.70.94])
	by smtp.github.com (Postfix) with ESMTPA id 3763D181028
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Aug 2026 08:25:12 -0700 (PDT)
Date: Wed, 05 Aug 2026 08:25:12 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1140838/000000-b24d0e@github.com>
Subject: [bluez/bluez] b24d0e: unit: Add test for sdp_xml_parse_record()
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

  Branch: refs/heads/1140838
  Home:   https://github.com/bluez/bluez
  Commit: b24d0efdc9aa823d207b694eb8568b04633520b9
      https://github.com/bluez/bluez/commit/b24d0efdc9aa823d207b694eb8568b04633520b9
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-05 (Wed, 05 Aug 2026)

  Changed paths:
    M Makefile.am
    A unit/sdp-xml/Bluetooth_HID-sdp_record.xml
    A unit/sdp-xml/qt-SerialPortSDPRecord.xml
    A unit/test-sdp-xml.c

  Log Message:
  -----------
  unit: Add test for sdp_xml_parse_record()

This adds 2 example XML files from other repositories, under a fair use
license exception.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
