Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005A02746D
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 22:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720476849; cv=none; b=S+pG+Th4ulnDVVEA5ldguGeVQSLXgJM7DS3gkOC4n3H/xn9HWfY1fBp7sKADhlz0viJxS/Wur9gxG9ZDCCaurYEr8TEEFR+vsCQ2pC2hHRXbs9WdUHtp1LyqhMtMoK9yoAdyqgcZDSmeljywPOG8rW06UVzhSzmnjzWIsUMf8Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720476849; c=relaxed/simple;
	bh=eqHG34RVkIG0CHYvmA5dNBtdcmblgfq8/yeCICa19Tw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cG5I6zLKY6mNDJyn9rrHT31MxD6HCGniQ77qyIjad2tF7V0MPOTet23dAtZWKjz3+N7VFgU0Yy7Ptk8Nr3PINi77g6tzn7AqDpUsBE2iHPZtKMfrthjLM1w1P5tEgI/kIzUeD95r+wdNIsr/nNsu1DCO8gMEGdO8icduYmMWlgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=V/qH0Gh9; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="V/qH0Gh9"
Received: from github.com (hubbernetes-node-66923d6.ac4-iad.github.net [10.52.147.35])
	by smtp.github.com (Postfix) with ESMTPA id 1AADD640CAA
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 15:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1720476847;
	bh=5jx4gXqa7JfpD2VrVVnOcmvDJHIJIa/WsxdSeBs5w58=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=V/qH0Gh9pHoCVN7EtXFrILW7bt7C/K4qjVmS3zd9quRBeillW/bJ09UgiaQm2JQ10
	 ehLoAQFGOBm+fpaOqrcqVVA1y4c6V7yb0UAvI8oaRipwuX0AkRcgLCardBb/d+5EO1
	 mKY1nuLjchzcpTd3Tg951rIbc+K1t7l9dq7a/V34=
Date: Mon, 08 Jul 2024 15:14:07 -0700
From: Marcel Holtmann <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/337cca-68864d@github.com>
Subject: [bluez/bluez] 895143: build: Add l2cap.7 and rfcomm.7 to ignore list
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
  Commit: 8951437476a1f9616d9836320df3d07ef6ca0898
      https://github.com/bluez/bluez/commit/8951437476a1f9616d9836320df3d07ef6ca0898
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2024-07-08 (Mon, 08 Jul 2024)

  Changed paths:
    M .gitignore

  Log Message:
  -----------
  build: Add l2cap.7 and rfcomm.7 to ignore list


  Commit: 68864d1aa818aca00d67f7a4d6078344483e9509
      https://github.com/bluez/bluez/commit/68864d1aa818aca00d67f7a4d6078344483e9509
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2024-07-08 (Mon, 08 Jul 2024)

  Changed paths:
    M ChangeLog
    M configure.ac

  Log Message:
  -----------
  Release 5.77


Compare: https://github.com/bluez/bluez/compare/337cca13037f...68864d1aa818

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
