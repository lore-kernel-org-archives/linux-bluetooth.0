Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C0E79FD
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Sep 2024 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726673123; cv=none; b=pRXhF3pa6l4vZeZKoyAuXgb4WS0AJq3U6nBVoTFtjWlm1IbQzi9jJKiAaWZ0+VFluvb3iJBExGS9GEgrE8tXYs4zEF89XuKn+OVxJoKMSzTH4Y3yGhDi1u0kx0h294Ivuhf9dO8mB0dwKavfGc9kNTJI9sbSYYjB40CepN7CsdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726673123; c=relaxed/simple;
	bh=u5zQ6UYf6OLs44OS+u/6k2vfsjcP0lWr67uTBu7URLA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=NSIp3JhtjU0FAHhayuCz4Z74dgZNdcv5JUnog9wGhQ6EA6iuVldqzYXTZzgOYpdJCUOxcZ6r5N5+pHOGlMxNxOeFOEY7faxq+BnBSyuwLp58+9yPJA4GTmxUDTwYGbOq5SqGvT87adAnCLfl6sIvI6Q2OObX9Yd6gNWTSfh9Dnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gJvAA2Gl; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gJvAA2Gl"
Received: from github.com (hubbernetes-node-c0572db.va3-iad.github.net [10.48.156.35])
	by smtp.github.com (Postfix) with ESMTPA id DA6C78C0A3F
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Sep 2024 08:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1726673120;
	bh=JYGFfpKCxGLM/rj6+zLwZ8gZZCpC28/PMZz5n/HCnUA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gJvAA2Glx5ncaitsAL6JobkjojBquYmZsluivLOB275mC4x6Mdmv5HLZj2lanPD+y
	 O7Ewhe1Y/ZijiP4BM0t+3YVcpi2pUY+zvg26OXf+BVIhW4A8v8MYbTW9/sJ8htDZYj
	 PG0ofIOu+lzeuUDot8Pa9NIiAY3I/gY8YKJVTu8o=
Date: Wed, 18 Sep 2024 08:25:20 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/8562d0-7aa245@github.com>
Subject: [bluez/bluez] 9a6a84: shared/uhid: Fix crash after
 bt_uhid_unregister_all
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
  Commit: 9a6a84a8a2b9336c2cdb943146207cb8a5a5260c
      https://github.com/bluez/bluez/commit/9a6a84a8a2b9336c2cdb943146207=
cb8a5a5260c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-09-16 (Mon, 16 Sep 2024)

  Changed paths:
    M src/shared/uhid.c

  Log Message:
  -----------
  shared/uhid: Fix crash after bt_uhid_unregister_all

This fixes the following crash which happens when
bt_uhid_unregister_all is called from a notification callback:

Invalid read of size 8
   at 0x1D9EFF: queue_foreach (queue.c:206)
   by 0x1DEE58: uhid_read_handler (uhid.c:164)
 Address 0x51286d8 is 8 bytes inside a block of size 16 free'd
   at 0x48478EF: free (vg_replace_malloc.c:989)
   by 0x1DA08D: queue_remove_if (queue.c:292)
   by 0x1DA12F: queue_remove_all (queue.c:321)
   by 0x1DE592: bt_uhid_unregister_all (uhid.c:300)

Fixes: https://github.com/bluez/bluez/issues/952


  Commit: f9f98c0b2aa44fe47482e083d428fa3b54ecdeb2
      https://github.com/bluez/bluez/commit/f9f98c0b2aa44fe47482e083d428f=
a3b54ecdeb2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-09-16 (Mon, 16 Sep 2024)

  Changed paths:
    M unit/test-uhid.c

  Log Message:
  -----------
  test-uhid: Add call to bt_uhid_unregister_all

This adds a call to bt_uhid_unregister_all so it tests if notification
callback end up calling that.


  Commit: 2908491c7efee5e14e880aa7a49ee6e5f098a24d
      https://github.com/bluez/bluez/commit/2908491c7efee5e14e880aa7a49ee=
6e5f098a24d
  Author: Celeste Liu <coelacanthushex@gmail.com>
  Date:   2024-09-17 (Tue, 17 Sep 2024)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: fix buffer overflow when terminal width > 255

In current code, we create line buffer with size 256, which can contains
255 ASCII characters. But in modern system, terminal can have larger
width. It may cause buffer overflow in snprintf() text.

limits.h provides constant LINE_MAX.

    {LINE_MAX}
        Unless otherwise noted, the maximum length, in bytes, of a
        utility's input line (either standard input or another
        file), when the utility is described as processing text
        files. The length includes room for the trailing <newline>.
        Minimum Acceptable Value: {_POSIX2_LINE_MAX}


  Commit: 1428d8461e92650f4414b3443bc6adc7cce70c49
      https://github.com/bluez/bluez/commit/1428d8461e92650f4414b3443bc6a=
dc7cce70c49
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-09-17 (Tue, 17 Sep 2024)

  Changed paths:
    M src/shared/shell.c
    M src/shared/shell.h

  Log Message:
  -----------
  shared/shell: Add bt_shell_get_timeout()

Make it possible to get the value of the general --timeout option.


  Commit: ae6dab10760637973ea966de535511ede6c5645b
      https://github.com/bluez/bluez/commit/ae6dab10760637973ea966de53551=
1ede6c5645b
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-09-17 (Tue, 17 Sep 2024)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Respect --timeout when bluetoothd isn't running

Exit after <timeout> seconds if bluetoothd isn't available. This
functionality is useful for non-interactive uses of bluetoothctl.


  Commit: 1a681aa0143e1b8f4e5d4ba7a74d26af398c3f75
      https://github.com/bluez/bluez/commit/1a681aa0143e1b8f4e5d4ba7a74d2=
6af398c3f75
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2024-09-17 (Tue, 17 Sep 2024)

  Changed paths:
    M Makefile.obexd
    M doc/org.bluez.obex.Client.rst
    A obexd/client/bip.c
    A obexd/client/bip.h
    M obexd/client/manager.c

  Log Message:
  -----------
  obexd: Add BIP client for AVRCP cover art download

The cover art image handle is available in the metadata of the track
when the OBEX BIP session is connected to the PSM port provided
in AVRCP SDP record and available as org.bluez.MediaPlayer property.

This service allows to get the thumbnail.


  Commit: 3ecf9b3398ac7aaa6eb7330a62685739a8bf611d
      https://github.com/bluez/bluez/commit/3ecf9b3398ac7aaa6eb7330a62685=
739a8bf611d
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2024-09-17 (Tue, 17 Sep 2024)

  Changed paths:
    M Makefile.obexd
    A obexd/client/bip-common.c
    A obexd/client/bip-common.h
    M obexd/client/bip.c

  Log Message:
  -----------
  obexd: Add Properties to org.bluez.obex.Image

This allows to get the different version of the image provided by
the remote device to chose the one to use with Get.

This bip-common.[ch] files are based on previous work done by
Jakub Adamek for GSoC 2011, see [1] and [2].

[1] https://www.bluez.org/gsoc-basic-image-profilebip/
[2] https://github.com/enkait/Basic-Imaging-Profile-in-obexd/blob/gsoc_fi=
nal/plugins/bip_util.c


  Commit: 088594d5299a7fbffe737666d9b13684a68374d5
      https://github.com/bluez/bluez/commit/088594d5299a7fbffe737666d9b13=
684a68374d5
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2024-09-17 (Tue, 17 Sep 2024)

  Changed paths:
    M obexd/client/bip-common.c
    M obexd/client/bip-common.h
    M obexd/client/bip.c

  Log Message:
  -----------
  obexd: Add Get to org.bluez.obex.Image

Retrieves the image corresponding to the handle and the description,
as one of the descriptions retrieved by Properties, and store it in
a local file.

If the "transform" property description exists it should be set
to one of the value listed by Properties for this description.


  Commit: 140903fb992a251b69ed2f13b030e51c33d1f0d0
      https://github.com/bluez/bluez/commit/140903fb992a251b69ed2f13b030e=
51c33d1f0d0
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2024-09-17 (Tue, 17 Sep 2024)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  avrcp: Update controller SDP record with cover art support


  Commit: 7aa245979db6ee74b665154f5c1f203a277eb64a
      https://github.com/bluez/bluez/commit/7aa245979db6ee74b665154f5c1f2=
03a277eb64a
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2024-09-17 (Tue, 17 Sep 2024)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.obex.Image.rst

  Log Message:
  -----------
  doc: Add description of org.bluez.obex.Image

This new interface allows to get the image referenced in the audio
metadata ImgHandle available in org.bluez.MediaPlayer track properties.
The image handle is only available in track info if an OBEX session is
connected to the ObexPort port provided in  org.bluez.MediaPlayer
properties.


Compare: https://github.com/bluez/bluez/compare/8562d0e3874e...7aa245979d=
b6

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
