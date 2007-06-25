Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <467FD4DF.9090108@free.fr>
References: <467FD4DF.9090108@free.fr>
Date: Mon, 25 Jun 2007 23:53:51 +0200
Message-Id: <1182808431.6385.30.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Kernel vs Userland AVDTP
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

Hi Fabien,

> Browsing the archives i've seen there has been some interest around the 
> end of 2004 for an avdtp kernel implementation.
> 
> However recent trends seem to try to solve the issue in userland 
> (Frederic's a2dpd or bluez's btaudiod for instance).
> 
> Is there a reason for this change of trends (except for "it's easier to 
> have it done in user space for now" ;-) ) ?
> 
> Wouldn't it make more sense to have it in kernel due to multiplexing 
> issues ?

at some point, yes. Currently it makes no sense to start with a kernel
version of AVDTP. Also Bluetooth 2.1 and 3.0 are gonna have high impact
on L2CAP and I wanna have that settled first before considering a kernel
based AVDTP, because it is not that simple. It would be as complex as
RFCOMM and so keeping it in userspace is better for now.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
