Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <23a15590711151534k50b707e4y73cf053eb0e9ada7@mail.gmail.com>
References: <23a15590711151534k50b707e4y73cf053eb0e9ada7@mail.gmail.com>
Date: Mon, 26 Nov 2007 07:40:32 +0100
Message-Id: <1196059232.4217.95.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Howto setup bluetooth network
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

Hi Leszek,

> is there any up-to-date guide for setting a network using
> bluez-utils-3-* ? I had searched the web quite extensively, but
> everything I found was about bluez-2 . What should I put in
> /etc/bluetooth/network.service and /etc/bluetooth/network.conf ?
> Tutorials write about 'pand', which is no longer shipped with current
> bluez on my distro (Gentoo). I get up to bluez creating pan0 and pan1,
> but do not know what to do next - I can't connect from a Windows box that
> did communicate with other PCs...

check wiki.bluez.org for examples on the network service. It still needs
some work to make it fully specification compliant, but that shouldn't
be far away. Patches are always welcome.

> And what does "Failed to claim to interface:" mean? It is always
> present in logs and never provides any additional info...

Provide the full log and check the source code for the function that
would trigger this error message.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
