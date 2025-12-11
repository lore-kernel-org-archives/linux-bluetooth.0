Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2B931AA93
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765475852; cv=none; b=nSS7ONb9E+kCbc6We79VqxtRTjmYPMux0v6nVdZoqveH26TwbHLAuuJOvLqeYDqqig+QwaGkkleW0ZzSzMrBGsKATzpt8guzatv7cOqj5UoXgBcboHjN9PEjTSco8j5rcROY2E+1O2vaDCF/N9pT3Dts5AQjavs8O9HrYK2si3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765475852; c=relaxed/simple;
	bh=zCwQooVGEXq1LepOgQRKVw4pnSnUNwS6sNBQKW8A2g8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Of++9HMG7XmRiqV3MndOeWC6GN7wmI2sSpx8dgJmvVnk59dK6+qGbUJE0n/iGGK0Vri7yLRGk6kzDHMD1nsdivgTQkab65hlVwceBWfDO3WCcIcT5LI0xnCxnifwXcctdH1qdT5oNSoKEWyKwZi19BGzU3hKyla9k7DoBNhpNZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=V9yVdM8Z; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="V9yVdM8Z"
Received: from github.com (hubbernetes-node-92ac431.ac4-iad.github.net [10.52.173.51])
	by smtp.github.com (Postfix) with ESMTPA id 8457040107F
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 09:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765475850;
	bh=g9JB1xaKQGzWMRX1GLIFutZFcbZvlMZlHQ/F8AqHreo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=V9yVdM8Z4A8e4Loh7FjfUhG0A4gZgrMcS9Ddtljrt6X6w0rnsE9Z6dz8uDz5xMdzn
	 PHWLdoa2WcBEGAVx/3PVPfhcf0P1qnG544AkGu9ptUhuZIlfBAZ4fklo+F9yrmVclx
	 wFlVKXEJ4G+VNqBb3fzbX/k7TYqm0+UUP6em5vWU=
Date: Thu, 11 Dec 2025 09:57:30 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1032100/654498-000000@github.com>
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

  Branch: refs/heads/1032100
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
