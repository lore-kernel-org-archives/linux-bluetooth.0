Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZJ6=vNfTHD+ZpXxep-iOoVZoQ-3ONvPYCXWkB93zrsq+w@mail.gmail.com>
References: <1337688756-1938-1-git-send-email-mikel.astiz.oss@gmail.com>
 <CAMOw1v5dXaujizhJKL_putC33oFZEnfE4AjKZ0gfQL=jmmJB2Q@mail.gmail.com> <CABBYNZJ6=vNfTHD+ZpXxep-iOoVZoQ-3ONvPYCXWkB93zrsq+w@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Tue, 22 May 2012 09:52:30 -0300
Message-ID: <CAMOw1v4K7Brx0MKU04Og-hS5=Mwxh_hsKdJMYZJ2fQ=jTTvB4A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v0] gdbus: Fix incorrectly discarded signals
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Mikel Astiz <mikel.astiz.oss@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, May 22, 2012 at 9:28 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Mikel, Lucas,
>
> On Tue, May 22, 2012 at 3:21 PM, Lucas De Marchi
> <lucas.demarchi@profusion.mobi> wrote:
>>> diff --git a/gdbus/object.c b/gdbus/object.c
>>> index 2dd7c0e..c33df57 100644
>>> --- a/gdbus/object.c
>>> +++ b/gdbus/object.c
>>> @@ -616,7 +616,7 @@ static gboolean check_signal(DBusConnection *conn, const char *path,
>>>                }
>>>        }
>>>
>>> -       if (*args == NULL) {
>>> +       if (!signal || !signal->name) {
>>>                error("No signal named %s on interface %s", name, interface);
>>>                return FALSE;
>>>        }
>>
>>
>> Ack.
>>
>
> Any reason why the code does not return TRUE within the for loop? I
> think it would have been simpler that way.

Indeed, it would be much better. Mikel, could you change this?

Thanks
Lucas De Marchi
