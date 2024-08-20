Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5814918E361
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166514; cv=none; b=sdIWbRYymej8crFdWmD/JoIt/cSds1EgCLxA+7haFYoavpLuSNy6PCmShp74aDfPw5LIqVbHvVGxx6m2RN6fy9yfJyj8dNJBpnQih667oTX7ekuvARntEtaF7iahTexNxPNTNt1/VIBjRJtNcFnhtUWaDnE6C0jhqbM20FAj2Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166514; c=relaxed/simple;
	bh=oiCEU+91Vt4hPy58XRxp2Llmw/rQhdinhJUhPjUaQjM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Hiz0PrzxfFwqSlU8UiPfvmpR1PlUxzWakTcJ0FNGvXYuyvRC8SD9txkEk+lTXhKM7c2+zz8br4T1yx6Fon4NxYLnd+zzcOtOlgfotobpoHBKIuGNTkyUj5I/rN82CkVnq+RH6mlc3FVMa0HtM9AkFskhmi5xJEX2GM5UWHHp+Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ev/9C7IU; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ev/9C7IU"
Received: from github.com (hubbernetes-node-5dadfdf.va3-iad.github.net [10.48.140.34])
	by smtp.github.com (Postfix) with ESMTPA id 547A4E1402
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 08:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1724166510;
	bh=eF2xavjx89+qLbFVVtDZbkzTWYDx5aMk5FoDmvGDa9g=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ev/9C7IUmiLbd/zHwvN2ipY/ZSs2Xj8E8Yq3LKbpjQmm/t5tCSS7fc84Jtf6vP6nC
	 F1GsJqACAgtICIDygOfbp0h9HUrcdWWhEU0eOKc23jVxwbMFI7GxnwPmHtraNq8Siy
	 dIcnyrY/5wITG8eQaQL5p8pKQUVQ/cGM7bDjhIOU=
Date: Tue, 20 Aug 2024 08:08:30 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/29d454-d5c68d@github.com>
Subject: [bluez/bluez] b35d0a: client/player: Add support for entering
 metadata v...
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
  Commit: b35d0a45baf260a6a626c3f52b074159fdad259c
      https://github.com/bluez/bluez/commit/b35d0a45baf260a6a626c3f52b074159fdad259c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-08-16 (Fri, 16 Aug 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add support for entering metadata via endpoint.presets


  Commit: a59529d3bac6fc6dc785102f5312acbd9d1c8be8
      https://github.com/bluez/bluez/commit/a59529d3bac6fc6dc785102f5312acbd9d1c8be8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-08-19 (Mon, 19 Aug 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Make endpoint.presets accept endpoint object

This makes endpoint.presets accept local endpoints rather than just
UUIDs:

[bluetooth]# endpoint.presets /local/endpoint/ep0 32_1_1


  Commit: c909433ed23b1f2645b314ba7df99adb66cd91a1
      https://github.com/bluez/bluez/commit/c909433ed23b1f2645b314ba7df99adb66cd91a1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-08-19 (Mon, 19 Aug 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Make endpoint.show print local preset

This makes command endpoint.show print preset set with endpoint.presets:

>endpoint.show /local/endpoint/ep2
Endpoint /local/endpoint/ep2
	UUID 00002bc9-0000-1000-8000-00805f9b34fb
	Codec 0x06 (6)
	Capabilities.#0: len 0x03 type 0x01
	Capabilities.Sampling Frequencies: 0x00ff
	Capabilities.Sampling Frequency: 8 Khz (0x0001)
	Capabilities.Sampling Frequency: 11.25 Khz (0x0002)
	Capabilities.Sampling Frequency: 16 Khz (0x0004)
	Capabilities.Sampling Frequency: 22.05 Khz (0x0008)
	Capabilities.Sampling Frequency: 24 Khz (0x0010)
	Capabilities.Sampling Frequency: 32 Khz (0x0020)
	Capabilities.Sampling Frequency: 44.1 Khz (0x0040)
	Capabilities.Sampling Frequency: 48 Khz (0x0080)
	Capabilities.#1: len 0x02 type 0x02
	Capabilities.Frame Duration: 0x03
	Capabilities.Frame Duration: 7.5 ms (0x01)
	Capabilities.Frame Duration: 10 ms (0x02)
	Capabilities.#2: len 0x05 type 0x04
	Capabilities.Frame Length: 26 (0x001a) - 240 (0x00f0)
	Capabilities.#3: len 0x02 type 0x03
	Capabilities.Audio Channel Count: 0x01
	Capabilities.Audio Channel Count: 1 channel (0x01)
	Preset 32_1_1
	Configuration.#0: len 0x02 type 0x01
	Configuration.Sampling Frequency: 32 Khz (0x06)
	Configuration.#1: len 0x02 type 0x02
	Configuration.Frame Duration: 7.5 ms (0x00)
	Configuration.#2: len 0x03 type 0x04
	Configuration.Frame Length: 60 (0x003c)
	Locations 0x00000002 (2)


  Commit: 168ea3078066d293e915280bb55ededa7d109abe
      https://github.com/bluez/bluez/commit/168ea3078066d293e915280bb55ededa7d109abe
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-08-19 (Mon, 19 Aug 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Print endpoint preset with endpoint.presets

If just the endpoint objects is passed to endpoint.presets then just
print it instead of the listing the presets available for the UUID:

[bluetooth]# endpoint.presets /local/endpoint/ep2
	Preset 32_1_1
	Configuration.#0: len 0x02 type 0x01
	Configuration.Sampling Frequency: 32 Khz (0x06)
	Configuration.#1: len 0x02 type 0x02
	Configuration.Frame Duration: 7.5 ms (0x00)
	Configuration.#2: len 0x03 type 0x04
	Configuration.Frame Length: 60 (0x003c)


  Commit: 1cc3cf08c4934e3c4dc1413e11ac84ac53ea28cf
      https://github.com/bluez/bluez/commit/1cc3cf08c4934e3c4dc1413e11ac84ac53ea28cf
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-08-19 (Mon, 19 Aug 2024)

  Changed paths:
    M profiles/input/hog-lib.c

  Log Message:
  -----------
  hog-lib: Fix calling bt_uhid_destroy with invalid instance

If the hog->uhid cannot be created then it is pointless to call
bt_uhid_destroy as it will likely just produce bogus output as in:

https://github.com/bluez/bluez/issues/529#issuecomment-2297350805


  Commit: d5c68dbed1eeffd62f55030bdc383c7a684daf69
      https://github.com/bluez/bluez/commit/d5c68dbed1eeffd62f55030bdc383c7a684daf69
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-08-19 (Mon, 19 Aug 2024)

  Changed paths:
    M profiles/input/hog-lib.c

  Log Message:
  -----------
  hog-lib: Add logging when bt_uhid_new fails

If bt_uhid_new fails there is likely a problem with uHID module or
bluetoothd don't have previleges to access /dev/uhid.


Compare: https://github.com/bluez/bluez/compare/29d4540828a1...d5c68dbed1ee

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
