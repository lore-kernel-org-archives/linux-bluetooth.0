Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20171208070134.GA29604@x1c.home>
References: <20171207122152.29743-1-luiz.dentz@gmail.com> <20171207122152.29743-3-luiz.dentz@gmail.com>
 <20171208070134.GA29604@x1c.home>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 8 Dec 2017 08:53:44 -0200
Message-ID: <CABBYNZ+jqr394=oTz-dt4++DHv-Z_ATghQME-Q4XcQrzrZNXtw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/7] mesh: Make meshctl use bt_shell helpers
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Fri, Dec 8, 2017 at 5:01 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Luiz,
>
> On Thu, Dec 07, 2017, Luiz Augusto von Dentz wrote:
>> -static void set_scan_filter_uuids(const char *arg)
>> +static void set_scan_filter_uuids(int argc, char *argv[])
>>  {
>>       g_strfreev(filtered_scan_uuids);
>>       filtered_scan_uuids = NULL;
>>       filtered_scan_uuids_len = 0;
>>
>> -     if (!arg || !strlen(arg))
>> +     if (argc < 2 || !strlen(argv[1]))
>
> This function seems to be called for string arrays like { UUID, NULL },
> with argc == 1, so the above check looks broken to me. Actually, it
> seems like this function is not used as a normal command handler, so why
> is it dressed up like one (just causes confusion and potential bugs like
> this)?

It was copied from bluetoothctl where it is a command, there are a
bunch of commands like this. Anyway Ive fixed this in v2 and rework
the parameters.


-- 
Luiz Augusto von Dentz
