Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41A41410.3040701@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] audio problems with a2play
References: <41A22C0B.4050008@xmission.com>	<41A234FA.7020303@xmission.com>	<20041123033429.132bf84b.henryk@ploetzli.ch>	<41A2B331.4010001@xmission.com>	<20041123070621.50569968.henryk@ploetzli.ch>	<41A3471C.4000602@xmission.com>	<20041123203836.046fb4f4.henryk@ploetzli.ch>	<41A3ACE2.4030501@xmission.com> <20041124035850.4c086e3a.henryk@ploetzli.ch>
In-Reply-To: <20041124035850.4c086e3a.henryk@ploetzli.ch>
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
Date: Tue, 23 Nov 2004 21:54:40 -0700

Guys!

Try out a2play.c! It's playing to my bluetake properly now, at least for 
most streams... (woohoo)

stream 5, 9 don't do anything, 7 is noise. 8 plays too fast.

the rest sound great.

What did it was putting frames up to the mtu length in every packet. 
Maybe the certification doesn't test short packets of only one frame.

Brad


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
