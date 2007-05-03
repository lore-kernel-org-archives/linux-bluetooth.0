Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Thu, 3 May 2007 08:27:33 -0400
Message-ID: <2EB6297382462046A9427D7324788A4801D5E78A@MCLNEXVS06.resource.ds.bah.com>
In-Reply-To: <4639D350.2020606@gmail.com>
References: <22b6c3510704292334q49fbce17s5f07f564bf38098f@mail.gmail.com>	<1ab01fb50705012238j36bd3f96u8baccf9bf4eb3ee1@mail.gmail.com><22b6c3510705022305s522c254fy511ee6e9db90c44c@mail.gmail.com>
	<4639D350.2020606@gmail.com>
From: "Williams, Richard" <williams_richard_b@bah.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] finding the least busy hci device
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

I think the solution is pretty simple, and is done entirely at the
application level. I wrote an app that uses multiple dongles, for HCI
commands, SDP and OBEX. I have an array of hci control objects that I
"alloc" and "free" just as you would any other shared resource. 

Whenever I need to do a BT operation, the app goes to the pool of HCI
devices and requests one with "hci_alloc()". If one is free, that "hciX"
is returned. If none is free, then NULL is returned. When the app is
done with the operation, I do an "hci_free()".


Rich



-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net
[mailto:bluez-devel-bounces@lists.sourceforge.net] On Behalf Of Manuel
Naranjo
Sent: Thursday, May 03, 2007 8:19 AM
To: BlueZ development
Subject: Re: [Bluez-devel] finding the least busy hci device

Hi Benjamin,
Please let me know how you solved this, I had patched obexftp in order
to use more than one bluetooth dongle at the same time, but didn't do
the load balance stuff, if you can get this done, please give me some
code snippets and I send the ObexFTP crew another patch with this stuff.
Thanks,
Manuel
> Hi Vikas,
>  
> I think your solution is far more elegant than mine. I'd tried to 
> obtain the amount of connected device  to the dongle via cl->conn_num,

> and try to gauge from there if the dongle is busy. Thanks mate
>  
> Regards,
> Ben
>
>  
>
>     I was trying it few months ago. What I was doing was not very much
>     effective but workable.
>     There is status for every connection ... "ci->state". If its state
>     is BT_CONNECTED means its connected and u can't connect it with
>     other once. With these state u can have a watch on dongles and if
>     any Dongle get free u can use it.
>
>     u can find these function under hci.c and hci_lib.h. use them ...
>     if get soem better way then please let me know..
>
>         Hi,
>          
>         I'm trying to write an OBEX application which will be deployed
>         in an environment with multiple attached Bluetooth USB
>         dongles. Since each bluetooth dongle can support only 7 ACL
>         active connection simultaneously, can anyone please suggest a
>         method to efficiently perform load balancing on all the
>         available bluetooth dongles? Is there a function which I can
>         use to seek out the least busy/connected hci device? Thanks
>          
>         Regards,
>         Ben
>
>
>
>
>     -- 
>     Impossible
>     itself contain
>     I M Possible
>
> Hi Ben,


------------------------------------------------------------------------
-
This SF.net email is sponsored by DB2 Express Download DB2 Express C -
the FREE version of DB2 express and take control of your XML. No limits.
Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
