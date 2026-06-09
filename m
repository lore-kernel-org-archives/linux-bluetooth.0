Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D273F58DF
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 11:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781005787; cv=none; b=cWlk6DmnmbojFnWGfSo73zrn28goP3EEurAD4OfPs9J/OjyrwEczGTDngpDB60RPr31IWQAtTN6T2zVGAa2p10oUa4XIyZm50MNzNNdqeye1sXGp/ng/DuBHWLetUc4uI7IcOCCvL3UrcIaQMvQugsbNBgxE7O7qxUQQLbr/rhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781005787; c=relaxed/simple;
	bh=R+KLFqXXQC28jA5AWcWYe/Skx8iCPYTj3XabZm8y3D4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Si3YzCar6PvZmy2lhSn/tybQR/yYe8+jio0XfvW5srik3ENEqw/WkBhyIJ03D5R5tMPx00/NQ9uB1VGW+674ji4A0A9URLQLf1yhsooIoDTA+U5VhTh4bOEDcpmcEcdhZfoKRKEKf3m1gxQf9rS/2ENq/kR+kgm6mFeGSXfAMjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MRD4vtSX; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MRD4vtSX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781005785;
	bh=KeGiGwLXHSV/nmnhNkgEOvE+gKmQrcE1BdfOVhmxA8k=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MRD4vtSXC2PQkWVsqRXKMh2oFDMFRveNkciNHjZ/EY/fYkrtrd+9ttJxQ/p9Z9BGN
	 hPWRQJPhf0SlwXhhP4HNNj/A1Ydwz94QZkDSqP99CF0m7lZxxA2wSZBgF10sBsE2Hz
	 H4F14puKxVrKJpOLbuYJnIAMf2iemlQkmF8+cuxE=
Received: from github.com (hubbernetes-node-947d791.ash1-iad.github.net [10.56.194.15])
	by smtp.github.com (Postfix) with ESMTPA id 257FF1810CD
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 04:49:45 -0700 (PDT)
Date: Tue, 09 Jun 2026 04:49:45 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1108507/000000-d6cc95@github.com>
Subject: [bluez/bluez] 0828cc: shared: rap: Add the is_central parameter to
 verif...
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

  Branch: refs/heads/1108507
  Home:   https://github.com/bluez/bluez
  Commit: 0828ccc601b1a2a788b21a5aef31d06fb5f42055
      https://github.com/bluez/bluez/commit/0828ccc601b1a2a788b21a5aef31d06fb5f42055
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M src/shared/rap.h

  Log Message:
  -----------
  shared: rap: Add the is_central parameter to verify whether the local role is central before sending the HCI CS Security Enable command.


  Commit: d6cc95002b6b86b843711f04be4175fad1473fdd
      https://github.com/bluez/bluez/commit/d6cc95002b6b86b843711f04be4175fad1473fdd
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M profiles/ranging/rap.c
    M profiles/ranging/rap_hci.c

  Log Message:
  -----------
  profiles: ranging: Add command flow and event support for CS Initiator

Introduce support for LE Channel Sounding (CS)
    ranging procedures in the Initiator role by enabling required
    HCI command sequencing and event handling.

    - Add transmission of core HCI LE CS commands:
      HCI_LE_CS_Read_Local_Supported_Capabilities,
      HCI_LE_CS_Read_Remote_Supported_Capabilities,
      HCI_LE_CS_Security_Enable,
      HCI_LE_CS_Create_Config,
      HCI_LE_CS_Remove_Config,
      HCI_LE_CS_Read_Remote_FAE_Table,
      HCI_LE_CS_Set_Channel_Classification,
      HCI_LE_CS_Set_Procedure_Parameters,
      HCI_LE_CS_Procedure_Enable

    - Add handling of event:
      HCI_LE_CS_Read_Remote_FAE_Table_Complete

    This enables cs capability discovery, cs configuration management
    and execution of CS ranging procedures in the Initiator role.

    - CS init pipeline not yet wired up pending D-Bus API.
    bt_rap_read_local_supported_capabilities() has no caller,
    mark __maybe_unused till DBus APIs are introduced.


Compare: https://github.com/bluez/bluez/compare/0828ccc601b1%5E...d6cc95002b6b

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
