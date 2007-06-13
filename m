Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <466D2E82.7070805@bluecellnetworks.com>
References: <E1Hwe2S-0003bG-Gu@mail.sourceforge.net>
	<B4DB78E18F6C47E6BA941FB0F17C6A97@iMe>
	<466D2E82.7070805@bluecellnetworks.com>
Date: Wed, 13 Jun 2007 04:46:18 +0200
Message-Id: <1181702778.6872.90.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] multiple server-instances on one single machine
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

Hi Uli,

> I'm trying to build a Bluteooth - receiver, which uses multiple 
> bluetooth-devices and has a server running for each stick.
> (Background is, that i need a machine for testing-purposes to test a 
> bluetooth-sender. I need multiple parallel connections to test the 
> transferspeed etc.)
> 
> I Took the sources of obexpushd 0.4 (debianpackage) and modified them, 
> so the obexpushd can be started with -DhciX to use a certain hci device. 
> This works perfect, if i start the server on hci2 for example, only hci2 
> gets the files. The big problem is, when i start a second instance of 
> the obexpushd eg. on hci3, only hci3 gets the content and hci2 not.
> 
> I tracked down the problem and can say, that the sdpd promotes the 
> OBEX-PUSH Service for each stick and not only for the one i want it to.
> 
> I altered  the  obexpush-sdp.c file from
> 
>   session = sdp_connect(BDADDR_ANY,BDADDR_LOCAL,SDP_RETRY_IF_BUSY);
>   status = sdp_record_register(session,rec,0);
> 
> to
> 
>   session = sdp_connect(&btdev,BDADDR_LOCAL,SDP_RETRY_IF_BUSY);
>   status = sdp_record_register(session,rec,0);
> 
> where btdev is the bdaddr_t of the wanted hci-device, but i still get 
> all running services promoted on all hci-devices.

the change in sdp_connect() gives you nothing when using BDADDR_LOCAL.
You need to use sdp_device_record_register() in the second step.

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
