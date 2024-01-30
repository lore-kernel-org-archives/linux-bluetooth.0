Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DD571B38
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jan 2024 19:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641875; cv=none; b=IM65d36KPnaFbyrHKFleq3ZBbtIqgV1m0kp6nhyGTQhQa3mL4+OyDFhCdi8+eUzCn2srh6NBpDl/i148hx8xTqO+I1kkMY5x0P+1L8LU7d5ahq6cc0cusKHPC57uCGxtglc88OORorwRHg4/I7AQQDfwVB7ON39zN2/YwW3ulFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641875; c=relaxed/simple;
	bh=jf/7npy4LsC6GqmahNtcpb7xEvrhArwXggJ4nei3kOU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=B5yCuT24qyFY6v5LtIef+8HL9WIC7LystHIc6NvTiUMO3xGHFOkgrloFxaHIHPBDLvvOBxIFb9ZazuQl3nA5MRFMzdx3wMYeXTeCc1b8Tw6Gvf5CoPt1Hg+3TW1JhqXBaERe14ed+wY71TXvlB+1CR+HGlaQ/mN+j5JZuCqM1vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cnPocdom; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cnPocdom"
Received: from github.com (hubbernetes-node-70352fc.va3-iad.github.net [10.48.140.32])
	by smtp.github.com (Postfix) with ESMTPA id 5B086E1063
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jan 2024 11:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1706641872;
	bh=vg62n62vqqENygdgMuNLtp1Hbep1iMAaAoQwD8RbH10=;
	h=Date:From:To:Subject:From;
	b=cnPocdomlg8wPYO23z4w+KwRWLBprPpngxa2MUWzzWJ/LztHZsHHpRStkLLJ3IPJC
	 UQDDHTMP9VEc9nfrQ3rsD6FcSAUOBvE0tPRi9c33B9Hj0ShhsthFlaFmRt6Bjh08GO
	 oUndLdylwyhqJbclDbv7kzejYLZ7F2KtuVkThw48=
Date: Tue, 30 Jan 2024 11:11:12 -0800
From: iulia-tanasescu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f59f49-a692cc@github.com>
Subject: [bluez/bluez] 8e4722: util: Add UTIL_IOV_INIT
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
  Commit: 8e472230055d8d1809d7dadf00919c2f81043ab7
      https://github.com/bluez/bluez/commit/8e472230055d8d1809d7dadf00919c2f81043ab7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-01-29 (Mon, 29 Jan 2024)

  Changed paths:
    M src/shared/lc3.h
    M src/shared/util.h

  Log Message:
  -----------
  util: Add UTIL_IOV_INIT

This adds UTIL_IOV_INIT macro which can be used to init elements of
struct iovec with a byte array.


  Commit: 423fcc4c4ce84cfc0f93aeaa237aaf165ec4116e
      https://github.com/bluez/bluez/commit/423fcc4c4ce84cfc0f93aeaa237aaf165ec4116e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-01-29 (Mon, 29 Jan 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add metadata support to struct capabilities

This enables defining metadata as part of the struct capabilities.


  Commit: 2faff4cadfe3f296176606fa07136bbe29eb95c3
      https://github.com/bluez/bluez/commit/2faff4cadfe3f296176606fa07136bbe29eb95c3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-01-29 (Mon, 29 Jan 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Use util_iov_dup/util_iov_free whenever possible

This uses util_iov_dup/util_iov_free whenever possible.


  Commit: 74e49f67e940e6debcd40fea259a2109eee1f82b
      https://github.com/bluez/bluez/commit/74e49f67e940e6debcd40fea259a2109eee1f82b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-01-29 (Mon, 29 Jan 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add .name field to struct capabilities

This adds .name field to struct capabilities which is then used to form
the endpoint object path so it is easier to identify the endpoint
capabilities:

[bluetooth]# endpoint.list local
/local/endpoint/pac_snk/lc3
/local/endpoint/pac_src/lc3
/local/endpoint/bcaa/lc3


  Commit: 0273602c19e6c392622f3eabd866e6be618ecc6d
      https://github.com/bluez/bluez/commit/0273602c19e6c392622f3eabd866e6be618ecc6d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-01-30 (Tue, 30 Jan 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Enable endpoint.show to work with local endpoints

This enables local endpoints to be printed with endpoint.show:

[bluetooth]# endpoint.show /local/endpoint/pac_snk/lc3
Endpoint /local/endpoint/pac_snk/lc3
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
	Capabilities.#2: len 0x02 type 0x03
	Capabilities.Audio Channel Count: 0x03
	Capabilities.Audio Channel Count: 1 channel (0x01)
	Capabilities.Audio Channel Count: 2 channel (0x02)
	Capabilities.#3: len 0x05 type 0x04
	Capabilities.Frame Length: 30 (0x001e) - 240 (0x00f0)
	Locations 0x00000003 (3)
	SupportedContext 0x00000fff (4095)
	Context 0x00000fff (4095)


  Commit: 12ccf5ea0fa53059e0870a49b67a36bdd21fe0c8
      https://github.com/bluez/bluez/commit/12ccf5ea0fa53059e0870a49b67a36bdd21fe0c8
  Author: Archie Pusaka <apusaka@chromium.org>
  Date:   2024-01-30 (Tue, 30 Jan 2024)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  Monitor: Remove handle before assigning

It is possible to have some handles not removed, for example the host
may decide not to wait for disconnection complete event when it is
suspending. In this case, when the peer device reconnected, we might
have two of the some handle assigned and create problem down the road.

This patch solves the issue by always removing any previous handles
when assigning a new handle if they are the same.

Reviewed-by: Zhengping Jiang <jiangzp@google.com>


  Commit: e98bbe3f1cb20bf045c82a13186fea7a0bfb8187
      https://github.com/bluez/bluez/commit/e98bbe3f1cb20bf045c82a13186fea7a0bfb8187
  Author: Archie Pusaka <apusaka@chromium.org>
  Date:   2024-01-30 (Tue, 30 Jan 2024)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  Monitor: Avoid printing stale address on connection event

We now remove potentially stale handle when assigning a new handle.
However, that is done after printing the handle and the stale address
associated with it.

Directly use print_field instead of print_handle to avoid printing the
stale address. We still print the correct address on the following
line anyway.


  Commit: 2aecc09ada8b645cddc476175727a793215279d6
      https://github.com/bluez/bluez/commit/2aecc09ada8b645cddc476175727a793215279d6
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-01-30 (Tue, 30 Jan 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Parse BIG handle at endpoint config

This adds support to parse the "BIG" key in bcast qos parser, at
endpoint configuration.


  Commit: 5c90ef8d8247e857113f2ba220393f73634898b1
      https://github.com/bluez/bluez/commit/5c90ef8d8247e857113f2ba220393f73634898b1
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-01-30 (Tue, 30 Jan 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Set bcast stream metadata

This updates bt_bap_stream_metadata to handle broadcast streams,
by setting stream medatada.


  Commit: 711814570bad07451e0c1c873f3b46c01a8d8d1f
      https://github.com/bluez/bluez/commit/711814570bad07451e0c1c873f3b46c01a8d8d1f
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-01-30 (Tue, 30 Jan 2024)

  Changed paths:
    M src/shared/lc3.h

  Log Message:
  -----------
  shared/lc3: Add macro for Channel Allocation LTV len

This adds a macro for the Audio_Channel_Allocation LTV len.


  Commit: a692cc44dc8735b9303f8893f784306b4d2654fe
      https://github.com/bluez/bluez/commit/a692cc44dc8735b9303f8893f784306b4d2654fe
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-01-30 (Tue, 30 Jan 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Update bcast endpoint input prompts

This updates the input prompts for broadcast endpoint register and
config.

To register a broadcast endpoint, the user will be asked to enter
the supported stream locations and context types.

At broadcast source endpoint config, the user will provide stream
config options: The BIG that the new stream will be part of, the
stream Channel Allocation, and the metadata of the subgroup to
include the stream. These options will be used to configure the
BASE and the BIG.

The flow to create a Broadcast Source is the following:

[bluetooth]# endpoint.register 00001852-0000-1000-8000-
00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 3
[/local/endpoint/ep0] Supported Context (value): 15
[NEW] Endpoint /org/bluez/hci0/pac_bcast0
Endpoint /local/endpoint/ep0 registered

[bluetooth]# endpoint.config /org/bluez/hci0/pac_bcast0
/local/endpoint/ep0 16_2_1
[/local/endpoint/ep0] BIG (auto/value): 1
[/local/endpoint/ep0] Enter channel location (value/no): 3
[/local/endpoint/ep0] Enter Metadata (value/no): 0x03 0x02
0x04 0x00

To create a Broadcast Sink, enter the following:

[bluetooth]# endpoint.register 00001851-0000-1000-8000-
00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 3
[/local/endpoint/ep0] Supported Context (value): 15

[bluetooth]# scan on
[NEW] Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/
pac_bcast0

[bluetooth]# endpoint.config
/org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_bcast0
/local/endpoint/ep0 16_2_1


Compare: https://github.com/bluez/bluez/compare/f59f4902bc4e...a692cc44dc87
