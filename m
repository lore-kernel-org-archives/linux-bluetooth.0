Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <406A9E23.9000406@soft.uni-linz.ac.at>
From: Simon Vogl <vogl@soft.uni-linz.ac.at>
MIME-Version: 1.0
To: Bluez-devel <Bluez-devel@lists.sourceforge.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Subject: [Bluez-devel] sco / csr final notes
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
Date: Wed, 31 Mar 2004 12:32:03 +0200

well now I have a heuristic that works most of the time. Looking at the
transmitted data, I wonder if there could be a big endian/little endian
switch that is toggled randomly in the firmware for the 16bit sco data.

Is there a lucky person with a developer kit out there who is able
to confirm this?
Thanks,
Simon


--=20
_______________________________________________________________________
Dr. Simon Vogl
Institut f=C3=BCr Pervasive Computing, Johannes Kepler Universit=C3=A4t L=
inz
Altenberger Stra=C3=9Fe 69, A-4040 Linz, Austria

Tel: +43 732 2468-8517, Fax: +43 732 2468-8426
mailto: vogl@soft.uni-linz.ac.at,  http://www.soft.uni-linz.ac.at/








-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
