Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAPGrrxWm=gfcdr6bCVneQFJiGsrajKqojZ-iES28=isitC1jiw@mail.gmail.com>
References: <CAPGrrxXkvaNjnUT9vJ8sdnHuabF7zwtWnOnnbLD1+G0huvj1xw@mail.gmail.com>
	<ca9f11c3ddb562558c25a7ff185407ad@mail.hendrik-sattler.de>
	<CAPGrrxWm=gfcdr6bCVneQFJiGsrajKqojZ-iES28=isitC1jiw@mail.gmail.com>
Date: Thu, 3 Nov 2011 17:13:11 +0200
Message-ID: <CABBYNZ+bqrdJwvOH3Uznbc54TaF=4c=VFBZ4ZG9_9aYOc2e=9w@mail.gmail.com>
Subject: Re: [RFC] API for MAP client in obex-client
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: Hendrik Sattler <post@hendrik-sattler.de>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Thu, Nov 3, 2011 at 4:16 PM, Bartosz Szatkowski <bulislaw@linux.com> wrote:
> On Thu, Nov 3, 2011 at 3:08 PM, Hendrik Sattler <post@hendrik-sattler.de> wrote:
>> Am 03.11.2011 14:44, schrieb Bartosz Szatkowski:
>>>
>>>               void SetFolder(boolean cdup, string name)
>>>
>>>                       Set working directory for current session.
>>>
>>>                       |  cdup  | folder name | operation    |
>>>                       |=====================================|
>>>                       | FALSE  | empty       | cd /         |
>>>                       |--------+-------------+--------------|
>>>                       | FALSE  | name        | cd name      |
>>>                       |--------+-------------+--------------|
>>>                       | TRUE   | [name]      | cd ..[/name] |
>>>                       +-------------------------------------+
>>
>> Why not simply
>>  void SetFolder(String cdString)
>>
>> and derive the obex command from that? It makes that API much easier to use.
>>
>> HS
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> Because it provoke more questions eg. what about failure in the middle
> of the path? Also i've planned to keep it at rather low level.

Well we can make it only accept only one step at time, which it seems
is what g_obex_setpath does. Btw what is thing with GetMessage return,
fd? Do we really need that? Can't we just convert to string so that
user applications don't have to convert it themselves? Otherwise just
use an array of bytes ('ay') or pass a path where the message should
be stored like GetFile. If the concern is that the transfer may take
too long the client the client should not wait the reply and instead
track the transfer using an agent.

-- 
Luiz Augusto von Dentz
