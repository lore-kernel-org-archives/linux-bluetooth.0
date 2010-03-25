Return-Path: <cyrus@holtmann.org>
Message-ID: <4BAB8BB0.4080405@gmail.com>
Date: Thu, 25 Mar 2010 17:13:36 +0100
From: sancane <sancane@gmail.com>
MIME-Version: 1.0
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Problems with bt_io_listen
References: <201003251545.52988.jcaden@libresoft.es> <2d5a2c101003250822g34187992m8509e17e825f50c8@mail.gmail.com>
In-Reply-To: <2d5a2c101003250822g34187992m8509e17e825f50c8@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
To: unlisted-recipients:; (no To-header on input)
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

> Hi,
> 
> On Thu, Mar 25, 2010 at 4:45 PM, José Antonio Santos Cadenas
> <jcaden@libresoft.es> wrote:
>> Hi all,
>>
>> We are developing an implementation of HDP and MCAP for bluez. We are triying
>> to perform many connections between two devices but when we make the second
>> connection it is not created correctly.
>>
>> We are using a defer connection (we passed a confirm callback to the
>> bt_io_listen function) and we think that we are missing something but  we
>> can't find what. If we used the connection callback (not defer) all the
>> connections are done successfully.
>>
>> We are listening with the following code:
>>
>> static void confirm_cb(GIOChannel *chan, gpointer user_data)
>> {
>>        ...
>>        node->chan = g_io_channel_ref(chan);
>>        ...
>>        /* All is ok */
>>        return;
>> drop:
>>        /* Connection refused */
>>        g_io_channel_shutdown(chan, TRUE, NULL);
>> }
> 
> Im not really sure what is the problem but maybe it is the missing
> bt_io_accept, but of course it can be that you just hide it in those
> ...

You're rigth, we forgot the bt_io_accept call.

> 
>> ....
>> chan = bt_io_listen(BT_IO_L2CAP, NULL, confirm_cb, NULL,
>>                                NULL, &gerr,
>>                                BT_IO_OPT_SOURCE_BDADDR, &src,
>>                                BT_IO_OPT_PSM, 0x1001,
>>                                BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
>>                                BT_IO_OPT_INVALID);
>> ...
> 
> The listen part at least seems ok.
> 
> 
Thanks.
