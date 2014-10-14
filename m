Return-Path: <cyrus@holtmann.org>
Message-ID: <543D5645.7090403@mlsw.biz>
Date: Tue, 14 Oct 2014 12:58:45 -0400
From: Nathan Jozwiak <njozwiak@mlsw.biz>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: GATT Notification not sending
References: <543D474D.1040700@mlsw.biz>
In-Reply-To: <543D474D.1040700@mlsw.biz>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Update: I downloaded the LightBlue app from the Apple Store. The app 
allows you to connect to a GATT server and select available services to 
interact with. My notification characteristic showed up properly with an 
initial value of 0x00 and a CCC value of 0. But when attempted to 
register with the notification I saw this error from my bluetoothd output:

bluetoothd[8754]: Refusing storage path for private addressed device 
/org/bluez/hci0/dev_59_F2_63_47_1D_90
bluetoothd[8754]: Unable to get ccc storage path for device
bluetoothd[8754]: attrib/gattrib.c:g_attrib_ref() 0xa073bd8: ref=3
bluetoothd[8754]: attrib/gattrib.c:g_attrib_unref() 0xa073bd8: ref=2

Unfortunately, I do not know the command LightBlue was sending to set 
the CCC, but I figured this might be a clue for someone.

Am I not properly setting up the notification characteristic? I followed 
the same logic as the power level characteristic setup in 
profiles/proximity/reporter.c register_tx_power().

Thanks
Nate

On 10/14/14 11:54 AM, Nathan Jozwiak wrote:
> Hi all,
>
> I'm trying to send a notification to a client when a characteristic
> value is updated by the server.
>
> Here is the characteristics creation in the GATT server:
>
>      /* Notification characteristic */
>      bt_uuid16_create(&uuid, GATT_CHARAC_UUID);
>      atval[0] = GATT_CHR_PROP_READ | GATT_CHR_PROP_NOTIFY;
>      put_le16(h + 1, &atval[1]);
>      put_le16(UUID_NOTIFY, &atval[3]);
>      attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE,
> ATT_NOT_PERMITTED, atval, 5);
>
>      /* Notification value */
>      bt_uuid16_create(&uuid, UUID_NOTIFY);
>      ekey_valid_handle = h;
>      atval[0] = 0x00;
>      attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE,
> ATT_NOT_PERMITTED, atval, 1);
>
>      /* Notification Client Characteristic Config (CCC) */
>      bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
>      atval[0] = 0x00;
>      attrib_db_add(adapter->adapter, h++, &uuid, ATT_NONE, ATT_NONE,
> atval, 1);
>
> I am connecting to the GATT server using the gatttool on another Linux
> system.
>
>      [CON][00:02:72:C9:5E:0F][LE]> char-desc 0x18
>      handle: 0x0018, uuid: 2803
>      handle: 0x0019, uuid: f005
>      handle: 0x001a, uuid: 2902
>      [CON][00:02:72:C9:5E:0F][LE]> char-read-hnd 0x1a
>      Characteristic value/descriptor: 00 01
>      [CON][00:02:72:C9:5E:0F][LE]> char-read-hnd 0x19
>      Characteristic value/descriptor: 00
>
> Should the CCC init to 0x01? That doesn't make sense to me. Wouldn't
> that indicate the client was already setup for notifications?
>
> I have an application that communicates with bluetoothd over TCP
> sockets. So when I send bluetoothd a command it will forward it, my
> application will process it, and respond to bluetoothd which will then
> update the Notification characteristic value depending on the
> success/failure of processing. I then need to notify the client of the
> change so it can reread the value to see if the command was successful.
>
>      [CON][00:02:72:C9:5E:0F][LE]> char-write-cmd 0x000b 0x1234567890
>      [CON][00:02:72:C9:5E:0F][LE]> char-read-hnd 0x19
>      Characteristic value/descriptor: ff
>
> The update of the characteristic value worked fine. But I am using btmon
> to monitor traffic between the two devices and I see no messages going
> out from the server to the client.
>
>
> Thanks,
> Nate
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Nathan Jozwiak
MapleLeaf Software, Inc.
858-598-4814
