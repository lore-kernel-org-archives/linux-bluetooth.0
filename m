Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <E4DA9AB828784E8E9041A5CF3C361A19@boyiliaoPC>
From: <boyiliao@yahoo.com.tw>
To: <linux-bluetooth@vger.kernel.org>
References: <58FD7F101A2B4D9AB24C5AB9404F6923@boyiliaoPC>
In-Reply-To: <58FD7F101A2B4D9AB24C5AB9404F6923@boyiliaoPC>
Subject: Re: bluetoothd crashes when connecting to XiaoMi RC
Date: Sun, 22 Nov 2015 08:49:11 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="big5";
	reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

The below is my workaroung right new, but in "g_attrib_ref" function should 
be another way to fix this crash.

guint gatt_read_char(GAttrib *attrib, uint16_t handle, GAttribResultFunc 
func,
                            gpointer user_data)
{
    uint8_t *buf;
    size_t buflen;
    guint16 plen;
    guint id;
    struct read_long_data *long_read;

    long_read = g_try_new0(struct read_long_data, 1);

    if (long_read == NULL)
        return 0;
        printf("call from here %d\n",__LINE__);
    long_read->attrib = g_attrib_ref(attrib);
+        if(long_read->attrib == NULL)
+            return 0;
    long_read->func = func;




GAttrib *g_attrib_ref(GAttrib *attrib)
{
    if (!attrib)
        return NULL;

+        if(attrib->ref_count > 30)
+       {
+            return NULL;
+        }
    __sync_fetch_and_add(&attrib->ref_count, 1);

    DBG("%p: g_attrib_ref=%d ", attrib, attrib->ref_count);

    return attrib;
}

BR,
Patirck

-----­ì©l¶l¥ó----- 
From: boyiliao@yahoo.com.tw
Sent: Sunday, November 22, 2015 8:21 AM
To: linux-bluetooth@vger.kernel.org ; Majordomo@vger.kernel.org
Subject: bluetoothd crashes when connecting to XiaoMi RC

Hi,

I am using bluez 5.35 on Raspberry pi (kernel 4.1.6).

I try to using XiaoMi BLE remote control on Raspberry pi , I found when
gatt.c gatt_read_char() function call gattrib.c g_attrib_ref () will cause
bluetoothd crashed, because I think it acess a wrong address
"attrib/gattrib.c:g_attrib_ref() 0x1c9210: g_attrib_ref=808464433"

the attachment is the bluetoothd log


BR,
Patrick 

