Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB502E7BCE
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 Aug 2025 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756587610; cv=none; b=ZIj/C1Y84RMYhZ83hcaM8g5T8/eXqKrtipvk5zbjLfB+HVSTthup/CTI0xeEQ3S4cIMsKoTfE/+W07uvPI+NeQD48o0tyuajDHOlHJFmjIOJcTI9VVeBTeHHpdOsbRpptOuMmkhIzYu+cPjZK5y1QmuzwAfo5qYeUIRbRjZQ8QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756587610; c=relaxed/simple;
	bh=l8Xlr2vn7NHo2eCl+H23/mXxufmIWAEopf2i9ATXuzI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=etvp7y9SYqYjHFiiIQsSzjkZCDLsbFKhpsx1KD/xCSQ2p2RgdkrvQGJtXsXTgrYKuljjdgTngnBttUTgoTvYFo3Bs9PptjyqsNIBif9zbPxCJQZ+hqzUAU78JKd7CxQ4+gFNpqUeZt9NEqWWxuW+6o5rhnEulIT89S8ZV43pgek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hchNu38d; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hchNu38d"
Received: from github.com (hubbernetes-node-1662fb4.ac4-iad.github.net [10.52.223.29])
	by smtp.github.com (Postfix) with ESMTPA id C13F57002C8
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 Aug 2025 14:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1756587607;
	bh=soNOn10h+9WvCHDBW/36n5LGasnvld2N8l+K0fscha0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hchNu38dmrnxEjRknNxccTCqGwIHgxeCV/j//dQ0NenzSL3yxRd5CBRQv7ZCGH2v4
	 aq6LjNeaOwRcgUfhCFftY85u425RRE3f3D5OfW/+o/I5nxwbbKU33mOBvAxVvpGZw4
	 KPp/KFyWiB0b1j/zr76g3hmg3wBTrRa06V0HviUM=
Date: Sat, 30 Aug 2025 14:00:07 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/987469/b222f8-000000@github.com>
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

  Branch: refs/heads/987469
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
