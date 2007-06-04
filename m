Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <d89ddf300706031341t1f38d12ayd8752280f93d9f28@mail.gmail.com>
References: <d89ddf300706012143s1444d9c9l98f2a06c8a05171b@mail.gmail.com>
	<1180858390.6872.5.camel@aeonflux.holtmann.net>
	<d89ddf300706031341t1f38d12ayd8752280f93d9f28@mail.gmail.com>
Date: Mon, 04 Jun 2007 17:25:48 +0200
Message-Id: <1180970748.13429.59.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] fleshing out audio daemon scenarios
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

Hi Brad,

> So I think next step will be to tell the audio daemon to put a headset
> in connected state and then with a basic plugin (no options) put it in
> streaming state and send some audio to it.
> 
> What does the command-line dbus injection stuff look like to get the
> audio daemon to connect to a set? 
> 
> I'll start documenting the minimal approach on the wiki.

no idea. Simply start playing with the code. A lot of stuff will fall
into place automatically and some other stuff needs more thinking, but
without actually trying to do it, we don't know what works and where we
have to fix stuff.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
