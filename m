Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171205111406.GA8010@x1c.lan>
References: <20171205105718.5832-1-luiz.dentz@gmail.com> <20171205111406.GA8010@x1c.lan>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 5 Dec 2017 13:17:13 +0200
Message-ID: <CABBYNZJp2VQR6J+PtvT72c4zDEKy1Xt7RFa026ue0y=bL_v7uw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] mesh: Make meshctl use bt_shell helpers
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Dec 5, 2017 at 1:14 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Luiz,
>
> On Tue, Dec 05, 2017, Luiz Augusto von Dentz wrote:
>> -static void cmd_connect(const char *arg)
>> +static void cmd_connect(int argc, char *argv[])
>>  {
>> +     char *filters[] = { MESH_PROXY_SVC_UUID };
>> +
>>       if (check_default_ctrl() == FALSE)
>>               return;
>>
>>       memset(&connection, 0, sizeof(connection));
>>
>> -     if (!arg || !strlen(arg)) {
>> +     if (!argc || !strlen(argv[0])) {
>>               connection.net_idx = NET_IDX_PRIMARY;
>>       } else {
>>               char *end;
>> -             connection.net_idx = strtol(arg, &end, 16);
>> -             if (end == arg) {
>> +             connection.net_idx = strtol(argv[0], &end, 16);
>> +             if (end == argv[0]) {
>>                       connection.net_idx = NET_IDX_INVALID;
>> -                     rl_printf("Invalid network index %s\n", arg);
>> +                     bt_shell_printf("Invalid network index %s\n", argv[0]);
>>                       return;
>>               }
>
> This looks like it's breaking the Node ID connecting that was just
> added. That code from Steve was taking advantage of the "end" pointer to
> get the next parameter, however now that you get the full parsed argv
> the connection.unicast should be set based on argv[1].

Looks like I miss this detail while rebasing, I will fix it.


-- 
Luiz Augusto von Dentz
