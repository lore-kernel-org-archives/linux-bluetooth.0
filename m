Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Douglas Russell <puggy@bobspants.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] hidd
References: <200405300037.53081.puggy@gentoo.org> <200405300926.07491.puggy@bobspants.com> <1085906283.4500.0.camel@pegasus>
In-Reply-To: <1085906283.4500.0.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405300957.11436.puggy@bobspants.com>
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
Date: Sun, 30 May 2004 09:57:11 +0000

That doesn't apppear to be available in my development-sources -2.6.6. I've 
grepped for HIDP and get nothing and have searched in menuconfig to no avail. 
I've checked every option in the bluetooth subsystem support and input device 
support, it's not there. Is this just in mh kernels? I am trying not to 
deviate from vanilla development too much as ppc in the main kernel tree is 
still quite new.

Thanks.

Puggy

On Sunday 30 May 2004 08:38, Marcel Holtmann wrote:
> Hi Douglas,
>
> > Still no closer to finding hidp....
>
> install a 2.6.6-mh2 kernel and select CONFIG_BT_HIDP.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle 10g.
> Take an Oracle 10g class now, and we'll give you the exam FREE.
> http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
