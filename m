Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1291954417-18138-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1291954417-18138-1-git-send-email-claudio.takahasi@openbossa.org>
Date: Fri, 10 Dec 2010 12:31:32 +0200
Message-ID: <AANLkTik8pqd0uaV2kVaeenBOfTPrVeO0YuW2mfQzJy1J@mail.gmail.com>
Subject: Re: [PATCH] Initial draft of Application registration API
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Dec 10, 2010 at 6:13 AM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
>  doc/attribute-api.txt |   44 +++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 43 insertions(+), 1 deletions(-)
>
> diff --git a/doc/attribute-api.txt b/doc/attribute-api.txt
> index 23808e6..ab62313 100644
> --- a/doc/attribute-api.txt
> +++ b/doc/attribute-api.txt
> @@ -23,7 +23,6 @@ fully transparent and a differentiation becomes unimportant in the future.
>  A service consists of some generic service information and a set of
>  characteristics. All characteristic are presented as object path as well.
>
> -
>  Local Service hierarchy
>  =======================
>
> @@ -37,6 +36,35 @@ Methods
>  Properties
>
>
> +Adapter Application Attribute hierarchy
> +=======================================
> +
> +Service                org.bluez
> +Interface      org.bluez.Attrib
> +Object path    [variable prefix]/{hci0,hci1,...}
> +
> +Methods                void RegisterApplication(array{string} uuids, dict settings)
> +
> +                       Method to allow applications to control automatic
> +                       connections to known devices.
> +
> +                       "settings" dictionary defines the wanted application
> +                       connection parameters. Defined values:
> +                       - Latency: low, medium and high
> +                       - BandWidth: TBD
> +                       - AutoConnect: boolean
> +
> +                       Latency parameter controls the scan and connect
> +                       interval. AutoConnect parameter controls automatic
> +                       connections if a bonded device emits a connectable
> +                       advertising report.
> +
> +               void UnregisterApplication(array{string} uuids)
> +
> +                       Unregister a previously registered application.
> +                       Remotes are automatically disconnected if no more
> +                       applications are interested in the given services.
> +
>  Device Service hierarchy
>  ========================
>
> @@ -154,3 +182,17 @@ Object path        freely definable
>  Methods                void ValueChanged(object characteristic, array{byte})
>
>                        New raw value of the Characteristic Value attribute.
> +
> +Adapter Application Agent hierarchy
> +====================================
> +
> +Service                unique name
> +Interface      org.bluez.Application
> +Object path    freely definable
> +
> +Methods                void Connected(object device, array{object} services)
> +
> +                       Indication that a given remote device was found
> +                       and the connection has been established. service
> +                       object represents an instance of a primary service
> +                       that the application is interested in.

It seems it is missing the object path on RegisterAplication to be
used to call Connected, also I could see some use of this Application
Agent for regular (non-LE) profiles, but of course the settings would
have a bit different purpose for those.

-- 
Luiz Augusto von Dentz
Computer Engineer
