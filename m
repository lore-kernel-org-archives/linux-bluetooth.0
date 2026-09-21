Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E0C38DC50
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 19:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018720; cv=none; b=LAFy6GAu49vo94iR+iaId0wFXb4SbvjsnXc1hsiBquycPG0AN4l882jnWZ5N+NLi947TOQkzbNYhQivMiq29LlSV0lPcYIK6ycxYlSzqH1MmxiiLFTGIriAJBvbtyBexQj8xB9F4uhkznpzav+4m4wIkxE8twxSC01GGjX4NgWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018720; c=relaxed/simple;
	bh=1MHsYbEaYb1S1kRtZv4FHIXUtNhkfbDwbO8wSJWWfOQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pQxQQRRPNidpsntJrXjXmNGV/9/XEmTcoG5IeCM6pCBGVPLl7oG5UN8Yj5j4RfmwjbJsE2zdhj7agJ8c8gv1zVKk5icgdsXHpZmUVOJbMWwN71zr9LomwFO/t4pFBa1dMDzBp/TUYkePwHtdkvrZZR+xx+GEcKJfIT63YB6/1vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DvRub2DR; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DvRub2DR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1790018718;
	bh=bYA5Q5JjV8snRN3fV0IuBG4AxpwYPPQW/t7ytMDB+G8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DvRub2DR386eM59T/2GOIQ+yhgrvpsluHE7Pk+W+BcaFWyErwlIBXn2hvTbNunShC
	 4HMa59jUoAwAMHIdrcpY83OfKPIOvpOyYKo5bv5jKE/rx2Wer/9iVhQK4862dbrJug
	 u9fXIoL/9jHdAtNOzB8mSZEPtvsE9Wx7Ew77+R5U=
Received: from github.com (hubbernetes-node-7d6af1d.ash1-iad.github.net [10.56.157.33])
	by smtp.github.com (Postfix) with ESMTPA id 9677D520B66
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 12:25:18 -0700 (PDT)
Date: Mon, 21 Sep 2026 12:25:18 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1169029/bce86b-000000@github.com>
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

  Branch: refs/heads/1169029
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
