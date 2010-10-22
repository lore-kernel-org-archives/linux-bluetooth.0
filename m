Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20101022131207.GA29655@jh-x301>
References: <1287743558-17002-1-git-send-email-ext-tommi.keisala@nokia.com>
	<1287743558-17002-2-git-send-email-ext-tommi.keisala@nokia.com>
	<20101022131207.GA29655@jh-x301>
Date: Fri, 22 Oct 2010 23:25:05 +0300
Message-ID: <AANLkTimwz0wYbiQpkPmJuNpmJxNxaAQ2UtudPqinh9kP@mail.gmail.com>
Subject: Re: [PATCH] Fix crash when GetProperties req is received before any
 adapters are set up
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: ext-tommi.keisala@nokia.comt, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Oct 22, 2010 at 4:12 PM, Johan Hedberg <johan.hedberg@nokia.com> wrote:
> Hi Tommi,
>
> On Fri, Oct 22, 2010, ext-tommi.keisala@nokia.com wrote:
>> This patch avoids a crash when org.bluez.Manager GetProperties request is
>> received and there is not yet any adapters ready. Happens often for example
>> when bluetoothd and ofonod is started next ot each other.
>>
>> Signed-off-by: Tommi Keisala <ext-tommi.keisala@nokia.com>
>> ---
>>  src/manager.c |    6 +++++-
>>  1 files changed, 5 insertions(+), 1 deletions(-)
>
> Looks like a bugfix is definitely in order here, but why introduce a new
> variable to the function? Wouldn't something like the folling be good
> enough:
>
> --- a/src/manager.c
> +++ b/src/manager.c
> @@ -197,13 +197,14 @@ static DBusMessage *get_properties(DBusConnection *conn,
>                        DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
>
>        array = g_new0(char *, g_slist_length(adapters) + 1);
> -       for (i = 0, list = adapters; list; list = list->next, i++) {
> +       for (i = 0, list = adapters; list; list = list->next) {
>                struct btd_adapter *adapter = list->data;
>
>                if (!adapter_is_ready(adapter))
>                        continue;
>
>                array[i] = (char *) adapter_get_path(adapter);
> +               i++;
>        }
>        dict_append_array(&dict, "Adapters", DBUS_TYPE_OBJECT_PATH, &array, i);
>        g_free(array);
>
> Could you send a new patch which doesn't introduce a new variable? Also,
> please leave out the signed-off-by from the commit message since it's
> not used for userspace bluez patches. Thanks.

Maybe we should also add a check here to omit adapters if we don't
have at least one to append, it should be fine to have empty
containers but I don't think this is very useful for the application
since they have to iterate in the container to find out there is in
fact nothing there.


-- 
Luiz Augusto von Dentz
Computer Engineer
