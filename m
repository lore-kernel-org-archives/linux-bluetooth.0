Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Timothy Murphy <tim@birdsnest.maths.tcd.ie>
Reply-To: tim@birdsnest.maths.tcd.ie
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Can only start Bluetooth once on my Sony Picturebook
References: <200405101325.18922.tim@birdsnest.maths.tcd.ie> <1084193820.4017.25.camel@pegasus>
In-Reply-To: <1084193820.4017.25.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200405102138.55282.tim@birdsnest.maths.tcd.ie>
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
Date: Mon, 10 May 2004 21:38:55 +0100

On Monday 10 May 2004 13:57, Marcel Holtmann wrote:

> > I'm running linux-2.6.6-rc2 under Fedora-1
> > on my Sony C1VFK Picturebook.
> > This has in-built Bluetooth.
> > To start this running, I say "spicctrl -l1"
> > (when the blue Bluetooth light on my laptop comes on)
> > followed by "service bluetooth restart".
> >
> > All this works perfectly.
> > But if I give the command "spicctrl -l0"
> > to stop the inbuilt Bluetooth
> > I am never able to restart it,
> > except by re-booting.

> Check if you have CONFIG_BT_HCIUSB_SCO enabled, if yes, disable for now
> or apply the attached patch.

Thanks for the advice.
I compiled linux-2.6.6 with
# CONFIG_BT_HCIUSB_SCO is not set
and now I can start and stop Bluetooth (with spicctrl) as often as I wish.

-- 
Timothy Murphy  
e-mail (<80k only): tim /at/ birdsnest.maths.tcd.ie
tel: +353-86-2336090, +353-1-2842366
s-mail: School of Mathematics, Trinity College, Dublin 2, Ireland


-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
