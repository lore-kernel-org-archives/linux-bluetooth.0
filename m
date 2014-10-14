Return-Path: <cyrus@holtmann.org>
Message-ID: <543D474D.1040700@mlsw.biz>
Date: Tue, 14 Oct 2014 11:54:53 -0400
From: Nathan Jozwiak <njozwiak@mlsw.biz>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: GATT Notification not sending
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I'm trying to send a notification to a client when a characteristic 
value is updated by the server.

Here is the characteristics creation in the GATT server:

     /* Notification characteristic */
     bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
     atval[0] = GATT_CHR_PROP_READ | GATT_CHR_PROP_NOTIFY;
     put_le16(h + 1, &atval[1]);
     put_le16(UUID_NOTIFY, &atval[3]);
     attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, 
ATT_NOT_PERMITTED, atval, 5);

     /* Notification value */
     bt_uuid16_create(&uuid, UUID_NOTIFY);
     ekey_valid_handle = h;
     atval[0] = 0x00;
     attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, 
ATT_NOT_PERMITTED, atval, 1);

     /* Notification Client Characteristic Config (CCC) */
     bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
     atval[0] = 0x00;
     attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NONE, 
atval, 1);

I am connecting to the GATT server using the gatttool on another Linux 
system.

	[CON][00:02:72:C9:5E:0F][LE]> char-desc 0x18
	handle: 0x0018, uuid: 2803
	handle: 0x0019, uuid: f005
	handle: 0x001a, uuid: 2902
	[CON][00:02:72:C9:5E:0F][LE]> char-read-hnd 0x1a
	Characteristic value/descriptor: 00 01
	[CON][00:02:72:C9:5E:0F][LE]> char-read-hnd 0x19
	Characteristic value/descriptor: 00

Should the CCC init to 0x01? That doesn't make sense to me. Wouldn't 
that indicate the client was already setup for notifications?

I have an application that communicates with bluetoothd over TCP 
sockets. So when I send bluetoothd a command it will forward it, my 
application will process it, and respond to bluetoothd which will then 
update the Notification characteristic value depending on the 
success/failure of processing. I then need to notify the client of the 
change so it can reread the value to see if the command was successful.

	[CON][00:02:72:C9:5E:0F][LE]> char-write-cmd 0x000b 0x1234567890
	[CON][00:02:72:C9:5E:0F][LE]> char-read-hnd 0x19
	Characteristic value/descriptor: ff

The update of the characteristic value worked fine. But I am using btmon 
to monitor traffic between the two devices and I see no messages going 
out from the server to the client.


Thanks,
Nate
