Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1352992159-11559-4-git-send-email-mikel.astiz.oss@gmail.com>
References: <1352992159-11559-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1352992159-11559-4-git-send-email-mikel.astiz.oss@gmail.com>
Date: Fri, 16 Nov 2012 15:29:00 +0200
Message-ID: <CABBYNZKouGGa7dbr3J87x3oaaV=WpAyEHGQkNQGL-wc_MrxJGg@mail.gmail.com>
Subject: Re: [RFC v1 03/16] manager: Extend FindAdapter with "default" pattern
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Thu, Nov 15, 2012 at 5:09 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> Extend the supported values in the given pattern in order to return the
> default adapter if "default" is given.
> ---
>  doc/manager-api.txt | 1 +
>  src/manager.c       | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/doc/manager-api.txt b/doc/manager-api.txt
> index 8497141..b0d534d 100644
> --- a/doc/manager-api.txt
> +++ b/doc/manager-api.txt
> @@ -27,6 +27,7 @@ Object path   /
>                         patterns are "hci0" or "00:11:22:33:44:55". Other
>                         supported values are:
>                                 "any"
> +                               "default"
>
>                         Possible errors: org.bluez.Error.InvalidArguments
>                                          org.bluez.Error.NoSuchAdapter
> diff --git a/src/manager.c b/src/manager.c
> index 3088dd9..79d049b 100644
> --- a/src/manager.c
> +++ b/src/manager.c
> @@ -110,7 +110,9 @@ static DBusMessage *find_adapter(DBusConnection *conn,
>         } else if (!strncmp(pattern, "hci", 3) && strlen(pattern) >= 4) {
>                 dev_id = atoi(pattern + 3);
>                 adapter = manager_find_adapter_by_id(dev_id);
> -       } else {
> +       } else if (!strcmp(pattern, "default"))
> +               adapter = manager_find_adapter_by_id(default_adapter_id);
> +       else {
>                 bdaddr_t bdaddr;
>                 str2ba(pattern, &bdaddr);
>                 adapter = manager_find_adapter(&bdaddr);
> --
> 1.7.11.7

Hmm, I though we would have a property e.g. DefaultAdapter because
with ObjectManager you also get the properties so once you do
GetManagedObjects you discover what is the default one. It could also
be a property of the Adapter interface e.g. boolean Default but if it
changes we actually have to emit 2 signals so it would no be an atomic
operation as it should be.


--
Luiz Augusto von Dentz
