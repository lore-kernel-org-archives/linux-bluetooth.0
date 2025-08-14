Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B4921B9CD
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755186931; cv=none; b=lB8SlMayIWu0S/glS54e4xRzHVQ8y5FZLMYel2VeQSWGnw9b+UJuYJZ1et4Ps3MQaYbthXJssecohWgT5tU4+9srh0cQRqGzuNVvsU8xfDfy1Jsp47uNpAkZbgk7yaIRtZPof69J6yLb1bwFTUurD2T51pMCxYdq5/Y0bt4YcfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755186931; c=relaxed/simple;
	bh=ltkkKpz3UDubhDPGIExnVB7Qy0QbkW+TrnFANuGTPUE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hbeaV+97z9+H6p8rClOyaBaVHeAGrteTkMQKa9R0ZnFBtWQUYDwMChkgqeekwTQfGAyDaygNlvTFUrnebxppE8zT5WFcbA8End7GBU/vNMNMEn8P7LMe0Pf7fc6yFJC6KSo3fxurrEB68nSDqnzDIPFP8SSUOM3h1oUdBqczXIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WmA4GtZv; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WmA4GtZv"
Received: from github.com (hubbernetes-node-c64f7f6.ac4-iad.github.net [10.52.183.52])
	by smtp.github.com (Postfix) with ESMTPA id D09A1700FFB
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 08:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755186928;
	bh=bc5BHT6ltUsipRSDMU3ZrkLcvA5PydRS9nJjZKz08gI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WmA4GtZvzbSOXCqx1QuhSKZqkiblDWVS8m8Ux9H9luukD0rIFAdT9NAUhWi9tBF6k
	 6CQ3b3oSvajoPDALaHUfBMrxBjbFP4EvBoVqsglVv4q9mqYqOI0a8mh8lBAm7EWGLM
	 hhIU4SL/Bf/IIs2LO+Aky4dYCINdFRISmIzfdLdg=
Date: Thu, 14 Aug 2025 08:55:28 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/991602/000000-085492@github.com>
Subject: [bluez/bluez] 085492: monitor: Print unacked frame when releasing
 them
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

  Branch: refs/heads/991602
  Home:   https://github.com/bluez/bluez
  Commit: 08549296a1caf59847277b33d674ccc1566cae5d
      https://github.com/bluez/bluez/commit/08549296a1caf59847277b33d674ccc1566cae5d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-08-14 (Thu, 14 Aug 2025)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Print unacked frame when releasing them

This attempts to print the frame number of frames considered unacked
(missing NOCP):

> HCI Event: Disconnect Complete (0x05) plen 4
        Status: Success (0x00)
        Handle: 2304 Address: XX:XX:XX:XX:XX:XX
        Reason: Connection Terminated By Local Host (0x16)
        [0]#102132 unacked
        [1]#102137 unacked
        [2]#102139 unacked
        [3]#102141 unacked
        [4]#102143 unacked
        [5]#102145 unacked
        [6]#102147 unacked
        [7]#102150 unacked



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
