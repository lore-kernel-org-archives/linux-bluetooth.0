Return-Path: <cyrus@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-reply-to: <75FB41F6-49E1-4CEE-8A7F-87DCF21645F5@holtmann.org>
References: <3e9cdced0805170741i202cfe62kef18ca9a0c2e30c@mail.gmail.com>
	<75FB41F6-49E1-4CEE-8A7F-87DCF21645F5@holtmann.org>
Mime-Version: 1.0
Date: Sat, 17 May 2008 18:55:11 +0200
From: Anders Eriksson <aeriksson@fastmail.fm>
Message-Id: <20080517165511.71BDB93C88E@tippex.mynet.homeunix.org>
Subject: Re: [Bluez-users] using bluez dbus interface exposed from hcid with
	plain c code
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


marcel@holtmann.org said:
> And of course you can write a client application using D-Bus low-level
> (libdbus) only. It is a little bit more work than using high level
> languages, but it is possible. I still have plans to provide a D-Bus   only
> replacement for hciconfig, hcitool etc. 

If the long term plan is that hcid is the only daemon necessary, and it is
accessed using dbus, how can I make hcid start on application request. In other
words, is there an "xinetd for dbus" which can dtrt?

/Anders


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
