Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <80236d750705290911g619e3d9eu8c6cda81c884b44d@mail.gmail.com>
References: <80236d750705290911g619e3d9eu8c6cda81c884b44d@mail.gmail.com>
Date: Tue, 29 May 2007 22:20:54 +0200
Message-Id: <1180470054.21432.141.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] [Bluez Users] Page timeout during sdp on
	heavy	traffic.
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

Hi Emanuele,

> I wrote a little application to simulate an heavy traffic.
> Simply discovers devices using hci0 and for each device discovered
> starts a thread to search service using hci1.
> Rinse and repeat forever.
> Usually I have 5-6 bluetooth devices in the area. 
> I'm not using d-bus messaging (yet) but i guess i'll try that too to
> check
> 
> Anyway I noticed a large number of timeouts during search services on
> devices who previously returned correct service record.

I have no idea how often I have to say that, but you can't page devices
at the same time. The chips simply don't support that. The same reason
why you can run an inquiry and page at the same time. It is not
possible. Period. And this means you have to serialize the SDP service
requests.

New kernel versions try to handling pending page attempts for piconet
creation, but that is also limited. And simultaneous name resolve
request can also cause troubles.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
