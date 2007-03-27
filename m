Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <80236d750703270300y3497df0et16f6f1a1d3ce53e0@mail.gmail.com>
References: <80236d750703270300y3497df0et16f6f1a1d3ce53e0@mail.gmail.com>
Date: Tue, 27 Mar 2007 12:32:03 +0200
Message-Id: <1174991523.5815.41.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] clearing remote name cache
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Emanuele,

> Hi using the hints about reading remote names from various threads I
> got on this ML time ago I started experiments with D-Bus API for
> bluez.
> 
> I tried to read a remotename in a thread called from another thread
> who does inquiry. 
> Each time he found a bdaddress he ask for a name
> (snipped code)
> 
> msg = dbus_message_new_method_call("org.bluez", "/org/bluez/hci0",
> "org.bluez.Adapter", "GetRemoteName"); 
> dbus_message_append_args(msg, DBUS_TYPE_STRING,
> &bdaddress,DBUS_TYPE_INVALID);
> reply = dbus_connection_send_with_reply_and_block(conn, msg, -1,
> &err);
>  if (reply == NULL) {
>  printf("Error %s\n", err.message);
> 
>   }
>  else {
>  dbus_message_get_args(reply, NULL, DBUS_TYPE_STRING, &name,
> DBUS_TYPE_INVALID);
>                 PBLOG_INFO("%s\n", name);
> }
> 
> all works well till I change the name of the remote device (a phone).
> Each time I run the program I still get the old name, no matter how
> can try. 
> Only workaround I got to solve this is to manually invoke hcitool name
> <bdaddress> to change the actual name in cache.

the name resolving operation is an expensive operation. It always
involves a low-level baseband page. So we try to avoid these kind of
operation whenever possible. This means that we return the cached name
all the time. However the cache will be automatically updated when you
actually connect to the remote device or if extended inquiry (a new
Bluetooth 2.1 feature) is used.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
