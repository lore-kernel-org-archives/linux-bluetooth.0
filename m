Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAJdJm_OqOs4-U4E+nN9VQ362F0aWe+qJnyxWVF_ABscwQE+5wA@mail.gmail.com>
References: <1350486869-5020-1-git-send-email-lucas.demarchi@profusion.mobi>
 <1350486869-5020-2-git-send-email-lucas.demarchi@profusion.mobi>
 <CAJdJm_OoM=Ku7pESgqvXEOJO3jB21bdGHfA368uiTnfoxb=bJw@mail.gmail.com> <CAJdJm_OqOs4-U4E+nN9VQ362F0aWe+qJnyxWVF_ABscwQE+5wA@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Wed, 17 Oct 2012 15:33:49 -0300
Message-ID: <CAMOw1v6_p74Jznoqi-jeLOHEhmQbfsnyaoAr-p-75qsBWCo-jQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] core: Update gdbus function calls
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Oct 17, 2012 at 1:25 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi again,
>
> On Wed, Oct 17, 2012 at 1:20 PM, Anderson Lizardo
> <anderson.lizardo@openbossa.org> wrote:
>> Hi Lucas,
>>
>> On Wed, Oct 17, 2012 at 12:14 PM, Lucas De Marchi
>> <lucas.demarchi@profusion.mobi> wrote:
>>> @@ -827,24 +824,21 @@ static void set_name(struct btd_adapter *adapter, const char *name,
>>>         int ret;
>>>
>>>         if (adapter->allow_name_changes == FALSE)
>>> -               return g_dbus_pending_property_error(btd_get_dbus_connection(),
>>> -                                               id, ERROR_INTERFACE ".Failed",
>>> +               return g_dbus_pending_property_error(id,
>>> +                                               ERROR_INTERFACE ".Failed",
>>>                                                 strerror(EPERM));
>>>
>>>         ret = adapter_set_name(adapter, name);
>>> -       if (ret >= 0) {
>>> -               g_dbus_pending_property_success(btd_get_dbus_connection(), id);
>>> -               return;
>>> -       }
>>> +       if (ret >= 0)
>>> +               return g_dbus_pending_property_success(id);
>>
>> Out of curiosity, is this style of returning "void" (instead of just
>> "return;") common in gdbus?
>
> Just realized that this is BlueZ specific code. Anyway, just found it
> odd (but answering my question, seems to be common).

It may be common because I used it a lot in the first conversions :-).
I don't know about other places using it. In gdbus-related code it's
very convenient because the function usually returns void as well, so
we can shortcut it with the g_dbus_pending_property_* calls.


Lucas De Marchi
