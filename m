Received: from out-37.smtp.github.com (out-37.smtp.github.com [192.30.252.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0054236AB5A
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 10:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784026703; cv=none; b=fMpH7pkVPBhZGeWWwsrqDwv0Irk95Fw7fPAzXKPdbtV55dd6pv794Vw9/uQivqpKCA2s3w7ZdtO4pYiX+zUB1oHBs55vd4NZhivDgFyQkGZ/CSAOfSsN/CNV1dSheAR0h5b/UFLWWHpvCEj9CZPdcZdsPdUPPlHXluiN/M9GynQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784026703; c=relaxed/simple;
	bh=D+OLYuONPydbMo52US3lu/RNw1/+oYBfpQd1BwF187U=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=nwSB/SM1WUyCm7/6Kzteb6Kib8ECcIkWDjKnbs99BYgsh64lLjbLrNgybxE+iBWw6YP2YicJGnYoxwDBkQPiXYwekR/gVoonUL2+gm5fDpjzZllpeLtRl87/6i9oWxBlIm67jqPj57+w2P17nuDrFU9KOKEhugMPBwr9pBpWlqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=A1ST6NcX; arc=none smtp.client-ip=192.30.252.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="A1ST6NcX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784026701;
	bh=BSv+BOMpMWIzfVAJ1d2AVYhYWOd/HXrpdAO9+jRXMhw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=A1ST6NcXkeBz0Dlto/kTPK5DAZyvKHL6Bu4qYSUfUXEKdMcnkLt+cXOeSy6BMR0nQ
	 IOzJMhyc25y1vv54h7yd+sK2gC5TaYkS5IPa5R3KicHHvHxvx5vykSo3sA1Akw2cRt
	 oJT+Vk10ovRmOPunJvfB9JwiZ0OZoiRhr6Y4vX/U=
Received: from github.com (hubbernetes-node-902a3e8.ash1-iad.github.net [10.56.146.23])
	by smtp.github.com (Postfix) with ESMTPA id 0F5399211F2
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 03:58:21 -0700 (PDT)
Date: Tue, 14 Jul 2026 03:58:21 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1127225/454ff2-000000@github.com>
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

  Branch: refs/heads/1127225
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
