Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42509930.20608@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Using bluetooth headset
References: <42507E3E.4090804@email.it>
In-Reply-To: <42507E3E.4090804@email.it>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 03 Apr 2005 19:32:32 -0600

check the requirements in the readme. you're probably missing libao-devel

Perini Davide wrote:
> Hello.
> Is there a simply way to use my bluetooth headset
> as a normal headset in Linux?
> 
> I seen btsco but I've got this error on Make
> 
> make  all-recursive
> make[1]: Entering directory `/home/sblantipodi/proba/btsco'
> Making all in sbc
> make[2]: Entering directory `/home/sblantipodi/proba/btsco/sbc'
> gcc @AO_CFLAGS@ -Wall -O2   -o sbcinfo  sbcinfo.o  -lasound -lm -ldl 
> -lpthread
> gcc: @AO_CFLAGS@: No such file or directory
> make[2]: *** [sbcinfo] Error 1
> make[2]: Leaving directory `/home/sblantipodi/proba/btsco/sbc'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/home/sblantipodi/proba/btsco'
> make: *** [all] Error 2
> 
> 
> Running Fedora Core 3
> Please help me
> 
> 
> 
> 
> -- 
> 
> Email.it, the professional e-mail, gratis per te: http://www.email.it/f
> 
> 
> 
> Sponsor:
> 
> La palestra in casa da Oliviero.it Trovi un' ampia gamma di tapis 
> roulant, a partire da € 429,00!
> *
> Clicca qui: http://adv.email.it/cgi-bin/foclick.cgi?mid=2845&d=4-4
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
