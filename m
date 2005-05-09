Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <427EE726.8030801@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Regarding a2recv
References: <20050506060525.32b209ca.henryk@ploetzli.ch>	<20050508125039.1494.qmail@web8305.mail.in.yahoo.com>	<20050509005413.3787d2d7.henryk@ploetzli.ch>	<1115596897.8949.79.camel@pegasus>	<20050509025805.331c34c7.henryk@ploetzli.ch>	<1115600627.8949.93.camel@pegasus> <20050509033555.12509786.henryk@ploetzli.ch>
In-Reply-To: <20050509033555.12509786.henryk@ploetzli.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Sun, 08 May 2005 22:29:26 -0600

Henryk

> I want. I committed it to cvs anyways, but it is #ifdef'd out. Compile
> with -DROLESWITCH to use it.

What do you think of making this code always compile in and run but 
report a warning and continue if the roleswitch call fails?

I think I understand now why the bluetake expects the headset to 
roleswitch. If the headset's radio can't have mixed slave/master 
connections open (scatternet?), then it needs the roleswitch in order to 
talk to a cellphone at the same time as the dongle. Is that right?

Brad


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
