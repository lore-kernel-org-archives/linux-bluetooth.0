Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1426126319-28510-1-git-send-email-jpawlowski@google.com>
References: <1426126319-28510-1-git-send-email-jpawlowski@google.com>
Date: Wed, 11 Mar 2015 20:04:43 -0700
Message-ID: <CAHrH25R1GKnB8D=Svrkpc4t1oTV6eWxj-0B5wxQs8r0ENnomDA@mail.gmail.com>
Subject: Re: [PATCH] tools/btmgmt: Introduce stop-find command
From: Arman Uguray <armansito@chromium.org>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> On Wed, Mar 11, 2015 at 7:11 PM, Jakub Pawlowski <jpawlowski@google.com> wrote:
> This patch adds stop-find command that stops discovery started by
> find, or find-service command.
> ---
>  tools/btmgmt.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>
> diff --git a/tools/btmgmt.c b/tools/btmgmt.c
> index 8eff56b..89c2f43 100644
> --- a/tools/btmgmt.c
> +++ b/tools/btmgmt.c
> @@ -1897,6 +1897,84 @@ static void cmd_find(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
>         }
>  }
>
> +static void stop_find_rsp(uint8_t status, uint16_t len, const void *param,
> +                                                       void *user_data)
> +{
> +       if (status != 0) {
> +               fprintf(stderr,
> +                       "Unable to stop discovery. status 0x%02x (%s)\n",
> +                                               status, mgmt_errstr(status));

You should stay consistent with other error messages, I would format
this as "Stop Discovery failed: status 0x%02x (%s)\n" (note the ':'
after "Stop Discovery failed").

> +               mainloop_quit();
> +               return;
> +       }
> +
> +       printf("Discovery stopped\n");
> +       discovery = false;
> +
> +       noninteractive_quit(EXIT_SUCCESS);
> +}
> +
> +static void stop_find_usage(void)
> +{
> +       printf("Usage: btmgmt stop-find [-l|-b]>\n");
> +}
> +
> +static struct option stop_find_options[] = {
> +       { "help",       0, 0, 'h' },
> +       { "le-only",    1, 0, 'l' },
> +       { "bredr-only", 1, 0, 'b' },
> +       { 0, 0, 0, 0 }
> +};
> +
> +static void cmd_stop_find(struct mgmt *mgmt, uint16_t index, int argc,
> +                         char **argv)
> +{
> +       struct mgmt_cp_stop_discovery cp;
> +       uint8_t type;
> +       int opt;
> +
> +       if (index == MGMT_INDEX_NONE)
> +               index = 0;
> +
> +       type = 0;
> +       type |= (1 << BDADDR_BREDR);
> +       type |= (1 << BDADDR_LE_PUBLIC);
> +       type |= (1 << BDADDR_LE_RANDOM);
> +
> +       while ((opt = getopt_long(argc, argv, "+lbh", stop_find_options,
> +                                                               NULL)) != -1) {

What happens if I pass "-b -l" or "-l -b"? The behavior is not very
well defined.

> +               switch (opt) {
> +               case 'l':
> +                       type &= ~(1 << BDADDR_BREDR);
> +                       type |= (1 << BDADDR_LE_PUBLIC);
> +                       type |= (1 << BDADDR_LE_RANDOM);

You've already or'd LE_PUBLIC and LE_RANDOM before entering the loop,
why do this again?

> +                       break;
> +               case 'b':
> +                       type |= (1 << BDADDR_BREDR);

Same, you've already or'd BREDR before the loop, so why is this line
needed? Also, if these shifted values are frequently used, can we just
define constants for them? I see that you mostly stayed consistent
with cmd_find and cmd_find_service, but perhaps the address type can
be calculated in a helper since this code is repeated.

> +                       type &= ~(1 << BDADDR_LE_PUBLIC);
> +                       type &= ~(1 << BDADDR_LE_RANDOM);
> +                       break;
> +               case 'h':
> +               default:
> +                       stop_find_usage();
> +                       exit(EXIT_SUCCESS);
> +               }
> +       }
> +
> +       argc -= optind;
> +       argv += optind;
> +       optind = 0;
> +
> +       memset(&cp, 0, sizeof(cp));
> +       cp.type = type;
> +
> +       if (mgmt_send(mgmt, MGMT_OP_STOP_DISCOVERY, index, sizeof(cp), &cp,
> +                                            stop_find_rsp, NULL, NULL) == 0) {
> +               fprintf(stderr, "Unable to send stop_discovery cmd\n");
> +               exit(EXIT_FAILURE);
> +       }
> +}
> +
>  static void name_rsp(uint8_t status, uint16_t len, const void *param,
>                                                         void *user_data)
>  {
> @@ -3268,6 +3346,7 @@ static struct cmd_info all_cmd[] = {
>         { "con",        cmd_con,        "List connections"              },
>         { "find",       cmd_find,       "Discover nearby devices"       },
>         { "find-service", cmd_find_service, "Discover nearby service"   },
> +       { "stop-find",  cmd_stop_find,  "Stop discovery"                },
>         { "name",       cmd_name,       "Set local name"                },
>         { "pair",       cmd_pair,       "Pair with a remote device"     },
>         { "cancelpair", cmd_cancel_pair,"Cancel pairing"                },
> --
> 2.2.0.rc0.207.ga3a616c
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks,
Arman
