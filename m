Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1338286766-5368-2-git-send-email-frederic.dalleau@linux.intel.com>
References: <1338286766-5368-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1338286766-5368-2-git-send-email-frederic.dalleau@linux.intel.com>
Date: Tue, 29 May 2012 17:05:43 +0300
Message-ID: <CABBYNZKw=--VW-B-y3UNuTNXfk7Cms_Hy=ZECD3w-Rs5x6abRQ@mail.gmail.com>
Subject: Re: [RFC] network: Reply to extensions at connection setup
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Tue, May 29, 2012 at 1:19 PM, Frédéric Dalleau
<frederic.dalleau@linux.intel.com> wrote:
> +       /* Reply to extensions */
> +       if (req->type & BNEP_EXT_HEADER) {
> +               uint8_t pkt[3];
> +               int l;
> +
> +               l = 3 + 2 * req->uuid_size;
> +               ext = packet + l;
> +               n -= l;
> +
> +ext:
> +               if (n <= 3)
> +                       return FALSE;
> +
> +               pkt[0] = BNEP_CONTROL;
> +               pkt[1] = BNEP_CMD_NOT_UNDERSTOOD;
> +               pkt[2] = ext[2];
> +
> +               send(sk, pkt, sizeof(pkt), 0);
> +
> +               if ((ext[0] & BNEP_EXT_HEADER) == 0)
> +                       return FALSE;
> +
> +               l = 2 + ext[1];
> +               ext += l;
> +               n -= l;
> +               goto ext;
> +       }
> +

It looks bad to use goto backwards in the code, specially when you
could use a for loop or something like that. Maybe you should this
part in a separate function where you can initialize the variables and
responding to each extension request, also it would be useful to have
the structures of the extension so you can do sizeof and things like
that to avoid using magic numbers.


-- 
Luiz Augusto von Dentz
