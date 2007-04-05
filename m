Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4614BA5D.5010701@access-company.com>
Date: Thu, 05 Apr 2007 10:59:09 +0200
From: Frederic Dalleau <frederic.dalleau@access-company.com>
MIME-Version: 1.0
To: Tim Chick <chick@computergeek.freeserve.co.uk>
References: <200701150326.46855.bluez-devel@huitl.de>
	<200703271139.42015.Tim.Chick@csr.com>
	<46091D10.7070809@access-company.com>
	<200703271501.49792.chick@computergeek.freeserve.co.uk>
In-Reply-To: <200703271501.49792.chick@computergeek.freeserve.co.uk>
Cc: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] Question about poll() - was Re: a2dpd and mplayer -
 any chance to get it working?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,
I'm investigating the problem tim talked about :
>>> I am using CVS from last night, and I see basically 100% CPU usage
>>> from a2dpd, with mpg321 and mplayer whilst it is streaming.
>>>       =

While I don't get 100% on arm I got a significant cpu usage which the =

previous btsco was not doing.
When streaming a2dpd is calling poll with small timeouts (like 1 ms) to =

ensure packets get sent at right time.
If poll(x,y,1) is replaced by usleep(1); poll(x,y,0) then cpu usage fall =

back to 0.

This means the poll call itself is burning cpu. Mmmm, I think this is =

strange.
Any ideas? What's the best place to find information for question like this?

Fr=E9d=E9ric


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
