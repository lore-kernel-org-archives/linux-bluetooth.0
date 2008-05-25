Return-Path: <cyrus@holtmann.org>
Message-ID: <4838D733.3010802@earthlink.net>
Date: Sat, 24 May 2008 22:04:19 -0500
From: "Mumia W.." <paduille.4061.mumia.w+nospam@earthlink.net>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <48336FD4.9040803@judebert.com>	<F60A3CE9E807BE49B5F56BD80B894D20016883DF@sc-exch03.marvell.com>
	<48379DBC.50504@judebert.com>
In-Reply-To: <48379DBC.50504@judebert.com>
Subject: Re: [Bluez-users] Syncing a Treo 680
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On 05/23/2008 11:46 PM, bluez-users.10.judebert@spamgourmet.com wrote:
> [...]
> Unfortunately, I still got the "port is in use" error [when attempting to hotsync].  I went back 
> through the second link, added my computer as a network, and tried to 
> follow the setup in Chapter 7.1 for surfing the web (because Chapter 7.2[0] 
> says that I need the pppd set up here), but I don't have sdpd running, 
> and I don't know where to find it.
> 
> Respectfully,
> Judebert
> 

Hello Judebert.

I'm just a user, like you, trying to get my bluetooth working properly. 
But I will try to help you.

Probably, Debian's bluez-utils contains most of the things in bluez-lib, 
bluez-pan, and bluez-sdp. I'm using Debian Etch, and /usr/sbin/sdpd is 
part of bluez-utils (as is /usr/bin/pand).

Even though you think that your Treo 680 already has a bluetooth hotsync 
profile, create a new one anyway. Despite the name, there are probably 
subtle unseen differences between network connection and hotsync 
profiles. When you create the new hotsync profile, be sure to give it a 
different name from the others.

Where did you read that using "dund" was a bad idea?

Try using dund. I have been able to get one of my bluetooth adapters 
working to get my Palm PDA online using the methods outlined here:

http://howto.pilot-link.org/bluesync/ga.html

(Another bluetooth dongle [the expensive one] does not work yet, and 
that's why I'm here.)

After you get everything setup properly (hcid, sdpd, dund, rfcomm), I 
suggest you use kpilot to help you hotsync. Gnome-pilot has never worked 
for me, and although kpilot is kcrap, it actually backs up your PDA when 
it's not crashing.

However, kpilot would need to know where to find the device file for 
contacting your smartphone, and that device file would be /dev/rfcomm0 
or /dev/rfcomm1 or something similar. So you'll start kpilot and go into 
"Settings/ Configure Kpilot/ Device." Most likely, the device will be 
/dev/rfcomm0.


PS.
We users should stick around here for so that we can build a knowledge 
core that is able to benefit others when they come here. If we all get 
what we need then leave the list (unsubscribe), that knowledge core can 
never form. The knowledge core I refer to would be a group of people 
knowledgeable in bluez and bluetooth.

----------------
[0] http://howto.pilot-link.org/bluesync/gb.html


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
