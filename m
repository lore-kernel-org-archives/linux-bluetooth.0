Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1338453008-15947-2-git-send-email-frederic.dalleau@linux.intel.com>
References: <1338453008-15947-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1338453008-15947-2-git-send-email-frederic.dalleau@linux.intel.com>
Date: Thu, 31 May 2012 12:38:55 +0300
Message-ID: <CABBYNZ++UoBw46_+BbCb0eJ1Utt_8XNtk_tJJy7yaE3bc1V4Ow@mail.gmail.com>
Subject: Re: [PATCH] network: Reply to extensions at connection setup
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Thu, May 31, 2012 at 11:30 AM, Frédéric Dalleau
<frederic.dalleau@linux.intel.com> wrote:
> -       if (req->type == BNEP_CONTROL &&
> +       if ((req->type & ~BNEP_EXT_HEADER) == BNEP_CONTROL &&
>                                req->ctrl > BNEP_FILTER_MULT_ADDR_RSP) {
>                uint8_t pkt[3];
>
> @@ -390,7 +416,8 @@ static gboolean bnep_setup(GIOChannel *chan,
>                return FALSE;
>        }
>
> -       if (req->type != BNEP_CONTROL || req->ctrl != BNEP_SETUP_CONN_REQ)
> +       if ((req->type & ~BNEP_EXT_HEADER) != BNEP_CONTROL ||
> +                               req->ctrl != BNEP_SETUP_CONN_REQ)
>                return FALSE;
>

Perhaps you can have a macro for getting just the header type without
the extension bit e.g. BNEP_HEADER(type) ((type) & ~BNEP_EXT_HEADER)

-- 
Luiz Augusto von Dentz
