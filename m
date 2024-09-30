Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFA41A0B0C
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Sep 2024 20:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727525; cv=none; b=ul1szvNH6mK9zYK6/5BuHXj9xAf0g5koPFWqCanUm/uNSdf85mYRS+zkvhFpi1jd+aVl3gMYofMaKUWy3uZ2cl2nR1mG1e1eVTC2l6lik8fnBCn8ENURq82FzvgLly6FNTbAaDz3171pBogczBGyx3wrfN3oHveuaw4vpBlb26A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727525; c=relaxed/simple;
	bh=SSVpH3kNDxN9/iad7HWzk38u1hUJqcIi0/8tyiWhhJM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VYDiF9w06/EnJKy0g3eCBVRdh3MUslrOUFAFPYcOrUO0Y4urqKEIvVArEymTV5MvQU4UlP3MuB+kwB3Yi071ptBF685+4yVwAIhyjHku3l7mnwGoBc5Fh7+ppJRu53bVYemfAOM0OPmqQ2RRpcnxBX9QBbN/74wvnaYAL6AVMeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fFlQ9kKj; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fFlQ9kKj"
Received: from github.com (hubbernetes-node-297a7a9.ac4-iad.github.net [10.52.135.19])
	by smtp.github.com (Postfix) with ESMTPA id 3055F640D10
	for <linux-bluetooth@vger.kernel.org>; Mon, 30 Sep 2024 13:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1727727523;
	bh=gX9rteX4+oZte3aGhiS/5mPEcPjurtXw1pn/xlSt4XE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fFlQ9kKjZBGQT1j5f58YWhBSykEHzoZ1oqliKTZC78nOC6+tgviKNGr5ud0Ofu7VW
	 yxjYg+6Io/dj4gZAqhxahE3nSi5wBoBOZCkeSPJNuZhSdvSl/L/QRkOmS9mHlU46M7
	 F8XstbbOy24FZwn3ichFldFaCvsdUBJ5qtTrg5fg=
Date: Mon, 30 Sep 2024 13:18:43 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/9a9dc3-38734e@github.com>
Subject: [bluez/bluez] 95c15d: client/player: Make endpoint.show print all
 endpoi...
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
  Commit: 95c15d2ca02a1056947884a0f5cd8a8360862815
      https://github.com/bluez/bluez/commit/95c15d2ca02a1056947884a0f5cd8a8360862815
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-09-27 (Fri, 27 Sep 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Make endpoint.show print all endpoint with no argument

This makes endpoint.show arguments optional and in case none is given
print all (local and remote) endpoints:

[bluetooth]# endpoint.show
Endpoint /local/endpoint/a2dp_src/sbc
	UUID 0000110a-0000-1000-8000-00805f9b34fb
	Codec 0x00 (0)
	Media Codec: SBC
	Channel Modes: Mono DualChannel Stereo JointStereo
	Frequencies: 16Khz 32Khz 44.1Khz 48Khz
	Subbands: 4 8
	Blocks: 4 8 12 16
	Bitpool Range: 2-64
Endpoint /local/endpoint/a2dp_snk/sbc
	UUID 0000110b-0000-1000-8000-00805f9b34fb
	Codec 0x00 (0)
	Media Codec: SBC
	Channel Modes: Mono DualChannel Stereo JointStereo
	Frequencies: 16Khz 32Khz 44.1Khz 48Khz
	Subbands: 4 8
	Blocks: 4 8 12 16
	Bitpool Range: 2-64


  Commit: eda123dc6d8e04ba7fadfd95d36b9f3ff0b1e1ff
      https://github.com/bluez/bluez/commit/eda123dc6d8e04ba7fadfd95d36b9f3ff0b1e1ff
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-09-27 (Fri, 27 Sep 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Make transport.show print all transports with no argument

This makes transport.show arguments optional and in case none is given
print all configured transports:

[bluetooth]# transport.show
Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep4/fd0
	UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
	Codec: 0x02 (2)
	Media Codec: MPEG24
	Object Types: MPEG-2 AAC LC
	Frequencies: 48kHz
	Channels: 2
	Bitrate: 320000
	VBR: Yes
	Device: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX
	State: active
	Delay: 0x06a4 (1700)
	Volume: 0x0059 (89)
	Endpoint: /org/bluez/hci0/dev_94_XX_XX_XX_XX_XX/sep4


  Commit: f7028d6a0569d295ba1fd0386c72b734da9dc8db
      https://github.com/bluez/bluez/commit/f7028d6a0569d295ba1fd0386c72b734da9dc8db
  Author: nxf92481 <vlad.pruteanu@nxp.com>
  Date:   2024-09-30 (Mon, 30 Sep 2024)

  Changed paths:
    M client/bluetoothctl-endpoint.rst
    M client/bluetoothctl-transport.rst

  Log Message:
  -----------
  client: Update endpoint and trasport doc

This updates the documentation for the use of endpoints and
transports according to the latest changes in their design.


  Commit: 20a38abb36618b14f4cf7593de3dba9634970cc7
      https://github.com/bluez/bluez/commit/20a38abb36618b14f4cf7593de3dba9634970cc7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-09-30 (Mon, 30 Sep 2024)

  Changed paths:
    M client/bluetoothctl-endpoint.rst
    M client/bluetoothctl-transport.rst

  Log Message:
  -----------
  client: Update endpoint.show and transport.show documentation

endpoint.show and transport.show argument is optional with latest
changes.


  Commit: 38734e02051364b4b6db6e684beda8c47a1ba452
      https://github.com/bluez/bluez/commit/38734e02051364b4b6db6e684beda8c47a1ba452
  Author: Cheng Jiang <quic_chejiang@quicinc.com>
  Date:   2024-09-30 (Mon, 30 Sep 2024)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Remove device after all bearers are disconnected

For a dual-mode remote, both BR/EDR and BLE may be connected,
RemoveDevice should be handled after all bearers are disconnects.
Otherwise, if msg is removed, but not all connection are dropped,
this function returns before *remove is updated, then after all
connections are dropped, but device->disconnects is NULL,
remove_device is not updated. Consequently *remove is not set to
true. Remove device is not performed in adapter_remove_connection.


Compare: https://github.com/bluez/bluez/compare/9a9dc3d456c0...38734e020513

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
