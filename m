Return-Path: <cyrus@holtmann.org>
Message-id: <A94F3F1039284ED7AB00B9BC928893CD@sisodomain.com>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
References: <1362402872-13080-1-git-send-email-jaganath.k@samsung.com>
 <1362402872-13080-2-git-send-email-jaganath.k@samsung.com>
 <CAJdJm_P8unpbmR6Y1dzmkmXErrP6cLwaX8wza_6f+EPB5rr=CA@mail.gmail.com>
In-reply-to: <CAJdJm_P8unpbmR6Y1dzmkmXErrP6cLwaX8wza_6f+EPB5rr=CA@mail.gmail.com>
Subject: Re: [PATCH 2/3] attrib: Fix use after free of attrib
Date: Mon, 04 Mar 2013 19:50:24 +0530
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

--------------------------------------------------
From: "Anderson Lizardo" <anderson.lizardo@openbossa.org>
Sent: Monday, March 04, 2013 7:14 PM
To: "Jaganath Kanakkassery" <jaganath.k@samsung.com>
Cc: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 2/3] attrib: Fix use after free of attrib

> Hi Jaganath,
>
> On Mon, Mar 4, 2013 at 9:14 AM, Jaganath Kanakkassery
> <jaganath.k@samsung.com> wrote:
>> If attrib is freed in cmd->func(), then it will be used if either
>> request or response queue has some data to send.
>
> As far as I know, attrib was not supposed to be freed on the
> cmd->func() callback. Do you have an example/testcase where this is
> happening? To me, looks like a refcount issue (i.e. g_attrib_unref()
> is deleting the attrib because a reference was not properly kept where
> necessary).
>

I got this issue in BlueZ 4.101 when I called "DiscoverCharacteristics".
"GetProperty" and "SetProperty" of characteristics. Please see the logs

daemon.debug bluetoothd[4567]: src/adapter.c:adapter_get_device() 
E8:E8:66:E0:C0:01
daemon.debug bluetoothd[4567]: attrib/gattrib.c:g_attrib_ref() 0xb6f47808: 
ref=1
daemon.debug bluetoothd[4567]: attrib/gattrib.c:g_attrib_ref() 0xb6f47808: 
ref=2
daemon.debug bluetoothd[4567]: src/device.c:btd_device_ref() 0xb6f47268: 
ref=9
daemon.debug bluetoothd[4567]: attrib/gattrib.c:g_attrib_ref() 0xb6f47808: 
ref=3
daemon.debug bluetoothd[4567]: attrib/gattrib.c:g_attrib_ref() 0xb6f47808: 
ref=4
daemon.debug bluetoothd[4567]: attrib/gattrib.c:g_attrib_ref() 0xb6f47808: 
ref=5
daemon.debug bluetoothd[4567]: attrib/gattrib.c:g_attrib_unref() 0xb6f47808: 
ref=4
daemon.debug bluetoothd[4567]: attrib/client.c:register_characteristic() 
Registered: 
/org/bluez/4567/hci0/dev_E8_E8_66_E0_C0_01/service0012/characteristic0014
daemon.debug bluetoothd[4567]: attrib/gattrib.c:g_attrib_ref() 0xb6f47808: 
ref=5
daemon.debug bluetoothd[4567]: attrib/gattrib.c:g_attrib_unref() 0xb6f47808: 
ref=4
daemon.debug bluetoothd[4567]: attrib/gattrib.c:g_attrib_unref() 0xb6f47808: 
ref=3
daemon.debug bluetoothd[4567]: gdbus/object.c:generic_message() /: 
org.bluez.Manager.DefaultAdapter()
daemon.debug bluetoothd[4567]: gdbus/object.c:generic_message() 
/org/bluez/4567/hci0/dev_E8_E8_66_E0_C0_01/service0012/characteristic0014: 
org.bluez.Characteristic.GetProperties()
daemon.debug bluetoothd[4567]: gdbus/object.c:generic_message() /: 
org.bluez.Manager.DefaultAdapter()
daemon.debug bluetoothd[4567]: gdbus/object.c:generic_message() 
/org/bluez/4567/hci0/dev_E8_E8_66_E0_C0_01/service0012/characteristic0014: 
org.bluez.Characteristic.SetProperty()
daemon.debug bluetoothd[4567]: attrib/gattrib.c:g_attrib_ref() 0xb6f47808: 
ref=4
daemon.debug bluetoothd[4567]: attrib/gattrib.c:g_attrib_unref() 0xb6f47808: 
ref=3
daemon.debug bluetoothd[4567]: src/device.c:btd_device_unref() 0xb6f47268: 
ref=8
daemon.debug bluetoothd[4567]: attrib/gattrib.c:g_attrib_unref() 0xb6f47808: 
ref=2
daemon.debug bluetoothd[4567]: attrib/gattrib.c:g_attrib_unref() 0xb6f47808: 
ref=1
daemon.debug bluetoothd[4567]: attrib/gattrib.c:g_attrib_unref() 0xb6f47808: 
ref=0
daemon.debug bluetoothd[4567]: attrib/gattrib.c:g_attrib_ref() 0xb6f47808: 
ref=1
daemon.err bluetoothd[4567]: crashed [1357010043] processname=bluetoothd, 
pid=4567, tid=4567, signal=11

I did not give this log in commit since it is based on 4.101

What I understood is cmd->func() is doing g_attrib_unref() which frees the 
attrib
during last unref. Then since data is there in queue it tries to ref in 
wake_up_sender().

Thanks,
Jaganath 

