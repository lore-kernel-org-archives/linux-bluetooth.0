Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <456184AD.4040009@eridani.co.uk>
Date: Mon, 20 Nov 2006 10:34:21 +0000
From: Michael McConnell <soruk@eridani.co.uk>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <45617D44.3010403@det.uvigo.es>
In-Reply-To: <45617D44.3010403@det.uvigo.es>
Subject: Re: [Bluez-users] emulating a GPRS modem with a linux PC
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

scostas wrote:
> Hi all:
> 
> I have a PDA and I need to connect to the internet with it, but at work. 
> I tried Synce but it doesn't work, because Pocket IE wants a true 
> connection, and Synce still doesn't support the desktop passthroug.
> 
> So I had the idea of emulating a BlueTooth GPRS modem with the PC. This 
> is: the PDA will think that my PC has a GPRS modem and will use it to 
> connect to the internet.
> 
> Is possible to do that? I tried to do it with pppd and /dev/rfcomm0 but 
> I was unable to make it work :(

You may need to set up some kind of "chat" script to emulate the AT 
interface of the mobile phone, this will take some trial and error since 
everything seems to want to send different commands :-/  The important 
one would be the ATD<whatever> command, in that case send "CONNECT" 
(chat will add the \r\n) then start PPP.

Hope that helps.

-- 
-- Michael "Soruk" McConnell
   Eridani Star System

   MailStripper - http://www.MailStripper.eu/ - SMTP spam filter
   Mail Me Anywhere - http://www.MailMeAnywhere.com/ - Mobile email

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
