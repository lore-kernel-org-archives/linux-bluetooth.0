Return-Path: <SRS0=/vUS=V2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85B6C7618B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jul 2019 12:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FFFF216C8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jul 2019 12:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="gi+3UtCC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfG2MLj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Jul 2019 08:11:39 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:45408 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfG2MLi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Jul 2019 08:11:38 -0400
Received: by mail-lj1-f169.google.com with SMTP id m23so58280759lje.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jul 2019 05:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=cigPOQhQ7kZH+fseW7co8cRSd1ulkJjF4lGLxjJWGdc=;
        b=gi+3UtCCZoFsDhixwH3tFxLC/AzI1Og/bDXIjSQilRK+tTyAuld8RnSUQC7xmfHpJI
         hkvDwlqUSLHHYFPfZyI4CLg5+/8eFxkIU3urPgfL4LH/UNXDLloy54nvRIpHc914d38L
         pgOqcBbnuwt6q/AOokhI8G0iXDmroKuu9qFN6nJD2vdQOu/2yGlXRZLkPjCdvdvA0pmX
         lx/2+H0cN8Qt6Ds+VmYuOqGfGSFEpQXh53ecgAjiFcgL/Km/tU2LjxUFna+0eULIMrkH
         mAWsFFGEsmlKw5avgiQN8aoe5QiiaWn6if4h+isCiRI5RwgBGOECpsN/DejetUP0VnCI
         IeSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=cigPOQhQ7kZH+fseW7co8cRSd1ulkJjF4lGLxjJWGdc=;
        b=QD1nycoeVNMiuybM0zaM5gkTP6TNGi89CETXGLGl696B+HGKg7eYW/HDNkhiywOijV
         DcWqZy8nHuTBBZB2emqTyFqwBlRMzQLyORpsDfujvmLWEJHGsmUgNoVrfQqoITDOzdD1
         E3Fbzv/p+6Eu1KRK/QHkdaw39gWRlQ5NT4hBGJVKYwn/h1XF+zu0EYZhM9QvsfwwyImy
         bBKVDxmmDZUzdZY09YLBF9zp1h14Go/NPVyc+soJzB1/sWWN85+CvYXXV+uILEPj50af
         SChm741urkLBYwWKqREaogItYEAH1BupYLdynK1FBgD27iyq+e4b/6V4cWnxbKz5G07Q
         mdnQ==
X-Gm-Message-State: APjAAAWcVWuzbvfg8JA1k43bUe2ct7qjfuAaA7drBEW4ro4pbxkX7Wjr
        JOTcnhRiClbQ4W0/FaGgsvjtRW7RiVjYuA4VSXArA7ktxA4=
X-Google-Smtp-Source: APXvYqw1atDrcc42i8MEvrx/gscc504BdRQM5ImY8263eH+aKVJUxZYdGr+CTCgl5lvnIzE9pfOEdmMDDYUAKBrYGVc=
X-Received: by 2002:a2e:b167:: with SMTP id a7mr59129511ljm.26.1564402295882;
 Mon, 29 Jul 2019 05:11:35 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?UmFmYcWCIEdhamRh?= <rafal.gajda@silvair.com>
Date:   Mon, 29 Jul 2019 14:11:25 +0200
Message-ID: <CAFcXi1yYYNv3T-0UtFGf_n91hHBvShxuWJdCVhUpdBf6grRP2w@mail.gmail.com>
Subject: Mesh daemon to watch InterfacesRemoved signals
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi all,

At the moment after connecting an app, mesh daemon only watches for
that app disconnecting from D-Bus with:
node->disc_watch =3D l_dbus_add_disconnect_watch(bus,
node->owner, app_disc_cb, node, NULL);

in node.c::get_managed_objects_cb

I can unregister all of the app interfaces (leaving it non functional
but still connected to D-Bus) and mesh daemon will not be aware of
that, still trying to communicate with it.
This is especially problematic if app stops functioning correctly, but
daemon continues to call its methods i.e. when a message is received.

Maybe it would be beneficial for mesh daemon to listen to
InterfacesRemoved signals to determine when apps/nodes disconnect:

signal time=3D1564398245.483028 sender=3D:1.6219 -> destination=3D(null
destination) serial=3D27 path=3D/com/silvair/application;
interface=3Dorg.freedesktop.DBus.ObjectManager; member=3DInterfacesRemoved
   object path "/com/silvair/application"
   array [
      string "org.mesh daemon.mesh.Application1"
      string "org.mesh daemon.mesh.ProvisionAgent1"
   ]
signal time=3D1564398245.483133 sender=3D:1.6219 -> destination=3D(null
destination) serial=3D28 path=3D/com/silvair/application/element0;
interface=3Dorg.freedesktop.DBus.ObjectManager; member=3DInterfacesRemoved
   object path "/com/silvair/application/element0"
   array [
      string "org.mesh daemon.mesh.Element1"
   ]


This would give applications ability to, for example, have a multiple
nodes registered and remove/change some of them without whole app
restarting.


Best Regards

--=20

Rafa=C5=82 Gajda

Silvair Sp. z o.o.
Jasnog=C3=B3rska 44
31-358 Krakow
POLAND

www.silvair.com

NOTICE TO RECIPIENT

We inform you that Silvair sp. z o.o. with its registered office in
Cracow (31-358), at Jasnog=C3=B3rska Street 44 is the controller of your
personal data. You can find more information about processing personal
data and your rights here.


Informujemy, =C5=BCe administratorem Twoich danych jest Silvair sp. z o.o.
z siedzib=C4=85 w Krakowie  (31-358), ul. Jasnog=C3=B3rska 44. Wi=C4=99cej =
informacji
na temat przetwarzania danych osobowych i przys=C5=82uguj=C4=85cych Ci praw
znajdziesz tu


This e-mail message and any documents accompanying it contain
information that belongs to SILVAIR. This e-mail is meant for only the
intended recipient of the transmission and may be a communication
privileged by law, confidential and/or otherwise protected from
disclosure. If you received this e-mail in error and you are not the
intended recipient, any review, use, dissemination, distribution, or
copying of this e-mail or attachment is strictly prohibited. Please
notify us immediately of the error by return e-mail and please delete
this message from your system.
