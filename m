Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: David Woodhouse <dwmw2@infradead.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1190504329.7150.277.camel@pmac.infradead.org>
References: <1190504329.7150.277.camel@pmac.infradead.org>
Date: Tue, 02 Oct 2007 13:15:06 +0100
Message-Id: <1191327306.9188.43.camel@pmac.infradead.org>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Serial service support for bluez-gnome
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

On Sun, 2007-09-23 at 00:38 +0100, David Woodhouse wrote:
> This needs a little more work in the support for adding devices -- we
> probably want another page in the dialog which shows the services
> available on the selected device, and lets you choose which one to
> connect to. I've hard-coded it to DUN for now.

I've done a first attempt at basic SDP support:
http://git.infradead.org/?p=users/dwmw2/bluez-gnome.git;a=commitdiff;h=d170121a3f223cb571da81a4958f2b86ec08069b

Now it needs to be hooked into the 'create device' dialog box... I'm
kind of hoping that someone who hates userspace a little less than I
will take pity on me and finish it off... :)

-- 
dwmw2


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
