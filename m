Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FFE2C3246
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748972034; cv=none; b=Zp7zZhgivGUYOGNBh6QtBRUqm2g94uJb8Ml833ZNdijAOxJg5+pPJeMkHwjz6OxULipQSNec93XHnXZEHCGWn2VpIQhSJdLYrvmLNtrSVdycv8VOpPC8+Btfuvha2OU4VM1lDICCAQpHItyZPdaWBNV4fulFJEV732cZg8IdBqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748972034; c=relaxed/simple;
	bh=8JpMLe2MT0ndeBPQRO5oR8ZRBIFInzPo8Bxa+2pyVOg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bSqTQcTePFJmhJj/MAuRqVXZD77i50qy3Njs9QH88e59LrdPrNJyV3B+aVREzkwzL3xXTcXFz9iX1cLAYxqQyHr0GdSlwRvdDOYLCOQs4gYTrc3G14hSO4OmP9W8AVqS6Pt9NEAPbUWnLWymcJgBzCNOVrJggNe/CIfquDCq3oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZBqRz4Rm; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZBqRz4Rm"
Received: from github.com (hubbernetes-node-cf1fce4.ac4-iad.github.net [10.52.180.36])
	by smtp.github.com (Postfix) with ESMTPA id 803F070108C
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 10:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748972031;
	bh=Sw1xAebvQNazvgL6J/QsTQUdsn+taLYmW/MK95EspeE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZBqRz4RmyiMwCEzCQWH9Jc54Iivx9E5wiuLUuNDVPr8rzt4zBc91smp+/Yo0jE3NN
	 lFKJkDPKm8UUbvovDKnY/Yjik13BC+1uQ2LeeZi9Q5l2rC2osJOSOWQ01YSKNq07FO
	 I02jDFP6vkV4UQ43DVS5UdAModoRZCyL6od7hIo4=
Date: Tue, 03 Jun 2025 10:33:51 -0700
From: mkasenberg <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/d97d19-8ad12f@github.com>
Subject: [bluez/bluez] 52fb0d: doc: Remove extra identation
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 52fb0d4de74bf3ed1fd43b1c8a14ab00f92824eb
      https://github.com/bluez/bluez/commit/52fb0d4de74bf3ed1fd43b1c8a14a=
b00f92824eb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-02 (Mon, 02 Jun 2025)

  Changed paths:
    M doc/org.bluez.Adapter.rst
    M doc/org.bluez.AdminPolicySet.rst
    M doc/org.bluez.AdminPolicyStatus.rst
    M doc/org.bluez.AdvertisementMonitor.rst
    M doc/org.bluez.AdvertisementMonitorManager.rst
    M doc/org.bluez.Agent.rst
    M doc/org.bluez.AgentManager.rst
    M doc/org.bluez.Battery.rst
    M doc/org.bluez.BatteryProvider.rst
    M doc/org.bluez.BatteryProviderManager.rst
    M doc/org.bluez.Device.rst
    M doc/org.bluez.DeviceSet.rst
    M doc/org.bluez.GattCharacteristic.rst
    M doc/org.bluez.GattDescriptor.rst
    M doc/org.bluez.GattManager.rst
    M doc/org.bluez.GattProfile.rst
    M doc/org.bluez.GattService.rst
    M doc/org.bluez.Input.rst
    M doc/org.bluez.LEAdvertisement.rst
    M doc/org.bluez.LEAdvertisingManager.rst
    M doc/org.bluez.Media.rst
    M doc/org.bluez.MediaAssistant.rst
    M doc/org.bluez.MediaControl.rst
    M doc/org.bluez.MediaEndpoint.rst
    M doc/org.bluez.MediaFolder.rst
    M doc/org.bluez.MediaItem.rst
    M doc/org.bluez.MediaPlayer.rst
    M doc/org.bluez.MediaTransport.rst
    M doc/org.bluez.Network.rst
    M doc/org.bluez.NetworkServer.rst
    M doc/org.bluez.Profile.rst
    M doc/org.bluez.ProfileManager.rst
    M doc/org.bluez.obex.Agent.rst
    M doc/org.bluez.obex.AgentManager.rst
    M doc/org.bluez.obex.Client.rst
    M doc/org.bluez.obex.FileTransfer.rst
    M doc/org.bluez.obex.Image.rst
    M doc/org.bluez.obex.Message.rst
    M doc/org.bluez.obex.MessageAccess.rst
    M doc/org.bluez.obex.ObjectPush.rst
    M doc/org.bluez.obex.PhonebookAccess.rst
    M doc/org.bluez.obex.Session.rst
    M doc/org.bluez.obex.Synchronization.rst
    M doc/org.bluez.obex.Transfer.rst

  Log Message:
  -----------
  doc: Remove extra identation

This remove the extra identation which doesn't really matter for
manpages.


  Commit: 99861c249c866e1c4f911f3c3da6de9cef2c3f02
      https://github.com/bluez/bluez/commit/99861c249c866e1c4f911f3c3da6d=
e9cef2c3f02
  Author: Antonio Russo <aerusso@aerusso.net>
  Date:   2025-06-03 (Tue, 03 Jun 2025)

  Changed paths:
    M tools/mpris-proxy.service.in

  Log Message:
  -----------
  Do not start mpris-proxy for system users

A default installation of bluez results in the systemd user unit
mpris-proxy.service being started for all users---including root.
This unnecessarily exposes system users to any security
vulnerabilities in mpris-proxy.

Inhibit this default behavior by using ConditionUser=3D!@system.

Reviewed-by: Guido G=C3=BCnther <agx@sigxcpu.org>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Andrew Sayers <kernel.org@pileofstuff.org>


  Commit: 8ad12fe7b4b93abf37b11e62b2e548cb245c2199
      https://github.com/bluez/bluez/commit/8ad12fe7b4b93abf37b11e62b2e54=
8cb245c2199
  Author: Magdalena Kasenberg <magdalena.kasenberg@codecoup.pl>
  Date:   2025-06-03 (Tue, 03 Jun 2025)

  Changed paths:
    M monitor/bt.h

  Log Message:
  -----------
  monitor: Fix bit for HCI_LE_Read_ISO_Link_QUALITY

Fix the bit ID of the HCI_LE_Read_ISO_Link_QUALITY command to match
the assigned value defined in Supported_Commands table in the Bluetooth
Core Specification.


Compare: https://github.com/bluez/bluez/compare/d97d1951b447...8ad12fe7b4=
b9

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
