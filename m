Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <80236d750704050226m1563a49dw74214b6e847c495e@mail.gmail.com>
References: <80236d750704050226m1563a49dw74214b6e847c495e@mail.gmail.com>
Date: Thu, 05 Apr 2007 11:28:42 +0200
Message-Id: <1175765322.5815.594.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] reading RSSI value with D-Bus Api
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

> reading another post here, I saw Marcel hinted to use the inquiry from
> D-Bus API to sort the devices by their RSSI so I tried a simple test
> 
> this is the part of code I'm using
> ...
> 
>  if (dbus_message_is_signal(msg, " org.bluez.Adapter",
> "RemoteDeviceFound")) {
>           printf ("Remote Device Found Signal Received\n");
>          
>              while (dbus_message_iter_get_arg_type(&iter)  !=
> DBUS_TYPE_INVALID)  { 
>                  switch (dbus_message_iter_get_arg_type(&item)) {
>                      case DBUS_TYPE_STRING:  /* first pameter
> bdaddress */
>                       .....
>        
>                      break;
>                      case DBUS_TYPE_UINT32: /* second parameter class
> of device */
>                      ........ 
>                     break;  
>                      
>                      case DBUS_TYPE_INT16: /* rssi */ 
>                          dbus_message_iter_get_basic(&args, &rssi);
>                          printf("rssi: %d\n", rssi);
>                          break;
>                      
> ......
> 
> 
> 
> Now the problem is: I can read the bdaddress and the device class
> good, but the RSSI values I get from variuous devices are negatives
> (the are in range -40 -90 usually). I read somewhere RSSI should range
> from 0 to 255 so maybe I'm doing something wrong ? api says the type
> RSSI is int16 not uint16 so I used a signed variable. 

the RSSI value is a signed int8 actually (except that D-Bus doesn't
support this type). You might confuse this with the link quality value,
but the RSSI is always signed.

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
