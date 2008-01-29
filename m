Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Jan 2008 17:12:36 -0500
From: Aristeu Rozanski <aris@ruivo.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20080129221236.GW5671@cathedrallabs.org>
References: <courier.479F910B.00002E18@softhome.net>
	<20080129210226.GV5671@cathedrallabs.org>
	<courier.479FA02D.0000617F@softhome.net>
MIME-Version: 1.0
In-Reply-To: <courier.479FA02D.0000617F@softhome.net>
Subject: Re: [Bluez-devel] PS3Remote patches
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

> Yes. All of them, i've checked the file in utils/input and assure that the 
> file bluetoothd-service-input just compiled is in /usr/lib/bluetooth/
> Is there anything else I can check? 
check if bluetoothd-service-input/hcid are running, they may be the old copy.
also, by default it'll be installed in /usr/local/...
Is uinput module loaded? is there anything on logs perhaps?

-- 
Aristeu


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
