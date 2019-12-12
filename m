Return-Path: <SRS0=nb/8=2C=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D42AC43603
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Dec 2019 17:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2557321655
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Dec 2019 17:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H79a3F3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbfLLR3s (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:29:48 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39525 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730114AbfLLR3s (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Dec 2019 12:29:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id d5so3461399wmb.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2019 09:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pycLCjvMMBP695CK9VSeSbANIs2m5SIPyow5sT3t3/0=;
        b=H79a3F3x8kwdyiD+VMdzp4s/E+V2jq4H8Cbua3dFR7wSiAcesUiOCh70shX9fmXQYs
         CY37NMuGnd3RICrBa2xSleqUiMu2ljbE174gwa3T6OGIUkiC3K5wVWQakS/E18K76/sQ
         WE0l9VcM2UA5UodE8ry/c/2fct6a7lL13oDja1Cvi5U2s4LGfWlRU7nnkn3poFJkGTuv
         qostKEr9cBsb7sIPB+K5BUmg+w4F7VVRKuzF56iPkD6lNFli7Qgw3xqcdKShY7wf5uz4
         IhGITpZKdQ3Zy+lS8CSDLgwu+a1Z5bvG/8p0RmXBtLxTZifgjByw0478/aHY3aeB1Fl6
         wAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pycLCjvMMBP695CK9VSeSbANIs2m5SIPyow5sT3t3/0=;
        b=Bjdcc9lq16riasv1Nat1iLge7lgmyDgRk0LOGrPc1r67KeE8b9a1lV32bEvH+wz6hw
         GuwgOyw7KEV0EtgpUWRF8XRWDsWXynzavH2bMbpkJqDVMTIVtmYkvvwcUduD7EwjhkRB
         ZYAbYhrBPxdiBQOoUUmUnhejR6788rXZ8dHryUGIeNtrq5itcVceh6sYYAm1Bpcgdr7J
         9N9BlV7y1q3AexmmCXrnJBv8HzE+tVoDWS1fhacIe4ZupO8gIWVLqPNZAsWUhWKfkNDm
         7NcOqGreP0qTrPs8W/3Llay0DwTM3D/TZydCzBYltZYJI4fzqvKMHRSu33vnQFqGLn29
         iFBw==
X-Gm-Message-State: APjAAAVc6HBXK1WwUYNMn+ka4+H98qcIIb42SoQK8hmYeajw0GJW2+cp
        cKQf96fJQpONzs1QTnSHUGAqoA7e
X-Google-Smtp-Source: APXvYqzGAFbRd6E6IRGNTmXvjDpBoXz9CoFfMjjjjMwn2LnDDflO+Y+1mS6kgmqJrwMNMH5EOGyGeA==
X-Received: by 2002:a05:600c:22d1:: with SMTP id 17mr8263826wmg.23.1576171786024;
        Thu, 12 Dec 2019 09:29:46 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id x17sm6220038wrt.74.2019.12.12.09.29.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Dec 2019 09:29:44 -0800 (PST)
Date:   Thu, 12 Dec 2019 18:29:44 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: bluez: Export SDP "Remote audio volume control" item for HSP profile
Message-ID: <20191212172944.hgt6se2qz2hpsbo2@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ys2u4j7ry3hhzv5x"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--ys2u4j7ry3hhzv5x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

According to HSP 1.2 specification, section 4.7 Remote Audio Volume
Control, Support for remote audio volume control is optional, so an
implementation may support none, either, or both of the controls for
microphone volume and speaker volume.

According to HSP 1.2 specification, section 5.3 SDP Interoperability
Requirements, bluetooth device with HSP profile announce via SDP "Remote
audio volume control" field information if device itself supports volume
control.

But currently I did not found any way how to access "Remote audio volume
control" SDP field in (pulseaudio) application as bluez does not export
it.

Can you please export this field? E.g. for HFP profile all optional
features from SDP are passed to NewConnection() DBus method via
fd_properties dictionary under Features key. Could you export that
"Remote audio volume control" bit for HSP profile in Features key?

And in same way, this needs to be handled also in RegisterProfile() DBus
method.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--ys2u4j7ry3hhzv5x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXfJ5BQAKCRCL8Mk9A+RD
Uq+1AKC4wILZjNxuosRcTWDKRYFtxojp+QCfWlYCoz6FAZSrT/3N7idLP/oetl4=
=TgGT
-----END PGP SIGNATURE-----

--ys2u4j7ry3hhzv5x--
