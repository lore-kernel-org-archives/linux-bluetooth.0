Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1566272816
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 20:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548966; cv=none; b=BYbE/WhusxcmNgzpM6dVEOm14Uix+vG0iZr0YEr1LQGqEWpRU4YcXTrMse+C8quzggUuKzP/DJQqX2qgMf5+fFBIuLwoTJf9u4IjjHbq1yTwL4SEsopeeRGtHwe6QBFvsJHnyBrBM5IAnwsgFMJqXtd80EDdkT+uGXdcJJ0aKtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548966; c=relaxed/simple;
	bh=YLKPeMWXPuWp9yoYeUim3mKP1qBaLXuqhvomnWdAWwU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Ps67i8ma0O8HOonKUtX+2xce4OUggZLjtH74jYQGhYn4cqws8Tm/xf/2BSD4GsCL3wjSndgQ8ApR7sg40nbEH+v0Bj7r1LB6KNedd9EdqX72QhFj+i46CeJiHjkR/KqoVcjjbmjOhAtmzNPDuvNrPI5bOyMh/Am4yn9fV1OSe8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IzNdM9qu; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IzNdM9qu"
Received: from github.com (hubbernetes-node-22889b5.ac4-iad.github.net [10.52.135.25])
	by smtp.github.com (Postfix) with ESMTPA id C0FFE640D50
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 12:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762548964;
	bh=Tty2H056cUSPcazEvjQOZWwnn6Zc0dirQDRb07yBg0U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IzNdM9quXp9MBkAe1HywLup57TdT2IAiW3KD8+7n4L/0E8m73UzYyDR/ajhJNjoIN
	 qndKZ/hVofcarQ6WUaSWOkeIdHFzRNY+27YM0TfemP5uIkZDaE7/ozAi+WQaQEAeLj
	 5MWSbackr/eCSkmnvJzPSVM1sMDQJO2dVwUlZKXA=
Date: Fri, 07 Nov 2025 12:56:04 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1021045/25ede9-000000@github.com>
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

  Branch: refs/heads/1021045
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
