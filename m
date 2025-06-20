Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1A51FDA6D
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 21:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750454349; cv=none; b=tpKn75i2nn+eLs/dWAAxkVd6nhKIBUN30DcafBfTypUutaDBBGRCrq9lDvZb4IVqsJiibZ7AAgEajgW7PVQCAD91m6IjiP5wktpmrlh9K8ZvQwdNhZFp5JsdamnmbE0ULk/1NlkDiyppeORssxcNTDy6TvM+MeRX8Y/eeq0Cgyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750454349; c=relaxed/simple;
	bh=EOnqZRuMeQYEWc4iHzd3dtxprc+GKNGkFcmAG64cAPg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=quxeF1xQwI1OvJVyYOMijwwPNp7QQO95wF96hUMaQz7AiWm2gASaBd7wSwnNgrsUqu798OLxg9viLJD4YHcgF8X1GNXM/ebsnwfUAA3O2T0H+NcxQhif8LzIMWfGvLEgESLkoEwFZnKNC9Q0nYFRbz7n74DAjSBsxnVvAZCbvH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=H9nacr6H; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="H9nacr6H"
Received: from github.com (hubbernetes-node-34c8121.va3-iad.github.net [10.48.143.35])
	by smtp.github.com (Postfix) with ESMTPA id E09C94E0A1A
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 14:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750454346;
	bh=lYqwgcFmeJmoIPAP8u51apkKfwiypZ3EIaxr2iyE+AI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=H9nacr6HTVh6Lxr1nNfxIcB+mIBiKOoquk1WEZ7nob1HmaLKhdYIwXvlrhb9uXzaV
	 UCJv9jdQoTkQlVSxUdCrHtlIev1Bgy6N+Hl/6Ds19eWjdcLxnnjEgOAxH8gkm1uWpu
	 h9aC6ggxhfs0BB8ot+30MPETyzADo47R8CuiYM4o=
Date: Fri, 20 Jun 2025 14:19:06 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/974407/e4df1f-000000@github.com>
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

  Branch: refs/heads/974407
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
