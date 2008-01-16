Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1200510167.17973.2.camel@teponkone>
References: <1200510167.17973.2.camel@teponkone>
Date: Wed, 16 Jan 2008 20:33:38 +0100
Message-Id: <1200512018.7978.83.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] bluez-gnome ui
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Teppo,

> I am not a user interface designer, but I think that the current UI for
> bluez-gnome is pretty awful: There is a Services tab that only geeks
> will understand (what actually is a Serial service?), there are buttons
> that appear/disapper and change contents depending on which bonded
> device is selected, there are non-obvious icons (what does that lock
> next to my phone mean? Is my phone locked?), there is no way to initiate
> pairing with a new device, for some reason it is necessary to ask the
> user for the class of the device when HAL already knows that, etc. I
> tried filing bugs for some of the individual issues, but those got
> wontfixed, so I thought I'd email the list directly. 

to be quite honest it is not that simple. I also never said that this is
a perfect UI, but it is a working one.

With the service tab, I fully agree. It was written from a full
technical background in mind and stuff like that should not be exposed
to the end user. However there are limitations to a certain degree and I
haven't seen any other proposal so far.

For the explanations of the icons. Write a patch that utilizes tooltip
to explain them.

In the class of device case, we actually do use HAL. However I wanna
have a way to not use HAL and set the class by myself. In case the "Use
HAL" checkbox is clicked we could go ahead and hide the class selection.
However that is not as simple as it sounds. You would have to hide the
box for all adapters. Remember this UI supports seamlessly multiple
adapters.

> I think the current crappiness is even more evident when compared to the
> brilliant design for BluetoothManager that was up at live.gnome.org. [1]
> Is there any chance of working towards the more non-geek-friendly vision
> presented on that old BluetoothManager page?

The answer to these kind of comments/questions is always the same. Send
in patches that will improve it.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
