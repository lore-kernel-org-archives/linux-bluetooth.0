Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Pairing a keyboard
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20041125075755.GC2505@frostnet.net>
References: <20041125064110.GA2505@frostnet.net>
	 <1101367010.7538.78.camel@pegasus>  <20041125075755.GC2505@frostnet.net>
Content-Type: text/plain
Message-Id: <1101371606.7538.95.camel@pegasus>
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
Date: Thu, 25 Nov 2004 09:33:26 +0100

Hi Chris,

> > The bluepin script must echo "PIN:0000".
> 
> Aha, that gets it. Thank you.
> 
> Do you know if I should I read about/look into putting the keyboard to
> sleep after inactivity? I have read in a couple places on the web that apple's
> devices do not go to sleep themselves, but perhaps what I read was old and
> bluez does this automatically now?

the hidd has a --timeout option you can use, but we don't support the
automatic switch into sniff mode.

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
