Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FDF3DEFFB
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 08:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785139634; cv=none; b=eN2LDA5cWU2zJQdfNY+v17EDyf6SDPwaip6ZXuoQabfflnZkbFV/5Z8dnKK8xsMgxyHsXI2m/BhYp/RNw71ot7QYok00IGx1DiVlrWXXFHimjr1RIh1q7dffRXrHnI7qxEjmAefAIh6qjeJhlPY9cI1eHWD4zYKMaY8ezBQ1HGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785139634; c=relaxed/simple;
	bh=u95BFKn8W9bWGIELdOrsYFRoWt23MW7XaPhzJ7aJhq4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Eqsk6xSrgrUA776qgBiZ0HEtSj2jruCkQj/MASkJDvpSGUASzDnjFzTi+Y3TpblhcoB36jxQX06j93KmWdpZ7hLmxNW5MiMyFugY8iinbrT1AC/IZuvLZzAEF1LWBpXXkoyHm3cFwUpfPbyl4OX+toO6TMNQUQcjh19zqtOWdr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XXQDgQCT; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XXQDgQCT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785139632;
	bh=ES6oYkDRRL5JAA/bcgMoPkrJYM9egpmdKzMI/nQdv2I=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XXQDgQCTVbCV6YpprBj0SzBFhYOsz6a3Vcc/HRrr8uOHUhdkA0iUMOYEydFNcQsdx
	 n3g/n0xfK1Rig2Fs209sUgJ7dxso6/N17GPs4t+8D9tjw1zzLnrlG0466vEICmI+yI
	 jKRPF26B70c/mR8jcuip4ABM5AZD7XpXGsbun5II=
Received: from github.com (hubbernetes-node-18c7c17.ash1-iad.github.net [10.56.128.31])
	by smtp.github.com (Postfix) with ESMTPA id 2EE16368115
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 01:07:12 -0700 (PDT)
Date: Mon, 27 Jul 2026 01:07:12 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1131452/a12498-000000@github.com>
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

  Branch: refs/heads/1131452
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
