Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D712AD20
	for <linux-bluetooth@vger.kernel.org>; Sat, 10 Jan 2026 00:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768006649; cv=none; b=sxnZnxBqCJIoUbxyANGgjK+LaQKJyS4GCdeCYGxb8mIWRUkFqe52BUEETUZKCrd58d3i94SgHIC7I6cy7dECoUT4K1U3buHF0oYXJj1GNRvmr8gj1YHxLA7zULMWCSf4FpSKVUXuYneZN900ZmmV4clILTR/2wlVF2yfYlZg6Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768006649; c=relaxed/simple;
	bh=ibeISvT0GrdUausonVQGvEUBHhMrt7wuBHndt61LYDE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gBMBMQvCm9v8DV7HBp1rXc3e8XqFBKU0tvi6ruO2XXSja2YvPy0gllEJRiJSoigIZfYmNwPpSFILv3biQmSemaZ09qTSx2Q86x0EDimniz7breoyhuz7tcrLO/6BrVWOsShYtfi95f4++XqjZNnUQOP8kqiKuniuDtrLj85+HpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Wk/LF8f+; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Wk/LF8f+"
Received: from github.com (hubbernetes-node-ba1df07.ac4-iad.github.net [10.52.180.41])
	by smtp.github.com (Postfix) with ESMTPA id 0128C40113A
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 16:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768006648;
	bh=P3ZBjrJRNt/f8YiZ+wQwy/jJ+K5d2/oF/MBTFmENOXI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Wk/LF8f+zipgBrDfd0esrn4E3n1eSADCPyZjGe6C2P6uw5C0hZmCw78LqDAtTj2xV
	 BU6AxhS6dN0dez94IROwyYDKul0CEjWSo84p9Vz//xehrbz4lldd6gPQoxDFO1OsUo
	 SUzY85P4VGj9gQNzzKkdkt1uiBYx8+a9KRMI4lX4=
Date: Fri, 09 Jan 2026 16:57:27 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1032118/b63544-000000@github.com>
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

  Branch: refs/heads/1032118
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
