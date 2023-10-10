Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D064BCD98C0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Oct 2023 22:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjJJWiE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Oct 2023 18:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjJJWiD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Oct 2023 18:38:03 -0400
Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1886399
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 15:38:01 -0700 (PDT)
Received: from github.com (hubbernetes-node-bc9b7c8.ac4-iad.github.net [10.52.132.39])
        by smtp.github.com (Postfix) with ESMTPA id 603DA1E093D
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 15:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1696977480;
        bh=sHmUxohvcY9zSyS6N1lHO9eTTaqOk54B6XqwG9V7wSk=;
        h=Date:From:To:Subject:From;
        b=SDVJiwbH+YP2e8OLG/vEhsoBmYfyClq/AdIqcTbPgTkhtNbNjuAIn+095JBr6zyaX
         5YaSaICJVBwla1P4ThppyjXZPIZEjiIsEtBle5gv/sf8i9PxbasbEQ7708BZs/GsB3
         x7l7VPQJdgRaK9G0k8JqnSa2btsUNZA1tuoTszOE=
Date:   Tue, 10 Oct 2023 15:38:00 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/d4a0d2-ee2762@github.com>
Subject: [bluez/bluez] 6f7eff: doc/adapter-api: Rename to
 org.bluez.Adapter.rst
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 6f7effa4534f4f1d52f74860c204bc9317b68ee4
      https://github.com/bluez/bluez/commit/6f7effa4534f4f1d52f74860c204bc9317b68ee4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-10-05 (Thu, 05 Oct 2023)

  Changed paths:
    M Makefile.am
    R doc/adapter-api.txt
    A doc/org.bluez.Adapter.rst

  Log Message:
  -----------
  doc/adapter-api: Rename to org.bluez.Adapter.rst

This renames adapter-api.txt to org.bluez.Adapter.rst and generate a
manpage org.bluez.Adapter.5.


  Commit: 359132ba897e3b3e942953b351450254443fa8d1
      https://github.com/bluez/bluez/commit/359132ba897e3b3e942953b351450254443fa8d1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-10-05 (Thu, 05 Oct 2023)

  Changed paths:
    M Makefile.am
    R doc/device-api.txt
    A doc/org.bluez.Device.rst

  Log Message:
  -----------
  doc/device-api: Rename to org.bluez.Device.rst

This renames device-api.txt to org.bluez.Device.rst and generate a
manpage org.bluez.Device.5.


  Commit: 42e2934c235685fcb86ad19745e2f10b78b3eba3
      https://github.com/bluez/bluez/commit/42e2934c235685fcb86ad19745e2f10b78b3eba3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-10-09 (Mon, 09 Oct 2023)

  Changed paths:
    M Makefile.am
    R doc/agent-api.txt
    A doc/org.bluez.Agent.rst
    A doc/org.bluez.AgentManager.rst

  Log Message:
  -----------
  doc/agent-api: Rename to org.bluez.Agent{Manager}.rst

This renames agent-api.txt to org.bluez.Agent{Manager}.rst and generate
manpages org.bluez.Agent{Manager}.5.


  Commit: c5729e61b1506b5df45c9a267640136a5419f287
      https://github.com/bluez/bluez/commit/c5729e61b1506b5df45c9a267640136a5419f287
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-10-09 (Mon, 09 Oct 2023)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.Profile.rst
    A doc/org.bluez.ProfileManager.rst
    R doc/profile-api.txt

  Log Message:
  -----------
  doc/profile-api: Rename to org.bluez.Profile{Manager}.rst

This renames profile-api.txt to org.bluez.Profile{Manager}.rst and
generate manpages org.bluez.Profile{Manager}.5.


  Commit: 6481b9095b3484d9e224e6a69744b926bb0aee99
      https://github.com/bluez/bluez/commit/6481b9095b3484d9e224e6a69744b926bb0aee99
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-10-09 (Mon, 09 Oct 2023)

  Changed paths:
    M Makefile.am
    R doc/network-api.txt
    A doc/org.bluez.Network.rst
    A doc/org.bluez.NetworkServer.rst

  Log Message:
  -----------
  doc/network-api: Rename to org.bluez.Network{Server}.rst

This renames network-api.txt to org.bluez.Network{Server}.rst and
generate manpages org.bluez.Network{Server}.5.


  Commit: cfc76016b4d4fbc720e588831ee3f6f3b1e283f0
      https://github.com/bluez/bluez/commit/cfc76016b4d4fbc720e588831ee3f6f3b1e283f0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-10-09 (Mon, 09 Oct 2023)

  Changed paths:
    M Makefile.am
    R doc/input-api.txt
    A doc/org.bluez.Input.rst

  Log Message:
  -----------
  doc/input-api: Rename to org.bluez.Input.rst

This renames input-api.txt to org.bluez.Input.rst and generate manpages
org.bluez.Input.5.


  Commit: dec59a07fb115bb26067f13cac1c7751ed6f83ad
      https://github.com/bluez/bluez/commit/dec59a07fb115bb26067f13cac1c7751ed6f83ad
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-10-09 (Mon, 09 Oct 2023)

  Changed paths:
    M Makefile.am
    R doc/advertising-api.txt
    A doc/org.bluez.LEAdvertisement.rst
    A doc/org.bluez.LEAdvertisingManager.rst

  Log Message:
  -----------
  doc/advertising-api: Rename to org.bluez.LEAdvertis*.rst

This renames advertising-api.txt to org.bluez.LEAdvertis*.rst and
generate manpages org.bluez.LEAdvertis*.5.


  Commit: c6c412d6ccbc5ce2df46a7530a45cf2d7cbb37e8
      https://github.com/bluez/bluez/commit/c6c412d6ccbc5ce2df46a7530a45cf2d7cbb37e8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-10-09 (Mon, 09 Oct 2023)

  Changed paths:
    M Makefile.am
    R doc/gatt-api.txt
    A doc/org.bluez.GattCharacteristic.rst
    A doc/org.bluez.GattDescriptor.rst
    A doc/org.bluez.GattManager.rst
    A doc/org.bluez.GattProfile.rst
    A doc/org.bluez.GattService.rst

  Log Message:
  -----------
  doc/gatt-api: Rename to org.bluez.Gatt*.rst

This renames gatt-api.txt to org.bluez.Gatt*.rst and generate manpages
org.bluez.Gatt*.5.


  Commit: cba68babe1e6714d93be27bc9c3891b6874f30ea
      https://github.com/bluez/bluez/commit/cba68babe1e6714d93be27bc9c3891b6874f30ea
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-10-09 (Mon, 09 Oct 2023)

  Changed paths:
    M Makefile.am
    R doc/battery-api.txt
    A doc/org.bluez.Battery.rst
    A doc/org.bluez.BatteryProvider.rst
    A doc/org.bluez.BatteryProviderManager.rst

  Log Message:
  -----------
  doc/battery-api: Rename to org.bluez.Battery*.rst

This renames battery-api.txt to org.bluez.Battery*.rst and generate
manpages org.bluez.Battery*.5.


  Commit: 87151d1904ada0c151bef96c69d70e9bb3d3a08a
      https://github.com/bluez/bluez/commit/87151d1904ada0c151bef96c69d70e9bb3d3a08a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-10-09 (Mon, 09 Oct 2023)

  Changed paths:
    M Makefile.am
    R doc/advertisement-monitor-api.txt
    A doc/org.bluez.AdvertisementMonitor.rst
    A doc/org.bluez.AdvertisementMonitorManager.rst

  Log Message:
  -----------
  doc/advertisement-monitor-api: Rename to org.bluez.AdvertisementMonitor*.rst

This renames advertisement-monitor-api.txt to
org.bluez.AdvertisementMonitor*.rst and generate manpages
org.bluez.AdvertisementMonitor*.5.


  Commit: ee27626c7a06b21a59cb46c192b7045fe9da5fb9
      https://github.com/bluez/bluez/commit/ee27626c7a06b21a59cb46c192b7045fe9da5fb9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-10-09 (Mon, 09 Oct 2023)

  Changed paths:
    M Makefile.am
    R doc/admin-policy-api.txt
    A doc/org.bluez.AdminPolicySet.rst
    A doc/org.bluez.AdminPolicyStatus.rst

  Log Message:
  -----------
  doc/admin-policy-api: Rename to org.bluez.AdminPolicy*.rst

This renames admin-policy-api.txt to org.bluez.AdminPolicy*.rst and
generate manpages org.bluez.AdminPolicy*.5.


Compare: https://github.com/bluez/bluez/compare/d4a0d223eaa5...ee27626c7a06
