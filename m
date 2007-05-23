Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <465484B4.2070701@access-company.com>
Date: Wed, 23 May 2007 20:15:16 +0200
From: Frederic Danis <frederic.danis@access-company.com>
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
> 

Regarding the Serial service API, I am not sure to understand difference between ConnectService and CreatePort.
Is it possible to use port like this : CreatePort, open rfcomm, RemovePort, use file descriptor on rfcomm, than close it (that should disconnect bluetooth) ?

Regards

Fred

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
