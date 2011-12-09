Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111209132206.GA31478@x220>
References: <1323349678-17905-1-git-send-email-bulislaw@linux.com>
	<1323349678-17905-3-git-send-email-bulislaw@linux.com>
	<20111209132206.GA31478@x220>
Date: Fri, 9 Dec 2011 14:58:08 +0100
Message-ID: <CAPGrrxU+DhEtjXt_wzkdV9q2Wycz3j4=48vxis0KZruFBATomA@mail.gmail.com>
Subject: Re: [PATCH obexd 3/6] Add support for SetFolder in MAP client
From: Bartosz Szatkowski <bulislaw@linux.com>
To: Bartosz Szatkowski <bulislaw@linux.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Dec 9, 2011 at 2:22 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Bartosz,
>
> On Thu, Dec 08, 2011, Bartosz Szatkowski wrote:
>> ---
>>  client/map.c       |   56 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  doc/client-api.txt |    5 +++-
>>  2 files changed, 60 insertions(+), 1 deletions(-)
>
> The first two patches have been applied, but this had issues:
>
>> +#define ERROR_INF MAP_INTERFACE ".Error"
>> +#define ERROR_FAILED_PATH "org.openobex.Error.Failed"
>
> First of all, this is not a path or an interface. It's the error name.
> Secondly, do you really need these defines since in some places you
> spell out the name inline in others you use a define. E.g. here it's
> inline:
>
>> +     else if (err_code != G_OBEX_RSP_SUCCESS)
>> +             reply = g_dbus_create_error(map->msg,
>> +                                             "org.openobex.Error.Response",
>> +                                             "%s (0x%02x)",
>> +                                             g_obex_strerror(err_code),
>> +                                             err_code);
>
> So please be consistent. Also think about whether we need MAP specific
> errors at all or if we can just use generic ones for the entire client
> (and maybe server too).

Ok, so for keeping things consistent with most common style in client
code, I'll go with inlined "org.openobex.Error.*"

-- 
Pozdrowienia - Cheers,
Bartosz Szatkowski
