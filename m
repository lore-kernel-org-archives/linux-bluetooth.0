Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
In-Reply-To: <be976db60612191123s62dfa67egc3c937e63ae2031@mail.gmail.com>
References: <be976db60612191123s62dfa67egc3c937e63ae2031@mail.gmail.com>
Message-Id: <E34033EC-19D4-4112-A964-C656CA724290@gmail.com>
From: Bas Schulte <basschulte@gmail.com>
Date: Tue, 19 Dec 2006 20:37:26 +0100
To: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] minicom over /dev/rfcomm0
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

Hi,

On 19-dec-2006, at 20:23, Mark S. Townsley wrote:

> In many examples that I found online where people are trying to  
> make their cellphone surf web or somehow talk to their cellphone  
> from Bluez, I notice that they can often do minicom over /dev/ 
> rfcomm0 in the setup.
>
> If I want to access the serial port service like that, but from my  
> C program, do I just treat /dev/rfcomm0 as a serial device and use  
> standard Unix serial programming libraries from my C program to do so?
> Just curious.  Thanks in advanced for any tip.

You sure can.

You can of course use the code provided by Manuel too but then your  
code won't work without rfcomm/bluetooth. The nice thing is that if  
you keep it generic you can test your application using any old  
serial connection. Or use a pipe in the filesystem etc..

Caveat: I can't get mgetty to work by feeding it /dev/rfcommX though : 
( It should work, must be one of those things ;)


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
