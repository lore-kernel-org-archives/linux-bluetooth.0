Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7375729BDB3
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Nov 2025 14:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736653; cv=none; b=oKyt0oEfQNNrRf/P4gP2ReT4LIFUwofNGZvV/Addw96T0qdhM5a0L66eI6/HXshpIJ/JZlpV4m5Yij28lJIyQxD9ifGJIGF2QqOO3SnjG6DzTvTeUO2eOZFxu2G+cJpepclUAclF47dnliREDUHX9soWwPJMvj0HOCUtFDo8mHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736653; c=relaxed/simple;
	bh=eFXsCYApiGfeLJSeRA1qkW2fU6wzFYxIQ2Ln/6SWXtg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=tWgeyolQ8JSt0ohzgY3h0OOViuuJ0kYvdvexr7Quj2agGBXJY+RWsonqHe+5t80a7ZXiAXrIIBEBODNJhXRlk9ItUfE9/6H4ZuKq/GUSoCqRBAMDHlXXan7/BCxCTF+bYHl8JSeTAnSP20BPPZd7baL5elIFmilDs3VpPmOkyIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IPVzXEti; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IPVzXEti"
Received: from github.com (hubbernetes-node-6086f23.ac4-iad.github.net [10.52.180.32])
	by smtp.github.com (Postfix) with ESMTPA id 77340641079
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Nov 2025 06:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763736650;
	bh=d6D+/TfEVAy44cAfd1sepNZr0RMjW47oTXWWvFvekic=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IPVzXEtik/TG7P/JpPcZsvzGdu25LOb5yRkJNoFbx8g+kODnZtqpYkwbtWlyjA0hr
	 YvO63fjvczz6ymRQ1GgS077NZUCuLKR1AJif2207Bvz5ohn5/UuEv2nal1IvD5LOBE
	 zp3qPavUC+fVRnTcOZZT9oMFwRPhPY5Sdmc75Hfs=
Date: Fri, 21 Nov 2025 06:50:50 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/tags/5.85/000000-a29922@github.com>
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

  Branch: refs/tags/5.85
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
