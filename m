Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9F025FA13
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Sep 2025 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903818; cv=none; b=YmgBJKZlSYhqDugRuaoX9mP3WVPGNnrRx6qn0K/UR9G9ZKpqlInSdd3igp0a/Qq+vcTrcifjshcHyNFO+XXb7xGsvhMGFRce4HJJXuMEjxKC+qpGiQSCwL+kT4l1St42L234Fcp1LlzfGFedcyrIW4YKbLdOfnLkq1pEXW3utQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903818; c=relaxed/simple;
	bh=42SAMxd+lQt0spj0lyOnVBpo9HFxyb1rdsswp9kTx/s=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gKl5lUHf4FPkCfwPPY29UPDj7uIJsYy9zh7KkT8Y3jN0dppIyvHMIh+CGUyv5a9qxlvIFBhF2QX+hyPMkjcc7jWdM8HQ2we9wuUUyBaY0kdcSB+qbVOjXOomrQTNlHB9mIx+Unf1+hDpABrhbvEd3XfLAzkcbZYqN39ggin31Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TNUqLHR4; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TNUqLHR4"
Received: from github.com (hubbernetes-node-ae2b360.ac4-iad.github.net [10.52.208.97])
	by smtp.github.com (Postfix) with ESMTPA id 78C56640842
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Sep 2025 09:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1758903816;
	bh=uUTLfWgdykt9UU6bTic2/lAiS8c0yzBmYwLuI5unY0s=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TNUqLHR4oMF0OwQ34zRtm4YT/tuY2m8cs3oB5+hQjouBVTIiMRz+U2ypwGEL8wyFh
	 NA5kAsxgEhrGjfTfwl6Iwrf+gxgUbddNiaYtmXz3SvhUJgs99PIHdVODLlSWe4fAVv
	 2Ke3TcQd368nOIdPROCSEsL/yTAe0EbfXDGjEmGU=
Date: Fri, 26 Sep 2025 09:23:36 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1006636/000000-8afd5b@github.com>
Subject: [bluez/bluez] f5853b: btdev: Fix handling of
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

  Branch: refs/heads/1006636
  Home:   https://github.com/bluez/bluez
  Commit: f5853b0611db93655fb74e9f376de2dee76b7d53
      https://github.com/bluez/bluez/commit/f5853b0611db93655fb74e9f376de2dee76b7d53
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-09-26 (Fri, 26 Sep 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Fix handling of BT_HCI_CMD_LE_SET_RESOLV_ENABLE

Checking for le_adv_enable alone is not valid considering the comments
itself states that peridic advertising shall be allowed.


  Commit: 8afd5b58b9249a1d2ad0ac07519ecbdef6cc98c7
      https://github.com/bluez/bluez/commit/8afd5b58b9249a1d2ad0ac07519ecbdef6cc98c7
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


Compare: https://github.com/bluez/bluez/compare/f5853b0611db%5E...8afd5b58b924

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
