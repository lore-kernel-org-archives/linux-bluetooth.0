Return-Path: <marcin.kraglak@tieto.com>
MIME-Version: 1.0
In-Reply-To: <CB8FC172-FF24-4B34-8279-01022CBF864E@holtmann.org>
References: <20170921174021.20154-1-marcin.kraglak@tieto.com> <CB8FC172-FF24-4B34-8279-01022CBF864E@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
Date: Fri, 22 Sep 2017 00:48:34 -0400
Message-ID: <CABD6X-K_vnmH4GRGpSd8M=oS3Xm0RSA7ZJyLtHNcZ_S_xpSmJQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Move common client code to bt_shell
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org development" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 21 September 2017 at 14:36, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Marcin,
>
>> This is first part of moving common code of client and meshctl to shared
>> directory. Next steps would be:
>> - functions for switching between menus (needed for meshctl)
>> - display functions
>> - common support for history
>>
>> Marcin Kraglak (4):
>>  shared/shell/bt_shell: Add initial implementation
>>  client: Use bt_shell to process commands.
>>  shared/shell/bt_shell: Add bt_shell_completion
>>  client: Use bt_shell_completion
>>
>> Makefile.tools              |   3 +-
>> client/main.c               |  93 ++-------------------------
>> src/shared/shell/bt_shell.c | 152 ++++++++++++++++++++++++++++++++++++++++++++
>> src/shared/shell/bt_shell.h |  43 +++++++++++++
>
> I am not a big fan of this deep directory structure. So either src/shell/ or put it all src/shared/. However I am sure tab-completion will be a pain with src/shell and src/shared ;)
Right, I'll move it to src/shared.
>
> Regards
>
> Marcel
>



-- 
BR
Marcin Kraglak
