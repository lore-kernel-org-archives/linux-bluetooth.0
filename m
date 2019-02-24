Return-Path: <SRS0=Ulsa=Q7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122E6C00319
	for <linux-bluetooth@archiver.kernel.org>; Sun, 24 Feb 2019 08:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C925720661
	for <linux-bluetooth@archiver.kernel.org>; Sun, 24 Feb 2019 08:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzsTPRlV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbfBXIgj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 24 Feb 2019 03:36:39 -0500
Received: from mail-lf1-f53.google.com ([209.85.167.53]:39083 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfBXIgj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 24 Feb 2019 03:36:39 -0500
Received: by mail-lf1-f53.google.com with SMTP id m11so4668880lfc.6;
        Sun, 24 Feb 2019 00:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=tTMxV4MeKApanaJSVjYBtuPmZySYZOtvXqdpemArB88=;
        b=fzsTPRlV7Wd11dXf5px9bQpR0ugEKfiexmzYoiph2iEFiJLg73LEbdvCG9RvNgEYDE
         zvS1o/+/is158g6sNVfPPkFfjYb10PsZGT1jNS38+F2NsgnQ8W2enmQdKiYeWGz+onLy
         al0jwEOOpwpn9xFhADmvOGVraQIu6U8/Np0LG3w7vk1/6LWIgpJgFenuyqOCesX4niXG
         Wj/H43GIdJKkliZk0YLRdKVIIW9gsv+WOKGpJFCJLm6OBSoD2NB2mf4OLZeJoZIErvNJ
         ATmpvPlG59+8pnr0GiLbiZU+6x1WtNOovWjtMXv2Yu+5xuNTatBzg6UTJopbcxMBs3JC
         J+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=tTMxV4MeKApanaJSVjYBtuPmZySYZOtvXqdpemArB88=;
        b=KV3B5ocw7Q2AvnLCPcM1DZQl8ds/2FF6FqfbmNKJlOTMHVa53JrpmdXeBaRXAATR1R
         y8T4IUErMRpf2tDbl2iZpG0sqAhCTdtGEc0jpBSlq+BBR9sZK3tPF9c5u6E4aQNqHDMk
         7WJR33xiCx4OLmY4jcV5C12Ys4FpulIxeroDqCl4n99psk0v4ibjGGKyG7OtUVfYpreR
         0HaSXB1PIJoXbD1BnDcz4gdWPrR1WApxXe00k0g/D1uI36yNDuRV2lCWmNnN3qtUuHTa
         VMnLcHWRzsbNERjtuh/RZZbNo83U5mGCA9Kvd7FbyuBnvJaXnX6DHWqQPSkQjE49555W
         y1rw==
X-Gm-Message-State: AHQUAuaO4qQIdyjqmOtkQyqdSkCO2n1P+r/JO+OzrVnpq1CU0ixuJbng
        i4udVTCJ16JFheYgNYs4kd89jMmXg5Q=
X-Google-Smtp-Source: AHgI3IZ25ubENyxIIuIYQ2xPNDYV7vRaPd3DdbiDvtmda4whg5A+jLL/dnvnpcVWGRyG7P8h4G0fLg==
X-Received: by 2002:a19:e05e:: with SMTP id g30mr2456957lfj.167.1550997396365;
        Sun, 24 Feb 2019 00:36:36 -0800 (PST)
Received: from localhost (91-154-113-38.elisa-laajakaista.fi. [91.154.113.38])
        by smtp.gmail.com with ESMTPSA id q123-v6sm1726671ljb.60.2019.02.24.00.36.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 00:36:34 -0800 (PST)
Date:   Sun, 24 Feb 2019 10:36:34 +0200
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: pull request: bluetooth-next 2019-02-24
Message-ID: <20190224083634.GA82295@jhedberg-mac01.home>
Mail-Followup-To: davem@davemloft.net, netdev@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dave,

Here's the main bluetooth-next pull request for the 5.1 kernel.

 - Fixes & improvements to mediatek, hci_qca, btrtl, and btmrvl HCI drivers
 - Fixes to parsing invalid L2CAP config option sizes
 - Locking fix to bt_accept_enqueue()
 - Add support for new Marvel sd8977 chipset
 - Various other smaller fixes & cleanups

Please let me know if there are any issues pulling. Thanks.

Johan

---
The following changes since commit fa7f3a8d56b38a3ed1880a3780afba82387da277:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2019-01-21 14:41:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git for-upstream

for you to fetch changes up to e0b67035a90b58d01f911fed77b6e3da153da66e:

  Bluetooth: mediatek: update the common setup between MT7622 and other devices (2019-02-18 14:08:55 +0100)

----------------------------------------------------------------
Balakrishna Godavarthi (4):
      Bluetooth: hci_qca: Add helper to set device address
      Bluetooth: hci_qca: use wait_until_sent() for power pulses
      Bluetooth: hci_qca: Deassert RTS while baudrate change command
      Bluetooth: hci_qca: Disable IBS state machine and flush Tx buffer

Colin Ian King (2):
      Bluetooth: make hw_err static, reduces object code size
      Bluetooth: remove redundant zero check on count

Dmitry Torokhov (2):
      usb: split code locating ACPI companion into port and device
      usb: assign ACPI companions for embedded USB devices

Gustavo A. R. Silva (3):
      Bluetooth: Mark expected switch fall-throughs
      Bluetooth: hci_event: Use struct_size() helper
      Bluetooth: a2mp: Use struct_size() helper

Hemantkumar Suthar (1):
      Bluetooth: btmrvl: add support for sd8977 chipset

Jeremy Cline (1):
      Bluetooth: hci_ldisc: Initialize hci_dev before open()

Kai-Heng Feng (1):
      Bluetooth: btrtl: Restore old logic to assume firmware is already loaded

Linus Walleij (1):
      Bluetooth: btmrvl: Drop unused GPIO includes

Marcel Holtmann (2):
      Bluetooth: Check L2CAP option sizes returned from l2cap_get_conf_opt
      Bluetooth: Verify that l2cap_get_conf_opt provides large enough buffer

Matthias Kaehlcke (1):
      Bluetooth: Fix locking in bt_accept_enqueue() for BH context

Myungho Jung (2):
      Bluetooth: hci_uart: Check if socket buffer is ERR_PTR in h4_recv_buf()
      Bluetooth: Fix decrementing reference count twice in releasing socket

Raghuram Hegde (1):
      Bluetooth: btusb: Add shutdown routine for BTUSB_INTEL_NEW devices

Rajat Jain (3):
      Bluetooth: Allow driver specific cmd timeout handling
      Bluetooth: btusb: Use the cmd_timeout method to reset the Intel BT chip
      Bluetooth: btusb: btusb_intel_cmd_timeout: use sleeping functions

Sean Wang (4):
      Bluetooth: mediatek: trivial typo fix
      Bluetooth: mediatek: fix up an error path to restore bdev->tx_state
      Bluetooth: mediatek: pass a pointer to mtk_hci_wmt_sync
      Bluetooth: mediatek: update the common setup between MT7622 and other devices

Stefan Agner (2):
      Bluetooth: btmrvl: improve printk messages
      Bluetooth: btmrvl: lower log level of informational message

YueHaibing (2):
      Bluetooth: 6lowpan: Fix debugfs_simple_attr.cocci warnings
      6lowpan: fix debugfs_simple_attr.cocci warnings

 drivers/bluetooth/Kconfig         |   4 +-
 drivers/bluetooth/btmrvl_drv.h    |   2 -
 drivers/bluetooth/btmrvl_sdio.c   |  43 ++++++-
 drivers/bluetooth/btmtkuart.c     | 257 ++++++++++++++++++++++++++++++++++----
 drivers/bluetooth/btqca.c         |  19 +++
 drivers/bluetooth/btqca.h         |   8 +-
 drivers/bluetooth/btrtl.c         |  10 +-
 drivers/bluetooth/btusb.c         |  73 +++++++++++
 drivers/bluetooth/h4_recv.h       |   7 +-
 drivers/bluetooth/hci_h4.c        |   4 +
 drivers/bluetooth/hci_ldisc.c     |  21 ++--
 drivers/bluetooth/hci_qca.c       |  87 +++++++------
 drivers/usb/core/usb-acpi.c       | 163 ++++++++++++++----------
 include/net/bluetooth/bluetooth.h |   2 +-
 include/net/bluetooth/hci_core.h  |   1 +
 net/6lowpan/debugfs.c             |  42 +++----
 net/bluetooth/6lowpan.c           |  11 +-
 net/bluetooth/a2mp.c              |   2 +-
 net/bluetooth/af_bluetooth.c      |  16 ++-
 net/bluetooth/hci_core.c          |   5 +-
 net/bluetooth/hci_event.c         |   8 +-
 net/bluetooth/hci_sock.c          |   3 +-
 net/bluetooth/l2cap_core.c        |  84 ++++++++-----
 net/bluetooth/l2cap_sock.c        |   2 +-
 net/bluetooth/rfcomm/core.c       |   1 +
 net/bluetooth/rfcomm/sock.c       |   2 +-
 net/bluetooth/sco.c               |   2 +-
 27 files changed, 661 insertions(+), 218 deletions(-)

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEyxvsVXjY3jV7sQ0/JCP2+/mo1BIFAlxyV4kACgkQJCP2+/mo
1BKV4A/+OyIs0vInwbKIiyF4begaAqotuG9Nej3fpGYGf72vzL/e0DU1DTnx7QfV
gFHaxt/xecLnAwPqe1QHW2XX2JTx1TXeMT1wYl4ryW1PjA6bdvuOhHIbthcPjyw5
YGSIji0f7kA73+T+Ql6bUriMzFfZADxRrXikcjNISfgBD90ctN5Op9G9kpFQwpgH
XDb8S2zLsBMb5eSF6Iwnxt5FCGO86E2jrlShIp3lNMjfB8a/ANzikH/rM+198W3g
19Co9re/8HvM0wq+EYfjVMoD1M9DuibE9ZRhuioE4oQn/4v2CilVYFpzLrIIQGBw
jd7Y9XZgMzeWpfrFXwfUZPcqKPvse3+lB1gyffyj0qw/AzyDp0yfwcvYrRDqtFLz
iMOYAudgM+xM4ChagayLStKXzobnhtjzPWN2wmgUexJdliZK5TegijwrdUMaad30
OiqwZYuRmHVXy/YiyN5TLY5XV6/Pmu2Ys9rZB8eQBYdON+acZtaFKITlvxMzo4Hg
G8cONAGCpL1fehzLwdAoIQ0Z95J2C5x2+aYokuNCioXoh+zfO0P6IbUKXHUGcMEh
zEssHYiWH/z24qLxArZn1yVCWLqoDr8bRMxDNeViswxVLag7LPNHGodpFzar9g0a
Ha5mRPKcmtyM3OzOF54XvuBGDLlhrrOC3nLGgxZN79ncETJagUs=
=d/as
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
