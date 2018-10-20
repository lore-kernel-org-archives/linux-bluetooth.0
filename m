Return-Path: <SRS0=5noO=NA=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414B8C67863
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Oct 2018 09:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11C42150F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Oct 2018 09:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlWpixLj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11C42150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbeJTRNc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 20 Oct 2018 13:13:32 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:35263 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbeJTRNc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 20 Oct 2018 13:13:32 -0400
Received: by mail-lf1-f50.google.com with SMTP id d7-v6so6319972lfi.2;
        Sat, 20 Oct 2018 02:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=O+BcuUr3u6hNdESXf8kNpE75V2ulNKAlyUx+FP6mDF0=;
        b=OlWpixLjd9j4BToCR4+/wER5tM7aoXKCNM0TmxlhAOrYVT5evm0dZ05UYZGkiqITJM
         JKYtTwlfevgssWJCPmtA5hovLhOTCHBKAbrrk7D2VQKCkD/0Q3KeKOLr1+wPuXFstXEb
         C5DRY6fmrvctMHUC3hdtr6qkVqwYVij6w4pMjt6kXzhOZMI97rdJYUVIdUVuHbxVPH1K
         CySnWnPAOdVbmJdNsxDAiW1PQDv8zA3/GrNfZey3XocCvYAedSd6TfeEUTq9mqsnkFC0
         VeK2lZldraef5Uu7A3IZuZd8Bbb4AukZP9bWOdEYlADZXwM7A9njnhg1lv6dv3GHcFm1
         bXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=O+BcuUr3u6hNdESXf8kNpE75V2ulNKAlyUx+FP6mDF0=;
        b=WTs95XOf4+w2srdwomOYN84V7aJk1i5gqYo38UDufwVDnSz3C984wp/12Mmrqb9olf
         08bXdnkj3Jjar77ieG7nbbu3RJoI/KnJCBlDFVgLU59owSYrbQuS81Ir6MUiVoB5f1Tf
         VxxSGIDTQ23MV0FnG5iV3SI5lYU/qaDgy3l0bcCMFxMAszCH8Z5SIfOffjBntwNmI1sN
         I+QW4MrsHqHETfY3oAhcJwZ6srAnvUm851Bc63HK2a/X9ywFQvNK9jOMzMpB3Dg86VfV
         6Lc2QhZrOv+821U+xhm0tbUnZTIbIG7U0+wJU9tcx3MCf0QBKW/HZBV2siZWiwMRON2g
         QevQ==
X-Gm-Message-State: ABuFfojnAm48UQ5rSH9rKbVRARG0bM/kXt2bORrVxfDqzE1uGmY8SF4H
        cWBb1ktHISZL7PW02Ssi+5PLSLY6
X-Google-Smtp-Source: ACcGV62lkJFe5WbxMRzTs3pFDCBkbdw6kBd/uSh6yqLHOO65Hg/uzPuJyRql8Ua5N0XyRYSC5W7Q0g==
X-Received: by 2002:a19:cf8d:: with SMTP id f135-v6mr4893887lfg.53.1540026227055;
        Sat, 20 Oct 2018 02:03:47 -0700 (PDT)
Received: from x1c.home (91-154-113-38.elisa-laajakaista.fi. [91.154.113.38])
        by smtp.gmail.com with ESMTPSA id g92-v6sm5845674lji.24.2018.10.20.02.03.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 20 Oct 2018 02:03:44 -0700 (PDT)
Date:   Sat, 20 Oct 2018 12:03:42 +0300
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     davem@davemloft.net
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: pull request: bluetooth-next 2018-10-20
Message-ID: <20181020090342.GA14926@x1c.home>
Mail-Followup-To: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dave,

Here's one more bluetooth-next pull request for the 4.20 kernel.

 - Added new USB ID for QCA_ROME controller
 - Added debug trace support from QCA wcn3990 controllers
 - Updated L2CAP to conform to latest Errata Service Release
 - Fix binding to non-removable BCM43430 devices

Please let me know if there are any issues pulling. Thanks.

Johan

---
The following changes since commit d864991b220b7c62e81d21209e1fd978fd67352c:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-10-12 21:38:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git for-upstream

for you to fetch changes up to c614ca3f7476934de54dd731e09d094ad822696c:

  Bluetooth: hci_qca: Add support for controller debug logs. (2018-10-18 09:55:16 +0200)

----------------------------------------------------------------
Balakrishna Godavarthi (1):
      Bluetooth: hci_qca: Add support for controller debug logs.

Cho, Yu-Chen (1):
      Bluetooth: btsdio: Do not bind to non-removable BCM43430

Colin Ian King (1):
      Bluetooth: Remove redundant check on status

Mallikarjun Phulari (2):
      Bluetooth: Use separate L2CAP LE credit based connection result values
      Bluetooth: Errata Service Release 8, Erratum 3253

Owen Lin (1):
      Bluetooth: btusb: Add support for 0cf3:535b QCA_ROME device

 drivers/bluetooth/btsdio.c    | 14 +++++++++-----
 drivers/bluetooth/btusb.c     |  1 +
 drivers/bluetooth/hci_qca.c   | 19 ++++++++++++++++++-
 include/net/bluetooth/l2cap.h | 19 +++++++++++++------
 net/bluetooth/hci_event.c     | 38 +++++++++++++++++---------------------
 net/bluetooth/l2cap_core.c    | 36 ++++++++++++++++++++++--------------
 6 files changed, 80 insertions(+), 47 deletions(-)

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbyu9uAAoJECQj9vv5qNQSm3YP/i2e58dvgaf2ZYRvRe1gJZli
uLvIa/EmXw1ukSky2D4XVtDXRmJhW3ra9eTQ/2b17gX+MyvNSON54YdHPSfAuvq2
aFT0SWhtpvjKsdrEnAlZydQO/7VzgMylDWJZsMVByCE901RFnIF3Zs89oV/j2reW
CTdGg7jpuidpST+aJJbsQlpmRsdUr+fmEKmoXdOya242L7F0JKZJIlfjSSXXL/KR
93nbkscYvLlcqTyDsep/pdA+femJ8N7qMJiyoAWOz4u/gYI0Q7DxH40xmmUmhfI2
e7iWQSddIcAFPe5RauA9nQX78m04oQRTiQ2p6ZsQrjXzHQ9oBTawRpWTuMpKIeo8
EulJc48UXjC0tvZgE9zPVZ5DIIQieQTqp+IHL0w2/EIre/qkMs9hzgi4+MYZeIdC
8l54yZMBsxf5G1A1pRBbGkVfJ6/nXgx3lyqRbdfSlZ4tIpPg34jeOtxECjhhnJPV
n2FBITxFURfi8HYMrbyotlyan07K/hP6WerZwffTH5kMrC10Y4ocGJbIk5u2nDj+
YDrL7HqkQ/YJR38uiiBsuClbtqavPmF5B8Rx/T/6LtdwNGhL0T9cvNv3FBIFbbba
Fn5H4iv/xViyKvLQbUxqQybEyoRty9KZm17ECZ8r8ub+TZbkqHm8eBlvs+jFn7o9
3/sgOhPxYpvw6z8VjpDZ
=Au/N
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
