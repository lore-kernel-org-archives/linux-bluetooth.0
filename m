Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <3f5a9ba20609172100s5446aa0co42cbd0101fc488e2@mail.gmail.com>
References: <3f5a9ba20609172100s5446aa0co42cbd0101fc488e2@mail.gmail.com>
Date: Mon, 18 Sep 2006 08:07:16 +0200
Message-Id: <1158559636.30486.7.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] How to handle multiple L2cap Connection
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

Hi,

> Problem:
>   My program's logic:
>   (1) have 1 thread named sensor to discover other bluetooth devices
>   (2) have at most 7 threads named workers, each worker will push a
> file to the scheduled device.
>   (3) have 1 thread to scheduler the found deivces to the workers.
> 
> the problem is, 
>    Each worker,
>    first to search the obex service in its target device. (use
> sdp_connect to create a connection, in fact a l2cap connect)
>    if obex service found, then push the file by OPENOBEX. (use
> Bt_TransportConnect to create a connection)
>  
>   For the coccurent workers, the l2cap connections are created
> coccurently.
>   So there is some error occurs such like errcode 103, errorcode 113,
> errcode 16,timeout
>  
>   In the former discusstion in the maillist, sem_t could be used
> to sync the call of connect
>    
>   so, I use a sem_t conn_sem to sync, but I found that no improvement.
>  
>   Who can give me a nice suggestion?

the baseband page can't be done simultaneously. Run "hcidump -X -V" to
see what error will show up.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
