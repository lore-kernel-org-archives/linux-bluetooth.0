Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1293447745-8697-1-git-send-email-michal.labedzki@tieto.com>
References: <1293447745-8697-1-git-send-email-michal.labedzki@tieto.com>
Date: Mon, 27 Dec 2010 08:13:51 -0400
Message-ID: <AANLkTi=zo=pgCCgJ=sL9bUftf6Vv7nO7xac92zU6gECC@mail.gmail.com>
Subject: Re: [PATCH 1/4] Filtering interface name from program arguments
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Michal Labedzki <michal.labedzki@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Dec 27, 2010 at 7:02 AM, Michal Labedzki
<michal.labedzki@tieto.com> wrote:
> +/* return 1 if string is ecimal number without leading zeros
> + * return 0 if not */

Typo: ecimal -> decimal

> +static int is_devnumber(const char *c)
> +{
> +       if (c[0] == '0' && c[1] != 0)
> +               return 0;
> +
> +       while (*c) {
> +               if (*c < '0' || *c > '9')
> +                       return 0;
> +               ++c;
> +       }
> +       return 1;
> +}
> +
> +/* return HCI dev_id from string like "hciX", where X is dev_id
> + * return -1 if string not match */

Suggestion: "return -1 if str has invalid format"

> +int hci_filter_devname(const char *str)
> +{
> +       int dev_id;
> +
> +       if ((strlen(str) >= 4) && (!strncmp(str, "hci", 3)) &&
> +               (is_devnumber(str + 3)))
> +               dev_id = atoi(str + 3);
> +       else
> +               dev_id = -1;
> +
> +       if (dev_id >= HCI_MAX_DEV)
> +               dev_id = -1;
> +
> +       return dev_id;
> +}
> +
> +/* return dev_id, which is on UP state, from 'hciX' or 'bdaddr'
> + * otherwise return -1 */
>  int hci_devid(const char *str)
>  {
>        bdaddr_t ba;
> -       int id = -1;
> +       int dev_id;
>
> -       if (!strncmp(str, "hci", 3) && strlen(str) >= 4) {
> -               id = atoi(str + 3);
> -               if (hci_devba(id, &ba) < 0)
> -                       return -1;
> -       } else {
> +       dev_id = hci_filter_devname(str);
> +       if (dev_id < 0) {
>                errno = ENODEV;
>                str2ba(str, &ba);
> -               id = hci_for_each_dev(HCI_UP, __same_bdaddr, (long) &ba);
> +               dev_id = hci_for_each_dev(HCI_UP, __same_bdaddr, (long) &ba);
> +       } else {
> +               if (hci_devba(dev_id, &ba) < 0)
> +                       return -1;
>        }

Use "else if (hci_devba(...))" and drop the extra brackets.

>
> -       return id;
> +       return dev_id;
>  }

> diff --git a/test/hciemu.c b/test/hciemu.c
> index a20374f..ae33d72 100644
> --- a/test/hciemu.c
> +++ b/test/hciemu.c
> @@ -1234,15 +1234,16 @@ int main(int argc, char *argv[])
>                exit(1);
>        }
>
> -       if (strlen(argv[0]) > 3 && !strncasecmp(argv[0], "hci", 3)) {
> +       dev = hci_filter_devname(argv[0]);
> +       if (dev < 0) {
> +               if (getbdaddrbyname(argv[0], &vdev.bdaddr) < 0)
> +                       exit(1);
> +       } else {
>                dev = hci_devid(argv[0]);
>                if (dev < 0) {
>                        perror("Invalid device");
>                        exit(1);
>                }
> -       } else {
> -               if (getbdaddrbyname(argv[0], &vdev.bdaddr) < 0)
> -                       exit(1);
>        }
>
>        if (detach) {
> diff --git a/test/l2test.c b/test/l2test.c
> index 17883a9..438ba39 100644
> --- a/test/l2test.c
> +++ b/test/l2test.c
> @@ -1101,6 +1101,7 @@ int main(int argc, char *argv[])
>  {
>        struct sigaction sa;
>        int opt, sk, mode = RECV, need_addr = 0;
> +       int devid;
>
>        bacpy(&bdaddr, BDADDR_ANY);
>
> @@ -1175,10 +1176,11 @@ int main(int argc, char *argv[])
>                        break;
>
>                case 'i':
> -                       if (!strncasecmp(optarg, "hci", 3))
> -                               hci_devba(atoi(optarg + 3), &bdaddr);
> -                       else
> +                       devid = hci_filter_devname(optarg);
> +                       if (devid < 0)
>                                str2ba(optarg, &bdaddr);
> +                       else
> +                               hci_devba(devid, &bdaddr);
>                        break;
>
>                case 'P':
> diff --git a/test/rctest.c b/test/rctest.c
> index b3804f5..a828ad9 100644
> --- a/test/rctest.c
> +++ b/test/rctest.c
> @@ -579,7 +579,7 @@ static void usage(void)
>                "\t-m multiple connects\n");
>
>        printf("Options:\n"
> -               "\t[-b bytes] [-i device] [-P channel] [-U uuid]\n"
> +               "\t[-b bytes] [-i hciX|bdaddr] [-P channel] [-U uuid]\n"
>                "\t[-L seconds] enabled SO_LINGER option\n"
>                "\t[-W seconds] enable deferred setup\n"
>                "\t[-B filename] use data packets from file\n"
> @@ -597,6 +597,7 @@ int main(int argc, char *argv[])
>  {
>        struct sigaction sa;
>        int opt, sk, mode = RECV, need_addr = 0;
> +       int devid;
>
>        bacpy(&bdaddr, BDADDR_ANY);
>
> @@ -644,10 +645,11 @@ int main(int argc, char *argv[])
>                        break;
>
>                case 'i':
> -                       if (!strncasecmp(optarg, "hci", 3))
> -                               hci_devba(atoi(optarg + 3), &bdaddr);
> -                       else
> +                       devid = hci_filter_devname(optarg);
> +                       if (devid < 0)
>                                str2ba(optarg, &bdaddr);
> +                       else
> +                               hci_devba(devid, &bdaddr);
>                        break;
>
>                case 'P':
> diff --git a/tools/ciptool.c b/tools/ciptool.c
> index edce9da..ec602ef 100644
> --- a/tools/ciptool.c
> +++ b/tools/ciptool.c
> @@ -427,7 +427,7 @@ static void usage(void)
>                "\n");
>
>        printf("Options:\n"
> -               "\t-i [hciX|bdaddr]   Local HCI device or BD Address\n"
> +               "\t-i <hciX|bdaddr>   Local HCI device or BD Address\n"
>                "\t-h, --help         Display help\n"
>                "\n");
>
> @@ -455,10 +455,11 @@ int main(int argc, char *argv[])
>        while ((opt = getopt_long(argc, argv, "+i:h", main_options, NULL)) != -1) {
>                switch(opt) {
>                case 'i':
> -                       if (!strncmp(optarg, "hci", 3))
> -                               hci_devba(atoi(optarg + 3), &bdaddr);
> -                       else
> +                       i = hci_filter_devname(optarg);
> +                       if (i < 0)
>                                str2ba(optarg, &bdaddr);
> +                       else
> +                               hci_devba(i, &bdaddr);
>                        break;
>                case 'h':
>                        usage();
> diff --git a/tools/hciconfig.c b/tools/hciconfig.c
> index f0ae11c..e20963d 100644
> --- a/tools/hciconfig.c
> +++ b/tools/hciconfig.c
> @@ -1849,7 +1849,13 @@ int main(int argc, char *argv[])
>                exit(0);
>        }
>
> -       di.dev_id = atoi(argv[0] + 3);
> +       i = hci_filter_devname(argv[0]);
> +       if (i < 0) {
> +               fprintf(stderr, "No valid device name.\n");
> +               exit(1);
> +       }
> +       di.dev_id = i;
> +
>        argc--; argv++;
>
>        if (ioctl(ctl, HCIGETDEVINFO, (void *) &di)) {
> diff --git a/tools/hcitool.c b/tools/hcitool.c
> index d50adaf..dc70e63 100644
> --- a/tools/hcitool.c
> +++ b/tools/hcitool.c
> @@ -2560,8 +2560,8 @@ static void usage(void)
>        printf("Usage:\n"
>                "\thcitool [options] <command> [command parameters]\n");
>        printf("Options:\n"
> -               "\t--help\tDisplay help\n"
> -               "\t-i dev\tHCI device\n");
> +               "\t--help                 Display help\n"
> +               "\t-i <hciX|bdaddr>       Local HCI device or BD Address\n");
>        printf("Commands:\n");
>        for (i = 0; command[i].cmd; i++)
>                printf("\t%-4s\t%s\n", command[i].cmd,
> diff --git a/tools/l2ping.c b/tools/l2ping.c
> index 29fb3d0..dd0ccbd 100644
> --- a/tools/l2ping.c
> +++ b/tools/l2ping.c
> @@ -255,7 +255,8 @@ static void usage(void)
>  {
>        printf("l2ping - L2CAP ping\n");
>        printf("Usage:\n");
> -       printf("\tl2ping [-i device] [-s size] [-c count] [-t timeout] [-d delay] [-f] [-r] [-v] <bdaddr>\n");
> +       printf("\tl2ping [-i <hciX|bdaddr> local hci or bd address] [-s size]"
> +               "[-c count] [-t timeout] [-d delay] [-f] [-r] [-v] <bdaddr>\n");

The change above looks strange. You could drop "local hci or bd
address" (it is implicit from "<hciX|bdaddr>").

>        printf("\t-f  Flood ping (delay = 0)\n");
>        printf("\t-r  Reverse ping\n");
>        printf("\t-v  Verify request and response payload\n");
> @@ -264,17 +265,18 @@ static void usage(void)
>  int main(int argc, char *argv[])
>  {
>        int opt;
> -
> +       int devid;

Add an empty line here.

>        /* Default options */
>        bacpy(&bdaddr, BDADDR_ANY);
>
>        while ((opt=getopt(argc,argv,"i:d:s:c:t:frv")) != EOF) {
>                switch(opt) {
>                case 'i':
> -                       if (!strncasecmp(optarg, "hci", 3))
> -                               hci_devba(atoi(optarg + 3), &bdaddr);
> -                       else
> +                       devid = hci_filter_devname(optarg);
> +                       if (devid < 0)
>                                str2ba(optarg, &bdaddr);
> +                       else
> +                               hci_devba(devid, &bdaddr);
>                        break;
>
>                case 'd':
> diff --git a/tools/main.c b/tools/main.c
> index 6800445..c000fba 100644
> --- a/tools/main.c
> +++ b/tools/main.c
> @@ -753,10 +753,11 @@ int main(int argc, char *argv[])
>        while ((opt = getopt_long(argc, argv, "+i:f:rahAESML:", main_options, NULL)) != -1) {
>                switch(opt) {
>                case 'i':
> -                       if (strncmp(optarg, "hci", 3) == 0)
> -                               hci_devba(atoi(optarg + 3), &bdaddr);
> -                       else
> +                       dev_id = hci_filter_devname(optarg);
> +                       if (dev_id < 0)
>                                str2ba(optarg, &bdaddr);
> +                       else
> +                               hci_devba(dev_id, &bdaddr);
>                        break;
>
>                case 'f':
> diff --git a/tools/sdptool.c b/tools/sdptool.c
> index 140a46a..c782e62 100644
> --- a/tools/sdptool.c
> +++ b/tools/sdptool.c
> @@ -4209,7 +4209,7 @@ static void usage(void)
>                "\tsdptool [options] <command> [command parameters]\n");
>        printf("Options:\n"
>                "\t-h\t\tDisplay help\n"
> -               "\t-i\t\tSpecify source interface\n");
> +               "\t-i\t\tSpecify source interface or bdaddr\n");
>
>        printf("Commands:\n");
>        for (i = 0; command[i].cmd; i++)
> @@ -4242,10 +4242,11 @@ int main(int argc, char *argv[])
>        while ((opt=getopt_long(argc, argv, "+i:h", main_options, NULL)) != -1) {
>                switch(opt) {
>                case 'i':
> -                       if (!strncmp(optarg, "hci", 3))
> -                               hci_devba(atoi(optarg + 3), &interface);
> -                       else
> +                       i = hci_filter_devname(optarg);
> +                       if (i < 0)
>                                str2ba(optarg, &interface);
> +                       else
> +                               hci_devba(i, &interface);
>                        break;
>
>                case 'h':
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
