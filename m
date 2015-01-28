Return-Path: <cyrus@holtmann.org>
Message-ID: <54C83C72.50607@esd-dev.be>
Date: Wed, 28 Jan 2015 02:33:38 +0100
From: =?UTF-8?B?TWF0aGlldSBPY2HDsWE=?= <mo@esd-dev.be>
MIME-Version: 1.0
To: "luiz.dentz@gmail.com >> Luiz Augusto von Dentz"
	<luiz.dentz@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Notify problem in gatt plugin - solved
References: <54BD2EBC.7040207@esd-dev.be> <CABBYNZLeCn1UypeiJ3p8PEZQffeHcpcjz5QDPzURMx4XCy2Dfw@mail.gmail.com> <54BEDA4E.30708@esd-dev.be>
In-Reply-To: <54BEDA4E.30708@esd-dev.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I have finally solved the problem.

For interested people, the notification mechanism showed in the 
alert-server (profiles/alert/server.c), which I used as starting point, 
is broken.

In src/shared/att.c:L306, a test condition prevents the sending of the 
data if a callback is defined but not needed (and it is the case for a 
notification).

So in my plugin source code, in attio_connected_cb(), by simply changing:
> ret = g_attrib_send(attrib, 0, pdu, len, destroy_notify_callback, cb, 
> NULL); 
to:
> ret = g_attrib_send(attrib, 0, pdu, len, NULL, NULL, NULL);
the notifications are now sent :)

Of course, the same change will fix the alert-server.

--
Mathieu OCAÑA


Le 20/01/2015 23:44, Mathieu Ocaña a écrit :
> Hi Luiz,
>
> Le 20/01/2015 10:30, Luiz Augusto von Dentz a écrit :
>> Hi Mathieu,
>>
>> On Mon, Jan 19, 2015 at 6:20 PM, Mathieu Ocaña <mo@esd-dev.be> wrote:
>>> Hello,
>>>
>>> I'm currently working on a plugin to implement a GATT peripheral. 
>>> Based on
>>> the plugins/gatt-example and the profiles/alert/server, I finally got
>>> something which works: read, write, with dbus signaling.
>>> But, notifications doesn't work...
>>> All seems ok until the call to "g_attrib_send()".
>>>
>>>>> static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
>>>>> {
>>>>>    [...]
>>>>>    len = 
>>>>> enc_notification(p_adapter->batterylevel_chr.level_hnd_value,
>>>>>                      nd->value, nd->len, pdu, len);
>>>>>    [...]
>>>>>    ret = g_attrib_send(attrib, 0, pdu, len, destroy_notify_callback,
>>>>> cb, NULL);
>>>>>    return;
>>>>> }
>>>
>>> The parameters passed to g_attrib_send seems valid, I have verified 
>>> the pdu,
>>> len and user_data, but I'm not sure to understand well all the 
>>> fields of
>>> "attrib" (struct _GAttrib). Moreover the return value is 0.
>>>
>>> Some extra details:
>>> - the destroy_notify_callback is not called (maybe normal as the
>>> notification is not succesfully sent).
>>> - in g_attrib_send, the call to bt_att_send() return 0. After this 
>>> point my
>>> understanding of the source code became a little bit fuzzy.
>> You might not be connected then so perhaps there is a bug in attio
>> callback. Which version are you using?
> I'm using the v5.27. I see no signs of disconnection in the debug 
> messages, but I will explore this lead.
> For now I use a Nordic dongle & software (master panel monitor) for my 
> tests and the connection seems ok (even if the notificatons are not 
> sent, the read/write operation are performed witout problem). But when 
> I use gatttool I'm disconnected constantly after 5-15s, (in this case 
> the debug log tells me it).
> I have not yet tested with a BT LE-enabled smartphone, but if I'm also 
> disconnected, maybe the two problems are related.
>
>>>> It would be great if someone could suggest me a fix or a workaround.
>>> I have also developped some extensions for the function 
>>> gatt_service_add(),
>>> such as the support of static value characteristic, and the 
>>> descriptors for
>>> presentation format, valid range and user description.
>>>> Before submitting this patch, I want to know which is the patch 
>>>> policy for
>>>> the bluez project? (validation test to perform, etc.).
>> It is documented in Submitting patches section in the HACKING:
>> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/HACKING
> Ok, I had totally forgotten this file. According to the coding 
> standards, I've some modifications to do.
> The answer is maybe obvious, but if I modify the behavior of the 
> function gatt_service_add(), I should also patch the profiles and 
> plugins which use it, accordingly?
>
> Thank for your answer,
>
> -- 
> Mathieu OCAÑA
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe 
> linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

