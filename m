Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Master, Slave and Maximal Peers Questions
From: Marcel Holtmann <marcel@holtmann.org>
To: ag@new-media-artists.de
Cc: Bluez Devel <bluez-devel@lists.sourceforge.net>
In-Reply-To: <FJENILNPNAGPJMMDOKDCAEOCDLAA.ag@new-media-artists.de>
References: <FJENILNPNAGPJMMDOKDCAEOCDLAA.ag@new-media-artists.de>
Content-Type: text/plain
Message-Id: <1074169363.2625.38.camel@pegasus>
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
Date: Thu, 15 Jan 2004 13:22:43 +0100

Hi Andreas,

> Hm, so i got this wrong. But if i connect two different devices with rfcomm,
> "hcitool con" gives me two lines that look like
> "< ACL 00:0A:D9:37:11:29 handle 41 state 1 lm MASTER". Thats what i meant
> talking about "master connections". If i start another rfcomm connect (the
> third one)i get "Device or resource busy" and i assumed thats because the
> chip i use (CSR, hci rev 16.4) can only handle two master connections. I
> found this info, that a 16.x CSR can make 7 Connections, while 2 of them can
> be Master on some web page that i remember to be on your server,
> unfortunatelly i cant find it anymore.
> 
> Im just wondering what a line ending with MASTER from hcitool con actualy
> means. IMHO it should mean that this is a peer is a slave in a piconet with
> me as the master. But why does rfcomm than say that "Device or resource
> busy" when i try to connect a third slave witch should be possible?

if you got something like this

	# hcitool con
	Connections:
	        < ACL 00:04:61:xx:xx:xx handle 45 state 1 lm MASTER 
	        < ACL 00:0A:D9:xx:xx:xx handle 42 state 1 lm MASTER 

it means that you have a piconet with two slave devices and you as
master.

I don't see any reason why you can't connect a third device into this
piconet. Run "hcidump -w <file>" for the third connection, so we can see
what happens on the HCI layer.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
