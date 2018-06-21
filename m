Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <A45809F0-CA1F-4ABA-B9C4-74634CD04C0E@holtmann.org>
References: <20170726090632.16494-1-luiz.dentz@gmail.com> <CABBYNZL011pcFsfLSJBLNgEU0aHqDGjuvqEvbU4xbaKHyiJmDg@mail.gmail.com>
 <A45809F0-CA1F-4ABA-B9C4-74634CD04C0E@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 21 Jun 2018 18:37:05 +0300
Message-ID: <CABBYNZKnqFspUrPVuA+Ca_fpGiEHQdEG6__Qvrwt=aXi2cHHQQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ] monitor: Use BPF to filter packets by index
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Jun 21, 2018 at 3:49 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Luiz,
>
>>> This uses a BPF filter to filter packets to specific index.
>>> ---
>>> monitor/control.c | 36 ++++++++++++++++++++++++++++++++++++
>>> monitor/control.h |  1 +
>>> monitor/packet.c  |  9 ++-------
>>> 3 files changed, 39 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/monitor/control.c b/monitor/control.c
>>> index 9bbdc37dc..05cfc3aaa 100644
>>> --- a/monitor/control.c
>>> +++ b/monitor/control.c
>>> @@ -28,6 +28,7 @@
>>>
>>> #include <stdio.h>
>>> #include <stdbool.h>
>>> +#include <stddef.h>
>>> #include <errno.h>
>>> #include <unistd.h>
>>> #include <stdlib.h>
>>> @@ -39,6 +40,7 @@
>>> #include <sys/stat.h>
>>> #include <termios.h>
>>> #include <fcntl.h>
>>> +#include <linux/filter.h>
>>>
>>> #include "lib/bluetooth.h"
>>> #include "lib/hci.h"
>>> @@ -58,6 +60,7 @@
>>> static struct btsnoop *btsnoop_file = NULL;
>>> static bool hcidump_fallback = false;
>>> static bool decode_control = true;
>>> +static uint16_t filter_index = HCI_DEV_NONE;
>>>
>>> struct control_data {
>>>        uint16_t channel;
>>> @@ -1028,6 +1031,31 @@ static int open_socket(uint16_t channel)
>>>        return fd;
>>> }
>>>
>>> +static void attach_index_filter(int fd, uint16_t index)
>>> +{
>>> +       struct sock_filter filters[] = {
>>> +               /* A <- MGMT index */
>>> +               BPF_STMT(BPF_LD + BPF_B + BPF_ABS,
>>> +                                       offsetof(struct mgmt_hdr, index)),
>>> +               /* A == HCI_DEV_NONE */
>>> +               BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, HCI_DEV_NONE, 0, 1),
>>> +               /* return */
>>> +               BPF_STMT(BPF_RET|BPF_K, 0x0fffffff), /* pass */
>>> +               /* A ==  index */
>>> +               BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, index, 0, 1),
>>> +               /* returns */
>>> +               BPF_STMT(BPF_RET|BPF_K, 0x0fffffff), /* pass */
>>> +               BPF_STMT(BPF_RET|BPF_K, 0), /* reject */
>>> +       };
>>> +       struct sock_fprog fprog = {
>>> +               .len = sizeof(filters) / sizeof(filters[0]),
>>> +               /* casting const away: */
>>> +               .filter = filters,
>>> +       };
>>> +
>>> +       setsockopt(fd, SOL_SOCKET, SO_ATTACH_FILTER, &fprog, sizeof(fprog));
>>> +}
>>> +
>
> I would prefer a bit more comments on what the program is doing. So allow packets from HCI_DEV_NONE, filter for index etc.

Sure I will update with what each instruction is doing.

> Regards
>
> Marcel
>



-- 
Luiz Augusto von Dentz
