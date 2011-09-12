Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1315524770-12000-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1315524770-12000-1-git-send-email-lucas.demarchi@profusion.mobi>
Date: Mon, 12 Sep 2011 18:05:01 +0300
Message-ID: <CABBYNZJtK8bdzmUsviafYQbvfxhX=6AG5=Jm4Hj62L9_1Chbcg@mail.gmail.com>
Subject: Re: [PATCH hcidump] avrcp: fix name of metadata field
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org,
	David Stockwell <dstockwell@frequency-one.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Fri, Sep 9, 2011 at 2:32 AM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
> Metadata field number 0x7 should be the track duration and not the
> progress of the track playback. Thus rename it to a better description.
> ---
>  parser/avrcp.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/parser/avrcp.c b/parser/avrcp.c
> index f8e4443..0b98a3e 100644
> --- a/parser/avrcp.c
> +++ b/parser/avrcp.c
> @@ -166,7 +166,7 @@
>  #define AVRCP_MEDIA_ATTRIBUTE_TRACK    0x4
>  #define AVRCP_MEDIA_ATTRIBUTE_TOTAL    0x5
>  #define AVRCP_MEDIA_ATTRIBUTE_GENRE    0x6
> -#define AVRCP_MEDIA_ATTRIBUTE_PROGRESS 0x7
> +#define AVRCP_MEDIA_ATTRIBUTE_DURATION 0x7
>
>  /* play status */
>  #define AVRCP_PLAY_STATUS_STOPPED      0x00
> @@ -909,8 +909,8 @@ static const char *mediattr2str(uint32_t attr)
>                return "Track Total";
>        case AVRCP_MEDIA_ATTRIBUTE_GENRE:
>                return "Genre";
> -       case AVRCP_MEDIA_ATTRIBUTE_PROGRESS:
> -               return "Progress";
> +       case AVRCP_MEDIA_ATTRIBUTE_DURATION:
> +               return "Track duration";
>        default:
>                return "Reserved";
>        }
> --
> 1.7.6.1

Ack

@David: Lets keep hcidump simple, if we start doing enums for
everything in hcidump we would just introduce more code for almost
nothing back for a tracing tool.

-- 
Luiz Augusto von Dentz
