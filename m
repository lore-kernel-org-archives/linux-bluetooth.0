Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20040630190206.GB26352@spring.luon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: sjoerd@spring.luon.net (Sjoerd Simons)
Subject: [Bluez-devel] btaddr <-> name bug ?
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
Date: Wed, 30 Jun 2004 21:02:06 +0200

Hi,

  Doing hcitool scan a few times gives some weird output:

$ hcitool scan
Scanning ...
        00:0D:93:08:60:89       familiar (0)
        00:02:C7:0B:97:F9       spring-0
$ hcitool scan
Scanning ...
        00:0D:93:08:60:89       spring-0
        00:02:C7:0B:97:F9       familiar (0)
$ hcitool scan
Scanning ...
        00:0D:93:08:60:89       spring-0
        00:02:C7:0B:97:F9       familiar (0)
$ hcitool scan
Scanning ...
        00:0D:93:08:60:89       familiar (0)
        00:02:C7:0B:97:F9       spring-0

The second and third run provide the right information, the first and last =
are=20
wrong.

I see this behaviour on both my powerbook and my destop machine. Both are=
=20
running debian unstable (bluez-libs and bluez-utils 2.7) with kernel 2.6.7.

Desktop dongle information:
hci0:   Type: USB
       BD Address: 00:02:72:00:FD:64 ACL MTU: 192:8  SCO MTU: 64:8
       HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x2=
0d
       Manufacturer: Cambridge Silicon Radio (10)

Powerbook builtin bluetooth information:
hci0:   Type: USB
        BD Address: 00:0D:93:08:60:89 ACL MTU: 192:8  SCO MTU: 64:8
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20e LMP Ver: 1.1 (0x1) LMP Subver: 0x=
20e
        Manufacturer: Cambridge Silicon Radio (10)

  Sjoerd
--=20
Logic is a little bird, sitting in a tree; that smells *_____=08=08=08=08=
=08awful*.


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
