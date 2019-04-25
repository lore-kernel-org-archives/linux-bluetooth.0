Return-Path: <SRS0=UcDi=S3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24A6C43219
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Apr 2019 13:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937E4206C0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Apr 2019 13:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISJuBQV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfDYNiO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Apr 2019 09:38:14 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:35261 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDYNiO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Apr 2019 09:38:14 -0400
Received: by mail-pf1-f179.google.com with SMTP id t21so11216969pfh.2;
        Thu, 25 Apr 2019 06:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=w0FZt+tk1YBEWcblzOlqRS3J1n81UsfcOzcMFq0uSRg=;
        b=ISJuBQV6a5MlSMAZnBR7GPXT7T/MD+elEMrOHYOj58XKuhDT5ug7uyETDXz/1sEFvi
         bt/pEfY3qHV0CeTArFWKcuYPqh+mtL70F/eFMuDyKfRHSV34UK9bsrYKf/OYe8cNUOvP
         JgEUn2QV7x6PI1wztwPdZXGb8vHBkVpGA/3ZIsrpjI1WQes/OhG/fReZFJTvTfdaD1Ox
         OvPW2S9tuSdrwuLkwA0DoIq3f1wzcDCEe4DD5Ab9Ep3AAs88TyW7JLMEI/LMDjGBHO62
         09hUc2Wgac1RqtwYGk52MxMHYcYqwrQdD6Hx8CrqvGVYryA0c/UeU632maERF8zgQ/uN
         WhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=w0FZt+tk1YBEWcblzOlqRS3J1n81UsfcOzcMFq0uSRg=;
        b=hHKK9gqWpX7VXqfs/1IkFbgwrCVYHvd3ZC6/6eC6IJQKAXJM7gZtppoaEAuqsBxqjl
         rIABAg6K83b5+Jo8PzHs7w3gAW94l/zdQSR2bzVpzeco+O5fx9rvUTULj7/Pyb6ZDMOw
         GQkNpH+ATeZUl2nU13bVJ62o40uvROvCTCh0ynfInXe0rGzdQAVDYcV+qP9DQtXs6umT
         III6Zoj3PxDcxxCSylP1gmUferNM9t6drCEsI3q1tqQw3gEExh9w8D36/IO+aecLOx0w
         OBeQ4N0AdSAnwBraw4cfarVlVoo0MZLp9RFE8AtRzcvMmFfD1NVBaUJgC2ipBEDHH+6E
         IdgQ==
X-Gm-Message-State: APjAAAWUv7SmuOklGcz2X1KDLjI53g+0ZWUL1uyGx22+QrsGAY/OfKCL
        zYpp9w07i0SqTHp3n4rZuq1CHtNxP2PKvg==
X-Google-Smtp-Source: APXvYqxQKuz+Aj9w9mMgZBlJn22aoPi2NGZAkee04WrJuY71SOuRZyZooPtrVcQmE+ktGupao7YvSg==
X-Received: by 2002:a63:f26:: with SMTP id e38mr38114549pgl.290.1556199493548;
        Thu, 25 Apr 2019 06:38:13 -0700 (PDT)
Received: from localhost (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id t12sm43371822pfl.59.2019.04.25.06.38.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 06:38:12 -0700 (PDT)
Date:   Thu, 25 Apr 2019 06:38:10 -0700
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: pull request: bluetooth-next 2019-04-25
Message-ID: <20190425133810.GB67839@jhedberg-mac01.local>
Mail-Followup-To: davem@davemloft.net, netdev@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

Here's the main bluetooth-next pull request for the 5.2 kernel.

 - Added support for Mediatek SDIO controllers
 - Added support for Broadcom BCM2076B1 UART controller
 - Added support for Marvel SD8987 chipset
 - Fix buffer overflow bug in hidp protocol
 - Various other smaller fixes & improvements

Please let me know if there are any issues pulling. Thanks.

Johan

---
The following changes since commit 7e6e185c74dd8a8dc539300c079adc6bc27045d6:

  net: systemport: Remove need for DMA descriptor (2019-04-22 22:20:15 -070=
0)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t for-upstream

for you to fetch changes up to d5bb334a8e171b262e48f378bd2096c0ea458265:

  Bluetooth: Align minimum encryption key size for LE and BR/EDR connection=
s (2019-04-25 06:18:07 -0700)

----------------------------------------------------------------
Balakrishna Godavarthi (2):
      Bluetooth: hci_qca: Give enough time to ROME controller to bootup.
      Bluetooth: hci_core: Don't stop BT if the BD address missing in dts

Chen-Yu Tsai (1):
      Bluetooth: hci_bcm: Fix empty regulator supplies for Intel Macs

Colin Ian King (1):
      Bluetooth: hci_h5: fix spelling mistake "sliped" -> "slipped"

Dan Carpenter (1):
      6lowpan: Off by one handling ->nexthdr

Ferry Toth (1):
      Bluetooth: btbcm: Add default address for BCM43341B

Fugang Duan (1):
      Bluetooth: Add return check for L2CAP security level set

Gustavo A. R. Silva (1):
      Bluetooth: Use struct_size() helper

Jaganath Kanakkassery (1):
      Bluetooth: Fix incorrect pointer arithmatic in ext_adv_report_evt

Luiz Augusto von Dentz (1):
      Bluetooth: Fix not initializing L2CAP tx_credits

Marcel Holtmann (1):
      Bluetooth: Align minimum encryption key size for LE and BR/EDR connec=
tions

Matthias Kaehlcke (3):
      Bluetooth: hci_qca: Add helper function to get the chip family
      Bluetooth: btqca: Fix misspelling of 'baudrate'
      Bluetooth: hci_qca: Fix crash with non-serdev devices

Sean Wang (11):
      mmc: add SDIO identifiers for MediaTek Bluetooth devices
      Bluetooth: mediatek: add support for MediaTek MT7663S and MT7668S SDI=
O devices
      mmc: sdio: Add helper macro for sdio_driver boilerplate
      Bluetooth: mediatek: Use module_sdio_driver helper
      Bluetooth: btsdio: Use module_sdio_driver helper
      Bluetooth: btmtksdio: fix uninitialized symbol errors in btmtksdio_rx=
_packet
      Bluetooth: mediatek: Fixed incorrect type in assignment
      Bluetooth: btmtksdio: Drop newline with bt_dev logging macros
      Bluetooth: btmtksdio: Add a bit definition for CHLPCR
      Bluetooth: btmtksdio: Fix hdev->stat.byte_rx accumulation
      Bluetooth: btmtksdio: Add runtime PM support to SDIO based Bluetooth

Stephan Gerhold (1):
      Bluetooth: btbcm: Add entry for BCM2076B1 UART Bluetooth

Tam=C3=A1s Sz=C5=B1cs (1):
      Bluetooth: btmrvl: add support for SD8987 chipset

Young Xiao (1):
      Bluetooth: hidp: fix buffer overflow

 drivers/bluetooth/Kconfig        |   15 +-
 drivers/bluetooth/Makefile       |    1 +
 drivers/bluetooth/btbcm.c        |    5 +-
 drivers/bluetooth/btmrvl_sdio.c  |   36 ++
 drivers/bluetooth/btmtksdio.c    | 1101 ++++++++++++++++++++++++++++++++++=
++++
 drivers/bluetooth/btmtkuart.c    |    2 +-
 drivers/bluetooth/btqca.h        |    2 +-
 drivers/bluetooth/btsdio.c       |   15 +-
 drivers/bluetooth/hci_bcm.c      |   20 +-
 drivers/bluetooth/hci_h5.c       |    2 +-
 drivers/bluetooth/hci_qca.c      |   50 +-
 include/linux/mmc/sdio_func.h    |   12 +
 include/linux/mmc/sdio_ids.h     |    2 +
 include/net/bluetooth/hci_core.h |    3 +
 net/6lowpan/nhc.c                |    2 +-
 net/bluetooth/hci_conn.c         |    8 +
 net/bluetooth/hci_core.c         |    2 -
 net/bluetooth/hci_event.c        |    2 +-
 net/bluetooth/hidp/sock.c        |    1 +
 net/bluetooth/l2cap_core.c       |    9 +-
 net/bluetooth/l2cap_sock.c       |    7 +-
 net/bluetooth/mgmt.c             |   11 +-
 22 files changed, 1246 insertions(+), 62 deletions(-)
 create mode 100644 drivers/bluetooth/btmtksdio.c


--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEyxvsVXjY3jV7sQ0/JCP2+/mo1BIFAlzBuD4ACgkQJCP2+/mo
1BIUgRAAst/w0saUyc3/DwbtzwYflLPqfD+HBdWXqZxSeXSI2q9T+Feh+b7fq26j
kpGQI09QfLdyegAFzJBPoYV4i8VE8ZAVV6fuC+toyHW70vGeEP4gqEL82MZio9Dr
MUbj9J2Xm6EEBKoAjKPfzEW9O7SREnKAj+ysflG9J4rru0N4d07BfK8sHqz8UX0T
cPHbkuDBYaABf8t+iGRoXRpoAT2v78OZqfAmRJ5KShrE7Dv05BpzpV71WREVx2o1
zAoTqlNORVbqkyWVM134KhAykV4itX7KqcVGHhtaez8pVNrCrzlY7KRJaEHTjhrB
zedDYooZjlpWFZQ34fSlRIhvbThra8xtXVJ6Y/LaYPd+MaY2+vloRBRCZjhDPEe7
OtkJGmXsLaODenlsbb+P190rMxDJc9zzVV0NpAUBa6Z6pHJ37XCbn5e8+NhFpsGp
qKKdCtXS5/OWbf9I+zF5xIMG/wED0afwnoHWcvjz6xWtvNkwd1leURY9syCfGjzE
lu1SCYGsUeY1qNLXOjzcP2n1+zDz4ANTiKU0FvFXBKeMqdpg5n9TaohIiqh0WTM8
uhNKhl//l+rxGew6u8VuvJgAGcAAYxy3H2I/oZ8Ux+VQ7DCn+PxNEdwN6DIowhPv
DCsqco0bjqL/ZKymewJJVIpnbsp7P42hEqLIpgNs9pnBQ930jbA=
=zg9x
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
