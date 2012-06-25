Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKdZnJ+-ywYVnPA-=BvS70qcM0G-N2-NUnRCYVhD-UwJQ@mail.gmail.com>
References: <CABBYNZ+oS3tGhYVY01uE6gfuzmA94TqV3YybgHdG83pCMzW8vA@mail.gmail.com>
 <1340639082-10347-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1340639082-10347-3-git-send-email-lucas.demarchi@profusion.mobi> <CABBYNZKdZnJ+-ywYVnPA-=BvS70qcM0G-N2-NUnRCYVhD-UwJQ@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Mon, 25 Jun 2012 12:56:21 -0300
Message-ID: <CAMOw1v4rCOt4_nn8kQU5wdksHFfwrURy2kbs-Z_xZaKnRbryiw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/3] maemo6: mce: Fix listening for signals
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Jun 25, 2012 at 12:55 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Lucas,
>
> On Mon, Jun 25, 2012 at 6:44 PM, Lucas De Marchi
> <lucas.demarchi@profusion.mobi> wrote:
>> We should listen for signals only on MCE bus name.
>> ---
>>  plugins/maemo6.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/plugins/maemo6.c b/plugins/maemo6.c
>> index 4819af4..a8c9bed 100644
>> --- a/plugins/maemo6.c
>> +++ b/plugins/maemo6.c
>> @@ -224,12 +224,13 @@ static int mce_probe(struct btd_adapter *adapter)
>>
>>        DBG("path %s", adapter_get_path(adapter));
>>
>> -       watch_id = g_dbus_add_signal_watch(conn, NULL, MCE_SIGNAL_PATH,
>> +       watch_id = g_dbus_add_signal_watch(conn, MCE_SERVICE, MCE_SIGNAL_PATH,
>>                                        MCE_SIGNAL_IF, MCE_RADIO_STATES_SIG,
>>                                        mce_signal_callback, adapter, NULL);
>>
>> -       tklock_watch_id = g_dbus_add_signal_watch(conn, NULL, MCE_SIGNAL_PATH,
>> -                                       MCE_SIGNAL_IF, MCE_TKLOCK_MODE_SIG,
>> +       tklock_watch_id = g_dbus_add_signal_watch(conn, MCE_SERVICE,
>> +                                       MCE_SIGNAL_PATH, MCE_SIGNAL_IF,
>> +                                       MCE_TKLOCK_MODE_SIG,
>>                                        mce_tklock_mode_cb, adapter, NULL);
>>
>>        btd_adapter_register_powered_callback(adapter, adapter_powered);
>> --
>> 1.7.11
>
> Don't bother with telephony drivers, they are about to be removed.

I only fixed all possible users in bluez. It's ok to just ignore this patch.


Lucas De Marchi
