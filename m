Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297BA21C167
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Sep 2025 13:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759152988; cv=none; b=rCBP30jlqhVj2vCkVtNABI03cFOImc+RJfIdeeI85mlnJD3Hi+akrjXivKFeP+KMcW9ax61dcXV1sqiveiDyIE2bd9VvDjAG6L8M9c/TePxd1Y3+yv5EJWQGpp/h/Q4MWEqU4k86+5uVLAVOqOhyhZnkc7ZMDSbAzHYn8YUqhME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759152988; c=relaxed/simple;
	bh=GVoJAI5XyabjJGs2Rh1a5BJdlLZE4WYCee79zzIczOM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=oQLULyfYM8WiPDJPDvtbafUHRh8Hft+gp/Y+U1g8FDGMNp1Xt8d7IW1TStTojx5CXyCg2KiU7rGThuC4H0sQdPamCXDhZkp3whYMTU4ObNiBQqrIU5VvH3WhH+kaa5s35UxUsUGSxafsquLUSXLLBysndul+E78R7tHLbidOZpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TqOpx7bg; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TqOpx7bg"
Received: from github.com (hubbernetes-node-d1e60ba.va3-iad.github.net [10.48.205.93])
	by smtp.github.com (Postfix) with ESMTPA id 3ACF9E1416
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Sep 2025 06:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1759152986;
	bh=5VslG3OKZU5kEdNDPlGz/ygrPGgTGBb1wdgQujF70sc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TqOpx7bgT0MTnCFSE459Kbs+NJCr2pob/XEdGAQecKSyPDmTo7lA1KR9/EHoUqVT0
	 k9SxUTo5bLgtmwH0bRXXuvSNZC3LVPnRaOiyl1GyIzYA9YEy6GLBO8kGGuNZxFlBXs
	 rzZ37fMq3KG/CSNZDAL9kqbnjXkQ1KpnpYTJj6W0=
Date: Mon, 29 Sep 2025 06:36:26 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/04a896-e7c77f@github.com>
Subject: [bluez/bluez] a6d35e: btdev: Fix handling of
 BT_HCI_CMD_LE_SET_RESOLV_EN...
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
  Commit: a6d35e91b80b6f52323003254affa944bdee6287
      https://github.com/bluez/bluez/commit/a6d35e91b80b6f52323003254affa944bdee6287
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-09-26 (Fri, 26 Sep 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Fix handling of BT_HCI_CMD_LE_SET_RESOLV_ENABLE

Checking for le_adv_enable alone is not valid considering the comments
itself states that peridic advertising shall be allowed.


  Commit: e7c77f80787def10ccaff73ea6d19ef36faba18c
      https://github.com/bluez/bluez/commit/e7c77f80787def10ccaff73ea6d19ef36faba18c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-09-26 (Fri, 26 Sep 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Fix advertisement state

The LE Advertisement state shall be updated whenever an advertisement
is disabled since if all advertisments sets are disabled it shall be
reflected in le_adv_enable.


Compare: https://github.com/bluez/bluez/compare/04a8966972d0...e7c77f80787d

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
