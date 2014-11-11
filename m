Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+Pk2m_VBvqmV3C11=tNF2Oed8NY8id-1913Q-z3FWKrw@mail.gmail.com>
References: <1415639247-14320-1-git-send-email-armansito@chromium.org>
	<CABBYNZ+Pk2m_VBvqmV3C11=tNF2Oed8NY8id-1913Q-z3FWKrw@mail.gmail.com>
Date: Tue, 11 Nov 2014 13:23:14 -0800
Message-ID: <CAHrH25QpAHmgX+2NZQPf1ohUQgwX5UhUFWZkUfQ1VsG2zbAHsw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 00/11] shared/gatt-server: Implement ATT operations
From: Arman Uguray <armansito@chromium.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

> On Tue, Nov 11, 2014 at 3:52 AM, Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> Hi Arman,
>
> On Mon, Nov 10, 2014 at 7:07 PM, Arman Uguray <armansito@chromium.org> wrote:
>> This patch set implements the most important server-side ATT protocol
>> operations by interfacing with the new gatt-db API functions. All
>> requests except "Read Multiple" and "Signed Write Command" are provided
>> in this set.
>>
>> This patch set also doesn't address checks for encryption/authentication/
>> authorization permissions. A TODO item has been added to address this
>> later.
>>
>> *v1: Removed offsetof math while casting service pointer to (void *)
>> *v2: - Added TODO for using struct iovec
>>      - Removed bt_gatt_server_set_max_prep_queue_len
>>      - Always pass write_cb to gatt_db_attribute_write even if the opcode is
>>        "Write Command".
>>      - Added more util_debug lines in handler functions.
>>
>> Arman Uguray (11):
>>   shared/gatt-server: Implement "Read By Type" request.
>>   shared/gatt-server: Implement "Find Information" request.
>>   shared/gatt-server: Implement "Write" request and command.
>>   shared/gatt-server: Implement "Read" request.
>>   shared/gatt-server: Implement "Read Blob" request.
>>   shared/att: Handle incoming confirmation PDU.
>>   shared/gatt-server: Add functions for sending
>>     notifications/indications.
>>   shared/gatt-server: Implement "Prepare Write" request.
>>   shared/gatt-server: Implement "Execute Write" request.
>>   shared/gatt-client: Fix alignment warnings.
>>   TODO: Update shared/gatt-server items.
>>
>>  TODO                     |   26 +-
>>  src/shared/att.c         |  119 +++--
>>  src/shared/gatt-client.c |    6 +-
>>  src/shared/gatt-server.c | 1221 +++++++++++++++++++++++++++++++++++++++++++---
>>  src/shared/gatt-server.h |   12 +
>>  5 files changed, 1257 insertions(+), 127 deletions(-)
>>
>> --
>> 2.1.0.rc2.206.gedb03e5
>
> I went ahead and applied this set, I will probably send a patch in a
> moment adding a timeout for db read/write operations, I figure 1
> seconds should be enough to start with since LE is focus on low
> latency, if that doesn't cut it we should adjust the write queue
> according to how many operation it can deliver before it times out.
>

Sounds reasonable to me. I guess, since the ATT timeout is 30 seconds,
a queue length of 30 and operation timeout of 1 seem good for now,
even if not optimal for all cases. We can tweak this later as
necessary.

>
> --
> Luiz Augusto von Dentz

Cheers,
Arman
