Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42C177D9.2040000@backend-wizard.com>
From: Attila Zsigmond <mail@backend-wizard.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Something strange with minicom
References: <200504300003.22570@ByZsA> <200504302029.45490@ByZsA>	 <1114889914.8836.168.camel@pegasus>  <200505021222.59646@ByZsA> <1115030245.21785.109.camel@pegasus>
In-Reply-To: <1115030245.21785.109.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
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
Date: Tue, 28 Jun 2005 18:16:25 +0200

It cleared finally. I write this only to help to others. There was no 
hardware error, no kernel error, no bluez error, no error in the phone. 
I didn't know about rfcomm channels and I used the default 1 instead of 
5, which is for serial port service on sharp GX15 phone.

Attila

Marcel Holtmann wrote:
> Hi Attila,
> 
> 
>>Is it possible that this error is caused by a kernel error? You knows it 
>>better... I have an old 2.4.24 kernel version. (Old kernel on an old 
>>PC: 700 MHz duron. :-( ) I know I should upgrade both.
> 
> 
> I never tried a Samsung phone and maybe they are a little bit buggy, but
> it can also be a problem of the kernel. The 2.4 series is no longer
> actively maintained and you should really update to a 2.6 kernel.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: NEC IT Guy Games.
> Get your fingers limbered up and give it your best shot. 4 great events, 4
> opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
> win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
