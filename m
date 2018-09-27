Return-Path: <SRS0=a08L=MJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434B3C43382
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Sep 2018 18:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC41121708
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Sep 2018 18:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3Q4ExTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC41121708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeI1AsS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:48:18 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35310 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeI1AsS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Sep 2018 20:48:18 -0400
Received: by mail-lf1-f68.google.com with SMTP id r191-v6so2994889lff.2;
        Thu, 27 Sep 2018 11:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=eyOrzsFYZ+Q620aFUz6QLahfBm/Y5X4FXCdq3SeJt+s=;
        b=O3Q4ExTqGU81bFRKgHO21scBC7Qf8D9igXB+JOoW7Z1TaPCt5sgKXtjbhN6pXobW1F
         9rD5mkrxsGlXWqDydJFuugco4ZD0Szu5RXJRhLz6IOmCh85rRWp+u9E2+Sy/AHk8dFw5
         Nidd9I3U/4PNn53ciXGaFCu8054JybMKtGRh/UQ1LMVuQIFoxzsHBrjXCIqmzeo8Lp7I
         HQI1MlTOlPVj7ZTSv/PfMOfP8X5GA0oMtricidkou4OEqjxCDyYgi6B/gXQ9F3uE2dAA
         +muQu+LqVq7Lzt5lKtuMnobQN1/ugoq1m2DooV8FuTWhztjZx9QknMR7H/5YZ1GWQCVT
         kEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:mime-version:content-disposition:user-agent;
        bh=eyOrzsFYZ+Q620aFUz6QLahfBm/Y5X4FXCdq3SeJt+s=;
        b=iF2lxZ6BRa++c40CZupnVqiPzDH8UcwzBM5PcHJO6K+gVp1s52QnBfxE6t078/hLV5
         /81ijrP/xzpqiUv92U3MdKfRlNXtR+CRjdtrGQN9LKTmoMB0nljJ2AkRqRRVhkgcUqhr
         MiAxzwBZs1G+apUwkKAI0fvJyc7f1B08AkdSgwUh84DaGWke/W52kVUSrT/ttRIkoPO1
         inmgsyBB9AcCnKvtn3mVzYYze8dblkO8Ks6al7Gt1pZDngUCLe4CmqqINrbX4uEC59N8
         2ZNPd/fUPLpLLbA7DoZrsA3oKmrpvV0TvslZRDWCCdais68dusbevGEA/a+Gtvw9BcPt
         aH4Q==
X-Gm-Message-State: ABuFfoiyZ0pOQr58I/rxgy66Tsa+7StQFwQVKV2B7kywSrq6UckN3HS2
        LxPhibFlnVThnSlnJ/oNc3z7JrNS2xU=
X-Google-Smtp-Source: ACcGV609hNTz3eXRoP8Xs0Ic3XytM2Qc8WoK2FKqfRniZcVcavXhIwhFuHTfwNoL59ibmjF7nDBSKA==
X-Received: by 2002:a19:3855:: with SMTP id d21-v6mr8467880lfj.148.1538072923269;
        Thu, 27 Sep 2018 11:28:43 -0700 (PDT)
Received: from x1c.home (91-154-113-38.elisa-laajakaista.fi. [91.154.113.38])
        by smtp.gmail.com with ESMTPSA id a4-v6sm558336lfe.54.2018.09.27.11.28.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 11:28:41 -0700 (PDT)
Date:   Thu, 27 Sep 2018 21:28:40 +0300
From:   Johan Hedberg <johan.hedberg@gmail.com>
To:     davem@davemloft.net
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Subject: pull request: bluetooth 2018-09-27
Message-ID: <20180927182840.GA31151@x1c.home>
Mail-Followup-To: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Dave,

Here's one more Bluetooth fix for 4.19, fixing the handling of an
attempt to unpair a device while pairing is in progress.

Let me know if there are any issues pulling. Thanks.

Johan

---
The following changes since commit 3f32d0be6c16b902b687453c962d17eea5b8ea19:

  tipc: lock wakeup & inputq at tipc_link_reset() (2018-09-25 20:48:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git for-upstream

for you to fetch changes up to cb28c306b93b71f2741ce1a5a66289db26715f4d:

  Bluetooth: SMP: fix crash in unpairing (2018-09-26 12:39:32 +0300)

----------------------------------------------------------------
Matias Karhumaa (1):
      Bluetooth: SMP: fix crash in unpairing

 net/bluetooth/mgmt.c |  7 ++-----
 net/bluetooth/smp.c  | 29 +++++++++++++++++++++++++----
 net/bluetooth/smp.h  |  3 ++-
 3 files changed, 29 insertions(+), 10 deletions(-)

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJbrSFXAAoJECQj9vv5qNQSjHoP/3TpFwaPXFWg9u/F03yRrIkm
SPvDlp+W5tlhY1fSAgG3NqmXInWt4a4K1dNPzf3Th7BQMLBYGCXMA3HePWC3siVw
8YMrnjbdgzFtY3YJuEABtXIk0VPv73hOvOrHx0szx0yctIcXQQt8PngiYUeL1p5Q
p6pEMHo7DKm6/Opv2Mifz2vwpPjg2ichw+U6w/4HDBSBLr9kbowI9odP40Uy47sM
Crtcdo95Xd9V/lunsrnDed1zuWxphXb9UkNK2GCZYxGG/TabMcAlzhZIhWdmkXK5
aj0bQQG8dQ2Gf34TXWfPGPttmRO5RGUGWSOb+xWkMtSd+9sqvsPYVC35S+9ykuWM
fpXcJDoFatJG4FsIw0nxCnU6Zonw6KpiXvc5KQqto+EePQa5o5RZoqo/Hc33/V46
PlZkyunldLYJNeARBEsY1xYqYp1QQoMnjhJzb/FbRENX7bvbF5nVkiwFZGoXawGg
5APsiosqHKPVnGxWTnipWL63Siiyfj5+U6uMTmorOgWfO+bBIsXE70hvXLWLhBLl
i8GGKhpgNqYhy/OnVQftYI4hxiwA4OvOLJDKg9J9vQPDnt/JcKmlT368ddPYTVCx
c/JcZk1zS98PWl3Bhc8HZ9DSSOPTOqZHTyeMWNnAPXVafMxkmTo20kKKYusNbV+e
0ncBYxW1hbFi5L6agPkb
=khKY
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
