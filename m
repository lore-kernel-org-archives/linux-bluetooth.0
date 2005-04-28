Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4270A249.20907@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] /etc/bluetooth/pin
References: <2621d9af05042711245fa28aa9@mail.gmail.com>
In-Reply-To: <2621d9af05042711245fa28aa9@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Thu, 28 Apr 2005 10:43:53 +0200

N. I. wrote:
> My device uses the fault pin as 1234.
> I want to change it to something else, e.g. 55113.
> 
> What I did was to modify the /etc/bluetooth/pin file to have the
> content only of 55113.
> My pin_helper has something like:
> 
> #!/bin/sh
> echo "PIN:"$(cat /etc/bluetooth/pin)
> 
> When I try to use l2ping to other device, my initiating l2ping device
> fails right away with message: "Can't connect.: Permission denied"

Is the l2ping performed on the host with the described pin setup?
Please do a hcidump to see what really happens...

I think the remote device asks for a pin, you supply 55113 and it fails 
because the remote device expects another one. but withhout a hcidump it's 
not possible to know...

> Is there anything missing that I can do in order for "NOT" using the
> default pin?

actually what you described above is doing exactly that. incoming and 
outgoing connections use now 55113. the only thing you might check is if 
hcid.conf points to the correct pin_helper application. the rest looks fine...

regards
Marco


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
