Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <449A297B.7010009@mail.utexas.edu>
References: <44867199.2000409@mail.utexas.edu>
	<1149664531.22472.4.camel@localhost> <4486EE2D.3010507@mail.utexas.edu>
	<1149714318.22472.59.camel@localhost>
	<4487B00F.7070204@mail.utexas.edu>
	<1149803817.4219.61.camel@localhost> <448A4385.4020809@mail.utexas.edu>
	<1149986039.5358.25.camel@aeonflux.holtmann.net>
	<4490C0F1.1090704@mail.utexas.edu> <1150874298.3950.15.camel@localhost>
	<449A297B.7010009@mail.utexas.edu>
Date: Thu, 22 Jun 2006 09:06:39 +0200
Message-Id: <1150959999.13991.9.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Latest 2.6.16-mh1 patch.
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

Hi Philip,

> I tried with 17-mh1 and the behaviour is not as bad. I only see one
> problem: If I turn off the mouse and then quickly turn it back on,
> the mouse doesn't work until the old connection times out on the host
> side. At that point, the mouse can reconnect and life returns to normal.
> 
> Reconnecting after a timeout disconnect or after turning off and waiting
> for the host to clean up is no longer a problem.
> 
> In the problem case, hcidump reports no incoming packets between when
> I turn off and on and when it reports the disconnect. Then I see the
> reconnect and new packets.
> 
> It's obviously not a big problem.

this seems that you have to wait for the link supervision timeout on the
host side. Play a little bit with it. If you turn off the Bluetooth chip
in the mouse the host simply needs some time to detect this.

What kind of chip is in your mouse? Is it CSR or Broadcom based?

Regards

Marcel



All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
