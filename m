Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41A3A32C.4090806@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Troubles compiling btsco
References: <41A39A11.3040906@musikcheck.dk>
In-Reply-To: <41A39A11.3040906@musikcheck.dk>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Tue, 23 Nov 2004 13:53:00 -0700

Hasse,

I know this isn't going to be a *lot* of help but I've been using debian 
with btsco. I don't know automake/autoconf/autobarf so I just update the 
various tools from -testing whenever they fail and it's working now...

Brad

Hasse Hagen Johansen wrote:
> Hi
> 
> I have checked out btsco from cvs from 
> http://www.gargan.org/linux/snd-bt-sco/
> 
> tried to run the bootstrap but i failed because the automake(on my 
> debian sid) didn't include --ignore-deps but only had a include-deps 
> option. I removed that
> 
> But when running configure I get this:
> 
> ./configure: line 2919: XIPH_PATH_AO: command not found
> 
> Don't know what that means, but it seems that this error is causing some 
> variable in the makefile not to substituted. I get this if I then try to 
> run make
> 
> miyagi:/home/hhj/btsco# make
> make  all-recursive
> make[1]: Entering directory `/home/hhj/btsco'
> Making all in sbc
> make[2]: Entering directory `/home/hhj/btsco/sbc'
> gcc -DHAVE_CONFIG_H -I. -I. -I..    @AO_CFLAGS@ -Wall -O2 -c sbclib.c
> gcc: @AO_CFLAGS@: No such file or directory
> make[2]: *** [sbclib.o] Error 1
> make[2]: Leaving directory `/home/hhj/btsco/sbc'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/home/hhj/btsco'
> make: *** [all-recursive-am] Error 2
> 
> I have tried to use a patch for debian from http://www.lxtreme.nl but 
> this doesn't seem to apply to the cvs version of btsco.
> 
> Does anyone have some tips ffor compiling it on debian?
> 
> Best Regards
> Hasse H. Johansen
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now. 
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
