Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] sdpd restarts
From: Bastien Nocera <hadess@hadess.net>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1145230769.4408.12.camel@localhost>
References: <1145218550.24273.62.camel@wyatt.hadess.net>
	 <1145230769.4408.12.camel@localhost>
Content-Type: text/plain
Message-Id: <1145267215.24273.64.camel@wyatt.hadess.net>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 17 Apr 2006 10:46:54 +0100

On Mon, 2006-04-17 at 01:39 +0200, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > I have a service (gnome-obex-server) that advertises OBEX PUSH support
> > via sdpd and sdp_record_register().
> > The problem is that the record would be gone after a restart of the sdpd
> > daemon. Which is the best way to check whether the daemon is still
> > available, and reregister the record when it comes back up?
> 
> with the current interface, there exists no good solution for this. With
> the new D-Bus API this will be available at some point.

OK, I added this to the opened bugzilla.

Cheers

-- 
Bastien Nocera <hadess@hadess.net> 



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
