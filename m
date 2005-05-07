Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] yes, a2dp timing is whacked
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20050507222047.430774e9.henryk@ploetzli.ch>
References: <42792979.90109@xmission.com>
	 <20050507031314.548afb03.henryk@ploetzli.ch>
	 <1115429201.9031.5.camel@pegasus> <1115494053.9031.15.camel@pegasus>
	 <20050507222047.430774e9.henryk@ploetzli.ch>
Content-Type: text/plain
Message-Id: <1115498715.9031.24.camel@pegasus>
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
Date: Sat, 07 May 2005 22:45:15 +0200

Hi Henryk,

> > So the best thing is too encode two or three full AVDTP frames in
> > advance and have them ready to send. The sending can't be controlled
> > be usleep(). We need a time that kicks in every whatever msec and
> > makes us to transmit the next frame.
> 
> That's what I would favour. According to the libc manual setitimer()
> would be the function of choice, if nobody else has a better idea (RTC,
> anyone?).

so in general the time that a SBC frame is calculated for, is always the
same if we don't change the parameters, right?

Using the ITIMER_REAL domain may works and since you can setup your
timer in microseconds, then this would be the way to go.

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
