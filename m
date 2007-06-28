Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <BAY102-W1B22F7EE02594921509C3F0090@phx.gbl>
References: <BAY102-W1B22F7EE02594921509C3F0090@phx.gbl>
Date: Thu, 28 Jun 2007 18:32:52 +0200
Message-Id: <1183048372.9499.42.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Service Discovery Issues
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

Hi Robert,

> Thanks for getting back to me, you were correct to say that it is
> UInt32, However even with that implemented, we're then back to the
> original error message again stating that the function doesn't exist,
> is it possible that I have a version of the API with that method
> missing? or it has perhaps been depreciated or renamed?
>  
> However, the standard GetRemoteServiceRecord() method appears to be in
> the API and I can get that to return the byte array to me,
> unfortunately I have no idea how to turn the byte array into anything
> useful for me to be able to extract the channel/port from, after
> speaking with quite a few people on the python and dbus mailing lists
> they were all a little stumped too.
>  
> I'd love to hear any more advice you can offer on either the XML or
> the ByteArray methods,

then you are not running bluez-utils-3.12 and you should. Fix that
first.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
