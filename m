Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <032b01c5a7ae$fd98ba00$6c01a8c0@Vijayakumar>
From: "Vijayakumar" <vijayakumar@isofttech.com>
To: <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Subject: [Bluez-devel] pand problem
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 23 Aug 2005 12:20:46 +0530

Hi all,

My linux kernel version is 2.4.20-8
Applied 2.4.18 mh patch

      My pand connection gets disconnected after about 4-5 hrs. I 
established pand connection between 2 dongles and ran multiple telnet 
sessions (each running ls -lR in an infinite loop) and an ftp 
session(transfers files repeatedly between the machines in an infinite 
loop).After some 4-5 hrs i found that the pand onnection no longer existed.

And I found "NET unregister event not supported" in my system log 
messages....Below is my system log...


Aug 22 20:45:14 test1 kernel: BlueZ L2CAP ver 2.1 Copyright (C) 2000,2001 
Qualcomm Inc
Aug 22 20:45:14 test1 kernel: Written 2000,2001 by Maxim Krasnyansky 
<maxk@qualcomm.com>
Aug 22 20:45:19 test1 kernel: BlueZ RFCOMM ver 0.4
Aug 22 20:45:19 test1 kernel: Copyright (C) 2002 Maxim Krasnyansky 
<maxk@qualcomm.com>
Aug 22 20:45:19 test1 kernel: Copyright (C) 2002 Marcel Holtmann 
<marcel@holtmann.org>
Aug 22 20:45:29 test1 kernel: BlueZ BNEP ver 1.1
Aug 22 20:45:29 test1 kernel: Copyright (C) 2001,2002 Inventel Systemes
Aug 22 20:45:29 test1 kernel: Written 2001,2002 by Clement Moreau 
<clement.moreau@inventel.fr>
Aug 22 20:45:29 test1 kernel: Written 2001,2002 by David Libault 
<david.libault@inventel.fr>
Aug 22 20:45:29 test1 kernel: Copyright (C) 2002 Maxim Krasnyanskiy 
<maxk@qualcomm.com>
Aug 22 20:45:50 test1 hcid[27188]: Bluetooth HCI daemon
Aug 22 20:45:50 test1 hcid[27188]: Starting security manager 0
Aug 22 20:45:52 test1 sdpd[27192]: Bluetooth SDP daemon
Aug 22 20:46:59 test1 pand[27198]: Bluetooth PAN daemon version 2.17
Aug 22 20:47:16 test1 hcid[27188]: link_key_request (sba=00:0F:3D:4C:4D:C6, 
dba=00:0B:91:FF:FF:41)
Aug 22 20:47:16 test1 hcid[27188]: pin_code_request (sba=00:0F:3D:4C:4D:C6, 
dba=00:0B:91:FF:FF:41)
Aug 22 20:47:16 test1 hcid[27188]: link_key_notify (sba=00:0F:3D:4C:4D:C6, 
dba=00:0B:91:FF:FF:41)
Aug 22 20:47:16 test1 pand[27199]: New connection from 00:0B:91:FF:FF:41 
bnep0
Aug 22 20:47:16 test1 /etc/hotplug/net.agent: invoke ifup bnep0
Aug 22 20:47:17 test1 kernel: ip_tables: (C) 2000-2002 Netfilter core team
Aug 22 20:54:42 test1 login(pam_unix)[4647]: session opened for user root by 
LOGIN(uid=0)
Aug 23 01:01:35 test1 /etc/hotplug/net.agent: NET unregister event not 
supported
Aug 23 04:22:32 test1 su(pam_unix)[28881]: session opened for user news by 
(uid=0)
Aug 23 04:22:32 test1 su(pam_unix)[28881]: session closed for user news

Regards,
Vijayakumar. 



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
