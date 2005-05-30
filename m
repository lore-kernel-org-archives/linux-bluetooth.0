Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] UART speed
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050530222200.DC40136D@arbetsmyra.dyndns.org>
References: <20050530222200.DC40136D@arbetsmyra.dyndns.org>
Content-Type: text/plain
Message-Id: <1117493801.7072.229.camel@pegasus>
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
Date: Tue, 31 May 2005 00:56:41 +0200

Hi Ronny,

> I'm using a UART based device with CSR chipset and BCSP protocol. The 
> module seem to use a speed of 115 200 bps by default but I would like 
> to lower it. Do BCSP support speeds as low as e.g. 9600 bps? If yes, is 
> there a tool for configuring the change? Perhaps a PSKEY?

the pskey tool from bluez-utils can do the job, but be careful with it.
You can render your device useless with this tool. And setting the UART
speed to 9600 bps makes no sense at all, because the throughput will
decrease and besides for AT commands it becomes useless.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
