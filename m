Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Nicholas =?iso-8859-1?Q?A=2E_Prey=DF?= <nicholas@insolent.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Problem with Logitech MX 900 and Apple keyboard
Message-ID: <20040429093614.GA3992@gmx.net>
References: <200404282247.31825.matiasbrutti@ciudad.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200404282247.31825.matiasbrutti@ciudad.com.ar>
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
Date: Thu, 29 Apr 2004 11:36:14 +0200

On  0, Matias Pablo Brutti <matiasbrutti@ciudad.com.ar> wrote:
> I'm running Mandrake 10.0 official with a 2.6.3-7 ... I just bougth a MX900 
> and the apple bluetooth keyboard .. the mouse ... was working when I 
> plugged .. like if was a plug and play devide . I didn't have to install 
> anything .. although .. i did not have any bluetooth installatin and if I 
> serch for bluetooth devices . it says that I have no devides .. I'm pretty 
> new on the subject .. and I think I have to load modules to the kernel .. 
> which ones should I load for my Logitech hub .. so It will be able to 
> recognize all my bluetooth .. When I try to start bthid it says that I have 
> no uimput .. or some modules .. what should I do .. or where should I read .. 
> to get my thing working ... I really like bluetooth .. and I would like to 
> work on linux too 
> if you need more info so you can help please email me ...
> Thanks a lot 

It sounds like your bluetooth chip is equipped with a hid proxy. 
Look here:
http://www.holtmann.org/linux/bluetooth/hid.html
Look in the CVS "bluez/utils2/hid/" there is a hid service utility.

nicholas


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
