Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] connection problems with pppd and 6630 over bluez
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <427B7021.5050302@whitelabel.org>
References: <427B5DB5.3080304@whitelabel.org>
	 <1115381691.8862.2.camel@pegasus>  <427B7021.5050302@whitelabel.org>
Content-Type: text/plain
Message-Id: <1115386676.8862.7.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 06 May 2005 15:37:56 +0200

Hi Stefan,

> >>I have pppd working over bluetooth, but have a strange problem; I only 
> >>seem to be able to connect about 1/3 of attempts. If I retry it usually 
> >>works, but some times it takes 5 or 6 goes.
> >>
> >>how can I diagnose and fix the problem. I'm running bluez-2.16
> > 
> > use "hcidump -X -V" as root to see what happens on the Bluetooth side.
> > If that looks fine then use pppdump to see what PPP is doing.
> 
> I've attached the results of a two attempts to connect, the first 
> failed, and the second succeeded. What am I looking for?

this is not a Bluetooth problem. This is your dialer script. In the
failure case you start PPP without getting the CONNECT response. You
even start PPP and three frames later your receive an OK. Use a dialer
like wvdial or check you logs for more details.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
