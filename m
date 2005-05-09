Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Regarding a2recv
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050509005413.3787d2d7.henryk@ploetzli.ch>
References: <20050506060525.32b209ca.henryk@ploetzli.ch>
	 <20050508125039.1494.qmail@web8305.mail.in.yahoo.com>
	 <20050509005413.3787d2d7.henryk@ploetzli.ch>
Content-Type: text/plain
Message-Id: <1115596897.8949.79.camel@pegasus>
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
Date: Mon, 09 May 2005 02:01:36 +0200

Hi Henryk,

> > Why doesn't the streaming start?
> 
> If I only knew ...
> The current code shows me that the stream connection is correctly
> established and the start streaming response is sent. Then after some
> seconds I get a read error on the command fd with error message
> "Connection timed out". 

I suspect that it is waiting for a role switch to happen.

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
