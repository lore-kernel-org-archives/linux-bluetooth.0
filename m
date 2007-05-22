Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46533F31.9090406@access-company.com>
Date: Tue, 22 May 2007 21:06:25 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Danis?= <frederic.danis@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <464B36D4.80702@access-company.com>	<1179666685.10069.250.camel@violet>	<e1effdeb0705210812p64d34f57l7800556df240fb23@mail.gmail.com>	<4653218D.3090504@access-company.com>
	<1179854658.9152.37.camel@aeonflux.holtmann.net>
In-Reply-To: <1179854658.9152.37.camel@aeonflux.holtmann.net>
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

Hello Marcel,

>> What I want to do in my program is : ConnectService, open rfcomm, DisconnectService, than use file descriptor on rfcomm. Close rfcomm after, that should 
>> disconnect the bluetooth connection.
> 
> that is not the the use case for ConnectService and DisconnectService.
> It is as simple as that. What you want is more like the CreatePort
> methods that create persistent RFCOMM bindings.

Even if I change to : ConnectService, open rfcommX, use file descriptor on rfcommX, close rfcommX, DisconnectService 
(that is a more classical use), the rfcommX connection is not released (and acl connection, until remote close it), as 
serial service keep a file descriptor opened on the rfcommX device (no close on node->io).

What I want to do is a non persistent rfcomm connection, only use "one-shot", but closable on local side.

Regards

Fred


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
