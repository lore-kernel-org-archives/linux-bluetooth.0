Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <624812.65481.qm@web38507.mail.mud.yahoo.com>
References: <624812.65481.qm@web38507.mail.mud.yahoo.com>
Date: Thu, 19 Jul 2007 17:32:51 +0200
Message-Id: <1184859172.7111.6.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Frequency hopping(channel)
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

Hi Robert,

> I have one question to the folks in Bluez group. I saw that we have to
> specify channel for L2CAP and RFCOMM connections:
> 
> struct sockaddr_rc rfcommclient = { 0 };
> 
> rfcommclient.rc_channel = channel;
> 
> Since Bluetooth uses frequency hopping and hops from one channel to
> another what is the need to specify this field??
> 
> Also, I see that throughout the L2CAP or RFCOMM connections it shows
> the same PSM value(one we specify for the channel) in the hcidump.
> 
> Does that mean no hopping is taking place ??
> 
> I am sorry if its a silly question but expecting an answer ??

you might wanna read the specification again. I know it is big, but you
mixed up a couple of things here. The RFCOMM channels and L2CAP PSMs are
part of the multiplexing (like TCP port numbers). They have nothing to
do with any frequency hopping inside the Bluetooth radio.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
