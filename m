Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300802241225l1a352768x94afccdc2b120be6@mail.gmail.com>
Date: Sun, 24 Feb 2008 13:25:41 -0700
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1203815399.8021.10.camel@pc.ilinx>
MIME-Version: 1.0
References: <1203815399.8021.10.camel@pc.ilinx>
Subject: Re: [Bluez-users] hci_scodata_packet: hci0 SCO packet for unknown
	connection handle 1
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

Brian

>  I follow the steps in http://wiki.bluez.org/wiki/HOWTO/AudioDevices
>  Feb 23 20:06:37 pc kernel: [20254.788127] hci_scodata_packet: hci0 SCO packet for unknown connection handle 1

I've added the kernel patch that is supposed to handle this problem to
the end of the wiki page. Please let us know if it helps. It's
ostensibly going to be an issue if you have a bluetooth adapter
capable of esco but your headset is not.

-- 
Brad

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
