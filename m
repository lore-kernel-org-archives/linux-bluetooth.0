Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 Jan 2008 10:14:26 -0500
From: jayjwa <jayjwa@atr2.ath.cx>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <200801241956.m0OJuWIV003375@alumnus.caltech.edu>
Message-ID: <alpine.LNX.1.00.0801251003010.18258@nge2.ngu.pk>
References: <200801241956.m0OJuWIV003375@alumnus.caltech.edu>
MIME-Version: 1.0
Subject: Re: [Bluez-users] 'cannot open libasound_module_pcm_bluetooth.so':
 a solution
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


On Thu, 24 Jan 2008, Russell A. Bell wrote:

-> 	When I try to play a file on my headset via bluetooth I get
-> that message.  I don't have libasound_module_pcm_bluetooth.so.  I run
-> Slackware 10.2 with kernel 2.6.23.1; I had all the bluez-* packages
-> (3.22: Slackware's most recent version) installed.

I have those, but I can't remember if it was built in the alsa stuff or the 
bluez stuff. The dates are newer on the libasound_module* files, and I 
upgraded bluez stuff last. Mine was built from source, both alsa and all bluez 
stuff. If you have a full install of both those, you should have the files. 
Possibly you don't have a full (alsa) install or one is not available from 
Slackware that supports bluetooth?


->  I uninstalled all
-> the bluez-* packages, downloaded the latest source from www.bluez.org,
-> built it, had the same result.

What happens if you build + install alsa from source, *then* build install 
bluez? Sometimes what is built depends on support you already have in-system.


-> I still haven't
-> figured out how to make a permanent connection to my headset.

Same problem here, with a Jabra; but I'm not sure what I'm trying is even 
possible. hcitool cc <addr> connects for about a 1/2 second. Anything else 
says 'Not connected'. I know the pin to be '0000', but the device doesn't show 
up on a scan. The only way I got the address was from when it paired with a 
phone.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
