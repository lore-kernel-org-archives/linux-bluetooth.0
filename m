Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Julien Campana <juliencampana@yahoo.fr>
To: BlueZ-devel List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1084285384.893.17.camel@fischer>
Mime-Version: 1.0
Subject: [Bluez-devel] Error while setting RFCOMM security options
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 11 May 2004 16:27:38 +0200

Hi!

I'm trying to connect to a device over RFCOMM using the flags
"authenticate", "encryption" and "master". Part of the code is:=20

/******************************************/
if ((fd =3D socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < 0)
     return fd;

memset(&local_addr, 0, sizeof(local_addr));
local_addr.rc_family =3D AF_BLUETOOTH;
bacpy(&local_addr.rc_bdaddr, BDADDR_ANY);
if ((err =3D bind(fd, (struct sockaddr *)&local_addr, sizeof(local_addr)))
< 0) {
     close(fd);
     return err;
   }

int opt =3D 0;
if (master) opt |=3D L2CAP_LM_MASTER;
if (auth) opt |=3D L2CAP_LM_AUTH;
if (encrypt) opt |=3D L2CAP_LM_ENCRYPT;



if (setsockopt(fd, SOL_RFCOMM, L2CAP_LM, &opt, sizeof(opt)) < 0) {
     printf("WARNING can't set link Mode (reason: %s)\n\n",
strerror(errno));
   }
/*******************************************/

This programm outputs the following message:=20
WARNING can't set link Mode (reason: Protocol not available)

Why? The L2CAP protocol is available as well as the RFCOMM protocol on
my machine (l2ping actually works and my program exchanges data over
RFCOMM without any problem).

Am I wrong in the way of setting these security flags?

Thank you for your answers.

Julien Campana





-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
