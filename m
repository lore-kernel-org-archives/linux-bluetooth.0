Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F0070FBC0FB3174D8D11444EB2D5B026FF36@DNCE02.ent.ti.com>
References: <1320417003-23493-1-git-send-email-anderson.lizardo@openbossa.org>
	<1320417003-23493-5-git-send-email-anderson.lizardo@openbossa.org>
	<F0070FBC0FB3174D8D11444EB2D5B026FF36@DNCE02.ent.ti.com>
Date: Mon, 14 Nov 2011 15:20:47 -0400
Message-ID: <CAJdJm_P_ax1EOKkL7+M-z16U+6o7oNx26irvs1-7w_UuGuA3vQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 4/4] Migrate example service to high level GATT API
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: "Ganir, Chen" <chen.ganir@ti.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

Sorry for the late response. Somehow I had this message as "read" on
my inbox, even though I never read it. Oh well...

On Sun, Nov 6, 2011 at 3:26 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
>> +static uint8_t battery_state_read(struct attribute *a, gpointer
>> [...]
>> +     uint8_t value;
>>
>> [...]
>> +     value = 0x04;
>> +     attrib_db_update(a->handle, NULL, &value, sizeof(value), NULL);
>>
> Why do we need to update the db here ? will the server hold the value until we return from this callback, and only then send the saved value to the client? Do we have a timeout for user reply?

As explained on the cover letter, this server API does not support
"static" attributes yet. So the lines above implement a read callback
for this attribute, which has the fixed value of 0x04 (as the original
upstream code).

This server API does not have anything related to connections, it just
updates the attribute database as necessary. The read/write callbacks
are called when actual ATT read/writes are attempted. Also note the
read/write callback implementations must not block (because they are
synchronous with the ATT connection). If you need to do something
which takes long time after read/write, you should schedule it using
e.g. g_idle_add().

If a server needs access to the connection state, it should do so by
using the default adapter (plus the connection callbacks API).
Unfortunately, this is a limitation on the current underlying
attribute API (not this high level layer). We do not support multiple
adapters on the same host yet.

>> +     return 0;
> What do the return code from the callback mean ? 0 = Read success/allow, other return value = read disallowed?

The return value for read/write callbacks is the ATT error opcode. A
"zero" return value means no error PDU should be sent. Of course, this
does not apply to Write Command, for which the return value is
ignored.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
