Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A603921F3
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772823416; cv=none; b=rfr5p9Dte1wT3agkTjH3pcnr8CK1Z5VvlyOiRuAaZ3wWynNZZz1+UE6BesrSbLxIK9WOaNgB/gI/eFLPxbisbJc5sw+OVnJAHKb7rySKzARIaFZGmIYG7uhipjw6qk00NmP0S7BJkE06tY7AVNSX1NxmtHsGU7MmqvYEJdSOFoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772823416; c=relaxed/simple;
	bh=179dERlEfxltrUigfiR3LCZh61/XMSLzK/jhplMHFkA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PGSudQLDzyLITLMIMv8d52/u4Jd2EJmnSZwAV9aQfsr+eSKPkQSuEYDQtv9oFkvYutf2/q/nc3B9iDzOUrmI4oxXdeuxacuEmVPi6QeJwomKTdc92SAgmBM9N0wj83q0FNI+Z4UVzWmPTPU3UHVEFDOx9V9juUFmesEd0An98Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=c3eeo6et; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="c3eeo6et"
Received: from github.com (hubbernetes-node-22b4aba.va3-iad.github.net [10.48.179.57])
	by smtp.github.com (Postfix) with ESMTPA id 111A81C11E7
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 10:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1772823415;
	bh=qM5OMG8AobSv/Dc/F4+65FtlpbTzwwgqCkCwdGaRDu4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=c3eeo6et59aFIEOLjWprVnePAaDXuIeB8+OBIJSJikXzqQ1mucq4wRzOjx9nPrQZJ
	 jMyWQ21RxvE1AW8i7Tk1VYcakyHPYOvAFFtTfuBI3Cv1NUfaYbHQL2YfyBfI8S1Mx4
	 Tr85xvcJZNGGK+0B3abGEsL+GuEhAfFxa9dWtANo=
Date: Fri, 06 Mar 2026 10:56:55 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1062730/9cabd8-000000@github.com>
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

  Branch: refs/heads/1062730
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
