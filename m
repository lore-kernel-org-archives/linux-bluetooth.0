Return-Path: <cyrus@holtmann.org>
From: "Liu, Raymond" <raymond.liu@intel.com>
To: Vinicius Gomes <vinicius.gomes@openbossa.org>
Date: Thu, 20 Nov 2008 12:47:07 +0800
Message-ID: <0463F45F3606F4428ED35AC8C709F92E0217A0CC@pdsmsx502.ccr.corp.intel.com>
References: <0463F45F3606F4428ED35AC8C709F92E0217A025@pdsmsx502.ccr.corp.intel.com>
	<2a9506370811192003u1c3d7f27qe50472922b7b33@mail.gmail.com>
In-Reply-To: <2a9506370811192003u1c3d7f27qe50472922b7b33@mail.gmail.com>
MIME-Version: 1.0
Cc: "bluez-devel@lists.sourceforge.net" <bluez-devel@lists.sourceforge.net>,
	"johan.hedberg@nokia.com" <johan.hedberg@nokia.com>
Subject: Re: [Bluez-devel] could not uses introspect in obexd client for
 session or ftp from the root path.
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
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Vinicius
>
>
>Or taking a look at the documentation at doc/client-api.txt ;-)
>
>>        But dbus-send --print-reply --dest=org.openobex.client /
>org.freedesktop.DBus.Introspectable.Introspect will not show that there are a
>/org/openobex node under this path. So it might not be easy for a user to know
>what kind of interfaces is provided for the whole org.openobex.client service.
>Since they will not know what's the right node path name.
>>
>
>They will know the right path name, because CreateSession returned it.

OK, I see. However, what if the other one who not want to create the session by themselves. They just want to know is there already a session exist and can be used through Dbus interface? They might probably not read the client-api doc 8 )

>
>I find d-feet very useful when I am exploring some app DBus interface.
>Just be aware
>that d-feet doesn't like very much the "/" root path, you might find
>it useful to change
>the root path (client/main.c:41) to something other than "/"
>("/client" for example).
>
>Using this trick I was able to verify that the
>"/org/openobex/session0" node is being added to
>the bus, it is just not being added as a child of the "/" node, but in
>parallel to it.

Yes, I try it out. It a good tool, Thanks!
However, as you said, it will not recognize the node under "/", I am wondering, is that because we do not provide the introspect info for child node , or just the bad of this tool? So user who use d-feet still could not find our secret interface :)

>
>>        I guess we can add a node, or child field, and a parent field in the
>generic_data structure, and update these information during the interface
>register operation, so that the introspect method can show the child node under
>a certain path?
>
>We really could, but as this way has been working very well for BlueZ,
>I don't really see this as a bug.

OK, I just think that to support child node info in introspect from the root path might be more friend to the end user. If you think it's ok, it is :)

>
>P.S.: http://pastebin.com/m49d7d516 an example ftp test script,
>it isn't very clean, but it works ;-)

Got it! Thanks. 

Raymond

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
