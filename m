Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <4045E93F.4040900@soft.uni-linz.ac.at>
From: Simon Vogl <vogl@soft.uni-linz.ac.at>
MIME-Version: 1.0
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Subject: [Bluez-devel] sco links
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
Date: Wed, 03 Mar 2004 15:18:39 +0100

hi,
can anyone help me with my sco link? in about 50% of cases, the audio dat=
a
has an offset of one byte, resulting in terrible noise. I think I saw a
flag in a packet header somewhere that indicates the number of bytes to s=
kip
until the audio data starts -- I looked through the bt specs several time=
s now
but can't find it again. Anyone has a clue for this?
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
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
