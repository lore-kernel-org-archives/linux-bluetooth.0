Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D630A199FAB
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 14:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751380725; cv=none; b=NgExRcEsr31XnN402bX4AhyDlXPawzpZWnu32pQx47sHmf9dBUivv2CpNbILcNp4zStJux6RN6G8Q7+7teY5mHf3eoAqGy4vkEQqjgT+RnUOsEqQeLE3Tv6vyR362qIviiMKJx05wciATHcDFjevlu5rO6eU3LJaJP2lgURdbsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751380725; c=relaxed/simple;
	bh=tol1113W5sDrzDXjD1zm81pIOWLGW704nd+9rvBvUdg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=msmzVde8W8Gb0xEunty3r0FZvWC0cHclMlC2zWKabcP/4jIoVLfDlvFUhh2QFdt7bkkr9xvpAjt/9y9qc1q2J8BTaJz2AiN4SKqGGn5p+Xhjdy7+horOoarCuggf2bP0Gdjn2FIaabh9VF1pl4O7e/x0SloWgwU+w6vdx6gGWng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Xf4luIgO; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Xf4luIgO"
Received: from github.com (hubbernetes-node-d9b4b9b.ac4-iad.github.net [10.52.202.53])
	by smtp.github.com (Postfix) with ESMTPA id F107F7006B2
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 07:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751380722;
	bh=8gh8ETrbhLN4zh0VK4WpOshUSaIefbd9OcGQKLS3i5k=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Xf4luIgO+1XWtCja3garQ24rJXC1Pgh7D7/tZHZREAwat9/QTuD9BE+4kZcn2hW9v
	 bCd0qEE5NHB/pg3nj+fVkwwxgsiloWOkTD8BkQu7o79ZKKVFf8Wn9tiValiUIw5l4/
	 qBy84Zy8O6YMrBNKtGbC4ABpOUFdwcawYSDaWYiI=
Date: Tue, 01 Jul 2025 07:38:42 -0700
From: Christian Eggers <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/977745/000000-e71481@github.com>
Subject: [bluez/bluez] 3fce1b: advertising: client_remove: use concrete type
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

  Branch: refs/heads/977745
  Home:   https://github.com/bluez/bluez
  Commit: 3fce1b5800eb96208deea45b134b406633fd0bd3
      https://github.com/bluez/bluez/commit/3fce1b5800eb96208deea45b134b406633fd0bd3
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-01 (Tue, 01 Jul 2025)

  Changed paths:
    M src/advertising.c

  Log Message:
  -----------
  advertising: client_remove: use concrete type

No need for using a void pointer here.


  Commit: e71481f6178d1901ea2f71d1b1e1884bb795cd65
      https://github.com/bluez/bluez/commit/e71481f6178d1901ea2f71d1b1e1884bb795cd65
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-07-01 (Tue, 01 Jul 2025)

  Changed paths:
    M mesh/node.h

  Log Message:
  -----------
  mesh: node: remove dead function declaration

node_attach_io() has been removed in 7cdc215ff5a1 ("mesh: Add
finalization of a newly created node")


Compare: https://github.com/bluez/bluez/compare/3fce1b5800eb%5E...e71481f6178d

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
