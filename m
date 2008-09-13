Return-Path: <cyrus@holtmann.org>
Message-ID: <48CC195A.8000106@free.fr>
Date: Sat, 13 Sep 2008 21:49:46 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <48CBE24E.6080507@free.fr>
	<1221325424.6695.45.camel@californication>
In-Reply-To: <1221325424.6695.45.camel@californication>
Subject: Re: [Bluez-devel] Some Audio error handling fixes.
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

Hi Marcel,

> 
> actually the convention is that if it is a return value, then we use a
> negative error value. If it is a parameter, we use the positive one. So
> the connection_lost change is wrong (it was wrong before though). Please
> fix this too.

Ok, that might be quite a huge patch though... it has been that way for 
so long... virtually every function will be impacted :-(

> 
>> While reading the latest code, i noticed common/error.{c, h} is gone...
>> There's a new one in src/, but with only one generic
>> error handling routine. I have the feeling this is a big step backwards,
>> as DBUS error names get duplicated into each service
>> again and again, paving the way for un unmanageable level of error
>> strings fragmentation :-( What do you guys think ?
> 
> It is not a big step backwards since we are using libgdbus error
> functions now and there are more simpler. There is a problem with the
> strings returned for a specific error, but I don't really thing it is
> that big of a problem.

Ok i see the thing now. By that i guess that all error handling outside 
of g_dbus_create_error are on their way out ?

I guess those ones should be replaced with g_dbus equivalents ?
./src/adapter.c:static DBusHandlerResult error_failed(DBusConnection *conn,

./src/adapter.c:static DBusHandlerResult 
error_connection_attempt_failed(DBusConnection *conn,


> 
> In the long term we might get btd_error_* or alike functions since then
> the plugins can use them. However right now every plugin has to handle
> its own errors.
> 
Thanks for the explanation,

Cheers,

Fabien

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
