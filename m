Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3790C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Dec 2021 17:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244659AbhLWRux (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Dec 2021 12:50:53 -0500
Received: from mout.gmx.net ([212.227.17.22]:48923 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244637AbhLWRuo (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Dec 2021 12:50:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1640281841;
        bh=8uV5Y2W0LnBGoknT+kOFKWwuA3zaQI0JS9pZm0AIfLg=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=O6IUrGtyYwboHIhwWVFX5ZyjxH8ItEr5l8aeoN6loxLqhDk/p3kudKRtvOCCe1TSR
         6q538W1916BDvmlDY90rdUl5+gr1wxlsJAeqwJEkKuvGqJa+g3O6xkHgUpG8iRwj6j
         i876Jtvc9Y5cTXgvYvxellEoDncsgX6A+SFV+8Ck=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from madeye.fritz.box ([37.4.228.18]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVNB1-1mrPOg0ZFv-00SNEh; Thu, 23
 Dec 2021 18:50:41 +0100
From:   Nicolas Fella <nicolas.fella@gmx.de>
To:     linux-bluetooth@vger.kernel.org
Cc:     Nicolas Fella <nicolas.fella@gmx.de>
Subject: [PATCH BlueZ] Use audio-card-bluetooth icon
Date:   Thu, 23 Dec 2021 18:50:05 +0100
Message-Id: <20211223175005.52976-1-nicolas.fella@gmx.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dMmA0ZRpbr6ZHGPDTIcJK3rTbFU1+YN/Qrf3qBxswOmkx2TaCFk
 nbZADyucYGENl4onz0WUR+yBi0Fm1uA2uUUUJMYejkqkfXfd9ikmK6Abi5FH62f7/2ZerDk
 hwKHXweiDZIulfAI4sheUMoHmXioo2lzNYjvrVwcZDDJKvnohrFezRQbWFoiVKbi3XA5w6z
 woF6A/DCerpB3mIRJRAjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rBAsVXXQmv4=:amgBu4O34Ekd8qV/yB1BiW
 yRZqiBL11AFEDv0k9rPG5tn36mYYjoAv8Qr6hkSTfFtBt427vAsONdQRBNzzw3C/iPHQ4WGOW
 caFPKSZkgteROOHEj8q/JH2IfXQhHiZUogB9Y/yAAhlNqmcFnbBa5J7tQwQTqUIHkvTtugswX
 gSraWU+2x9yh22Zq1k6bpYEsqHbDRl8900sTzfkMpE64971yJMC0JhKDV+Cm3l7SZRbSNtmcu
 kGH7cbS4wBenAUlK4S3BMxPLX1Xi9mWRlrRcJM6FAwLQyKXgIP8DozT84JwAen5L373Gr++Lx
 HHByegD9ahhN0xdER/gN8zE2nRWhgLCKmEWFdn+Vju3UE/hY3xfJGfB2pXym1gx7AwaMbTj3M
 GDZZBamadCGqAtqrDoRlwmQfJP+4XB3wCv5OCs0f6dY3CqllzrQqwnLMyBAzK51P/cvhMvjZs
 frj2bDsLBUoDQI1BHe8Svtr6wJrpD+53iu+mIKQQ92aiKxsvnJndZpBDIZx8Jm/ym9Rfwt+s5
 NmKgHmvbTQ7KV/jJNQlSeGw5KEr/tDe3uMGdFyELYDRiOJHLnKfwhKyLQtDpGRDqjDOW50eG6
 ZhtbgAPBrcTcfwZPK4Bmy4TJOJQOqX12qn85B9ck5evjnFQIGCV37BPsr9MoQk9elMIrHKU6b
 bMK6qkncMNmoXuVp+LxMP/u1UJpxvoL9RizC6iQJwiPKtxMlil209KwkaBgfescTgt3zAmlD7
 O1bvDuNZSiGsEsK3ig0OfERQ2Cm2yxggBvgXK98jAXk99Pa8d9pru0VjaZho1eoApqL+oOVRy
 KLYe+OzdFwR7I5v9g4qqONGR2dbxGDsAXtd9u9YgFtVCHjri94iIXDz5sCx3bNmRkPyKwbFqP
 ToY3024xEe1Zz19L/l9vUmBLapB0qjgL8wDgMnsNzTu9VLgOpj0NdJn7oNUEGJt/cWj7INZdI
 5YVPVngFFtwQB0phuO5v5L1xkeQsiOYK77jgS+99HobsB/A12VYRBBdx4VYqKiF5penJJy1vs
 cegRPfeSWO+W2ikDHk0ro7BXyiDjHujsodK6ph2oMralRJy3JEIkbeExR0hOO2lUE0wlgcogr
 bj5c4gcdaAUzCk=
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

PulseAudio uses this icon for this kind of device

Let's be consistent

Users will gracefully fall back to audio-card if audio-card-bluetooth
is not found
=2D--
 src/dbus-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/dbus-common.c b/src/dbus-common.c
index 5e2c83d52..3611cb013 100644
=2D-- a/src/dbus-common.c
+++ b/src/dbus-common.c
@@ -80,7 +80,7 @@ const char *class_to_icon(uint32_t class)
 		case 0x0d: /* Camcorder */
 			return "camera-video";
 		default:
-			return "audio-card";	/* Other audio device */
+			return "audio-card-bluetooth";	/* Other audio device */
 		}
 		break;
 	case 0x05:
=2D-
2.34.1

