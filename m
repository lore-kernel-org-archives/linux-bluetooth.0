Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Fred Schaettgen <bluez-devel@schaettgen.de>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Service level security for RFCOMM
References: <1099024935.10164.11.camel@pegasus> <1099042277.31284.438.camel@baroque.rococosoft.com>
In-Reply-To: <1099042277.31284.438.camel@baroque.rococosoft.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410291234.49907.bluez-devel@schaettgen.de>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 29 Oct 2004 12:34:49 +0200

On Friday 29 October 2004 11:31, Stephen Crane wrote:
> On Fri, 2004-10-29 at 05:42, Marcel Holtmann wrote:
> > actually it seems that nobody really cares about service level security
> > on the RFCOMM layer. Or people are too lazy to send in a patch. However,
> > I spent some hours with thinking about it and the core stuff of a small
> > framework for providing authentication and encrypt feedback from HCI to
> > higher level protocols is finished.
..
> > And btw, who is really interested in this feature or needs it?

Over here! I'm interested.
I would like to integrate service level security into the meta server of 
kdebluetooth. At the moment you can allow/disallow connections (or show a 
confirmation popup) based on the service/rfcomm channel and on the peer 
device address, but we can't ask for an authenticated link. Being able to use 
service level security would allow us to force authenticated links when using 
any service other than obex push, which should work without having to pair 
devices first.
IIRC I asked you to allow every user to send authentication requests a few 
months ago, so that even programs running without root privileges can trigger 
authentication. But then I didn't post it on the list as you told me, to let 
other people comment on the security implications. The corresonding patch 
changed only a single bit somewhere, but of course this solution is not very 
conveniant. But if you want authentication to appear as a property of a 
single rfcomm connection that's fine too, as long as a regular users are 
allowed to use this feature. Would that be safe?

regards
Fred

-- 
Fred Schaettgen
bluez-devel@schaettgen.de


-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
