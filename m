Return-Path: <SRS0=FwQS=W3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C59C3A59B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 31 Aug 2019 02:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 265E523711
	for <linux-bluetooth@archiver.kernel.org>; Sat, 31 Aug 2019 02:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Yg0xIJtv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfHaCTZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Aug 2019 22:19:25 -0400
Received: from mout.gmx.net ([212.227.15.19]:42865 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726976AbfHaCTZ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Aug 2019 22:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567217961;
        bh=ifidEffeyMupzIkg+f7JcgQzRGW/+0Poj7qYGtbo06Y=;
        h=X-UI-Sender-Class:Subject:References:To:From:Date:In-Reply-To;
        b=Yg0xIJtvri5n3UdR0GVFFFAwTZvcQ0xPxqNxDj9Vy6w+Lf9E96kZ8R1jE/2oqJI7a
         wiU2e3cgpxwyeOcYJ6Lg1PKli0Ljhzy4hyHxGIzElw5gw0BsB9cF4rfRyC8woiPfP+
         lVw9cY8fCc1txHItDJRCX2glW4iAc5rzydv+Jd8w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.188.20] ([91.115.152.31]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6Db0-1i63mL2QeG-006eTY for
 <linux-bluetooth@vger.kernel.org>; Sat, 31 Aug 2019 04:19:21 +0200
Subject: mesh: DBus NoReplay in Python script
References: <30b2e8c6-e95f-29e0-2887-55a4b2eea004@gmx.at>
To:     linux-bluetooth@vger.kernel.org
From:   Fabian Mauroner <mauroner@gmx.at>
X-Forwarded-Message-Id: <30b2e8c6-e95f-29e0-2887-55a4b2eea004@gmx.at>
Message-ID: <fb15bb13-3dc4-5f98-b63b-aeb65e7cd730@gmx.at>
Date:   Sat, 31 Aug 2019 04:19:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <30b2e8c6-e95f-29e0-2887-55a4b2eea004@gmx.at>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:rxuFZKvRkrBUS6sNb+ihqZK5VNVsF/l7gRfPq2ABc7wWBnNF307
 odSmniENdURGS/XjhymwhakyPVJLfL1ICbTu7zJp4hp5bk+bRVhDfMwYAOxOlnRunsTku3D
 LLmDgL9np+l4VhT/K/73qmhWAAbHD0u20vt87/79DqvRxA3mTroU115LkDZEi1ckxwxrZ/k
 pl0OMKzZnqGy4BziB+2GA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m5KCbIDptqI=:46UwuxjS2o0KPpmKhTVpdV
 emc03A0a/Bt7fExjzWMYH2w/BrPt1FK6h38sKgI+Zz1qxVDSWXHucaB2NrLmkqTxmE5HBsNxs
 maZok0gaMvUkBCysgFVxqQmHxUQfKyBKLUKsLO0NvymqBgre7wtC7LdZezP9iSEx3MYNyn1Fr
 AI4YcnJUVZzEpV+jpiVKHewDzpy3ORsY14hlOCQK1VuVlD0GRFUzsHOgmxDpv/6irmLM1PheA
 FQO7vVR5IJieLxPNF2uDq1onhuDs1CWvE9CzkQA1j86zaRJ0MxqsdcNYfEhcuIC/0AIWWIkGe
 8JoN/oZiiS01pYqYHVtTH7RZYUE3OJqWAeXSnNW2uqCINxLjb9Zah5/xU4LL47IV9dx16sQXW
 BnQ19yc4alURAgs2D3hYBLi0RErqxTh4ieutbZlfnw4nsZUdnUnMRfyPRjk+B0yKcTN6w23em
 3MBi+NkHAaksI7TdwnN3tVXhd6Kf7/znpfUdduNj48W9r/KVMVBbDrAbFZYdkOggQCC4Z+cE3
 f/hlqyblt3xlwgdqN37OCD55QR/SXms4FU1/cTp9MzUkCsTVzSQcsTAN+cuNjYb0dO8EI5EmB
 MAy4jgs92ITzxDJJVchOgZnX8xcwHYhgK0nWlUzy8n0zyDSWxZlmeiJogF7VsCMIPhA3jSc7i
 uHdCKMStQakTJk6ubffQ6ltza2/pVz2OxuOvsn9628fh20gUsNC2Phl0FBDBgiU1nLS1r+5qj
 CetWS+DyVyctI+TJIHIjUzWN5F8XiVtKH9ujBhzQ2IoH+kXQs4WAR0ScpqfZR1dU7HYCARlFR
 Mk20RNeUD0pvw0ZcNA3r4eFmyJ08Pyg2CW+4vN5ZvQzWMmsCWm6jvnBtyxvyMgWj0HDfa1z05
 FY4AuUDKkvwwEQAC7AhueILYX2sEoAzgz1C3hOqu5Pa8fxEtDmm60BXzwTZrCMZqpMgJX4xp7
 YY62sfkoASivY4ogZupPJYOMtw8I/1pFFdO9lJ+W/h4aTkjNOQW4ha/NIpWw80M2//n1hj1eC
 3uv5LedR6hHai+TOuFEUoy8QbQXekr3aa0IJrTIIxEA81fV32ctoD8aP0OCuNLB3FDjvhDZj0
 EvlAgaKKvTwrvWR6RPW4LmBXIijHskxGNYOnSevXTajVMTIHO0WKXpuOwiwQghC/dVKRlaFyi
 crD2AY/AsQRrxcrPL6anctGNqGzpAS8Lcd+qQ8OdpnoF2adA==
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello dear bluez developers,

I have a problem with the Import function in bluetooth mesh:

I have a python program ble_mesh_node.py which runs as root started by
systemctl. I'm initializing all the required stuff (as in the mesh test
python script), start the mainloop in another thread, and then the
import function is called.
There I'm getting an Error.NoReply exception as you can seen in the output=
:

    /2019-08-30 14:23:52,883 - ble_mesh_node.py:729 - ERROR -
    org.freedesktop.DBus.Error.NoReply: Did not receive a reply.
    Possible causes include: the remote application did not send a
    reply, the message bus security policy blocked the reply, the reply
    timeout expired, or the network connection was broken.//
    //Traceback (most recent call last)://
    //=C2=A0 File "/home/pi/smarthome/gui/ble_mesh_node/ble_mesh_node.py",
    line 793, in <module>//
    //=C2=A0=C2=A0=C2=A0 with open('config.json', 'r') as f://
    //FileNotFoundError: [Errno 2] No such file or directory:
    'config.json'//
    //
    //During handling of the above exception, another exception occurred:/=
/
    //
    //Traceback (most recent call last)://
    //=C2=A0 File "/home/pi/smarthome/gui/ble_mesh_node/ble_mesh_node.py",
    line 724, in import_node//
    //=C2=A0=C2=A0=C2=A0 iv_index, unicast)//
    //=C2=A0 File
    "/home/pi/smarthome/local/env/lib/python3.7/site-packages/dbus/proxies=
.py",
    line 70, in __call__//
    //=C2=A0=C2=A0=C2=A0 return self._proxy_method(*args, **keywords)//
    //=C2=A0 File
    "/home/pi/smarthome/local/env/lib/python3.7/site-packages/dbus/proxies=
.py",
    line 145, in __call__//
    //=C2=A0=C2=A0=C2=A0 **keywords)//
    //=C2=A0 File
    "/home/pi/smarthome/local/env/lib/python3.7/site-packages/dbus/connect=
ion.py",
    line 651, in call_blocking//
    //=C2=A0=C2=A0=C2=A0 message, timeout)//
    //*dbus.exceptions.DBusException:
    org.freedesktop.DBus.Error.NoReply: Did not receive a reply.
    Possible causes include: the remote application did not send a
    reply, the message bus security policy blocked the reply, the reply
    timeout expired, or the network connection was broken.*/

That has the following relevant python code:

    /=C2=A0=C2=A0=C2=A0 token =3D -1//
    //=C2=A0=C2=A0=C2=A0 try://
    //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with open('config.json', =
'r') as f://
    //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d=
ata =3D json.load(f)//
    //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t=
oken =3D int(data['token'])//
    //=C2=A0=C2=A0=C2=A0 except IOError://
    //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 try://
    ////*token =3D bleMeshNode.import_node()*//
    //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 except://
    //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
ass//
    //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if token !=3D -1://
    //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 w=
ith open('config.json', 'w') as f://
    //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 data =3D {}//
    //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 data['token'] =3D token//
    //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 data =3D json.dump(data, f)/


However, it seems that only the return value (token) cannot be sent
back, because the node.json file can be successfully created with
meaningful content and also a token is created which I printed in the
create_node_ready_cb function:

        /static void create_node_ready_cb(void *user_data, int status,//
        //struct mesh_node *node)//
        //{//
        //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct l_dbus_message=
 *reply;//
        //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct l_dbus_message=
 *pending_msg;//
        //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const uint8_t *token;=
//
        //
        //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pending_msg =3D l_que=
ue_find(pending_queue,
        simple_match, user_data);//
        //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!pending_msg){//
        //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 l_debug("pending msg\n");//
        //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;//
        //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }//
        //
        //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (status !=3D MESH_=
ERROR_NONE) {//
        //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 l_debug("status !=3D \n");//
        //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 reply =3D dbus_error(pending_msg, status, NULL=
);//
        //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto done;//
        //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }//
        //
        //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node_attach_io(node, =
mesh.io);//
        //
        //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reply =3D l_dbus_mess=
age_new_method_return(pending_msg);//
        //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 token =3D node_get_to=
ken(node);//
        ////*l_debug("token %i \n", *token);*//
        //
        //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l_debug();//
        //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l_dbus_message_set_ar=
guments(reply, "t",
        l_get_be64(token));//
        //
        //done://
        //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l_dbus_send(dbus_get_=
bus(), reply);//
        //=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 l_queue_remove(pendin=
g_queue, pending_msg);//
        //}/


here the output from the journalctl:

    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS] < 6c 02 01
    01 c0 01 00 00 08 00 00 00 3d 00 00 00 l...........=3D...
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 0=
6 01 73
    00 04 00 00 00 3a 31 2e 34 00 00 00 00=C2=A0 ..s.....:1.4....
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 0=
5 01 75
    00 06 00 00 00 08 01 67 00 0d 61 7b 6f=C2=A0 ..u.......g..a{o
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 6=
1 7b 73
    61 7b 73 76 7d 7d 7d 00 00 00 00 00 00=C2=A0 a{sa{sv}}}......
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 0=
7 01 73
    00 04 00 00 00 3a 31 2e 38 00 00 00 00=C2=A0 ..s.....:1.8....
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 b=
8 01 00
    00 00 00 00 00 0d 00 00 00 2f 61 74 2f=C2=A0 ............/at/
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 7=
3 6d 61
    72 74 68 6f 6d 65 00 00 00 6c 00 00 00=C2=A0 smarthome...l...
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 1=
b 00 00
    00 6f 72 67 2e 62 6c 75 65 7a 2e 6d 65=C2=A0 ....org.bluez.me
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 7=
3 68 2e
    41 70 70 6c 69 63 61 74 69 6f 6e 31 00=C2=A0 sh.Application1.
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 4=
4 00 00
    00 00 00 00 00 09 00 00 00 43 6f 6d 70=C2=A0 D...........Comp
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 6=
1 6e 79
    49 44 00 01 71 00 00 fe ff 00 00 00 00=C2=A0 anyID..q........
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 0=
9 00 00
    00 50 72 6f 64 75 63 74 49 44 00 01 71=C2=A0 ....ProductID..q
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 0=
0 00 01
    00 00 00 00 00 09 00 00 00 56 65 72 73=C2=A0 ............Vers
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 6=
9 6f 6e
    49 44 00 01 71 00 00 01 00 00 00 00 00=C2=A0 ionID..q........
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 1=
3 00 00
    00 2f 61 74 2f 73 6d 61 72 74 68 6f 6d=C2=A0 ..../at/smarthom
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 6=
5 2f 61
    67 65 6e 74 00 7e 00 00 00 00 00 00 00=C2=A0 e/agent.~.......
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 1=
e 00 00
    00 6f 72 67 2e 62 6c 75 65 7a 2e 6d 65=C2=A0 ....org.bluez.me
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 7=
3 68 2e
    50 72 6f 76 69 73 69 6f 6e 41 67 65 6e=C2=A0 sh.ProvisionAgen
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 7=
4 31 00
    00 56 00 00 00 0c 00 00 00 43 61 70 61=C2=A0 t1..V.......Capa
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 6=
2 69 6c
    69 74 69 65 73 00 02 61 73 00 00 00 00=C2=A0 bilities..as....
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 1=
0 00 00
    00 0b 00 00 00 6f 75 74 2d 6e 75 6d 65=C2=A0 ........out-nume
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 7=
2 69 63
    00 00 00 00 00 0d 00 00 00 4f 75 74 4f=C2=A0 ric.........OutO
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 6=
6 42 61
    6e 64 49 6e 66 6f 00 02 61 73 00 00 00=C2=A0 fBandInfo..as...
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 0=
a 00 00
    00 05 00 00 00 6f 74 68 65 72 00 00 00=C2=A0 ........other...
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 1=
3 00 00
    00 2f 61 74 2f 73 6d 61 72 74 68 6f 6d=C2=A0 ..../at/smarthom
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 6=
5 2f 65
    6c 65 30 30 00 70 00 00 00 00 00 00 00=C2=A0 e/ele00.p.......
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 1=
7 00 00
    00 6f 72 67 2e 62 6c 75 65 7a 2e 6d 65=C2=A0 ....org.bluez.me
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 7=
3 68 2e
    45 6c 65 6d 65 6e 74 31 00 50 00 00 00=C2=A0 sh.Element1.P...
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 0=
5 00 00
    00 49 6e 64 65 78 00 01 79 00 00 00 00=C2=A0 ....Index..y....
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 0=
6 00 00
    00 4d 6f 64 65 6c 73 00 02 61 71 00 00=C2=A0 ....Models..aq..
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 0=
a 00 00
    00 00 10 01 10 03 10 0b 10 11 10 00 00=C2=A0 ................
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 0=
c 00 00
    00 56 65 6e 64 6f 72 4d 6f 64 65 6c 73=C2=A0 ....VendorModels
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 0=
0 05 61
    28 71 71 29 00 00 00 00 00 00 00 00 00=C2=A0 ..a(qq).........
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]:
    mesh/node.c:get_app_properties() path /at/smarthome
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]:
    mesh/node.c:get_element_properties() path /at/smarthome/ele00
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]:
    mesh/mesh-config-json.c:mesh_config_create() New node config
    /tmp/0a0102030405060708090a0b0c0d0e0f/node.json
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]:
    mesh/cfgmod-server.c:cfgmod_server_init() 00
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]:
    mesh/keyring.c:keyring_put_remote_dev_key() Put Dev Key
    /tmp/0a0102030405060708090a0b0c0d0e0f/dev_keys/0070
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]:
    mesh/keyring.c:keyring_put_net_key() Put Net Key
    /tmp/0a0102030405060708090a0b0c0d0e0f/net_keys/000
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: Register io cb
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: recv_register 1
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: recv_register 3
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: Send SNB on
    network 000
    *Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]:
    mesh/mesh.c:create_node_ready_cb() token 239*
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]:
    mesh/mesh.c:create_node_ready_cb()
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS] > 6c 02 01
    01 08 00 00 00 07 00 00 00 1f 00 00 00=C2=A0 l...............
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 0=
6 01 73
    00 04 00 00 00 3a 31 2e 38 00 00 00 00=C2=A0 ..s.....:1.8....
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 0=
5 01 75
    00 07 00 00 00 08 01 67 00 01 74 00 00=C2=A0 ..u.......g..t..
    Aug 30 14:23:52 raspberrypi bluetooth-meshd[439]: [DBUS]=C2=A0=C2=A0 4=
2 58 aa
    3b 7e e8 72 ef=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 BX.;~.r.


When I'm starting the program once again, instead of the Error.NoReply I
get an AlreadyExists Error.
One thing what I'm a bit wondering is, that the exception is thrown at
the same time (14:23:52) as the node was created...
This brings me to the conclusion, that there is only a problem with the
return value/message.

In the past I tried also the attach, join, create_network etc. functions
and I got always the same NoReplay Error, although I'm running the
program as root..

I hope you can help me to bring my private smartHome to run...

Best regards from Austria,
Fabian Mauroner



