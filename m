Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0998E23CE
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 20:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746477221; cv=none; b=AwQ2mJ6WDBfMeEsqgZAvsvCxmPBuIIaIdpep5RZaKAvPqfgU9t4qCVRcnAHgoH/i8JQlDyqYpIL4Rbr1Ab9JvS+aTzWT045x1ind5LHi6/HAEAQGOS7qQbgc9mU4AkjMzUgNJfm86WsMVfxhKD/HQKJntOwsnnowxZCuJxtV7rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746477221; c=relaxed/simple;
	bh=NL0EjsK4EkXhbpeNOzJkGeS7FnKVYPZHK5ZMb6sTeDs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=QFXLDYf0Ysh1TqKmisnmkrLRLkiqbRav3MjHD0J2wSqUG3VdYrIlMbWQoa1FnJgiK0IClfR8Vq6AuAaEWr+5W94GptMyZK1G5IHDuj/EbSoe5Cf+UEkDHv6UbZ3IHsXWGlV9yJz6Y+i8apih3AE7CZZYNjAYG33vvolvC5/Emtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=khtuwFHY; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="khtuwFHY"
Received: from github.com (hubbernetes-node-f487a31.ash1-iad.github.net [10.56.211.37])
	by smtp.github.com (Postfix) with ESMTPA id 1A17E921363
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 13:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746477219;
	bh=Kjt4bRSnhKyQ7WtIhVYPGdWKRNygvNjNZ6Td7Wzx44g=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=khtuwFHYJRuUujOpR1J/QQUHLCTLO0xJ7iFRiqj0FdwkxbjKsHDgZanXt/g0Fzq4W
	 GoPN9M4Dh2ziM0fzKjpMdNT8GN8J/1ffghhtzqXneZ7UccXnk9iT1QTvi93eicf8Et
	 Bs49xDf813c2tMgfO9WxlcetsVmELkLef3ruuDMA=
Date: Mon, 05 May 2025 13:33:39 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/959149/571b64-000000@github.com>
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

  Branch: refs/heads/959149
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
