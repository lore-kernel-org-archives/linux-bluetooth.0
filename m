Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4582A310.60905@jambit.com>
Date: Fri, 15 Dec 2006 14:28:48 +0100
From: =?ISO-8859-15?Q?Frank_Heimb=E4cher?= <frank.heimbaecher@jambit.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
References: <44F6B7AE.1030209@jambit.com>
In-Reply-To: <44F6B7AE.1030209@jambit.com>
Subject: [Bluez-users] How to use sbc.c of btsco?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Dear community

I want to use the codec implemented in sbc.c in btsco. Is there a chance
to get a documentation of the code? I understand so much that you call
sbc_init() first, sbc_finish() at the end, and use sbc_decode() and
sbc_encode() for converting.

sbc_encode: It seems like you put pcm data on 'data' and get sbc data in
 'sbc.data'. 'count' is not used in the function. How often must I call
it? How do I know how much of 'data' is converted already?

sbc_decode: Put sbc data on 'data' and you get pcm data in 'sbc.m.data'.
Is that right? Must I always change the byte order like it is done in
a2recv.c?

Are there special things to do if I have a .wav file or do I just have
to call the functions? I am just talking of the payload and not the headers.

It would help me a lot if somebody could put me on the right track.

Thanks a lot
Frank


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
