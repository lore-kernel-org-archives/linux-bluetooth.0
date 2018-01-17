Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH BlueZ v2 1/2] obexd: Emit file information for client
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <20a39652-482a-9fde-6d44-0a8147f156fe@jp.fujitsu.com>
 <CABBYNZ+QaVYh-B08ixqHi=WxZDhj1bshBLgkJOO2NzKEbVuvKA@mail.gmail.com>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <110905d3-6883-315a-3a18-3e32a249d5c7@jp.fujitsu.com>
Date: Wed, 17 Jan 2018 16:37:04 +0900
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+QaVYh-B08ixqHi=WxZDhj1bshBLgkJOO2NzKEbVuvKA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>> And the info command only prints out the Session/Status/Size/Transferred
>> properties and does not print out the others as below:
>>
>>   # info /org/bluez/obex/server/session1/transfer0
>>   Transfer /org/bluez/obex/server/session1/transfer0
>>           Session: /org/bluez/obex/server/session1
>>           Status: active
>>           Size: 18446744073709551614
>>           Transferred: 262010
>>   [CHG] Transfer /org/bluez/obex/server/session1/transfer0 Transferred: 294771 (@32KB/s 428259:52)
> 
> I think the idea was to omit the Size in case the header has not been
> read, or is not available, though perhaps that needs fixing in both
> obexd really omit if the size is 0 and perhaps disable progress if the
> size is unknown. The documentation already indicates Size is optional
> but the implementation does not add a exists callback, but Im not sure
> why that would appear as the value above instead of 0.

It seems that the value is OBJECT_SIZE_DELETE (-2). When I tentatively
removed OBJECT_SIZE_DELETE at obex_session_start(), the info command
printed out 0 as the Size property. So I think that obexd may emit the
Size property after starting a session and before getting a file size.
I will try to dig this behavior.


Regards,
Eramoto

