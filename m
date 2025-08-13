Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494C62EA155
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 07:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755069747; cv=none; b=pPfdvfGE6/ypJw/Gn/t3SuHluHfzLEhQttRpxM76Ej1maxwrXl4zGhuWVUmOuuDHtU9rmFrLvhckwwb49ImG1WbVC5XPNAfmM6wZJi7Mio/l+yLbwpJzRK2hMnU4v1TMJR/l+NuXL6upD1iiH8IA3tt0FomJhgHykcsnuIwfi5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755069747; c=relaxed/simple;
	bh=xJeZKq5r4X3VTbpQhGmtupPGSOvxlC43Yn8Iy1ao7nA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KqaNkeZ+PgURU6W7q/GkofIn3PGQXtgELTpWMFORtYvK9RBGt+YvQqBMlg/E3VOnKU0Vqgin74NtoXBZJ89DL177eLGfWEAcZpA9G5dDLNAM2/tKCcxbiSOE/kKzCmospbUs88Zvli0c3xBliAKoguwq/+t+JgSEb7t8YJqdEgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TDkyVBx0; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TDkyVBx0"
Received: from github.com (hubbernetes-node-6bb5c22.ash1-iad.github.net [10.56.208.48])
	by smtp.github.com (Postfix) with ESMTPA id 75C7D1412F6
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Aug 2025 00:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755069745;
	bh=dFnjoooikboy/YDLEFB/uyqtPrKmA7CgLsy/Z9aErj0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TDkyVBx0KcUUu7QabXY7XAQdDTZuH9mrV74vuPyYbKwHdhC2z8H8K1E4HjWL6+hZ0
	 cl/qcVcdQvUeDjYcNqAMLbyczWINTE4iaV1Kz+ycZhwGoAOPdLlfOZVe4Qqzq9APXB
	 Joo05ifShioChY53mJ6tE3QMAU+ga6cyeivtHzMw=
Date: Wed, 13 Aug 2025 00:22:25 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/990865/000000-4c4c77@github.com>
Subject: [bluez/bluez] 4c4c77: As a BIS sink role, BlueZ currently defaults to
 sy...
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

  Branch: refs/heads/990865
  Home:   https://github.com/bluez/bluez
  Commit: 4c4c778e2b040e446b06028caabd41977b0ac54f
      https://github.com/bluez/bluez/commit/4c4c778e2b040e446b06028caabd41977b0ac54f
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-08-13 (Wed, 13 Aug 2025)

  Changed paths:
    M doc/org.bluez.Device.rst
    M plugins/neard.c
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  As a BIS sink role, BlueZ currently defaults to synchronizing with the first broadcast source device discovered by the le discovery procedure. This behavior may not align with user expectations, as it removes control over the target device selection.

This patch introduces a new SyncBroadcast method to the device1 interface,
allowing users to explicitly choose which broadcast source device to
synchronize with.

Signed-off-by: Ye He <ye.he@amlogic.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
