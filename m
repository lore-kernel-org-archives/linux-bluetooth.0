Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038C9C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Nov 2022 22:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbiKSWqp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Nov 2022 17:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbiKSWqo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Nov 2022 17:46:44 -0500
Received: from mr85p00im-zteg06021501.me.com (mr85p00im-zteg06021501.me.com [17.58.23.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A495F7B
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Nov 2022 14:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1668898003; bh=AR/FIrOLWaA3wFV7lNtNZ7j0pA2fC7HblFa8+hrYJYA=;
        h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To;
        b=m7JMULC8956OsUa4+5onDRjNQA94RlcqrkQ199qd7q1VUTdNjtXfnWcuNFhYV8U0G
         55OUuKMCDT7HXXQ134gWA7mhFTxJAgRaqbGZo3qEko1/Nthx5gUPzv05zc+OBxr+Ht
         EHiHCc9/KdaxtzF7pUqqYZ+Zc98N8OERh/ub6zsO61hFh6wmO52oPfJj2VTsq+zqWi
         p932+lsrurwCEOpSh+kahGlZM6aQ7ZHmOggLdVTWLZI2t2xG43WySN5w3nKj62OIof
         Fo6EPKjTGotD0Gto+yP87nKRFMsFQCiZfSw0JUTWRKpzMRvGJESR2MBPcktw8GiUzM
         UiPPoLFKhGEJg==
Received: from smtpclient.apple (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-zteg06021501.me.com (Postfix) with ESMTPSA id B93DE279425A
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Nov 2022 22:46:42 +0000 (UTC)
From:   Andrew McNaughton <andrewmcnaughton@me.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.96\))
Subject: How to get USB bluetooth device working/supported?
Message-Id: <37313DFD-3F70-4CA9-BF3E-B08FAB4BEB39@me.com>
Date:   Sat, 19 Nov 2022 22:46:28 +0000
To:     linux-bluetooth@vger.kernel.org
X-Mailer: Apple Mail (2.3731.300.96)
X-Proofpoint-ORIG-GUID: hK81VmjB6D0RCRfyqtkV44_7WWaxuwsB
X-Proofpoint-GUID: hK81VmjB6D0RCRfyqtkV44_7WWaxuwsB
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.572,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-14=5F01:2022-01-14=5F01,2020-02-14=5F11,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 clxscore=1015 spamscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=815 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2211190178
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

How does one go about getting a device that should work with btusb but =
doesn=E2=80=99t? It works fine with Microsoft generic bt drivers. There =
must be some sort of quirk.

This is for a Bluetooth 5.3 transceiver. There=E2=80=99s not a lot of =
these about yet but I think important for accessing newer/upcoming audio =
purposes.


=46rom /sys/kernel/debug/usb/devices:

T:  Bus=3D02 Lev=3D02 Prnt=3D02 Port=3D01 Cnt=3D01 Dev#=3D  3 Spd=3D12   =
MxCh=3D 0
D:  Ver=3D 2.00 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D10d7 ProdID=3Db012 Rev=3D88.91
S:  Manufacturer=3DActions
S:  Product=3Dgeneral adapter
S:  SerialNumber=3DACTIONS1234
C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3Dc0 MxPwr=3D100mA
I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D1ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
E:  Ad=3D01(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
E:  Ad=3D01(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
E:  Ad=3D01(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
E:  Ad=3D01(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
E:  Ad=3D01(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 =
Driver=3Dbtusb
E:  Ad=3D01(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms


dmesg | grep Bluetooth
[   11.375035] Bluetooth: Core ver 2.22
[   11.375054] Bluetooth: HCI device and connection manager initialized
[   11.375057] Bluetooth: HCI socket layer initialized
[   11.375059] Bluetooth: L2CAP socket layer initialized
[   11.375062] Bluetooth: SCO socket layer initialized
[   11.450398] Bluetooth: hci0: Opcode 0x c5a failed: -56
[   12.455169] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   12.455173] Bluetooth: BNEP filters: protocol multicast
[   12.455176] Bluetooth: BNEP socket layer initialized


This is on Linux Kernel: 6.0.8-300.fc37.aarch64


This needs to be added to the usb.ids (I=E2=80=99ve tried submitting to =
the update robot but I don=E2=80=99t know if that is still alive):

10d7 Actions Semiconductor Co., Ltd
b012 ATS2851 Bluetooth 5.3 Transceiver [Ugreen CM591]



Thanks in advance.
--
Andrew McNaughton

email: andrewmcnaughton@me.com=
