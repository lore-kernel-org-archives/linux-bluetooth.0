Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Tue, 20 Nov 2007 17:06:36 +0100
From: Robert Winder <robertwinder@casema.nl>
Message-ID: <1277734668.20071120170636@casema.nl>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] fakeinput for PS3 sixaxis
Reply-To: Robert Winder <robertwinder@casema.nl>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
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

Hi,

Maybe it have been lost in the chatter but Aristeu Sergio Rozanski
Filho did send in a fakeinput patch for the Playstation 3 sixaxis
controller a month ago.

see http://sourceforge.net/mailarchive/message.php?msg_id=20071007184035.GA7430%40cathedrallabs.org

I don't see the patch in cvs so maybe it got stalled somewhere. Maybe
someone can consider this patch again for inclusion. Can't ask
Aristeau for a resend directly because i just subscribed and thus
haven't got his email address to ask for a resend.

As I understand it the ps3 sixaxis controller has to be defined as
fakeinput otherwise it won't connect.

With bluez-util 3.22. I see the PS3 controller trying to connect

Nov 20 18:06:56 localhost input[4060]: Incoming connection on PSM 17
Nov 20 18:06:56 localhost input[4060]: Incoming connection on PSM 19

but to no avail.

With the old daemon hidd there is a nocheck option but with hidc there
isn't so I'm not able to connect the controller with BT.

    /Robert     


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
