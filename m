Return-Path: <SRS0=018A=MM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA5CC004D2
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Sep 2018 07:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F53B2082A
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Sep 2018 07:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0rwjVJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F53B2082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbeI3OIf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 Sep 2018 10:08:35 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:40629 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbeI3OIf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 Sep 2018 10:08:35 -0400
Received: by mail-lj1-f172.google.com with SMTP id r83-v6so9322730ljr.7;
        Sun, 30 Sep 2018 00:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=qQdSbUA57qtvgH37vz5IOPITWtOHvDsdfYFbulet6zo=;
        b=V0rwjVJhf4yYa4mdtWNVso1/3X7dskPR1Rcb1SIn1RKMmGR8zDjQlAQH9cQlEFwi31
         B9JDYR1u5jtAjGgTztZOLfHZQ+qzVV54d49LaJdJ132hi3rG5qwerk+St8bJdTxnMtl7
         nKS9xXpwTXT6l1pnulxCdPAR5NM9ozpwD/a/tRu8fgMpYjI8ydJ0wGI1HzrQvmApDBmm
         2xnKFFExf3X0NPhKzMpHyuEpYyITMamzQHBmh1k9xMy08ps/T2e0tIIjSUxHOj+7TSzd
         w5oJTb8IuoNnAB4HFtYMbUs2KJR7sbKjmTDAtUfj0SDEkkRrpgaerS7g/O6jkLFYCM1v
         qNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=qQdSbUA57qtvgH37vz5IOPITWtOHvDsdfYFbulet6zo=;
        b=bAXo3vtMQ6JuXNSgLaibiH7jJot0Cyq655oI8nu3FF0spHjQFGlFXZWc0Mg8nFIAL3
         +eoM8mHwLCmmKxWsQtLw//mIIISS8fnxvadNcM8LkCVJs9XY403kFzMBdrJM/P30VqnK
         kq0YEzP9s7rvW+AHx3L7MCV5o/62CFltouY584NUYB4qhBWtNf2RFpxLID3AqM1bVs5r
         3cYl8Q6xcBOE1VHpkjV/phZlziWgEgmM3VCrrvBgTQj/lMUO097KNwO4amt5pjRRyNXt
         +6FY/vh55D4g6yPV9WljD38xEdvJE4mZWAsPhRs/71ql0Mxh3UtOcTg0GQyeTb9cQCk/
         G10Q==
X-Gm-Message-State: ABuFfoi8dTxbZYOkCxykApd6adugzv+pT0plKHdJjeVUbOFR6PJT+0Ez
        3HTMXGXE4G9RREqoTI06flfyViZr
X-Google-Smtp-Source: ACcGV63BTnmbCoVrLqVZ0atcmmDoDI9YL86rbYvr1icJw8k2YRNChyn9/mv5cE3gBltc0rRn4iBogQ==
X-Received: by 2002:a2e:9e10:: with SMTP id e16-v6mr3238444ljk.169.1538292999680;
        Sun, 30 Sep 2018 00:36:39 -0700 (PDT)
Received: from x1c.home (91-154-113-38.elisa-laajakaista.fi. [91.154.113.38])
        by smtp.gmail.com with ESMTPSA id y1-v6sm1640610lfk.89.2018.09.30.00.36.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Sep 2018 00:36:38 -0700 (PDT)
Date:   Sun, 30 Sep 2018 10:36:36 +0300
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     davem@davemloft.net
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: pull request: bluetooth-next 2018-09-30
Message-ID: <20180930073636.GA25786@x1c.home>
Mail-Followup-To: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dave,

Here's the first bluetooth-next pull request for the 4.20 kernel.

 - Fixes & cleanups to hci_qca driver
 - NULL dereference fix to debugfs
 - Improved L2CAP Connection-oriented Channel MTU & MPS handling
 - Added support for USB-based RTL8822C controller
 - Added device ID for BCM4335C0 UART-based controller
 - Various other smaller cleanups & fixes

Please let me know if there are any issues pulling. Thanks.

Johan

---
The following changes since commit 1042caa79e9351b81ed19dc8d2d7fd6ff51a4422:

  net-ipv4: remove 2 always zero parameters from ipv4_redirect() (2018-09-26 20:30:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git for-upstream

for you to fetch changes up to 30d65e0804d58a03d1a8ea4e12c6fc07ed08218b:

  Bluetooth: Fix debugfs NULL pointer dereference (2018-09-28 20:53:48 +0200)

----------------------------------------------------------------
Alex Lu (1):
      Bluetooth: btrtl: Add support for RTL8822C with USB interface

Andrea Parri (1):
      Bluetooth: Remove unnecessary smp_mb__{before,after}_atomic

Ankit Navik (1):
      Bluetooth: Add definitions and track LE resolve list modification

Balakrishna Godavarthi (5):
      Bluetooth: hci_qca: Remove serdev_device_open/close function calls
      Bluetooth: hci_qca: Remove hdev dereference in qca_close().
      Bluetooth: hci_serdev: clear HCI_UART_PROTO_READY to avoid closing proto races
      Bluetooth: hci_serdev: Add protocol check in hci_uart_dequeue().
      Bluetooth: hci_qca: Add poweroff support during hci down for wcn3990

Christian Hewitt (1):
      Bluetooth: btbcm: Add entry for BCM4335C0 UART bluetooth

Colin Ian King (1):
      Bluetooth: btrtl: Make array extension_sig static, shrinks object size

Ding Xiang (1):
      Bluetooth: bt3c_cs: Fix obsolete function

Jagdish Tirumala (1):
      Bluetooth: hci_serdev: Fixed error space required before open paranethesis

Justin TerAvest (1):
      Bluetooth: btusb: Add quirk for BTUSB_INTEL_NEW

Luiz Augusto von Dentz (3):
      Bluetooth: L2CAP: Derive MPS from connection MTU
      Bluetooth: L2CAP: Derive rx credits from MTU and MPS
      Bluetooth: L2CAP: Detect if remote is not able to use the whole MPS

Luiz Carlos Ramos (1):
      Bluetooth: ath3k: add more information to error message

Matias Karhumaa (1):
      Bluetooth: Fix debugfs NULL pointer dereference

Sanjay Kumar Konduri (1):
      Bluetooth: btrsi: fix bt tx timeout issue

 drivers/bluetooth/ath3k.c        | 11 ++++---
 drivers/bluetooth/bt3c_cs.c      |  9 ++++--
 drivers/bluetooth/btbcm.c        |  1 +
 drivers/bluetooth/btrsi.c        | 13 +++++++-
 drivers/bluetooth/btrtl.c        | 10 +++++-
 drivers/bluetooth/btusb.c        |  1 +
 drivers/bluetooth/hci_qca.c      | 50 +++++++++++++++++++++++++-----
 drivers/bluetooth/hci_serdev.c   | 10 +++---
 include/net/bluetooth/hci.h      | 14 +++++++++
 include/net/bluetooth/hci_core.h | 17 +++++++++++
 include/net/bluetooth/l2cap.h    |  3 --
 net/bluetooth/bnep/core.c        |  7 +++--
 net/bluetooth/cmtp/core.c        | 14 +++++----
 net/bluetooth/hci_core.c         | 65 +++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        | 47 ++++++++++++++++++++++++++++
 net/bluetooth/hidp/core.c        | 13 +++++---
 net/bluetooth/l2cap_core.c       | 66 ++++++++++++++++++++++++++--------------
 net/bluetooth/smp.c              | 23 ++++++--------
 18 files changed, 299 insertions(+), 75 deletions(-)

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbsH0EAAoJECQj9vv5qNQSM6MP/R2Sp8D1fL1TRKz3bKF/C2FA
rAxgJvTZJFZ+/+N5Vadu+ZwYTbZYMK3V+wimlw0xgkaeFw/Bt0U1JibixsDoafzd
czMKwS7YwN8XAGR5RI9hRNHetEoIqL5ztmZ5iJv99kG6MLbZiQ9qjEjw/jjK5DNi
+E1c+xFD5Nhyf80Twuuo5BTtCtiZYpdJEYEqs0cWu9xhIXKdYTZLlG0SNOHuOc16
ZNN1x/cz3eDgUxh55whQ/opgg9PvkMes34hhASQJJAR2ofqe01zPYuu4+5Y1y0Kr
+9cJyuQIIMbgYDXaPyCw1bHy61+P9llbOd9+fyksh+QGB+TcSsgOfZoTvtY1gyn9
Y5+wZfw+OWHW/RizYg94fgJl5EOhWRUD7YSVn5kydI/1PuWFGejxPiPzWBi1mhDz
+EJ1pUYUTry2t+jcHk2C30RNHCPMzW3Wbavj3cr2GHSN+Ii/sKhwwwB84WvwjE6Z
Jm9kVV9MtIum7oS2fR0f7e7Vv2/+3QmEF7tG0S1mhQR5FE+k2wOp58WJ8fb5KsNZ
bhX0KhZpBIi0HIuPMNde73w/LmYEN4ae2IZVfafJGFIe6ao31t4XVPLPplKFJ5Rg
Ki3sFiFKOZtds5Ny3La4Hb+7pOQYGbRkODtID2mcy9et6t/xVt3eJZ0Bcs4BUPiz
/i9kP7P4JFfC9mzmFp/Y
=rVtx
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
