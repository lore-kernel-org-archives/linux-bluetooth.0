Return-Path: <cyrus@holtmann.org>
Message-ID: <48172BB6.8040303@suse.de>
Date: Tue, 29 Apr 2008 16:07:50 +0200
From: Stefan Seyfried <seife@suse.de>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <012d01c8a8d3$4669be00$6701a8c0@freqonedev>
In-Reply-To: <012d01c8a8d3$4669be00$6701a8c0@freqonedev>
Subject: Re: [Bluez-devel] Bluez-utils-3.30 (patched) plugins failing at
	startup
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

David Stockwell wrote:
> As stated in my last message, I caught up with all recent patches from hc=
id, and now find that when initializing the libxxxxx.so =

> plugins, the call to g_module_open STILL fails as shown in the following:


configure with "--enable-glib" (even if you did enable-all, this does not
enable glib) and that sould be it.
-- =

Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg | "Well, surrounding them's out."

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG N=FCrnberg)

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference =

Don't miss this year's exciting event. There's still time to save $100. =

Use priority code J8TL2D2. =

http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/java=
one
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
