Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Nicholas A. Preyss" <nalp@gmx.net>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Error message
Message-ID: <20040521172502.GA15835@gmx.net>
References: <200405211611.38038.welpan@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200405211611.38038.welpan@gmx.de>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 21 May 2004 19:25:02 +0200

On  0, Alex <welpan@gmx.de> wrote:
> Okay this is  my first mail in this list, so I am sorry for mistakes.
> I try to connect a Headset with a dongle.
> The problem begins if  I plug in my dongle  and boot my System, my System 
> hangs.

Do you use ehci-hcd driver for USB2.0? What does the syslog say, after
plugging in the dongle.

> So i plugged my dongle after booting my System i get this message:  
> hci_scodata_packet :hci0 sco packet unknown connection for handle 0
> 
> I killed this message and  make : hciconfig 
> Nothing is found

You can kill a message? 


> I make this in KDE-Shell
> no Error message , hciconfig find my dongle

Plz post the output of "hciconfig -a" if dongle is recognized.

> I can scan for headset and find it, but i cant get any connection.
> 
> I make hcidump, I get this message:
> 
> SCO data: handle 0x0000 dlen0

Maybe you can post the whole hcidump trace not only a single line.

> My System: Debian unstable
>                    Kernel 2.6.6
> installed bluez packages:
> 		   bluez-bluefw
>   		   bluez-hcidump
>                  bluez-utils
> 		   bluez-pan
>                  bluez-pin

The Packages in unstable are a bit outdated. But I don't believe this
can be the reason.

nicholas

You can contact me in german as well, but if please directly by mail. 


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
