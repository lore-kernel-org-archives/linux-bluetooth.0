Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth Printing (Belkin Print Server)
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <41A3B992.7080202@phaldor.co.uk>
References: <41A2089D.5030100@phaldor.co.uk>
	 <1101139759.15086.14.camel@pegasus> <41A21EE3.5060408@phaldor.co.uk>
	 <20041123091654.GB16952@suse.de> <1101202810.26578.61.camel@pegasus>
	 <41A35BFE.9000507@phaldor.co.uk> <1101226220.27351.4.camel@pegasus>
	 <41A36388.4010301@phaldor.co.uk> <1101227784.27351.7.camel@pegasus>
	 <41A3715B.6050101@phaldor.co.uk>  <41A3B992.7080202@phaldor.co.uk>
Content-Type: text/plain
Message-Id: <1101276396.27351.92.camel@pegasus>
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
Date: Wed, 24 Nov 2004 07:06:36 +0100

Hi Dave,

>     Sorry for the stupid question, here are the results you asked for.

please attach them as *.txt files.

And the information so far are looking a little bit weird. For the
serial port they use UUID32 and for HCRP they use UUID16. I've never
seen this before.

However may you wanna force it to use the serial port profile. I haven't
tried this for a long time, but actually this URI should do it:

	bluetooth://0002724080A3/spp

In hcidump you should now see a connection to RFCOMM channel 3 (DLCI 6).

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
