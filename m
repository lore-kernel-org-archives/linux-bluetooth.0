Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44D0D695.6060709@palmsource.com>
Date: Wed, 02 Aug 2006 18:45:09 +0200
From: Frederic Danis <frederic.danis@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44D0D1BB.7010400@palmsource.com>
	<Pine.LNX.4.63.0608021833340.6321@redbean.intranet.gw-instruments.de>
In-Reply-To: <Pine.LNX.4.63.0608021833340.6321@redbean.intranet.gw-instruments.de>
Subject: Re: [Bluez-devel] rfcomm command output
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

Hello Peter,


Peter Wippich wrote:

>Hi Fred, 
>
>On Wed, 2 Aug 2006, Frederic Danis wrote:
>
>  
>
>>Hello
>>
>>I want to use rfcomm command and start a program when a connection is 
>>made. To do this I try "rfcomm listen 0 > rfcomm.log 2>&1" but nothing 
>>is written to rfcomm.log file. (same problem happens if I try to pipe 
>>output to another program). Do you have any idea why I can not redirect 
>>rfcomm output ?
>>Is there another way to start a program on rfcomm connection ?
>>    
>>
>
>You have to give a device (e.g. /dev/rfcomm0) on which you want to listen. 
>  
>
I understand that "rfcomm listen 0" will create /dev/rfcomm0 when a 
client connects to my device, but I want to start my program (that can 
use a device like /dev/rfcomm0 or /dev/ttyS0) after this creation (and 
don't know how to do this in a shell).

Thanks

Fred

-----------------------------------------------
It is not by improving the oil lamp that one invents the electric bulb!
-----------------------------------------------
Danis Frederic            PalmSource Europe
Software engineer
Mail : mailto:frederic.danis@palmsource.com
-----------------------------------------------


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
