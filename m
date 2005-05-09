Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <427F8F00.3000407@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <20050506060525.32b209ca.henryk@ploetzli.ch>	<20050508125039.1494.qmail@web8305.mail.in.yahoo.com>	<20050509005413.3787d2d7.henryk@ploetzli.ch>	<1115596897.8949.79.camel@pegasus>	<20050509025805.331c34c7.henryk@ploetzli.ch>	<1115600627.8949.93.camel@pegasus>	<20050509033555.12509786.henryk@ploetzli.ch>	<427EE726.8030801@xmission.com> <20050509144808.6deef7fa.henryk@ploetzli.ch>
In-Reply-To: <20050509144808.6deef7fa.henryk@ploetzli.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re: [Bluez-devel] Regarding a2recv
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
Date: Mon, 09 May 2005 10:25:36 -0600

Henryk,

>>What do you think of making this code always compile in and run but 
>>report a warning and continue if the roleswitch call fails?
> 
> 
> Would be fine with me. It's just that I wasn't sure whether a roleswitch
> would break anything else.

Unless Marcel thinks it's a problem, I will make this the default 
behavior. We could provide a command-line switch to turn it off (or run 
it as non-root and the other end won't even notice you tried to switch :)

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
