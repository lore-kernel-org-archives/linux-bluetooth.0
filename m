Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] uclinux and bluez
From: Marcel Holtmann <marcel@holtmann.org>
To: egroJorge <egroJorge@terra.es>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <155715390.20040509133553@terra.es>
References: <1083853467.28356.18.camel@pancho>
	 <1083877519.4420.78.camel@pegasus>  <1083925117.1946.36.camel@pancho>
	 <1083946524.4420.124.camel@pegasus>  <143918984.20040508155253@terra.es>
	 <1084054174.4420.169.camel@pegasus>  <155715390.20040509133553@terra.es>
Content-Type: text/plain
Message-Id: <1084102922.9269.23.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 09 May 2004 13:42:02 +0200

Hi Jorge,

> M> what kind of hciattach command do you use?
> 
> #hciattach -n /dev/tts/2 any 115200 flow
> 
> M> What kind of Bluetooth module
> M> do you use?
> 
> It is made by Taiyo Yuden. I dont remember the exact reference, but I
> can look for it (tomorrow at work)

I think they use a Bluetooth chip from CSR, so I prefer you use "csr" or
"bcsp" as type for hciattach (depending if it is in H4 or BCSP mode).

> M> What endian is your ucLinux platform?
> 
> Little endian

So you shouldn't get any endian problems.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
