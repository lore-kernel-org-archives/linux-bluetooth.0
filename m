Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] newbe: rfcomm_recv_frame: bad checksum in packet
From: Marcel Holtmann <marcel@holtmann.org>
To: pat <pat@xvalheru.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040910155027.M37511@xvalheru.org>
References: <20040910155027.M37511@xvalheru.org>
Content-Type: text/plain
Message-Id: <1094997603.5695.9.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 12 Sep 2004 16:00:03 +0200

Hi Pat,

> I have installed the BlueZ to my laptop because I want to use GPRT through the
> Bluetooth. I have scripts and the rest configured and I'm able to connect and
> upload some data, but within 30 seconds the connection go down. The system log
> contains only this line "rfcomm_recv_frame: bad checksum in packet". Could
> someone help me ???

actually this should never happen, because the underlaying L2CAP layer
is reliable. Try to use the latest 2.6 kernel and run "hcidump -X" as
root and show the output to us.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
