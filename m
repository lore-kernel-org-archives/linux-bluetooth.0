Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1F93A3E79
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 21:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780435609; cv=none; b=X0Eph40wz3ICEQ8abScX1rYRn372CUIG6ueSVu4BCKExuCfO2LMvKIMh5t+PaeI0OD8yxRTg5hJcI4DGrP5L+SXuGD8tsvNyUPIjEHAn/NMImD2ot2NI7eMXlunfsWyW0sszZZSkRYuVRRWh8tZeLGUBkat+z4M8y//Plcups+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780435609; c=relaxed/simple;
	bh=NFJmxzpzQmQ9L44j1eRkfPcyvydlO4VSTJcK9qrao+s=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kWdlvXSQ4dLXWY08k5s6O/ytO7F3dFa7DUr2TflYhgskNR6BOYEZbGlAHV8usyZtrl326avANZa/fd/pm2Rx0D++ZqtSdoVaY1buOi04UJ3yROhg6lRe9ucs7cRPl0AXOybyr2HBVJdTt/Xo05R0EUYDpcaKHHWognMyOu1D/HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Mrg0isfY; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Mrg0isfY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780435607;
	bh=9u1l/TKsCLiYG/cY+DoU3uIDrY2/AqMuKm4ZSA413P0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Mrg0isfY9ei4plxO7qatfcwnesOiKSu1oYtYSeQdHjzFHnleHc2CDeedAnHqQe/QL
	 l5t03Q+Y9mNvoHfG2xh9rQyjaag5QMfC6A0k3CNHgwtt0iWy95upmw0oKwD+2zrGhM
	 IuDTN/6kGZ6WycDbgODExBDBkl/kpSZoprfzCnCA=
Received: from github.com (hubbernetes-node-db175bc.ac4-iad.github.net [10.52.200.129])
	by smtp.github.com (Postfix) with ESMTPA id 270374021B
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jun 2026 14:26:47 -0700 (PDT)
Date: Tue, 02 Jun 2026 14:26:47 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1104846/000000-c3ed9c@github.com>
Subject: [bluez/bluez] c3ed9c: advertising: Fix sending extra bytes with
 MGMT_OP_...
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

  Branch: refs/heads/1104846
  Home:   https://github.com/bluez/bluez
  Commit: c3ed9c6105d29ee0bd563f2d33a181d218cf1b4a
      https://github.com/bluez/bluez/commit/c3ed9c6105d29ee0bd563f2d33a181d218cf1b4a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-02 (Tue, 02 Jun 2026)

  Changed paths:
    M src/advertising.c

  Log Message:
  -----------
  advertising: Fix sending extra bytes with MGMT_OP_ADD_EXT_ADV_DATA

MGMT_OP_ADD_EXT_ADV_DATA expects the command to be of size of
struct mgmt_cp_add_ext_adv_data not mgmt_cp_add_advertising.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
