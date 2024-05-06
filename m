Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A001614EC4C
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 May 2024 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715006031; cv=none; b=i1vOdXJ/P5kel1umi2YJ9BQi3JsLPymCMOAvVfW8vjQJn06PPqZONeCh/5YHTNTgxOEOC8afOBCL0Jl9fO5cToFQEjYvLw3GepDNlSie3roWMCoquiOzqgefdo/Dch1Y1u904ETM77vSti3hbFSazDeQwSFm63hy9IvWymX0ZDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715006031; c=relaxed/simple;
	bh=mM3QrNL1UvGn4OMguEoUSB6GWFt2EJPcFi0XGq7UoME=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=W1HmyPHQdQs49HbiruFdDpkYr3IWkVZDKzFhEIcAXF3q+mKT3G7hHRbjuvofzUjF/U2n/Cj1HFedDTOfyUeKJIuz2fCP6rMMYk1gTJBj0JEeb1Ho97f1moJURhAQDfVwfOBjLLkge0bUrSc/rEj2AfFUoxsg104tfmC5tiT9NAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mHE2MKiw; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mHE2MKiw"
Received: from github.com (hubbernetes-node-044a8d3.va3-iad.github.net [10.48.137.37])
	by smtp.github.com (Postfix) with ESMTPA id B1361E1087
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 May 2024 07:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1715006029;
	bh=Vg+MRHvzaY30Fa6ufgWWkJTmhOuJJaET/G8rgIclYdE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mHE2MKiwDbPAj/8IuRAGthES3ci/uV5I6Z7NtbJrEB3i3dV5WCkJ4L8gCeCXPbWCU
	 0DHHPDMesU5ukUxhiY4DBxUW0GFDs6+C19d/g1HlpOgng+ZAFW7cDdOREdE3naUEl/
	 X8mJThSBMO0CcyPM8k22xh3X6qq1EHKtqG9IWyXs=
Date: Mon, 06 May 2024 07:33:49 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/14057f-f34cc1@github.com>
Subject: [bluez/bluez] f34cc1: gatt-database: Fix error registering
 characteristi...
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: f34cc1da5081e1a464212dc73cde8ba4f2b79d99
      https://github.com/bluez/bluez/commit/f34cc1da5081e1a464212dc73cde8ba4f2b79d99
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-05-03 (Fri, 03 May 2024)

  Changed paths:
    M src/gatt-database.c

  Log Message:
  -----------
  gatt-database: Fix error registering characteristic with Handle 0x0000

Registering a characteristic with handle 0x0000 means that the
application wants a handles to be auto allocated but requires to be
informed of what values they end up in the database.

Fixes: https://github.com/bluez/bluez/issues/821



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
