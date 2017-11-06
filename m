Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH 1/4] shared/bt_shell: Add initial implementation
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CABBYNZ+LeE1GWmwqY-xg1T7pANysyh8e6Z=Ntg4+Ak5Nm+MBQg@mail.gmail.com>
Date: Mon, 6 Nov 2017 14:52:29 +0100
Cc: Marcin Kraglak <marcin.kraglak@tieto.com>,
        ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <59E0E07F-5582-4309-A1DA-3D101042992C@holtmann.org>
References: <20170922050002.24002-1-marcin.kraglak@tieto.com>
 <20170922050002.24002-2-marcin.kraglak@tieto.com>
 <e05e1cc3-d78d-ed00-da14-86c7746f7556@jp.fujitsu.com>
 <CABBYNZLk5BuL9c-8Ly=0yZ0rWa71LwktOrfBeE1B4UT5ch_OTA@mail.gmail.com>
 <CABD6X-JMhadihPULzU4cW6hG7SUPtGUyb-5G8GUFZJYK1X4wgA@mail.gmail.com>
 <CABBYNZJLU=mkTU8cFJOk6pejPJoG2q7BMNfN+Xt2a8=o-Mu9Tw@mail.gmail.com>
 <1509974648.26101.1.camel@tieto.com>
 <CABBYNZ+LeE1GWmwqY-xg1T7pANysyh8e6Z=Ntg4+Ak5Nm+MBQg@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>>>>>>> +#ifdef HAVE_CONFIG_H
>>>>>>> +#include <config.h>
>>>>>>> +#endif
>>>>>>> +
>>>>>>> +#include <stdio.h>
>>>>>>> +#include "src/shared/util.h"
>>>>>>> +#include "src/shared/queue.h"
>>>>>>> +#include "src/shared/bt_shell.h"
>>>>>>> +
>>>>>>> +#define CMD_LENGTH   48
>>>>>>> +
>>>>>>> +static struct {
>>>>>>> +     const struct bt_shell_menu_entry *current;
>>>>>>> +} bt_shell_data;
>>>>>>> +
>>>>>>> +bool bt_shell_init(const struct bt_shell_menu_entry *menu)
>>>>>>> +{
>>>>>>> +     if (bt_shell_data.current || !menu)
>>>>>>> +             return false;
>>>>>>> +
>>>>>>> +     bt_shell_data.current = menu;
>>>>>>> +
>>>>>>> +     return true;
>>>>>>> +}
>>>>>>> +
>>>>>>> +void bt_shell_cleanup(void)
>>>>>>> +{
>>>>>>> +     bt_shell_data.current = NULL;
>>>>>>> +}
>>>>>>> +
>>>>>>> +void bt_shell_process(const char *cmd, const char *arg)
>>>>>>> +{
>>>>>>> +     const struct bt_shell_menu_entry *entry;
>>>>>>> +
>>>>>>> +     if (!bt_shell_data.current || !cmd)
>>>>>>> +             return;
>>>>>>> +
>>>>>>> +     for (entry = bt_shell_data.current; entry->cmd;
>>>>>>> entry++) {
>>>>>>> +             if (strcmp(cmd, entry->cmd))
>>>>>>> +                     continue;
>>>>>>> +
>>>>>>> +             if (entry->func) {
>>>>>>> +                     entry->func(arg);
>>>>>>> +                     return;
>>>>>>> +             }
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     if (strcmp(cmd, "help")) {
>>>>>>> +             printf("Invalid command\n");
>>>>>>> +             return;
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     bt_shell_print_menu();
>>>>>>> +}
>>>>>>> +
>>>>>>> +void bt_shell_print_menu(void)
>>>>>>> +{
>>>>>>> +     const struct bt_shell_menu_entry *entry;
>>>>>>> +
>>>>>>> +     if (!bt_shell_data.current)
>>>>>>> +             return;
>>>>>>> +
>>>>>>> +     printf("Available commands:\n");
>>>>>>> +     for (entry = bt_shell_data.current; entry->cmd;
>>>>>>> entry++) {
>>>>>>> +             printf("  %s %-*s %s\n", entry->cmd,
>>>>>>> +                                     (int)(CMD_LENGTH -
>>>>>>> strlen(entry->cmd)),
>>>>>>> +                                     entry->arg ? : "",
>>>>>>> entry->desc ? : "");
>>>>>> 
>>>>>> 
>>>>>> I think that it is better to
>>>>>>  - add some white-spaces
>>>>>> or
>>>>>>  - add a new line
>>>>>> between the argument string and the description string, because
>>>>>> it is a little
>>>>>> difficult for the help of register-characteristic to read as
>>>>>> below:
>>>>>> 
>>>>>>  [bluetooth]# help
>>>>>>  Available commands:
>>>>>>  ...
>>>>>>    unregister-service
>>>>>> <UUID/object>                  Unregister application service
>>>>>>    register-characteristic <UUID> <Flags=read,write,notify...>
>>>>>> Register application characteristic
>>>>>>    unregister-characteristic
>>>>>> <UUID/object>           Unregister application characteristic
>>>>>>    register-descriptor <UUID> <Flags=read,write...>  Register
>>>>>> application descriptor
>>>>> 
>>>>> It should probably have the same formatting as bluetoothctl:
>>>>> 
>>>>> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/client/ma
>>>>> in.c#n2677
>>>>> 
>>>>> --
>>>>> Luiz Augusto von Dentz
>>>> 
>>>> Yes, I'll correct it
>>> 
>>> Are you still working on this?
>>> 
>> No, unfortunatelly I don't have enough time to finish it.
> 
> Ok, so I will start working on it myself.

just a side note, lets do src/shared/shell.[ch] and not start with bt_ prefixes in file names.

Regards

Marcel

