Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <46F19B7F.70702@ozob.net>
References: <46F19B7F.70702@ozob.net>
Date: Thu, 20 Sep 2007 09:07:24 +0200
Message-Id: <1190272044.5525.147.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] How do I get rfcomm to reread config file?
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

Hi Gene,

> I have several bluetooth gps receivers. In /etc/bluetooth/rfcomm.conf I 
> have their MAC address listed but commented out except the one I want to 
> use. However, when change and restart the bluetooth service the new 
> address is not picked up and the old one is still by rfcomm.
> 
> How can I get rfcomm to pick up the new MAC?
> 
> /etc/bluetooth/rfcomm.conf:
> 
> rfcomm0 {
>          # Automatically bind the device at startup
>          bind yes;
> 
>          # Bluetooth address of the device
>          #device 00:08:1B:C0:D3:1F;
>          #device 00:0B:0D:18:15:4F;
>          #GPSlim240
>          device 00:0B:0D:6D:E2:E6;
> 
>          # RFCOMM channel for the connection
> #       channel 1;
> }
> 
> My bluez is 3.18 on Gentoo.

calling "rfcomm unbind all" and then "rfcomm bind all" should work.

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
