Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHwR_AWn-_-=u8RVZpV8pZ-P1JeZx3oKuhZgE8j-na8c-7KXGw@mail.gmail.com>
References: <CAHwR_AWn-_-=u8RVZpV8pZ-P1JeZx3oKuhZgE8j-na8c-7KXGw@mail.gmail.com>
Date: Mon, 18 May 2015 08:38:48 +0200
Message-ID: <CAHwR_AVsxXhgMSnieXzbj4if0X3gR12PzGzw1iKoeu8F8ToXMQ@mail.gmail.com>
Subject: Re: [PATCH] hciattach: Big endian support for various TI chips.
From: Jonas Rydow <jrydow@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,
Did I miss something with this patch? It has not been accepted nor
rejected or commented.

Best regards
Jonas

On Tue, Dec 16, 2014 at 9:32 AM, Jonas Rydow <jrydow@gmail.com> wrote:
> The firmware files from TI and the loading of firmware are designed to
> work on little endian machines. This patch adds support to load the
> firmware on big endian hosts as well as on little endian hosts.
> ---
> tools/hciattach_ti.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/tools/hciattach_ti.c b/tools/hciattach_ti.c
> index 8322b45..555fe5e 100644
> --- a/tools/hciattach_ti.c
> +++ b/tools/hciattach_ti.c
> @@ -124,6 +124,8 @@ static FILE *bts_load_script(const char
> *file_name, uint32_t *version)
>          perror("can't read firmware file");
>          goto errclose;
>      }
> +    header.magic = htobl(header.magic);
> +    header.version = htobl(header.version);
>
>      if (header.magic != FILE_HEADER_MAGIC) {
>          fprintf(stderr, "%s not a legal TI firmware file\n", file_name);
> @@ -153,6 +155,9 @@ static unsigned long bts_fetch_action(FILE *fp,
> unsigned char *action_buf,
>      if (1 != fread(&action_hdr, sizeof(struct bts_action), 1, fp))
>          return 0;
>
> +    action_hdr.type = htobs(action_hdr.type);
> +    action_hdr.size = htobs(action_hdr.size);
> +
>      if (action_hdr.size > buf_size) {
>          fprintf(stderr, "bts_next_action: not enough space to read
> next action\n");
>          return 0;
> @@ -241,6 +246,7 @@ static int brf_send_command_socket(int fd, struct
> bts_action_send *send_action)
>  {
>      char response[1024] = {0};
>      hci_command_hdr *cmd = (hci_command_hdr *) send_action->data;
> +    cmd->opcode = htobs(cmd->opcode);
>      uint16_t opcode = cmd->opcode;
>
>      struct hci_request rq;
> @@ -331,10 +337,13 @@ static int brf_do_action(uint16_t brf_type,
> uint8_t *brf_action, long brf_size,
>          break;
>      case ACTION_SERIAL:
>          DPRINTF("S");
> +        ((struct bts_action_serial *) brf_action)->baud =
> htobl(((struct bts_action_serial *) brf_action)->baud);
> +        ((struct bts_action_serial *) brf_action)->flow_control =
> htobl(((struct bts_action_serial *) brf_action)->flow_control);
>          ret = brf_set_serial_params((struct bts_action_serial *)
> brf_action, fd, speed, ti);
>          break;
>      case ACTION_DELAY:
>          DPRINTF("D");
> +        ((struct bts_action_delay *) brf_action)->msec =
> htobl(((struct bts_action_delay *) brf_action)->msec);
>          brf_delay((struct bts_action_delay *) brf_action);
>          break;
>      case ACTION_REMARKS:
