Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956C92FE591
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Mar 2026 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643695; cv=none; b=Xw5R6qB1euhUly5vHyuhdekHV2+Gt5pJkUm3b8IK2rD2SVhfD/SX9x7FEf/f9dRt2yebDrRERK2KcMZXc2sP8qfH4j4tNr+S+tPSx3+SjjEuzCgdDxsSGWe4RrlVyMtb3CATCz6UgGIPYxWQB0TJRaY1zqHR4aNxcVF0hURYJxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643695; c=relaxed/simple;
	bh=psxwwCUOge7BG2TFjW2ypf0OyO41pqCIB0TtVvKKuB0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=SO6PajXtvDc445lCgWiNYph4VxKPB9vkXeFsIoraTKAE5qiFYazYg0aPfys1DkxHZEwmqXA/JTwMsCO/gqn+cgbqsdZj2/q08buVYK7SfYNum9ThjiqXeVS9x5Bb8rhNajB5wygH6XfY5vylgpyNuBQffiWCMfgeA/C5Atrej6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QsuJ2FnB; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QsuJ2FnB"
Received: from github.com (hubbernetes-node-59f398f.ash1-iad.github.net [10.56.203.119])
	by smtp.github.com (Postfix) with ESMTPA id B99BF6011E8
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Mar 2026 09:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1772643693;
	bh=2jVWFgonMieGPMZk8gSDmYwCYPSsuhP+efWoy98FEIU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QsuJ2FnB0u2IFBu3gQ5JVmeqUmMapFvY6s/Ccutm8TRTfa+n+7JO9w7eBvcnBJQRV
	 sHHPONkAO7VbeWm79ts2MH+KkiTjH0QGPOAgOdp1zYiFwPvEWYozYUSO1w2W3onEbr
	 9QDsB7fuU3zZTWqLDiyIkB6/lOMoHo9utrewqQHk=
Date: Wed, 04 Mar 2026 09:01:33 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1049845/cef822-000000@github.com>
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

  Branch: refs/heads/1049845
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
