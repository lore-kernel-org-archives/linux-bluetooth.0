Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Mathieu Doidy <mdoidy@roulaize.net>
Message-ID: <c8nu9p$139$1@sea.gmane.org>
References: <c8n1bg$gc5$1@sea.gmane.org> <200405221054.15925.cijoml@volny.cz>
Subject: [Bluez-users] Re: Service Record registration failing and sdpd exiting
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
Date: Sat, 22 May 2004 16:14:49 +0000 (UTC)

On 2004-05-22, Michal Semler <cijoml@volny.cz> wrote:
> Hi,
>
> upgrade to bluez-libs and bluez-utils 2.7. pan and sdp packages are 
> deprecated.
> You should upgrade your kernel with latest -mh patch too
>
> Then try again.
>
> Michal

upgrading to latest bluez-{libs,utils} made it, thanks
(I was already using 2.6.6-mh1)

obex over bluetooth now works fine
but i couldn't get it to connect through serial port
it seems that 6230 does not use the mrouter protocol

so, well, any hint about how to create a link with a 6230 would be appreciated
i'd just like to be able to synchronize my phone (with multisync for example)

 /Mathieu



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
