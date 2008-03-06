Return-Path: <cyrus@holtmann.org>
Date: Thu, 6 Mar 2008 10:57:51 -0500
From: jayjwa <jayjwa@atr2.ath.cx>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1204793365.8023.9.camel@littletux>
Message-ID: <alpine.LNX.1.00.0803061047380.3415@nge2.ngu.pk>
References: <alpine.LNX.1.00.0803052312120.7716@nge2.ngu.pk>
	<1204793365.8023.9.camel@littletux>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Headset not working, 2.6.24.x style
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



On Thu, 6 Mar 2008, Guillaume Bedot wrote:

-> You can try this kernel patch and report if this works for you (for me
-> it does) :
-> http://lkml.org/lkml/diff/2008/2/25/530/1


It does indeed work. I applied the patch to 2.6.24.3 and the headset 
produces sound now. Thank you very much.



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
