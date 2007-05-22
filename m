Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4653218D.3090504@access-company.com>
Date: Tue, 22 May 2007 18:59:57 +0200
From: Frederic Danis <frederic.danis@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <464B36D4.80702@access-company.com>	<1179666685.10069.250.camel@violet>
	<e1effdeb0705210812p64d34f57l7800556df240fb23@mail.gmail.com>
In-Reply-To: <e1effdeb0705210812p64d34f57l7800556df240fb23@mail.gmail.com>
Subject: Re: [Bluez-devel] Fix for disconnection in new serial service
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

Claudio Takahasi wrote:
> On 5/20/07, Marcel Holtmann <marcel@holtmann.org> wrote:
>> Hi Frederic,
>>
>>> I find a little bug preventing disconnection in new serial service.
>> can you check against latest CVS. I am not sure if Claudio fixed this or
>> not. Thanks.
>>
>> Regards
>>
>> Marcel
> 
> Hi Frederic,
> 
> using g_io_channel_set_close_on_unref(io, TRUE) will trigger the
> following warning for G_IO_NVAL condition:
> 
> (process:8085): GLib-WARNING **: Invalid file descriptor.
> 
> BR,
> Claudio.

Hello Claudio,

I understand your comment.

But, I am trying to use the serial service and I do not understand one point :
after a ConnectService, the only way to disconnect it (disconnect rfcomm and acl), is by closing connection from remote side.

   ~ # dbus-send --system --type=method_call --print-reply --dest=:1.19 /org/bluez/serial org.bluez.serial.Manager.ConnectService string:00:01:02:03:05:06 
string:spp
   serial[1048]: /org/bluez/serial: org.bluez.serial.Manager.ConnectService()
   serial[1048]: Connect in progress
   serial[1048]: rfcomm_connect_cb: connected
   serial[1048]: name_listener_add(:1.28)
   method return sender=:1.19 -> dest=:1.28
      string "/dev/rfcomm0"
   serial[1048]: Connect requestor :1.28 exited. Releasing /dev/rfcomm0 node
   ~ # dbus-send --system --type=method_call --print-reply --dest=:1.19 /org/bluez/serial org.bluez.serial.Manager.DisconnectService string:/dev/rfcomm0
   serial[1048]: /org/bluez/serial: org.bluez.serial.Manager.DisconnectService()
   Error org.bluez.serial.Error.DoesNotExist: Invalid node
     // Here, the RFComm connection is still up until remote side disconnect

How can I disconnect rfcomm (and acl) connection from local side (currently, the serial service has opened a file descriptor on /dev/rfcommX, that is close only 
on remote disconnection, keeping up the /dev/rfcommX device) ?

What I want to do in my program is : ConnectService, open rfcomm, DisconnectService, than use file descriptor on rfcomm. Close rfcomm after, that should 
disconnect the bluetooth connection.

Hope I am clear

Regards

Fred

-- 
-----------------------------------------------
It is not by improving the oil lamp that one invents the electric bulb!
-----------------------------------------------
Danis Frederic                   Access Company
Software engineer
Mail : mailto:frederic.danis@access-company.com
-----------------------------------------------

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
