Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: David Mackie <d.mackie@ru.ac.za>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Can you spoof/forge Bluetooth Devices/Address?
Message-ID: <20040607160324.GA97052@rucus.ru.ac.za>
References: <E320A8529CF07E4C967ECC2F380B0CF90140382A@bsebe001.americas.nokia.com> <1086595869.12811.28.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1086595869.12811.28.camel@pegasus>
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
Date: Mon, 7 Jun 2004 18:03:24 +0200

On Mon 2004-06-07 (10:11), Marcel Holtmann wrote:
>
> However David mentioned he wants to talk to a phone and right now I
> haven't seen any phone with PAN or UPnP. To support legacy devices you
> need a distributed SDP database (you must keep it up-to-date) and use
> somekind of tunneling for the RFCOMM channels. The RFCOMM tunnel is very
> easy to achieve. It is a simple mapping from a TCP stream to a RFCOMM
> stream. You can also map it to different channel numbers on each side.
> The real problem here is the SDP database. Think about it.
> 

Hi,

You are right in that we are wanting this to work with legacy devices, and
therefore there can be no modification to the phone's bluetooth stack. For
all intesnts and purposes the phone must think it communicating with the PC,
or the applications on the phone at least. I had thought that intial device
discovery would be the first and hardest problem to get around. Or am I
missing somthing in SDP? How to get a phone to talk to a repeater intailly
is the problem I think I will have. And that was why I was hopping to spoof
the PC by the repeater. Thanks for help and suggestions so far.

-dave


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
