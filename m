Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] tcp/ip with bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <2de4657604110906345b0b1576@mail.gmail.com>
References: <2de46576041107213335071d47@mail.gmail.com>
	 <1099913078.6896.83.camel@pegasus>
	 <2de4657604110906345b0b1576@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1100011433.6866.10.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 09 Nov 2004 15:43:53 +0100

Hi Manjunath,

> I got the Pan up and running and am just thinking of a way to measure
> the bluetooth data transfer rate.........how do i do it????
> 
> I was also trying to bring up the rfcomm socket....but am facing some problem...
> 1. 'sdptool browse bd_addr' shows 'SDP Server' and 'Public Browse
> Group Root', 'LAP' but no other services????I was looking for dial-up
> networking.......how do i add new services??

write the profile implementation.

> 2. i run the 'rfcomm bind' command and then try 'rfcomm connect' and i
> get an error 'Can't connect RFCOMM socket: Resource temporarily
> unavailable'. I read in one of  the mails where you have said that
> bind and connect, both  are not required?? Hope u can again help me
> with this....

What you are searching for is "rfcomm listen ...", but this was not what
I meant with replacing TCP with RFCOMM. If you want TCP/IP then you can
use pand or dund for doing all the work, but you can also use the RFCOMM
socket directly like you use a TCP socket.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
