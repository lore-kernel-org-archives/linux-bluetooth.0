Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <46533F31.9090406@access-company.com>
References: <464B36D4.80702@access-company.com>
	<1179666685.10069.250.camel@violet>
	<e1effdeb0705210812p64d34f57l7800556df240fb23@mail.gmail.com>
	<4653218D.3090504@access-company.com>
	<1179854658.9152.37.camel@aeonflux.holtmann.net>
	<46533F31.9090406@access-company.com>
Date: Tue, 22 May 2007 23:08:55 +0200
Message-Id: <1179868135.9152.39.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
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

Hi Frederic,

> >> What I want to do in my program is : ConnectService, open rfcomm, DisconnectService, than use file descriptor on rfcomm. Close rfcomm after, that should 
> >> disconnect the bluetooth connection.
> > 
> > that is not the the use case for ConnectService and DisconnectService.
> > It is as simple as that. What you want is more like the CreatePort
> > methods that create persistent RFCOMM bindings.
> 
> Even if I change to : ConnectService, open rfcommX, use file descriptor on rfcommX, close rfcommX, DisconnectService 
> (that is a more classical use), the rfcommX connection is not released (and acl connection, until remote close it), as 
> serial service keep a file descriptor opened on the rfcommX device (no close on node->io).

that is the use case this is designed for. If this doesn't seem to work
than it actually looks like a bug. Can you provide further information
for Claudio so he can debug it.

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
