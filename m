Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <b7f7accd0710162048k790a1d69tac577730fed6bb6e@mail.gmail.com>
References: <b7f7accd0710160552x6d6e8a49h9646911eb2a94bf8@mail.gmail.com>
	<b7f7accd0710162048k790a1d69tac577730fed6bb6e@mail.gmail.com>
Date: Wed, 17 Oct 2007 16:25:56 +0200
Message-Id: <1192631156.6184.28.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Regarding GetInfo
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

Hi Yogesh,

> I want to get device class. But DBus API's are available for getting
> device Major class, Minor class and service class. But no API to get
> device class. To get Device class I have two options,
> 1. Get device class from GetInfo. 
> 2. Get Major class, Minor class and service class and from that
> construct device class.
> So I choose first way, But I am not able to get device class.
> 
> To get information about adapter, I have written code like this. 
> 
> msg = dbus_message_new_method_call("org.bluez", "/org/bluez/hci0",
> INTERFACE,"GetInfo");
>         reply = dbus_connection_send_with_reply_and_block (conn,msg,
> -1,&error);
>         dbus_message_iter_init (reply, &iter); 
>         printf("\nSignature::%s",dbus_message_get_signature(reply));
>         cout<<"\nIter
> signature::"<<dbus_message_iter_get_signature(&iter);
>         dbus_message_iter_recurse (&iter, &dict_iter); 
>         cout<<"\ndict_Iter
> signature::"<<dbus_message_iter_get_signature(&dict_iter);
>         dbus_message_iter_recurse (&dict_iter, &data_iter);
>         cout<<"\ndata_Iter
> signature::"<<dbus_message_iter_get_signature(&data_iter); 
>         while (dbus_message_iter_has_next(&data_iter))
>         {
>             cout<<"\ndata
> type::"<<(dbus_message_iter_get_arg_type(&data_iter));
>             dbus_message_iter_next(&data_iter); 
>         }
> 
> But its not working. When I print signatures, it is printing like this
> Signature::a{sv}
> Iter signature::a{sv}
> dict_Iter signature::{sv}
> data_Iter signature::s
> data type::115
> 
> And I found that, 
>  a{sv} is a dictionary with 's'tring keys and 'v'ariants as values
> 
> So does that mean GetInfo is returning only one key value pair?
> Or I am missing something?

we fixed the signature in the last release. That might explain an issue.
Other than that, I can't read C++ code. Use plain C or Python to make me
look at your code.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
