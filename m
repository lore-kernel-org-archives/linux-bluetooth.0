Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Disconnecting after 54 seconds
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
Cc: Matthew Johnson <matt@matthew.ath.cx>
In-Reply-To: <Pine.LNX.4.63.0511041142190.27685@illythia.matthew.ath.cx>
References: <Pine.LNX.4.63.0511041142190.27685@illythia.matthew.ath.cx>
Content-Type: text/plain
Message-Id: <1131119129.11673.4.camel@localhost.localdomain>
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
Date: Fri, 04 Nov 2005 16:45:29 +0100

Hi Matthew,

> I have a nokia 6230 and a USB bluetooth dongle with a CSR chipset which
> I'm using to test an application I'm writing to monitor the connection
> to the phone. The application uses code from hcitool to bring up a
> connection to the phone. I'm finding that every minute or so the
> connection is dropped and I have to reconnect.
> 
> This is reproducible with l2ping. l2ping sends and receives pings fine,
> but then terminates with Connection reset by peer. Using time(1) to
> monitor this repeatedly it seems it happens almost exactly after 54
> seconds in every case (min 53.722, max 54.616, SD under 200ms).
> 
> Is there some sort of timeout happening here? I thought it might need
> activity to keep the link up, but l2ping should do that. Has anyone else
> seen anything similar?

these are L2CAP echo packets and so this doesn't have to be reliable.

> (please reply to me as well, I'm not subscribed)

Then please do so.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
