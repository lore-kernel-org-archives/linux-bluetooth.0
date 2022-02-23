Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7F4C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Feb 2022 21:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238272AbiBWV5W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Feb 2022 16:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiBWV5V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Feb 2022 16:57:21 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E66D35248
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 13:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645653408;
        bh=R3MOz0kaKVeZFt4XH5glaupgy3FerYbqwcYKy1DYtVQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=BbaP7euMfCpCkqfM084/0cksIn5BIRBxZBxrQ0mrTBs2wmMvIh/eSiyLPGNE1cWtO
         TaQEHw/DCBlDXVX7o9cGm7l3/BtAZMMnpC2U90Gif/Fiauzf6XSyUhsvDLc9GrSlxb
         DgBG4sefyqJvBIs0jPjxElvoP1/sSFrBQfin6WLs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from madeye.fritz.box ([37.4.228.18]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhU9j-1nrOdP1wyh-00eaEQ; Wed, 23
 Feb 2022 22:56:48 +0100
From:   Nicolas Fella <nicolas.fella@gmx.de>
To:     linux-bluetooth@vger.kernel.org
Cc:     Nicolas Fella <nicolas.fella@gmx.de>
Subject: [PATCH BlueZ] neard: Fix reading State message
Date:   Wed, 23 Feb 2022 22:56:17 +0100
Message-Id: <20220223215618.335489-1-nicolas.fella@gmx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bRH4cr4jf1kZDZhPTbQdlwM9feQNaT8yzezkQZZFcqC9CrOkXIE
 bbqGeHHD3xkwj3H6FhOPawA2ipMdsxHd5j+4w+B90sA9GNEke1JE4YxmM2DpHd4MScNyfzS
 IxI3P0Dt8H6Q+FDwzFIChzvr4g55koe89rRkBIb0hadvL9f/jX6KdGziP6dK6GH+mPVMQt1
 rM3PJ3Pj2xgO5E76ShgQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C37dJlydnw0=:H6zsOEVYIwlvKP6Itl5JhG
 3xKlNZ9FvpWPSCxD5wW7Ixa50FIktCxFGy6W4Gtfc4RX7XeizuBdhLb9upLn66IkZHEpJGucq
 kQ+4Tin4/GRHpmSj82rkeBDj2MYsbfS46q9Ao4MFYkmwO3wKF9NIWf34FI/bkK3YRmv4cCow1
 uaOELPerjEvfgg0LV4c3H4cE7fbS6NdBgAEBSpw3kEJc3kK+mfw16fqfaQrcP3/7GL5eOcz/b
 LGc3yNxTAO5GZbB2WCvCK3cwZ8P1iAjIHEICsLFTlSEVh6/0JEK0puYYDBUEpTEz0qyJQH7Lr
 vfqmGMiaf2DDajYH3Bwj4ZKYve/aI9QM08zW5u3mkxrFB2fr6O3pv6o2Bqh/5N+xjCwS4VxW5
 mso5Xu1NCcWHRI1UgQHwnwl/KFRaqvtWLl6Tug56Ntp2wOXNjaTXvwgV21uW/iWYvsO1v/8ru
 DxFdmG7v7hhbMMFTFD6vQe3j55JcELC3yHQwIJomS8SkHygsaBY4y6uAW7gSRBHiTpD9+5PKr
 vIETCaC9JQPy6CpC1B9B5UWxtE/jLpm1yLDuUdgoZOTOvbxiVjK5mspUB7BUG+SYlRHaaESo0
 W3sbMuAcrNlG/OsaClni3+EcI+tYM/8LvAuNRuifzbVFJ2Dzo8V9f4ZrTHN6L3lvJoFwyfISx
 MDBIoWfVtY6FV5k23Yda61HgN7w/wUEWwQ1oE3KOfFMKn205jU/PMczqaJY5UB8Y4Bz3JZoYA
 uobk2BKt2p+vSDPAtQFfi/A3zIzMegDl6VgAl2xob8CP7kwzsLpQZKwuKHC2oQYQklG3pIv18
 vLWjhSlvT0ncqtblZkULl+5geFZ8ta4PeHYalEFDqpooAlY3r3WTssXLVSwK3Ado0h8FzbECF
 8euFYM7RYTUHc1aQfzYQMuwfx6HKF8N2bN3oAqe7mfMJQoTA65OgXE/r79kZ2UPdbc7M+mva7
 GWY46V8FrIpvDEmADTbYlg/kqfNZVkc9Sc+bzhzsOtRiKnytYc8jBXu/Eef7cQmB6qRMFFrmd
 ly3efwV0Fqtz9hYowgQxobIC+rmZOg79cjB2ZpeT/0McL5gCfX6i4LMPElKSd1UDbIZj6aQC9
 hJra2U9ErlUuUA=
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

dbus_message_iter_recurse only makese sense for container types, this is a=
 string.

Fixes: https://github.com/bluez/bluez/issues/300
=2D--
 plugins/neard.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index a75527148..99762482c 100644
=2D-- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -575,14 +575,12 @@ static int process_message(DBusMessage *msg, struct =
oob_params *remote)
 			if (process_nokia_com_bt(data, size, remote))
 				goto error;
 		} else if (strcasecmp(key, "State") =3D=3D 0) {
-			DBusMessageIter array;
 			const char *state;

 			if (dbus_message_iter_get_arg_type(&value) !=3D
 					DBUS_TYPE_STRING)
 				goto error;

-			dbus_message_iter_recurse(&value, &array);
 			dbus_message_iter_get_basic(&value, &state);

 			remote->power_state =3D process_state(state);
=2D-
2.35.1

