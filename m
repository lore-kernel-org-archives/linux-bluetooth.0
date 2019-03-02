Return-Path: <SRS0=Oh6E=RF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADC1C4360F
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Mar 2019 20:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212532086D
	for <linux-bluetooth@archiver.kernel.org>; Sat,  2 Mar 2019 20:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzRCHY9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfCBUBD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 2 Mar 2019 15:01:03 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34449 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfCBUBD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 2 Mar 2019 15:01:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id o10so1199006wmc.1;
        Sat, 02 Mar 2019 12:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=QYT6fia9SmvagypJbFj1ZV0YIm01NKLlWgIHqvOui80=;
        b=FzRCHY9vFYN2aaeBObrg1YSw5jL7YUIXfv543HnDd62y8884hW1vi1/O2vJkJu/MAY
         Nv0n8xvowdwVMF2TtL+82QSD6wZRY/U5kIpvVBTtYnl2F+1/qTX1oNzfOro/fwLf0HHh
         ItMSrjk8khIth4ZDie63bVjXcVwM9wP0QIT6vi08GRD7UpS3kDZ3MoKqV7QW3HKv3f1I
         vZK17jEdzGcjV5ziCM3sRkyiRF1oc5xJ5w5CQIgLp2djjkFXBE6NWlJw0w2sX0Qex334
         YZGZ0HRuV+c/Z0MsmRyVC0Ov6gg8NPuDTk7R2qTstafQxrU88x6MaEf6TWtanOiLb7fr
         F2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=QYT6fia9SmvagypJbFj1ZV0YIm01NKLlWgIHqvOui80=;
        b=ZUyrdMOr9B27pfmZTr8AS5i06HDW0XpBhw3auvsUlTp3QCzlXWmt3kCgXsGNx+RYvv
         VKNaUQQYFBagVeTW0KolehB68HK4oIcladgpDmbwOtuOY16xG1d60sQp1TYrlRt7pNdF
         Q2P/D1f51VqaqqPMdhi/xJUnS4nRVD8ht9Pbr6H5Q1XMe/ZJEgo6MPF1uRKYweUAEDfN
         CfMGdCNArBec325xE2PTyIATBYwUCX8s7huXABnb7J1h1UaP97nJn8nLSWp8K749UdiY
         Vhd9P1IciitqQWfy9n1VSSgFj7dU0gSxjIhbfdSsHHZEQ76Rl+2atrAlQ+PSV9qTwS1p
         O2aA==
X-Gm-Message-State: AHQUAuafSEtmby1OP3u84sG3Sz+Y0LNsTuKAdAWkk1RiKOtKOmvD3nEl
        gdwQXRATuENENyv2y25YJGUBFZlV2ws=
X-Google-Smtp-Source: APXvYqwh2f4Asz3OBYDbHSK2u3tOQcakXzxm3+/4DKpy2/tVo3KpT0vNMDy0ZCT1LV1k7zuH6nnwKQ==
X-Received: by 2002:a1c:5fd7:: with SMTP id t206mr6760023wmb.73.1551556859715;
        Sat, 02 Mar 2019 12:00:59 -0800 (PST)
Received: from localhost ([85.207.23.41])
        by smtp.gmail.com with ESMTPSA id v10sm4764865wrn.26.2019.03.02.12.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Mar 2019 12:00:58 -0800 (PST)
Date:   Sat, 2 Mar 2019 21:00:57 +0100
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: pull request: bluetooth-next 2019-03-02
Message-ID: <20190302200057.GA22165@arejment-mobl.ger.corp.intel.com>
Mail-Followup-To: davem@davemloft.net, netdev@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dave,

Here's one more bluetooth-next pull request for the 5.1 kernel:

 - Added support for MediaTek MT7663U and MT7668U UART devices
 - Cleanups & fixes to the hci_qca driver
 - Fixed wakeup pin behavior for QCA6174A controller

Please let me know if there are any issues pulling. Thanks.

Johan

---
The following changes since commit c14f7e1efcbf744c49fcb44a121112c54d2c5330:

  net: wan: z85230: replace dev_kfree_skb_irq by dev_consume_skb_irq for drop profiles (2019-02-25 14:36:15 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git for-upstream

for you to fetch changes up to 22eaf6c9946ae269061d95bb9ceee02524166474:

  Bluetooth: mediatek: add support for MediaTek MT7663U and MT7668U UART devices (2019-03-02 19:51:23 +0100)

----------------------------------------------------------------
Brian Norris (3):
      Bluetooth: btusb: add QCA6174A compatible properties
      dt-bindings: net: btusb: add QCA6174A IDs
      arm64: dts: rockchip: move QCA6174A wakeup pin into its USB node

Gustavo A. R. Silva (1):
      Bluetooth: mgmt: Use struct_size() helper

Kefeng Wang (1):
      Bluetooth: hci_ldisc: Postpone HCI_UART_PROTO_READY bit set in hci_uart_set_proto()

Matthias Kaehlcke (8):
      Bluetooth: Add quirk for reading BD_ADDR from fwnode property
      Bluetooth: btqcomsmd: use HCI_QUIRK_USE_BDADDR_PROPERTY
      Bluetooth: hci_qca: Set HCI_QUIRK_USE_BDADDR_PROPERTY for wcn3990
      Bluetooth: hci_qca: Pass boolean 'on/off' to qca_send_power_pulse()
      Bluetooth: hci_qca: Move boot delay to qca_send_power_pulse()
      Bluetooth: hci_qca: Add delay after power-off pulse
      Bluetooth: hci_qca: Use msleep() instead of open coding it
      Bluetooth: hci_qca: Reduce delay after sending baudrate request for WCN3990

Sean Wang (2):
      dt-bindings: net: bluetooth: add support for MediaTek MT7663U and MT7668U UART devices
      Bluetooth: mediatek: add support for MediaTek MT7663U and MT7668U UART devices

 Documentation/devicetree/bindings/net/btusb.txt    |   3 +
 .../devicetree/bindings/net/mediatek-bluetooth.txt |  64 +++++
 .../boot/dts/rockchip/rk3399-gru-chromebook.dtsi   |  13 +
 .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi      |  46 ++--
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       |  13 -
 drivers/bluetooth/btmtkuart.c                      | 281 ++++++++++++++++++++-
 drivers/bluetooth/btqcomsmd.c                      |  31 +--
 drivers/bluetooth/btusb.c                          |   2 +
 drivers/bluetooth/hci_ldisc.c                      |   3 +-
 drivers/bluetooth/hci_qca.c                        |  50 ++--
 include/net/bluetooth/hci.h                        |  12 +
 net/bluetooth/hci_core.c                           |  43 ++++
 net/bluetooth/mgmt.c                               |  14 +-
 13 files changed, 478 insertions(+), 97 deletions(-)

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEyxvsVXjY3jV7sQ0/JCP2+/mo1BIFAlx64NoACgkQJCP2+/mo
1BK5ARAAoVIUDWuM3+TF+Wsr0nAZFQJyYQKyeRiRLQhJ/2JffEJPn8ZWFGfVa6NE
P/IedwjtvnHb6xUtIYThQmlmZrHg5GaWJwfuDPnZ+bFeY9MW0BhrJx39IJfeFDBB
tpIc8WylT4rwRbFPSu3iQKuHXFWpZ90gJXsdGlr0OeSSdO4jy/QSTcEhn4a0bfH6
whY1V6zghz1w9RBZlrTowPFk7kbvQ9Jcx8l37GRIV8BbV4ok4eZBLxRyP7Eoo7UL
kPelH3VSk0JuUCvJhnd2Cc0ASaYqoiM2c2uEbAo6hXOMTUoslktUxjU11bxpPkqZ
8d5EhMmcnWP/Pei806LVZ+uvWY8D7uI3xzogUw3F/t+J4bD5LrqjjsnDfXEKEKfu
+0fVunJrOv3V2So522OpHYtGRbAEcPcRXc7vKqhng2DrLp/I7oRhewIc+AJ6pOue
qX7NslnYeR/SWJKPTfDdC9W70oCpjYAXE29siOGR9HgJXSXTz5f0EcbUn4y/Mqb2
TysbB2kZWk8tnSxgIPTUrvgXoHsqOEyZJD1LL+6tCksU635EZ+mrXE9PB7QS7BnT
CSTOts76t2KPGet0OkplqQC9W/sRqBPOIEbw2S0p9xveQJx6e+KW45AuZzBxxV0B
gDhoqdAdzpokEKwHoL2YrEZhuYpjd5wDgSAbfTQlSi1wJN8YDr0=
=f69R
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
