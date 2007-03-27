Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46091D10.7070809@access-company.com>
Date: Tue, 27 Mar 2007 15:33:04 +0200
From: Frederic Dalleau <frederic.dalleau@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <200701150326.46855.bluez-devel@huitl.de>	<45BD6370.4050005@xmission.com>
	<45C36CE5.90205@access-company.com>
	<200703271139.42015.Tim.Chick@csr.com>
In-Reply-To: <200703271139.42015.Tim.Chick@csr.com>
Subject: Re: [Bluez-devel] a2dpd and mplayer - any chance to get it working?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


> It looks like this stuff is in flux at the moment?
>   
Well, some people reported it works, some said it don't, but to me, it 
works.
> I am using CVS from last night, and I see basically 100% CPU usage from 
> a2dpd, with mpg321 and mplayer whilst it is streaming.
>   
> This is running on a 400MHz ARM based system, so there should be plenty 
> of CPU available.
>   
Try a2dpd -g to get traces, to see possible errors.
Is the sound ok ? Does it do 100% when there is no stream?
Could you try it on pc?

Frederic

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
