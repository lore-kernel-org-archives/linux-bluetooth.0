Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <42D2505A.6070206@soft.uni-linz.ac.at>
From: Simon Vogl <vogl@soft.uni-linz.ac.at>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=UTF-8; format=flowed
Subject: [Bluez-devel] zeevo module on uart
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
Date: Mon, 11 Jul 2005 12:56:26 +0200

hi,
I am trying to talk to a Zeevo BT module (tc2001p chip on it) which is
attached to an xscale processor via serial.
When I start hciattach, I get an error message (and I cannot talk to the
device later on):

root@tinypxa263:~# hciattach ttyS1 any
h4_recv: Unknown HCI packet type f1

The current kernel is 2.4.19-rmk7-pxa2 +local patches, bluez* 2.18
Is this a kernel issue or is something else in my setup wrong?
thanks
Simon

--=20
_______________________________________________________________________
Dr. Simon Vogl
ARC Seibersdorf research GmbH
Research Studios Austria, Studio Pervasive Computing Applications
Altenberger Stra=C3=9Fe 69, A-4040 Linz, Austria

Tel: +43 732 2468-8517, Fax: +43 732 2468-8426
mailto: simon.vogl@researchstudio.at



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
