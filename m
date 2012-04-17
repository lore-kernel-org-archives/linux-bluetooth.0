Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1334127438-27617-5-git-send-email-mikel.astiz.oss@gmail.com>
References: <1334127438-27617-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1334127438-27617-5-git-send-email-mikel.astiz.oss@gmail.com>
Date: Tue, 17 Apr 2012 15:30:39 +0300
Message-ID: <CABBYNZKqA0jNU-3KzOSVYi2a5UBkD7A_uswQCD=Nn5zdZFdSoQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v0 4/7] media: Support multiple transports per endpoint
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Wed, Apr 11, 2012 at 9:57 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> +static struct media_transport *get_unique_transport(
> +                                       struct media_endpoint *endpoint)
> +{
> +       if (endpoint->transports == NULL)
> +               return NULL;
> +
> +       if (endpoint->transports->next != NULL)
> +               return NULL;
> +
> +       return endpoint->transports->data;
>  }

This doesn't look necessary in case of A2DP the endpoint cannot be
reused because of in_use flag, but overall the rest looks good.

-- 
Luiz Augusto von Dentz
