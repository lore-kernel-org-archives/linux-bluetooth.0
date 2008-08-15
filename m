Return-Path: <cyrus@holtmann.org>
Message-ID: <6A01CB6FD5D845BAB337067E073F0D44@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <73BDD852208F403CB708EBFA9AED92A0@freqonedev>
	<1218482965.25524.20.camel@californication>
Date: Fri, 15 Aug 2008 09:20:06 -0500
MIME-Version: 1.0
Subject: Re: [Bluez-devel] Question about Bluez-4.1 Object Paths
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

Greetings, Marcel

BTW: Not sure what is going on with the lists, but I just got your 
response in the digest today.  Good thing we have irc.

> Hi David,
>
>> After installing 4.1 yesterday, I noticed that the object paths for
>> org.bluez.Adapter and org.bluez.Device have changed: both are now
>> prefixed with "/org/bluez", probably reflecting the recent firestorm
>> with the DBus folks.  So now, the object path for the "zero-th" 
>> adapter
>> is not "/hci0", but "/org/bluez/hci0" as it was for the "legacy" DBus
>> interface.
>
> the object path of the adapter and device interfaces need to be
> discovered via functions like ListAdapters and ListDevices. Relying on
> stable object path names is wrong. I will change them randomly from
> release to release if I have to. Any application that will break 
> because
> of this is a broken application.

Agree with the requirement to discover adapter and device interface 
object paths.

Also noted that we are still using "/" for org.bluez.Manager, and 
appreciate your "reasons" for doing so ;-) (raising Havoc, so to speak).

>
> Regards
>
> Marcel
>
>
>
>
> 


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
