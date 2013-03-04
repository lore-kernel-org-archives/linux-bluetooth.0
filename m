Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BB160896-8882-459E-9698-D194ED36E2C2@holtmann.org>
References: <1362405510-8685-1-git-send-email-luiz.dentz@gmail.com>
	<1362405510-8685-3-git-send-email-luiz.dentz@gmail.com>
	<BB160896-8882-459E-9698-D194ED36E2C2@holtmann.org>
Date: Mon, 4 Mar 2013 22:15:28 +0200
Message-ID: <CABBYNZLXkS8gFhjX2gbcr4Hjcb_h3wn-hDWKzo6rFsBKmBiYDA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/4] core: Move plugin_init and plugin_cleanup to plugin.h
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Mar 4, 2013 at 8:50 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Luiz,
>
>> profiles/input/manager.c  | 2 ++
>> profiles/scanparam/scan.c | 2 ++
>> src/hcid.h                | 3 ---
>> src/main.c                | 1 +
>> src/plugin.h              | 2 ++
>> 5 files changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/profiles/input/manager.c b/profiles/input/manager.c
>> index 6ed12ee..e1e1057 100644
>> --- a/profiles/input/manager.c
>> +++ b/profiles/input/manager.c
>> @@ -32,6 +32,8 @@
>> #include <bluetooth/sdp.h>
>> #include <bluetooth/sdp_lib.h>
>>
>> +#include <glib.h>
>> +
>> #include "log.h"
>> #include "plugin.h"
>>
>> diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
>> index 268bdc8..8428816 100644
>> --- a/profiles/scanparam/scan.c
>> +++ b/profiles/scanparam/scan.c
>> @@ -31,6 +31,8 @@
>>
>> #include <bluetooth/bluetooth.h>
>>
>> +#include <glib.h>
>> +
>> #include "lib/uuid.h"
>> #include "log.h"
>> #include "plugin.h"
>> diff --git a/src/hcid.h b/src/hcid.h
>> index ea67cc2..294e844 100644
>> --- a/src/hcid.h
>> +++ b/src/hcid.h
>> @@ -41,9 +41,6 @@ struct main_opts {
>>
>> extern struct main_opts main_opts;
>>
>> -gboolean plugin_init(const char *enable, const char *disable);
>> -void plugin_cleanup(void);
>> -
>> void rfkill_init(void);
>> void rfkill_exit(void);
>>
>> diff --git a/src/main.c b/src/main.c
>> index 62a88cd..23d598f 100644
>> --- a/src/main.c
>> +++ b/src/main.c
>> @@ -56,6 +56,7 @@
>> #include "agent.h"
>> #include "profile.h"
>> #include "systemd.h"
>> +#include "plugin.h"
>>
>> #define BLUEZ_NAME "org.bluez"
>>
>> diff --git a/src/plugin.h b/src/plugin.h
>> index 89c7b85..f281cd9 100644
>> --- a/src/plugin.h
>> +++ b/src/plugin.h
>> @@ -39,6 +39,8 @@ struct bluetooth_plugin_desc {
>>               struct bluetooth_plugin_desc __bluetooth_builtin_ ## name = { \
>>                       #name, version, priority, init, exit \
>>               };
>> +gboolean plugin_init(const char *enable, const char *disable);
>> +void plugin_cleanup(void);
>> #else
>> #define BLUETOOTH_PLUGIN_DEFINE(name, version, priority, init, exit) \
>>               extern struct btd_debug_desc __start___debug[] \\
>
> why are we doing this?

Didn't you want to cleanup hcid.h to minimize the usage of it, or you
are referring to the declarations being inside the #ifdef for built-in
plugins? If you have the declarations outside the ifdef then the
external plugins would have those functions undefined. Perhaps you
change your mind after seeing what it actually mean, perhaps we should
leave as it is? But IMO the main header should follow the binary name
of the daemon as is done for obexd and you got me scared when I look
into connman.h and ofono.h, 800+ lines in a header? You change those
files you basically have to recompile the whole thing.


-- 
Luiz Augusto von Dentz
