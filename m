Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C26303A0F
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761854000; cv=none; b=IG3fg5oa2HyZOIV0NbylgjRSOKuuaEE7YmBP0LM69Uq2jTlaQz8Nkei/qmqqlTAoAwxu8KhVNszSGnkzf8Kyk1MNNoqOh0LN7efY0qYh1Y+VZ3Y7ConcocPmMAyMUzcFtxxyD4LlHJVW8m/kwko66wOeFhEvulj7O5eJFOA7EzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761854000; c=relaxed/simple;
	bh=3E/o4f1EXdOF0yhioaaqlL5mcjvxlHW9pzOJgxBd58c=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=GQYZpm6sMhX6vbHsl4BDOCnh4+B+HSBQerLfjTMb3SlUETxQpRhJeU1mbQ6uOAyCu72CtJV8mvYE/XtllaS55/SzsaaY226DfHJB1Il6VN83U2/uhyeBGRGEG0ZSrdhoUTwEGqoTyo2F37TFEHnteRfhADgzIC+eczmklvgcOEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gwdiI3TX; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gwdiI3TX"
Received: from github.com (hubbernetes-node-75cc943.ash1-iad.github.net [10.56.174.27])
	by smtp.github.com (Postfix) with ESMTPA id 11ECB601295
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 12:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1761853998;
	bh=xOmMjGm746a55BPL42i9amPZ37UGwx+KAQdBxoTOZbQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gwdiI3TXY/b4mwWJ1t764HOOyCQVQezDo1pm3USrQwpYHuxtUGruM7k29237EefUu
	 VK6HgpoYsl8mERguoTpxm5LbV3bYb65EXh6AVCbO7gmYlWMIMpwtGVH1h4DGZ8daKF
	 OvtRD7vX7U+2ziLD4xbfIi4I4sLS//Fq2mm1qjyU=
Date: Thu, 30 Oct 2025 12:53:18 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1017886/000000-1a9f88@github.com>
Subject: [bluez/bluez] 3c046e: monitor: Add decoding support for LL Extended
 Feat...
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

  Branch: refs/heads/1017886
  Home:   https://github.com/bluez/bluez
  Commit: 3c046e5ff7f7092170f5603f4ec429fac1d74518
      https://github.com/bluez/bluez/commit/3c046e5ff7f7092170f5603f4ec42=
9fac1d74518
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-30 (Thu, 30 Oct 2025)

  Changed paths:
    M monitor/bt.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add decoding support for LL Extended Feature Set

This adds support for decoding LL Extended Feature Set introduced in 6.0
that adds the following:

Commands:

 - HCI_LE_Read_All_Local_Supported_=C2=ADFeatures(0x2087)(Feature:47,1)
 - HCI_LE_Read_All_Remote_Features(0x2088)(Feature:47,2)

Events:

 - HCI_LE_Read_All_Remote_Features_Complete(0x2b)(Mask bit:42)


  Commit: 1a9f88452d23aff75adff896bed064ec0e6c0c77
      https://github.com/bluez/bluez/commit/1a9f88452d23aff75adff896bed06=
4ec0e6c0c77
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-30 (Thu, 30 Oct 2025)

  Changed paths:
    M monitor/bt.h
    M monitor/ll.c
    M monitor/packet.c
    M monitor/packet.h

  Log Message:
  -----------
  monitor: Add decoding support for LL_FEATURE_EXT_{REQ,RSP}

This adds support for LL_FEATURE_EXT_{REQ,RSP} which is used to
exchange LL Features.


Compare: https://github.com/bluez/bluez/compare/3c046e5ff7f7%5E...1a9f884=
52d23

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
