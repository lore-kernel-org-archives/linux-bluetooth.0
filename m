Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20161219111621.16199-1-luiz.dentz@gmail.com>
References: <20161219111621.16199-1-luiz.dentz@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 20 Dec 2016 11:58:33 +0200
Message-ID: <CABBYNZ+dmT7kZDaK9okZqHFs5cAWkAzqYnsudX2Rbjde+n96Zw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] tools/test-runner: Fix not creating /usr/share/dbus-1/system.conf
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Dec 19, 2016 at 1:16 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Apparently this is the new location where D-Bus will look for its
> configuration so just creare a symlink to /etc/dbus-1/system.conf.
> ---
>  tools/test-runner.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/test-runner.c b/tools/test-runner.c
> index 9b54426..fb8f7e2 100644
> --- a/tools/test-runner.c
> +++ b/tools/test-runner.c
> @@ -419,6 +419,10 @@ static void create_dbus_system_conf(void)
>
>         fclose(fp);
>
> +       if (symlink("/etc/dbus-1/system.conf",
> +                               "/usr/share/dbus-1/system.conf") < 0)
> +               perror("Failed to create system.conf symlink");
> +
>         mkdir("/run/dbus", 0755);
>  }
>
> --
> 2.9.3

Applied.


-- 
Luiz Augusto von Dentz
