Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Regarding a2recv
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050509144808.6deef7fa.henryk@ploetzli.ch>
References: <20050506060525.32b209ca.henryk@ploetzli.ch>
	 <20050508125039.1494.qmail@web8305.mail.in.yahoo.com>
	 <20050509005413.3787d2d7.henryk@ploetzli.ch>
	 <1115596897.8949.79.camel@pegasus>
	 <20050509025805.331c34c7.henryk@ploetzli.ch>
	 <1115600627.8949.93.camel@pegasus>
	 <20050509033555.12509786.henryk@ploetzli.ch>
	 <427EE726.8030801@xmission.com>
	 <20050509144808.6deef7fa.henryk@ploetzli.ch>
Content-Type: text/plain
Message-Id: <1115643481.8949.172.camel@pegasus>
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
Date: Mon, 09 May 2005 14:58:01 +0200

Hi Henryk,

> > I think I understand now why the bluetake expects the headset to 
> > roleswitch. If the headset's radio can't have mixed slave/master 
> > connections open (scatternet?), then it needs the roleswitch in order
> > to  talk to a cellphone at the same time as the dongle. Is that right?
> 
> Ah, thanks for clearing that up. I was wondering about that all the
> time, and doubt that insisting on a roleswitch is something the spec
> allows.

don't get me started on these things ;)

I have no idea how the current A2DP devices made it through the
qualification. If you check the record handles of the HP headphone than
you see that they are under 0x10000 and this is also violating the
specification. And the best example is the non-A2DP conform AVDTP
payload with 0xff 0xff of the Aiptek headphone.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
