Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTimDY-b6uRr68WWbzuLw_4mP0Sp+Hg@mail.gmail.com>
References: <1306338000-7905-1-git-send-email-luiz.dentz@gmail.com>
	<1306338000-7905-3-git-send-email-luiz.dentz@gmail.com>
	<BANLkTimDY-b6uRr68WWbzuLw_4mP0Sp+Hg@mail.gmail.com>
Date: Wed, 25 May 2011 22:45:46 +0300
Message-ID: <BANLkTinBfZQ6jfngOBDDVJSDDyJCwsJ-yg@mail.gmail.com>
Subject: Re: [PATCH 3/3] Improve usage documentation for some options
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, May 25, 2011 at 8:17 PM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi Luiz,
>
> On Wed, May 25, 2011 at 11:40 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> ---
>>  src/main.c |    8 ++++++--
>>  1 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/main.c b/src/main.c
>> index e1ce442..5b30f07 100644
>> --- a/src/main.c
>> +++ b/src/main.c
>> @@ -100,13 +100,17 @@ static GOptionEntry options[] = {
>>                                G_OPTION_ARG_CALLBACK, parse_debug,
>>                                "Enable debug information output", "DEBUG" },
>>        { "root", 'r', 0, G_OPTION_ARG_STRING, &option_root,
>> -                               "Specify root folder location", "PATH" },
>> +                               "Specify root folder location. Both absolute"
>> +                               "and relative can be use, but relative paths"
>> +                               "are assume to be relative to user $HOME"
>> +                               "folder", "PATH" },
>
> IIRC, you should add the spaces to the string if you want them on the
> printed string, otherwise you will see:
>
> absoluteand
> pathsare
> etc.

It sure does need the extra spaces, gonna fix them, thanks.

>>        { "root-setup", 'S', 0, G_OPTION_ARG_STRING, &option_root_setup,
>>                                "Root folder setup script", "SCRIPT" },
>>        { "symlinks", 'l', 0, G_OPTION_ARG_NONE, &option_symlinks,
>>                                "Enable symlinks on root folder" },
>>        { "capability", 'c', 0, G_OPTION_ARG_STRING, &option_capability,
>> -                               "Specify capability file", "FILE" },
>> +                               "Specify capability file, use '!' mark for"
>> +                               "scripts", "FILE" },
>
> Same here.
>
> Regards,
> --
> Anderson Lizardo
> Instituto Nokia de Tecnologia - INdT
> Manaus - Brazil
>



-- 
Luiz Augusto von Dentz
Computer Engineer
