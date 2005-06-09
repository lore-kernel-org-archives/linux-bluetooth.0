Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42A82B4F.90805@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] BlueZ on ETRAX 100LX devboard 82+
References: <20050609111219.8923.qmail@web52804.mail.yahoo.com>
In-Reply-To: <20050609111219.8923.qmail@web52804.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Thu, 09 Jun 2005 13:43:11 +0200

Hello

There're (a lot) of mails about this topic in the archive. I don't 
remember directly how they ended, but if you've to program the rfcomm 
stuff yourself anyway, you're probably best of if you do it from beginning.
I had more or less the same problem when I started. I never was able to 
use the rfcomm utility, it never worked for me. So I programmed 
everything myself from the beginning on...

regards
Marco

Naved Aziz wrote:
> Hi,
>  
> I am currently working on the Axis devboard 82+ for a project that 
> requires bluetooth support on the board.  The kernel for the SDK 
> (obtained from the axis developer website) has support for BlueZ, and I 
> have been able to compile the kernel and flash the image onto the board 
> without any errors (the linux kernel used is 2.4.29).  The basic stack 
> functions like sdptool, hcitool, l2ping, work fine. 
>  
> However, the problem is with rfcomm.  I cannot connect to any remote 
> devices (I have tried with Nokia 6600), attempting which gives the 
> "Can't create RFCOMM socket: resource currently unavailable"), cannot 
> bind ("Can't create device list: Operation not supported"), cannot 
> release, etc.  Has anyone faced this problem with RFCOMM on this board?  
> I have also tried porting Axis's openBT stack, which I could not compile 
> into the kernel at all.
>  
> I am totally new at Linux, and would greatly appreciate any help that 
> someone can provide.
>  
> Sincerely and desperately,
>  
> Naved
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam? Yahoo! Mail has the best spam protection around
> http://mail.yahoo.com
> 



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
