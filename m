Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Nicholas A. Preyss" <nalp@gmx.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Problem with Logitech MX 900 and Apple keyboard
Message-ID: <20040501203909.GB1900@gmx.net>
References: <200404282247.31825.matiasbrutti@ciudad.com.ar> <200404300024.51331.matiasbrutti@ciudad.com.ar> <20040430120109.GA30493@gmx.net> <200405011203.43498.matiasbrutti@ciudad.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200405011203.43498.matiasbrutti@ciudad.com.ar>
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
Date: Sat, 1 May 2004 22:39:09 +0200

On  0, Matias Pablo Brutti <matiasbrutti@ciudad.com.ar> wrote:
> 	Sorry to bother you again ... I managed to get it recognice the mouse and the 
> keyboard .. and everythings looks .. pretty now ... I can see both .. devices 
> and their address . the problem starts when I try to connect .. with 
> bthid ... deamon ...  bthid -c <addrs> and ... it ask for a pin number .. and 
> never gets connected to the devices .. in the logs .. says ... " connection 
> failed" or permissiion denied" ... I managed to get them to actually be seen 
> but now they do not work ;) thats funny ji ji i j.

Take care of your "." key, i have the impression it feels a bit
overstressed. ;) (the keyboard whisperer)

Maybe you can run hcidump while trying to connect. And provide here the
output.


> one more thing .... if I try to execute the bthid  by Peter Klausler .... 
> still prints out in the logs that Can' find uimput devide .. and I have it 
> on .. /dev/misc/uinput .. that is another .. big ???? for me .. 

The above refers to the bthid of bluez ? 
A "ls -lh /dev/misc/uinput" would be helfpul.

nicholas
P.S.: I am away the next few days, so you might need to wait or someone
else has to take care of you.


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
