Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <e1effdeb0709101035v352dc24uc853cecceaa47f2d@mail.gmail.com>
Date: Mon, 10 Sep 2007 14:35:46 -0300
From: "Claudio Takahasi" <cktakahasi@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <loom.20070907T162203-609@post.gmane.org>
MIME-Version: 1.0
References: <loom.20070907T162203-609@post.gmane.org>
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

Hi Dick,

I was not able to reproduce the reported problem. Could you please
send me more details? Try reproduce the problem in the latest release
(3.18) and share your hcidump.

On 9/7/07, Dick <dick@mrns.nl> wrote:
> Hi,
>
> I still have some trouble with the input service and I think I've found
> something related which is reproduceable.
>
> If a device is reconnecting a lot the l2cap table in /sys/class/bluetooth/l2cap
> is growing with connections (which aren't closed).
>
> Try the following with a HID input device:
>
> 1. Start and configure the input service for the device
[Claudio Takahasi]
After call CreateDevice how are you connecting the input? Device
initiated connection or calling Device.Connect() ?

> 2. Start hcidump
> 3. Power off the input device
> 4. Wait until "Disconn complete" appear in hcidump
> 5. Power on the input device
[Claudio Takahasi]
how are you reconnecting?

> 6. Repeat from step 3
>
> If you look at:
> sort /sys/class/bluetooth/l2cap |uniq -c
>
> You will see a huge number of connections from the input device.
>
> greetings,
> Dick

BR,
Claudio Takahasi.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
