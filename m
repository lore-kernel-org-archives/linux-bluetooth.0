Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLk5BuL9c-8Ly=0yZ0rWa71LwktOrfBeE1B4UT5ch_OTA@mail.gmail.com>
References: <20170922050002.24002-1-marcin.kraglak@tieto.com>
 <20170922050002.24002-2-marcin.kraglak@tieto.com> <e05e1cc3-d78d-ed00-da14-86c7746f7556@jp.fujitsu.com>
 <CABBYNZLk5BuL9c-8Ly=0yZ0rWa71LwktOrfBeE1B4UT5ch_OTA@mail.gmail.com>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
Date: Fri, 22 Sep 2017 03:52:49 -0400
Message-ID: <CABD6X-JMhadihPULzU4cW6hG7SUPtGUyb-5G8GUFZJYK1X4wgA@mail.gmail.com>
Subject: Re: [PATCH 1/4] shared/bt_shell: Add initial implementation
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz Eramoto,

On 22 September 2017 at 03:42, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Eramoto, Marcin,
>
> On Fri, Sep 22, 2017 at 9:27 AM, ERAMOTO Masaya
> <eramoto.masaya@jp.fujitsu.com> wrote:
>> Hi Marcin,
>>
>>> +#ifdef HAVE_CONFIG_H
>>> +#include <config.h>
>>> +#endif
>>> +
>>> +#include <stdio.h>
>>> +#include "src/shared/util.h"
>>> +#include "src/shared/queue.h"
>>> +#include "src/shared/bt_shell.h"
>>> +
>>> +#define CMD_LENGTH   48
>>> +
>>> +static struct {
>>> +     const struct bt_shell_menu_entry *current;
>>> +} bt_shell_data;
>>> +
>>> +bool bt_shell_init(const struct bt_shell_menu_entry *menu)
>>> +{
>>> +     if (bt_shell_data.current || !menu)
>>> +             return false;
>>> +
>>> +     bt_shell_data.current = menu;
>>> +
>>> +     return true;
>>> +}
>>> +
>>> +void bt_shell_cleanup(void)
>>> +{
>>> +     bt_shell_data.current = NULL;
>>> +}
>>> +
>>> +void bt_shell_process(const char *cmd, const char *arg)
>>> +{
>>> +     const struct bt_shell_menu_entry *entry;
>>> +
>>> +     if (!bt_shell_data.current || !cmd)
>>> +             return;
>>> +
>>> +     for (entry = bt_shell_data.current; entry->cmd; entry++) {
>>> +             if (strcmp(cmd, entry->cmd))
>>> +                     continue;
>>> +
>>> +             if (entry->func) {
>>> +                     entry->func(arg);
>>> +                     return;
>>> +             }
>>> +     }
>>> +
>>> +     if (strcmp(cmd, "help")) {
>>> +             printf("Invalid command\n");
>>> +             return;
>>> +     }
>>> +
>>> +     bt_shell_print_menu();
>>> +}
>>> +
>>> +void bt_shell_print_menu(void)
>>> +{
>>> +     const struct bt_shell_menu_entry *entry;
>>> +
>>> +     if (!bt_shell_data.current)
>>> +             return;
>>> +
>>> +     printf("Available commands:\n");
>>> +     for (entry = bt_shell_data.current; entry->cmd; entry++) {
>>> +             printf("  %s %-*s %s\n", entry->cmd,
>>> +                                     (int)(CMD_LENGTH - strlen(entry->cmd)),
>>> +                                     entry->arg ? : "", entry->desc ? : "");
>>
>>
>> I think that it is better to
>>   - add some white-spaces
>> or
>>   - add a new line
>> between the argument string and the description string, because it is a little
>> difficult for the help of register-characteristic to read as below:
>>
>>   [bluetooth]# help
>>   Available commands:
>>   ...
>>     unregister-service <UUID/object>                  Unregister application service
>>     register-characteristic <UUID> <Flags=read,write,notify...> Register application characteristic
>>     unregister-characteristic <UUID/object>           Unregister application characteristic
>>     register-descriptor <UUID> <Flags=read,write...>  Register application descriptor
>
> It should probably have the same formatting as bluetoothctl:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/client/main.c#n2677
>
> --
> Luiz Augusto von Dentz

Yes, I'll correct it

-- 
BR
Marcin Kraglak
