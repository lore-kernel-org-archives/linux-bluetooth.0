Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] OBEX Push without pairing
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <42244089.7010906@futurlink.com>
References: <42242BAB.7080406@futurlink.com>
	 <1109667687.17256.140.camel@pegasus>  <42244089.7010906@futurlink.com>
Content-Type: text/plain
Message-Id: <1109674076.17256.143.camel@pegasus>
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
Date: Tue, 01 Mar 2005 11:47:56 +0100

Hi Pedro,

> > it seems that your device is working in security mode 3 and then
> > actually every ACL connection requests the authentication. The simple
> > answer is to use security mode 1/2.
> >   
> Thank you for your fast answer.
> 
> I am not quite sure about the security mode the device is. How can I
> get it? In any case, I have executed (as root):
> 
> $ hciconfig hci0 noencrypt
> $ hciconfig hci0 noauth
> 
> but still no success. With the same computer and configuration and as
> a normal user, if I send a file from KDE using kbtobexclient, it works
> as expected (no PIN requested, just the confirmation for receiving the
> message), so I believe that there is some other things to do. I guess
> that it should be a library call or somthing similar. Any suggestions?

run "hcidump -X -V" as root at the same time and show us the result.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
