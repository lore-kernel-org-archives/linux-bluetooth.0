Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Achim Bohnet <ach@mpe.mpg.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Can't understand
References: <200405121820.59166.andrewthegreat@mail.ru> <1084367829.25099.16.camel@pegasus>
In-Reply-To: <1084367829.25099.16.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200405122238.47202.ach@mpe.mpg.de>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 12 May 2004 22:38:47 +0200

On Wednesday 12 May 2004 15:17, Marcel Holtmann wrote:
> Hi Hedin,
> 
> > I have Redhat 9.0 with 2.6.6-mh1 patched kernel and all modules compiled.
> > I have Tecom BT3030 Dongle.
> > 
> > I compiled bluez-libs-2.7 and bluez-utils-2.7. After some effort (big effort!) 
> > I managed to compile bluez-pin (why is it needed - no word anywhere...).
> > 
> > I also installed all other modules without problems, except bluez-bluefw. It 
> > gives following errors:
> 
> the bluez-bluefw was never ported to work on 2.6 systems. You can use
> the bcm203x firmware loader driver instead. For some more information
> take a look here http://www.bluez.org/drivers.html

FWIW: I had a short intermezzo with SuSE 9.1 (kernel 2.6.4) some
hours ago and I had to install bluez-bluefw pkg to get the AVM USB
stick working (the pkg contained blubase.frm)  Maybe SuSE
just added the firmware file, maybe they did more.

Achim
> 
> Regards
> 
> Marcel
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by Sleepycat Software
> Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
> higher performing products faster, at low TCO.
> http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 
> 

-- 
  To me vi is Zen.  To use vi is to practice zen. Every command is
  a koan. Profound to the user, unintelligible to the uninitiated.
  You discover truth everytime you use it.
                                      -- reddy@lion.austin.ibm.com


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
