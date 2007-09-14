Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Dick <dick@mrns.nl>
To: bluez-users@lists.sourceforge.net
Date: Fri, 14 Sep 2007 19:51:09 +0200
Message-Id: <1189792269.7901.14.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] input service leaking l2cap connections
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

> I was not able to reproduce the reported problem. Could you please
> send me more details? Try reproduce the problem in the latest release
> (3.18) and share your hcidump.
I'm using the latest bluez release and a almost-latest kernel
(2.6.22-gentoo-r6).

On 9/7/07, Dick <dick@mr...> wrote:
> > Try the following with a HID input device:
> >
> > 1. Start and configure the input service for the device
> [Claudio Takahasi]
> After call CreateDevice how are you connecting the input? Device
> initiated connection or calling Device.Connect() ?
Device initiated.

> 2. Start hcidump
> 3. Power off the input device
> 4. Wait until "Disconn complete" appear in hcidump
Well, you *shouldn't* wait until "Disconn complete" during the
"initialisation", go to step 5 just before the "Disconn complete".
> 5. Power on the input device, the device should be reconnected
initiated by the device.
> 6. Repeat from step 3

I've posted this before; I've got another problem with the dinovo
desktop.

1. Start and configure the input service
2. Let the devices initiate the connections
3. Use the devices
4. Wait until the devices go idle
5. Wake the devices up

Result:
- hcidump will show you input from the devices
- hcitool con will show you the input devices are connected
- the input events aren't registed by the input service (keyboard /
mouse won't work)

I hope this helps,

TIA,
Dick

PS. The bluez gmane archive isn't updated anymore!


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
