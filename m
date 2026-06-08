Received: from out-34.smtp.github.com (out-34.smtp.github.com [192.30.252.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6863E7BA4
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 19:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948241; cv=none; b=sCtqF3jAb4eIppxwJBcJL7A1mZg1z58dgZX5Jt67Juaw4P+daaSQR9Q4SVIt7JPd/wtRNsc+Kg+5sJ1aaSxEYY6UMN53rPeMq+tA0cm5wzThE4kIxG+IRmI/Ol6c71GAA24bdFJhUEOlLiM0eJXAeFSr+K/YdwI5kPegJDguTtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948241; c=relaxed/simple;
	bh=FMio9d9pGTQYnu7AnFuWcrvkxz6E/QMzmXMHxcXEj4M=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RimsBEqXJk3nR3dpgnCrOh0E1osols585jLQnDqgctz+HRYQuYg8Duvg//YnQbzqEIl/8sVukvH+Cjt3Kci2ilBimgSG5C0qUsZEugfNi/3cEnLFUmY+xeAU4F9AvAGr4NaoXJsGGwS/NB+h6n9vLWKbQ94Va0IlFtzxjzPH4R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DjZiTtNb; arc=none smtp.client-ip=192.30.252.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DjZiTtNb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780948239;
	bh=QM6G6m0fDwgUHrZ8wAtDyJaoHqwx1OsQERe9Gokb7Dk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DjZiTtNb1DHmQIMfJnnDE3ZIyN1B4tfB93FT8tKkckkL/2vBxft0uqt3OQ+tDC+5y
	 5mkFB3iNOwv8GH6pEBJzmkVuapH5Dgjeb5NUfwj3sPLexEO2RbJhqdUq16gufmmDil
	 MA7eov91s1cNgWtgv4FtQ5Fp4jurEah2D62QdyB8=
Received: from github.com (hubbernetes-node-af76b97.ac4-iad.github.net [10.52.183.54])
	by smtp.github.com (Postfix) with ESMTPA id 6125C741275
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 12:50:39 -0700 (PDT)
Date: Mon, 08 Jun 2026 12:50:39 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1107813/3c59a0-000000@github.com>
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

  Branch: refs/heads/1107813
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
