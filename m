Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <54BD2EBC.7040207@esd-dev.be>
References: <54BD2EBC.7040207@esd-dev.be>
Date: Tue, 20 Jan 2015 11:30:25 +0200
Message-ID: <CABBYNZLeCn1UypeiJ3p8PEZQffeHcpcjz5QDPzURMx4XCy2Dfw@mail.gmail.com>
Subject: Re: Notify problem in gatt plugin
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?UTF-8?Q?Mathieu_Oca=C3=B1a?= <mo@esd-dev.be>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mathieu,

On Mon, Jan 19, 2015 at 6:20 PM, Mathieu Ocaña <mo@esd-dev.be> wrote:
> Hello,
>
> I'm currently working on a plugin to implement a GATT peripheral. Based on
> the plugins/gatt-example and the profiles/alert/server, I finally got
> something which works: read, write, with dbus signaling.
> But, notifications doesn't work...
> All seems ok until the call to "g_attrib_send()".
>
>>> static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
>>> {
>>>   [...]
>>>   len = enc_notification(p_adapter->batterylevel_chr.level_hnd_value,
>>>                     nd->value, nd->len, pdu, len);
>>>   [...]
>>>   ret = g_attrib_send(attrib, 0, pdu, len, destroy_notify_callback,
>>> cb, NULL);
>>>   return;
>>> }
>
>
> The parameters passed to g_attrib_send seems valid, I have verified the pdu,
> len and user_data, but I'm not sure to understand well all the fields of
> "attrib" (struct _GAttrib). Moreover the return value is 0.
>
> Some extra details:
> - the destroy_notify_callback is not called (maybe normal as the
> notification is not succesfully sent).
> - in g_attrib_send, the call to bt_att_send() return 0. After this point my
> understanding of the source code became a little bit fuzzy.

You might not be connected then so perhaps there is a bug in attio
callback. Which version are you using?

>> It would be great if someone could suggest me a fix or a workaround.
>
> I have also developped some extensions for the function gatt_service_add(),
> such as the support of static value characteristic, and the descriptors for
> presentation format, valid range and user description.
>> Before submitting this patch, I want to know which is the patch policy for
>> the bluez project? (validation test to perform, etc.).

It is documented in Submitting patches section in the HACKING:
https://git.kernel.org/cgit/bluetooth/bluez.git/tree/HACKING


-- 
Luiz Augusto von Dentz
