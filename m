Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1339742339-15816-1-git-send-email-gustavo@padovan.org>
References: <1339742339-15816-1-git-send-email-gustavo@padovan.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Fri, 15 Jun 2012 10:30:13 -0300
Message-ID: <CAMOw1v4-fXUj6CFrjeQ2PeiY+O2JvfMHfiQqt0asxYstH8QPyg@mail.gmail.com>
Subject: Re: [PATCH] TODO: add BlueZ 5 tasks
To: Gustavo Padovan <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jun 15, 2012 at 3:38 AM, Gustavo Padovan <gustavo@padovan.org> wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
>
> ---
>  TODO |   33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/TODO b/TODO
> index 17e9848..355a344 100644
> --- a/TODO
> +++ b/TODO
> @@ -30,6 +30,39 @@ General
>   Priority: Low
>   Complexity: C1
>
> +
> +BlueZ 5
> +==========
> +
> +- Make mgmtops part of bluetooth core. mgmt will be the only way to communicate
> +  with the kernel in BlueZ so a plugin is not needed anymore.
> +
> +  Priority: High
> +  Complexity: C2
> +
> +- Move BlueZ to use standard DBus properties and object manager
> +
> +  Priority: High
> +  Complexity: C2
> +
> +- Reorganize source tree according to RFC sent to linux-bluetooth (Subject:
> +  [RFC] Reorganizing the BlueZ source tree)
> +
> +  Priority: High
> +  Complexity: C1
> +
> +- Remove deprecated DBus signal from audio code. New ones need to be added to
> +  replace the deprecated ones.
> +
> +  Priority: High
> +  Complexity: C2
> +
> +- Remove deprecated code/DBus methods.
> +
> +  Priority: High
> +  Complexity: C2

Besides the complexity being inverted from my POV, ack.

The move to OM and DBus.Properties are much more complex the removing
deprecated methods/code.


Lucas De Marchi
