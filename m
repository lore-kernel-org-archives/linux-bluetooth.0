Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1439392033-11822-1-git-send-email-luiz.dentz@gmail.com>
References: <1439392033-11822-1-git-send-email-luiz.dentz@gmail.com>
Date: Thu, 13 Aug 2015 14:10:39 +0300
Message-ID: <CABBYNZ+n9q=06zOiGZJxRFAFtOwPMP7R+Z+sdLOXH4WbQ+xqOw@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/7] tools/hciconfig: Add missing hci_close_dev
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Aug 12, 2015 at 6:07 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Add hci_close_dev for commands using hci_open_dev, this is mostly to be
> consistent with other commands that do cleanup but in practice makes no
> difference since hciconfig will exit anyway.
> ---
>  tools/hciconfig.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/tools/hciconfig.c b/tools/hciconfig.c
> index 0e0b790..eac96b0 100644
> --- a/tools/hciconfig.c
> +++ b/tools/hciconfig.c
> @@ -963,6 +963,8 @@ static void cmd_class(int ctl, int hdev, char *opt)
>                         printf("%s, %s\n", major_devices[cls[1] & 0x1f],
>                                 get_minor_device_name(cls[1] & 0x1f, cls[0] >> 2));
>         }
> +
> +       hci_close_dev(hdev);
>  }
>
>  static void cmd_voice(int ctl, int hdev, char *opt)
> @@ -1023,6 +1025,8 @@ static void cmd_voice(int ctl, int hdev, char *opt)
>                 }
>                 printf("\tAir Coding Format: %s\n", acf[vs & 0x03]);
>         }
> +
> +       hci_close_dev(s);
>  }
>
>  static void cmd_delkey(int ctl, int hdev, char *opt)
> @@ -1462,6 +1466,8 @@ static void cmd_inq_parms(int ctl, int hdev, char *opt)
>                 printf("\tInquiry interval: %u slots (%.2f ms), window: %u slots (%.2f ms)\n",
>                                 interval, (float)interval * 0.625, window, (float)window * 0.625);
>         }
> +
> +       hci_close_dev(s);
>  }
>
>  static void cmd_page_parms(int ctl, int hdev, char *opt)
> @@ -1533,6 +1539,8 @@ static void cmd_page_parms(int ctl, int hdev, char *opt)
>                         interval, (float)interval * 0.625,
>                         window, (float)window * 0.625);
>         }
> +
> +       hci_close_dev(s);
>  }
>
>  static void cmd_page_to(int ctl, int hdev, char *opt)
> @@ -1597,6 +1605,8 @@ static void cmd_page_to(int ctl, int hdev, char *opt)
>                 printf("\tPage timeout: %u slots (%.2f ms)\n",
>                                 timeout, (float)timeout * 0.625);
>         }
> +
> +       hci_close_dev(s);
>  }
>
>  static void cmd_afh_mode(int ctl, int hdev, char *opt)
> @@ -1630,6 +1640,8 @@ static void cmd_afh_mode(int ctl, int hdev, char *opt)
>                 print_dev_hdr(&di);
>                 printf("\tAFH mode: %s\n", mode == 1 ? "Enabled" : "Disabled");
>         }
> +
> +       hci_close_dev(dd);
>  }
>
>  static void cmd_ssp_mode(int ctl, int hdev, char *opt)
> @@ -1664,6 +1676,8 @@ static void cmd_ssp_mode(int ctl, int hdev, char *opt)
>                 printf("\tSimple Pairing mode: %s\n",
>                         mode == 1 ? "Enabled" : "Disabled");
>         }
> +
> +       hci_close_dev(dd);
>  }
>
>  static void print_rev_ericsson(int dd)
> @@ -1790,6 +1804,9 @@ static void cmd_revision(int ctl, int hdev, char *opt)
>                 printf("\tUnsupported manufacturer\n");
>                 break;
>         }
> +
> +       hci_close_dev(dd);
> +
>         return;
>  }
>
> --
> 2.4.3

Applied.


-- 
Luiz Augusto von Dentz
