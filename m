Return-Path: <cyrus@holtmann.org>
Message-ID: <477E9A32.8080908@cs.wisc.edu>
Date: Fri, 04 Jan 2008 12:42:26 -0800
From: Ben Liblit <liblit@cs.wisc.edu>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <477C6D10.2040003@cs.wisc.edu> <1199337678.26099.35.camel@aeonflux>
In-Reply-To: <1199337678.26099.35.camel@aeonflux>
Subject: Re: [Bluez-users] enabling/disabling in response to ThinkPad hotkey
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

Marcel Holtmann wrote:
> The reason for this is that the Bluetooth on/off switches are all
> different and HAL and rfkill is the way to abstract it into a common
> interface. It is not the job of hcid to abstract this.

OK, I see your point.  HAL is supposed to keep other daemons from having 
to worry about such things.  I've conveyed your reply back to the HAL 
mailing list.

That said, it's unfortunate that the end result is an Fn+F5 key which 
does *nothing* useful out of the box.  Even if different users would 
want it to do slightly different things, right now it does *nothing* by 
default.  I'm savvy enough to write my own script that runs as root, 
hooks into HAL D-BUS signals, and responds accordingly.  Most users 
won't do that, so for them, this key is useless.

Oh well.  Between HAL and Bluez, things are much better now than they 
ever were before.  We're not done yet, but at least we're making progress.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
