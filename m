Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 14 Sep 2007 11:22:31 +0200
From: Stefan Seyfried <seife@suse.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <20070914092231.GB1085@suse.de>
References: <BAY123-F29B9F211658DBCAE83E7F7C0C30@phx.gbl>
	<BAY123-F26AFEA092F402F4E2C4044C0BC0@phx.gbl>
MIME-Version: 1.0
In-Reply-To: <BAY123-F26AFEA092F402F4E2C4044C0BC0@phx.gbl>
Subject: Re: [Bluez-users] Plugz fails ./configure
	glib-2.0	gthread-2.0gobject-2.0 not fo
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Fri, Sep 14, 2007 at 02:29:42AM +0100, Another Name wrote:
> Ignore this question folks....looks like my pkg-config stuff is borked....
> =

> rpm -qa | grep glib shows the packages installed whereas

show the output of that command.

> pkg-config --list-all | grep glib doesn't show them and I can't locate =

> glib-2.0.pc

You probably don't have the correct package installed.
-- =

Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg  | "Well, surrounding them's out." =


This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG N=FCrnberg)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
