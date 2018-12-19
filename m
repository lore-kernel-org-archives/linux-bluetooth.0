Return-Path: <SRS0=/IWC=O4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A66C43387
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 15:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4122133F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Dec 2018 15:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZ11VU3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbeLSPwy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 19 Dec 2018 10:52:54 -0500
Received: from mail-pg1-f173.google.com ([209.85.215.173]:44394 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbeLSPwx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 19 Dec 2018 10:52:53 -0500
Received: by mail-pg1-f173.google.com with SMTP id t13so9608046pgr.11;
        Wed, 19 Dec 2018 07:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=Y9XmIRztP/AoioYKdVGEZTUQsXqiQk17ShNjhXz//L0=;
        b=PZ11VU3M/C/CriI/OY0BRp80wGLv1j8Zdj4YnZAVSHZbEMxrTO3RLVGxWIYWiOwUrC
         04LxCqQP5FkxM3KmyL13+qTp5bODClafKr9ImbSQIAz54NaLHTQkCekuboD3cHbQIrYE
         p3i/gn+YG/Nq++1B+5x7tJDb98wesBeB4eHEi/Unxan9VkiubOpfswtwXs6t4wkRkFRJ
         P0A4zlvm/jBgWg7N/GrvdxGTX1M33poWKZ22CjhEI1t2Xhn5rWD2h7cFPoVN4t8yY7H4
         jE5w+W7YQ+FsGXLJ77JXaGb+fBgwT+mEvHxsAVCHXbCGIkXKIebWizySIscFpgxvpL4q
         cH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=Y9XmIRztP/AoioYKdVGEZTUQsXqiQk17ShNjhXz//L0=;
        b=lREDku79wh5Kz8zob0rA1eTa10oHr+hlxd4zVoiVMZ8dPgm1l913aivNEP3mKOeCXY
         Qq5eehYmJQUNX/5rSPlO3vIrevcAcnMeEytx2zcpn0lI7tYxf3GKvqbrsSd9sQ0UiLnO
         C+ctservEZPFzEfG1SmkTMidg9eh9hoi2K0ZjxtnVmYKXojkLK3OFs8Wjb0PrPsVF18U
         mPSyEHJS0hxE4mpoihfgbIVpm2yVZKt1MxVGiieiWxl3XErZPA/rPxPTinyKceYpWSgn
         v/tKPEEnr0Xj5VVzak2VbDhYKUMb3z4NQ7u0lWlra4kim7ERg3cEBz/ibC7NaPC5vsLH
         swhg==
X-Gm-Message-State: AA+aEWa7CEPKGilRJOgpH7CbCJFv19VMagNWhv4yT5YhjLUU/NXXRB3g
        Paqs+K7ACMvpTSsypOQZ/mYPqjHfz38=
X-Google-Smtp-Source: AFSGD/VgegrI1G+icPZb5SONoxMkyeE/+aPuBPBNU9YqrYOSmlmP373CEcR9LR/REKp92wdqMLRCcg==
X-Received: by 2002:a63:184a:: with SMTP id 10mr18503901pgy.81.1545234772535;
        Wed, 19 Dec 2018 07:52:52 -0800 (PST)
Received: from localhost (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id g11sm25336891pfo.139.2018.12.19.07.52.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 07:52:50 -0800 (PST)
Date:   Wed, 19 Dec 2018 17:52:46 +0200
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: pull request: bluetooth-next 2018-12-19
Message-ID: <20181219155246.GA25077@jhedberg-mac01.local>
Mail-Followup-To: davem@davemloft.net, netdev@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dave,

Here's the main bluetooth-next pull request for 4.21:

 - Multiple fixes & improvements for Broadcom-based controllers
 - New USB ID for an Intel controller
 - Support for new Broadcom controller variants
 - Use DEFINE_SHOW_ATTRIBUTE to simplify debugfs code
 - Eliminate confusing "last event is not cmd complete" warning message
 - Added vendor suspend/resume support for H:5 (3-Wire UART) controllers
 - Various other smaller improvements & fixes

Please let me know if there are any issues pulling. Thanks.

Johan

---
The following changes since commit b12c97d45cd061862b79fe02aa41a73d685ec7a1:

  nfp: flower: fix cb_ident duplicate in indirect block register (2018-12-1=
7 23:34:12 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t for-upstream

for you to fetch changes up to 1629db9c75342325868243d6bca5853017d91cf8:

  Bluetooth: Fix unnecessary error message for HCI request completion (2018=
-12-19 14:37:03 +0100)

----------------------------------------------------------------
Andrea Parri (1):
      Bluetooth: Remove unnecessary smp_mb__after_atomic() barriers

Balakrishna Godavarthi (1):
      Bluetooth: hci_serdev: Remove setting of HCI_QUIRK_RESET_ON_CLOSE.

Chen-Yu Tsai (12):
      dt-bindings: net: broadcom-bluetooth: Fix external clock names
      dt-bindings: net: broadcom-bluetooth: Add VBAT and VDDIO supplies
      dt-bindings: net: broadcom-bluetooth: Add BCM20702A1 compatible string
      dt-bindings: net: broadcom-bluetooth: Add BCM4330 compatible string
      Bluetooth: hci_bcm: Handle deferred probing for the clock supply
      Bluetooth: hci_bcm: Simplify clk_get error handling
      Bluetooth: hci_bcm: Use "txco" and "extclk" to get clock reference
      Bluetooth: hci_bcm: Add support for LPO clock
      Bluetooth: hci_bcm: Add support for regulator supplies
      Bluetooth: hci_bcm: Wait for device to come out of reset after power =
on
      Bluetooth: hci_bcm: Add compatible string for BCM4330
      Bluetooth: btbcm: Add default address for BCM43430A0

Colin Ian King (2):
      Bluetooth: clean an indentation issue, remove extraneous space
      Bluetooth: hci_intel: clean an indentation issue, remove extraneous s=
paces

Hans de Goede (2):
      Bluetooth: hci_h5: Add suspend / resume ops
      Bluetooth: hci_h5: Turn off RTL8723BS on suspend, reprobe on resume

Johan Hedberg (1):
      Bluetooth: Fix unnecessary error message for HCI request completion

Jonathan Bakker (1):
      Bluetooth: hci_bcm: Handle specific unknown packets after firmware lo=
ading

Maxime Ripard (1):
      Bluetooth: hci_bcm: Add BCM20702A1 variant

Pawe=C5=82 Chmiel (1):
      Bluetooth: btbcm: Add entry for BCM4329B1 UART bluetooth

Raghuram Hegde (1):
      Bluetooth: btusb: Add support for Intel bluetooth device 8087:0029

Yangtao Li (2):
      6lowpan: convert to DEFINE_SHOW_ATTRIBUTE
      Bluetooth: Change to use DEFINE_SHOW_ATTRIBUTE macro

 .../devicetree/bindings/net/broadcom-bluetooth.txt |  11 +-
 drivers/bluetooth/btbcm.c                          |  14 ++-
 drivers/bluetooth/btusb.c                          |  80 ++++++------
 drivers/bluetooth/hci_bcm.c                        | 134 +++++++++++++++++=
+---
 drivers/bluetooth/hci_h5.c                         |  81 +++++++++++++
 drivers/bluetooth/hci_intel.c                      |  20 +--
 drivers/bluetooth/hci_serdev.c                     |   3 -
 net/6lowpan/debugfs.c                              |  13 +-
 net/bluetooth/hci_event.c                          |   6 +
 net/bluetooth/hci_request.c                        |   2 +-
 net/bluetooth/l2cap_core.c                         |  12 +-
 net/bluetooth/rfcomm/core.c                        |  12 +-
 net/bluetooth/rfcomm/sock.c                        |  12 +-
 net/bluetooth/sco.c                                |  12 +-
 14 files changed, 280 insertions(+), 132 deletions(-)

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEyxvsVXjY3jV7sQ0/JCP2+/mo1BIFAlwaaUcACgkQJCP2+/mo
1BI54BAAkhUEvd2ZMmczM7RTDURsihsPu0veVU9TkBjYGiB02Ggf/ZIQK2L7uWOA
EMgIcSqbcZR086G4Gs9AveEcK4n4RHOCkjOqCwRQMG8kekv2gUjp0b8GmhWgkSrK
TVyRpRc1DVZNgD3nXxyD6jZv0XrduUN/Ip0m65DPv/qobazCF/msQO0B+4V+tmUP
IZDA9YaL+udWpHlde7aa1MDggiBcyP2g4iFW8uV347E0NxKKte9IdU4e4nA0RzQb
vPqWyZCgkZU9FFumlKC+ftI5sIiYJXgChDppqE0KNdXdkKyCFW1v/Q1bkvnwuwc6
Izvs/HCM6Lo0BKK5z21lXvP9WuOFUBWxptYe9008cwQ7BoqwIUkali8H3DJt19uw
dpvzXIuWMb2zVTmXXv/3R4fGCJ+bESQMST2GWKFzY3tlAmFquToS8woTmK/8YnMF
e4hsI4fZTsBRb0ca7mSwSw9DXZCYDcitbxO091Lwt8pd2DCJ8vAwXuFAcC2OEjKm
R/1TgSTbgyZhgy0D56NYxiQnlQSY1IviSdw2UIOqC37SL8pQrNFEpMjazajipqJQ
32oNs381JiSTZ3lA16CYYJbvb2kzhTRL+7q3Ac19/j0dgN6avrbBUjCo6XJ2Gh+6
8V7idTz+T8Dtull6WEEJnpfubl/M+xTIJhBm81tM6wDWJH7YMF8=
=QJaH
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
