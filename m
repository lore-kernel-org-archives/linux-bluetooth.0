Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: jan d tux <janice@asti.dost.gov.ph>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Content-Type: text/plain
Message-Id: <1075714467.1546.49.camel@Asgard>
Mime-Version: 1.0
Subject: [Bluez-users] bizzare result when getting the bluetooth address
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 02 Feb 2004 17:34:27 +0800

Good day to all.

Can anybody help me figure out why the bluetooth address I am getting is
not right?

What I am trying to do is get the bluetooth address of the sender/peer
to my obex server.

Here are the obex calls I made:
--------
	handle = OBEX_Init(OBEX_TRANS_BLUETOOTH, obex_event, 0);

	BtOBEX_ServerRegister(handle, NULL, OBEX_PUSH_HANDLE);

	btobex_accept(handle);

	OBEX_HandleInput(handle, 1);

	//get addresss
	
	fd = OBEX_GetFD(handle);
	if( fd < 0 )
		return 0;

	getpeername(fd,(struct sockaddr *)&sa,&len)
		return 0;

	baswap(&bdaddr, &sa.rc_bdaddr);
	printf("\tADDRESS: %s\n", batostr(&bdaddr));
--------


when i run the program, i was able to get the following:
        channel: 10	
        family: 31
        ADDRESS 2: 00:0A:00:02:EE:69 -> this is not the bluetooth
address of the sender!!! Its address is 00:02:EE:69:E1:88. The last for
digits displayed are the 1st four digits of the device's real address. I
tried it with another device and the result is the same, from the
original address (00:E0:03:74:38:8E) to 00:0A:00:E0:03:74.

Bdw, I am using openobex.

Any help would be appreciated.


Thanks :)


Also, thanks to Marcel for replying to my first email: Getting remote
device address & name using obex commands

-- 

~jan



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
