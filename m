Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A75447ACF9
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 11:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787310113; cv=none; b=O7gpeaVuG/12/KS65RY3mwyZhZyWd9GnMnrpOq+VgayOhrhDXc2dxb7Z5DcWHneKYxguftU2cuqQu7z6Nw5wIQ7ZgXVTKlfQo0B43iNbtZSZp6B/TbC8TB9K//s6Bge/KQ+ZluuvBSpJ7galKdaKlB4YoJeleKMR38FQ654kWbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787310113; c=relaxed/simple;
	bh=tHcJLysDAFh3Y6+uBQOgCrvYmfO4+5l9UL/oAc8RpXc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JH2kksPbWDg62nsbw1uhgQsiENTWq0ptsA/+T6uY3rhkG1pImNOHqkZFETB8zTHTMHYt+CbWcVr7xrf2DM51yooeY9aOh+KOmlcedslsbUm4Iimzabp4WI1OTiri1UrcIWYTrp3tVRzXz44iv8rCSEdpRfu4Sy7vDFZ6wg5LphA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XGl7ZxDv; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XGl7ZxDv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787310111;
	bh=ECFfCj0LLXjwliqE1GI7NEfk1Yj7UdYRdgV+LDcrzb4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XGl7ZxDvjTx7NcMQGNJFVItbA5QgFb4DeM18dIcTHry5YkVErB4rBydko9WGZg2Ad
	 mQyc/u1KdOi1ulbQpzMxu98uBuyeAYm0gCmB9NGR3mG3lVKDF0KlvBsKxCIHLIMrQ5
	 jy2zM+2/lkybelJ3krBJUiIS7Yg6OQVYRwrTZQe0=
Received: from github.com (hubbernetes-node-ba48795.va3-iad.github.net [10.48.160.23])
	by smtp.github.com (Postfix) with ESMTPA id 555FD80066B
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 04:01:51 -0700 (PDT)
Date: Fri, 21 Aug 2026 04:01:51 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1149533/ce02cc-000000@github.com>
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

  Branch: refs/heads/1149533
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
