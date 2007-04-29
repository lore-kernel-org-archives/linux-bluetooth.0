Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Reiner Klenk <pdq808@t-online.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <7.0.1.0.2.20070429085827.03de8030@dubai.oilfield.slb.com>
References: <7.0.1.0.2.20070429085827.03de8030@dubai.oilfield.slb.com>
Date: Sun, 29 Apr 2007 10:23:48 +0200
Message-Id: <1177835028.16681.8.camel@grappa>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Fwd: Re: Unable to set number of SCO buffers
	:	please upgrade your Kernel !
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Sun, 2007-04-29 at 09:08 +0400, John Frankish wrote:

> 2. I compiled bluez-libs/bluez-utils 3.9 to see if plugz would work 
> better with this - I ran into the same pin problem as before in that 
> I don't get a pin pop-up on my machine. If I set security to auto in 
> hcid.conf then I can pair with my cell phone since I can enter a pin 
> on the phone but this does not work with a bluetooth headset since I 
> cannot enter a pin and hcid just sits there waiting...
I have seen something like this, where the problem appeared to be that
the pin helper could not pop up its window due to authorization failure.
If this is the case, it helps to "xhost +".

Hth,
Reiner
-- 
debb1046 (gmail, gtalk, jabber.org, ekiga.net, last.fm, skype)


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
