Return-Path: <bluez-users-bounces@lists.sourceforge.net>
In-Reply-To: <1190447181.5133.50.camel@aeonflux.holtmann.net>
To: BlueZ users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <OF9D18AD83.F8E599FE-ON88257360.0082BF50-88257360.0082DE64@etas.de>
From: rparker@vetronix.com
Date: Mon, 24 Sep 2007 16:49:26 -0700
Subject: Re: [Bluez-users] UDP and TCP packets across Bluez connections?
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

Marcel Holtmann <marcel@holtmann.org> 
Sent by: bluez-users-bounces@lists.sourceforge.net
09/22/2007 12:46 AM
Please respond to
BlueZ users <bluez-users@lists.sourceforge.net>


To
BlueZ users <bluez-users@lists.sourceforge.net>
cc

Subject
Re: [Bluez-users] UDP and TCP packets across Bluez connections?






Hi,


> Or if there is not real TCP/IP support with Bluetooth does Windows
> understand RFCOMM and L2CAP? 

If you wanna have TCP then you can do Ethernet over Bluetooth which is
done by PAN over BNEP. And that would interact with Windows or any other
OS for that matter.

Do you happen to know whether I need to install a special driver on 
Windows so that Windows will recognize ethernet packets that come via 
Bluetooth? Or will it just automagically work?




-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
