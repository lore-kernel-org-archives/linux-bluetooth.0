Return-Path: <SRS0=AfC+=MN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E083C0044B
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Oct 2018 10:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A105921471
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Oct 2018 10:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A105921471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbeJARBi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:01:38 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60676 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbeJARBi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Oct 2018 13:01:38 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id EEADA807AA; Mon,  1 Oct 2018 12:24:30 +0200 (CEST)
Date:   Mon, 1 Oct 2018 12:24:30 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
        marcel@holtmann.org
Subject: low energy: does gatt client/server work in current version? How to
 test?
Message-ID: <20181001102430.GA6708@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm trying to get gatt client/server to run; my ultimate goal is to
turn Linux machine into "low-energy device", providing services
similar to heartbeat measurement.

I do have existing qt application (running on Android and PC) I'd like
"device" to talk to.

TODO says:

- Add complete GATT test coverage in unit/test-gatt following the GATT
  test
    spec. This could use shared/gatt-client and shared/gatt-server at
  the same
    time to test both against each other. We should definitely have
  tests for
    gatt-server and gatt-client simultaneously on one side of the
  connection.

  Priority: High
    Complexity: C4

Which tells me that maybe I should consider helping with that. But so
far I was not able to get it to work...

I can use gatt-server and connect to it using gatttool, but depending
on details during the server start (?) and phase of moon, either
device is not enumerated by the QT code, or it is not detected as
low-energy device, or no UUIDs are detected.

My attempt at launching server is below (using python gatt-server, (1)
). I was doing "hciconfig leadv 0" manually at some point.

Using hciconfig while bluetoothd is running sounds kind-of
dangerous. Stackoverflow (2) suggests using btmgmt (3) instead, and
things got slightly different, but did not start to work for me. Is
there documentation how to get this to work somewhere?

Thanks and best regards,
							Pavel

(3)
sudo tools/btmgmt -i hci0 power off
sudo tools/btmgmt -i hci0 le on
sudo tools/btmgmt -i hci0 connectable on
sudo tools/btmgmt -i hci0 name "some friendly name"
sudo tools/btmgmt -i hci0 advertising on
sudo tools/btmgmt -i hci0 power on
tools/btgatt-server -i hci0 -s low -t public -r -v

(2)
https://stackoverflow.com/questions/29128586/bluetooth-low-energy-in-c-usin=
g-bluez-to-create-a-gatt-server#31030321

(1)
#!/usr/bin/python3
# -*- python -*-

import os
import re
import time

def pcmd(c):
    return os.popen(c).readline()[:-1]

class Ble:
    def down(m):
        print("Shutting down BLEE")
        os.system("sudo killall bluetoohd")
        os.system("sudo killall gatt-server")
        os.system("sudo hciconfig hci0 down")       =20

    def up(m):
        print("Starting up BLEE")
        os.system("sudo ../bluez/src/bluetoothd -d -n &")
        time.sleep(2)
        os.system("sudo ./gatt-server &")
        time.sleep(2)
        os.system("sudo hciconfig hci0 up")
        ##os.system("../bluez/test/example-gatt-server &")
        while True:
            #os.system("sudo hciconfig hci0 leadv 0")
            time.sleep(5)

    def run(m):
        m.down()
        time.sleep(1)
        m.up()
               =20
b =3D Ble()
b.run()



									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlux9d4ACgkQMOfwapXb+vIzYwCffb/Uwko/GHbgIghBTcBl8cnx
SmIAnRNFmCvOkfcY70sCvOjUl6+YCVW+
=pCtK
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
