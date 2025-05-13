Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF0812CD96
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 17:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747159184; cv=none; b=hWUj08/69z/6QPb8vvSTuRn4ONp7ygCwQshHR/avpQTZZbxasMNIU3s/aN+XD/SoNslWFaGHMc9KlCE9skP46xQDDQZAnPmYd4W2U6ZF0J/FTnWrL9C0dzYtNQNAeNsWFMwi9aOf0R/flMMKjegj10RcwYoveNKuDE3wwZQCHmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747159184; c=relaxed/simple;
	bh=P/WSTpP2GBvMMC1lCUX0oUP7auDOiZn04JFpgrqgD30=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uDoOU8G5M2VGGAi2d5GCjqXeT5AgTqI+k1v4F9K8JZ/q/T5XG3Xs/FV41kJKqurumWM6mddmROKK3BbahSuMf1YV3UINbo34j3trrB/7l8QNOP/mXzwEoDaA3BDtazmwFOQyqOTlKlpqiXvGBYdKaIXHPylDP6BfpyIOVyOo+IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SiYbr49X; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SiYbr49X"
Received: from github.com (hubbernetes-node-7fa9bf2.va3-iad.github.net [10.48.149.30])
	by smtp.github.com (Postfix) with ESMTPA id ABB10E082B
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 May 2025 10:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747159180;
	bh=JsmI0Y+tHhRj/+mlA4bX1c1COo0qrl4+cwyfAB9yj/w=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SiYbr49XOqpArtj+y1M/pk+3B6T2LcN0/PPlgrQh2rInBFP2Hyd4vwYUncEmoQAzb
	 tFVBFrjKKkZTf3cZuwrcsswuyUEqmYUoS/cTkkJbEYhxi94yackA0MZGg0zCwXXzKQ
	 +U4w8xIp+TrMNH8IJWExVa1XxgNYfPw7uInRK+Fk=
Date: Tue, 13 May 2025 10:59:40 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/962525/000000-4cbe9e@github.com>
Subject: [bluez/bluez] 4cbe9e: monitor: Add decoding for FSU command and event
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

  Branch: refs/heads/962525
  Home:   https://github.com/bluez/bluez
  Commit: 4cbe9e9cc4636212ad58c1414763954fdbc64c66
      https://github.com/bluez/bluez/commit/4cbe9e9cc4636212ad58c1414763954fdbc64c66
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-13 (Tue, 13 May 2025)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add decoding for FSU command and event

This adds decoding for FSU command and event as defined in the Bluetooth
Core 6.0 specification:

$ tools/hcitool cmd 0x08 0x009d 0xff 0xff 0x00 0x00 0x00 0x00 0x01 0x03
< HCI Command: LE Frame Space Update (0x08|0x009d) plen 8
        Handle: 65535 Address: 00:00:00:00:00:00 (OUI 00-00-00)
        Frame Space min: 0 us (0x0000)
        Frame Space max: 0 us (0x0000)
        PHYs: LE 1M (0x01)
        types: 0x03
          T_IFS_ACL_CP
          T_IFS_ACL_PC



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
