Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170726090632.16494-1-luiz.dentz@gmail.com>
References: <20170726090632.16494-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 Jun 2018 20:00:33 +0300
Message-ID: <CABBYNZL011pcFsfLSJBLNgEU0aHqDGjuvqEvbU4xbaKHyiJmDg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] monitor: Use BPF to filter packets by index
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Jul 26, 2017 at 12:06 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This uses a BPF filter to filter packets to specific index.
> ---
>  monitor/control.c | 36 ++++++++++++++++++++++++++++++++++++
>  monitor/control.h |  1 +
>  monitor/packet.c  |  9 ++-------
>  3 files changed, 39 insertions(+), 7 deletions(-)
>
> diff --git a/monitor/control.c b/monitor/control.c
> index 9bbdc37dc..05cfc3aaa 100644
> --- a/monitor/control.c
> +++ b/monitor/control.c
> @@ -28,6 +28,7 @@
>
>  #include <stdio.h>
>  #include <stdbool.h>
> +#include <stddef.h>
>  #include <errno.h>
>  #include <unistd.h>
>  #include <stdlib.h>
> @@ -39,6 +40,7 @@
>  #include <sys/stat.h>
>  #include <termios.h>
>  #include <fcntl.h>
> +#include <linux/filter.h>
>
>  #include "lib/bluetooth.h"
>  #include "lib/hci.h"
> @@ -58,6 +60,7 @@
>  static struct btsnoop *btsnoop_file = NULL;
>  static bool hcidump_fallback = false;
>  static bool decode_control = true;
> +static uint16_t filter_index = HCI_DEV_NONE;
>
>  struct control_data {
>         uint16_t channel;
> @@ -1028,6 +1031,31 @@ static int open_socket(uint16_t channel)
>         return fd;
>  }
>
> +static void attach_index_filter(int fd, uint16_t index)
> +{
> +       struct sock_filter filters[] = {
> +               /* A <- MGMT index */
> +               BPF_STMT(BPF_LD + BPF_B + BPF_ABS,
> +                                       offsetof(struct mgmt_hdr, index)),
> +               /* A == HCI_DEV_NONE */
> +               BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, HCI_DEV_NONE, 0, 1),
> +               /* return */
> +               BPF_STMT(BPF_RET|BPF_K, 0x0fffffff), /* pass */
> +               /* A ==  index */
> +               BPF_JUMP(BPF_JMP + BPF_JEQ + BPF_K, index, 0, 1),
> +               /* returns */
> +               BPF_STMT(BPF_RET|BPF_K, 0x0fffffff), /* pass */
> +               BPF_STMT(BPF_RET|BPF_K, 0), /* reject */
> +       };
> +       struct sock_fprog fprog = {
> +               .len = sizeof(filters) / sizeof(filters[0]),
> +               /* casting const away: */
> +               .filter = filters,
> +       };
> +
> +       setsockopt(fd, SOL_SOCKET, SO_ATTACH_FILTER, &fprog, sizeof(fprog));
> +}
> +
>  static int open_channel(uint16_t channel)
>  {
>         struct control_data *data;
> @@ -1045,6 +1073,9 @@ static int open_channel(uint16_t channel)
>                 return -1;
>         }
>
> +       if (filter_index != HCI_DEV_NONE)
> +               attach_index_filter(data->fd, filter_index);
> +
>         mainloop_add_fd(data->fd, EPOLLIN, data_callback, data, free_data);
>
>         return 0;
> @@ -1459,3 +1490,8 @@ void control_disable_decoding(void)
>  {
>         decode_control = false;
>  }
> +
> +void control_filter_index(uint16_t index)
> +{
> +       filter_index = index;
> +}
> diff --git a/monitor/control.h b/monitor/control.h
> index 630a852e4..dc655a45d 100644
> --- a/monitor/control.h
> +++ b/monitor/control.h
> @@ -30,5 +30,6 @@ void control_server(const char *path);
>  int control_tty(const char *path, unsigned int speed);
>  int control_tracing(void);
>  void control_disable_decoding(void);
> +void control_filter_index(uint16_t index);
>
>  void control_message(uint16_t opcode, const void *data, uint16_t size);
> diff --git a/monitor/packet.c b/monitor/packet.c
> index 387be1dcb..cedbef1f7 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -104,7 +104,6 @@ static time_t time_offset = ((time_t) -1);
>  static int priority_level = BTSNOOP_PRIORITY_INFO;
>  static unsigned long filter_mask = 0;
>  static bool index_filter = false;
> -static uint16_t index_number = 0;
>  static uint16_t index_current = 0;
>
>  #define UNKNOWN_MANUFACTURER 0xffff
> @@ -259,8 +258,9 @@ void packet_select_index(uint16_t index)
>  {
>         filter_mask &= ~PACKET_FILTER_SHOW_INDEX;
>
> +       control_filter_index(index);
> +
>         index_filter = true;
> -       index_number = index;
>  }
>
>  #define print_space(x) printf("%*c", (x), ' ');
> @@ -4039,9 +4039,6 @@ void packet_control(struct timeval *tv, struct ucred *cred,
>                                         uint16_t index, uint16_t opcode,
>                                         const void *data, uint16_t size)
>  {
> -       if (index_filter && index_number != index)
> -               return;
> -
>         control_message(opcode, data, size);
>  }
>
> @@ -4063,8 +4060,6 @@ void packet_monitor(struct timeval *tv, struct ucred *cred,
>         const char *ident;
>
>         if (index != HCI_DEV_NONE) {
> -               if (index_filter && index_number != index)
> -                       return;
>                 index_current = index;
>         }
>
> --
> 2.13.3

ping



-- 
Luiz Augusto von Dentz
