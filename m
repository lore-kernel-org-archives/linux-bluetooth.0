Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <2d5a2c100705282058o22ace961y93308be3340bb2d4@mail.gmail.com>
References: <1179933855.3629.75.camel@cookie.hadess.net>
	<1179936924.3629.88.camel@cookie.hadess.net>
	<1179937606.3629.92.camel@cookie.hadess.net>
	<59278C28-851A-44FF-AE01-25D8F074CE1E@nokia.com>
	<1180013992.3151.6.camel@cookie.hadess.net>
	<089F41B2-DBC5-483E-A6C9-F413E18DF38B@nokia.com>
	<1180032597.14752.13.camel@cookie.hadess.net>
	<1180096233.14752.27.camel@cookie.hadess.net>
	<1180097928.14752.33.camel@cookie.hadess.net>
	<1180105720.14752.49.camel@cookie.hadess.net>
	<2d5a2c100705282058o22ace961y93308be3340bb2d4@mail.gmail.com>
Date: Tue, 29 May 2007 11:26:23 +0100
Message-Id: <1180434383.3030.70.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] CUPS plugin discovery bits
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

On Tue, 2007-05-29 at 00:58 -0300, Luiz Augusto von Dentz wrote:
> I consider this as a wizard for printers, like in NetwokManager the
> network wizard also
> does start a discovery and it work like a charm but in my opinion it
> doesnt belong to bluez utils.

It's a standard feature of cups backends. If they support it, they
should list the accessible/known printers in the vicinity.

> Having each wizard to rely in its own discovery is probably a bad
> design, we can probably integrate 
> all wizard together and then having services configuring them in the
> background. This way we
> could leave to the user to use periodic scan and popup specific device
> wizard dependent on
> each service when active. Also in my opinion it should exist a printer
> service for those that want to 
> configure its devices that are not in discoverable mode.

True, it would be much better. But in the meanwhile, this patch simply
implements a CUPS feature and allows us to have some basic integration
in the distribution-provided printer tools.

Being able to configure the printer via a bluetooth configuration wizard
requires a bit more work, but it's also on my plans. There should be a
CUPS service that would allow hcid to add/remove bluetooth printers from
cups with minimum user interaction.

> Btw, The printer wizard as it is now wont work with periodic
> discovery, signals DiscoveryStarted and
> DiscoveryCompleted are not emitted while in periodic  discovery. 

The cups backend isn't supposed to run forever, so it can't do periodic
discovery.

-- 
Bastien Nocera <hadess@hadess.net> 


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
