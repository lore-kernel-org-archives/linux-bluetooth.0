Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1c6043a5-a92b-d1b9-df4e-af77a9c30beb@jp.fujitsu.com>
References: <20180222092055.22493-1-andrzej.kaczmarek@codecoup.pl>
 <20180222092055.22493-4-andrzej.kaczmarek@codecoup.pl> <1c6043a5-a92b-d1b9-df4e-af77a9c30beb@jp.fujitsu.com>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Date: Fri, 23 Feb 2018 12:34:31 +0100
Message-ID: <CADAkoF6pMURihijMJf930oaO8dmAzmeDBUK2mWeF00bA5Qw8CQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/3] monitor: Add support for reading over J-Link RTT
To: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eramoto,

On Fri, Feb 23, 2018 at 8:00 AM, ERAMOTO Masaya
<eramoto.masaya@jp.fujitsu.com> wrote:
> Hi Andrzej,
>
>
> On 02/22/2018 06:20 PM, Andrzej Kaczmarek wrote:
>> This patch adds support for reading data over J-Link RTT. It can be
>> used as replacement for TTY when reading from embedded devices since
>> it's much faster and does block a UART. Data format is the same as
>> for TTY. At the moment monitor over RTT is only supported by Apache
>> Mynewt project.
>>
>> Reading data is done by polling RTT every 1 msec since there is no
>> blocking API to read something from RTT buffer.
>>
>> To enable reading from RTT, J-Link and RTT configuration needs to be
>> passed via command line:
>>   -J --jlink <device>,<interface>,<speed>,<serialno>
>>   -R --rtt <address>,<area>,<buffer>
>>
>> <device> - one of devices supported by J-Link (no default)
>> <interface> - only 'swd' supported for now (default: swd)
>> <speed> - interface speed (default: 1000)
>> <serialno> - emu serial number or 0 if not used (detault: 0)
>> <address> - RTT control block address (default: 0)
>> <area> - RTT control block search area length (default: 0)
>> <buffer> - RTT buffer name with monitor data stream (default: monitor)
>>
>> Parameters with default values can be omitted.
>>
>> For example, to read from default nRF52 device and look for RTT buffer
>> with default name over entire RAM area use:
>>   btmon -J nrf52 -R 0x20000000,0x10000
>> ---
>>  Makefile.tools    |  3 ++-
>>  monitor/control.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  monitor/control.h |  1 +
>>  monitor/main.c    | 30 ++++++++++++++++++++++++++----
>>  4 files changed, 79 insertions(+), 5 deletions(-)
>>
>> diff --git a/Makefile.tools b/Makefile.tools
>> index 71d083e71..7466633bb 100644
>> --- a/Makefile.tools
>> +++ b/Makefile.tools
>> @@ -59,9 +59,10 @@ monitor_btmon_SOURCES = monitor/main.c monitor/bt.h \
>>                               monitor/analyze.h monitor/analyze.c \
>>                               monitor/intel.h monitor/intel.c \
>>                               monitor/broadcom.h monitor/broadcom.c \
>> +                             monitor/jlink.h monitor/jlink.c \
>>                               monitor/tty.h
>>  monitor_btmon_LDADD = lib/libbluetooth-internal.la \
>> -                             src/libshared-mainloop.la @UDEV_LIBS@
>> +                             src/libshared-mainloop.la @UDEV_LIBS@ -ldl
>>  endif
>>
>>  if TESTING
>> diff --git a/monitor/control.c b/monitor/control.c
>> index 98f414be9..73462be42 100644
>> --- a/monitor/control.c
>> +++ b/monitor/control.c
>> @@ -54,6 +54,7 @@
>>  #include "ellisys.h"
>>  #include "tty.h"
>>  #include "control.h"
>> +#include "jlink.h"
>>
>>  static struct btsnoop *btsnoop_file = NULL;
>>  static bool hcidump_fallback = false;
>> @@ -1376,6 +1377,55 @@ int control_tty(const char *path, unsigned int speed)
>>       return 0;
>>  }
>>
>> +static void rtt_callback(int id, void *user_data)
>> +{
>> +     struct control_data *data = user_data;
>> +     ssize_t len;
>> +
>> +     do {
>> +             len = jlink_rtt_read(data->buf + data->offset,
>> +                                     sizeof(data->buf) - data->offset);
>> +             data->offset += len;
>> +             process_data(data);
>> +     } while (len > 0);
>> +
>> +     if (mainloop_modify_timeout(id, 1) < 0)
>> +             mainloop_exit_failure();
>> +}
>> +
>> +int control_rtt(char *jlink, char *rtt)
>> +{
>> +     struct control_data *data;
>> +
>> +     if (jlink_init() < 0) {
>> +             fprintf(stderr, "Failed to initialize J-Link library\n");
>> +             return -EIO;
>> +     }
>> +
>> +     if (jlink_connect(jlink) < 0) {
>> +             fprintf(stderr, "Failed to connect to target device\n");
>> +             return -ENODEV;
>> +     }
>> +
>> +     if (jlink_start_rtt(rtt) < 0) {
>> +             fprintf(stderr, "Failed to initialize RTT\n");
>> +             return -ENODEV;
>> +     }
>> +
>> +     printf("--- RTT opened ---\n");
>> +
>> +     data = new0(struct control_data, 1);
>> +     data->channel = HCI_CHANNEL_MONITOR;
>> +     data->fd = -1;
>> +
>> +     if (mainloop_add_timeout(1, rtt_callback, data, free_data) < 0) {
>> +             free(data);
>> +             return -EIO;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>>  bool control_writer(const char *path)
>>  {
>>       btsnoop_file = btsnoop_create(path, BTSNOOP_FORMAT_MONITOR);
>> diff --git a/monitor/control.h b/monitor/control.h
>> index 630a852e4..c315eb7db 100644
>> --- a/monitor/control.h
>> +++ b/monitor/control.h
>> @@ -28,6 +28,7 @@ bool control_writer(const char *path);
>>  void control_reader(const char *path);
>>  void control_server(const char *path);
>>  int control_tty(const char *path, unsigned int speed);
>> +int control_rtt(char *jlink, char *rtt);
>>  int control_tracing(void);
>>  void control_disable_decoding(void);
>>
>> diff --git a/monitor/main.c b/monitor/main.c
>> index 3e61a4661..27132e3c3 100644
>> --- a/monitor/main.c
>> +++ b/monitor/main.c
>> @@ -72,6 +72,10 @@ static void usage(void)
>>               "\t-S, --sco              Dump SCO traffic\n"
>>               "\t-A, --a2dp             Dump A2DP stream traffic\n"
>>               "\t-E, --ellisys [ip]     Send Ellisys HCI Injection\n"
>> +             "\t-R  --rtt <device>,[<interface>],[<speed>],[<serialno>]\n"
>> +             "\t                       Read data from RTT\n"
>> +             "\t-C  --rtt-cb [<address>],[<area>],[<name>]\n"
>> +             "\t                       RTT control block parameters\n"
>
> The description of two options is incorrect since it is different from
> the commit message and the implementation of this patch.

Ah, I forgot to update this message after changing option names -
thanks, will fix later in v2.

> Regards,
> Eramoto

Best regards,
Andrzej
