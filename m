Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1413382102-4049-4-git-send-email-gowtham.ab@samsung.com>
References: <1413382102-4049-1-git-send-email-gowtham.ab@samsung.com>
	<1413382102-4049-4-git-send-email-gowtham.ab@samsung.com>
Date: Thu, 16 Oct 2014 10:59:39 +0300
Message-ID: <CABBYNZLHUAtBdcnRbWcSO+QbbtuUV4u4JOvi2K1rTiXdNrH6iQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] Fix enum coding-style
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Oct 15, 2014 at 5:08 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Fix the enum coding-style as per the new coding style doc.

I guess the tabs confused you a little bit, the coding style is more
about having the values in case they come from a specification, the
alignment of the values don't need to be exactly as in the example in
the coding style.

> ---
>  lib/uuid.h                    |  8 ++++----
>  profiles/cups/cups.h          | 16 ++++++++--------
>  profiles/health/hdp_types.h   |  4 ++--
>  profiles/proximity/reporter.h |  6 +++---
>  profiles/time/server.c        | 20 ++++++++++----------
>  5 files changed, 27 insertions(+), 27 deletions(-)
>
> diff --git a/lib/uuid.h b/lib/uuid.h
> index 8303772..f05888a 100644
> --- a/lib/uuid.h
> +++ b/lib/uuid.h
> @@ -142,10 +142,10 @@ extern "C" {
>
>  typedef struct {
>         enum {
> -               BT_UUID_UNSPEC = 0,
> -               BT_UUID16 = 16,
> -               BT_UUID32 = 32,
> -               BT_UUID128 = 128,
> +               BT_UUID_UNSPEC =        0,
> +               BT_UUID16 =             16,
> +               BT_UUID32 =             32,
> +               BT_UUID128 =            128,
>         } type;
>         union {
>                 uint16_t  u16;
> diff --git a/profiles/cups/cups.h b/profiles/cups/cups.h
> index f4e0c01..dbea1bf 100644
> --- a/profiles/cups/cups.h
> +++ b/profiles/cups/cups.h
> @@ -21,14 +21,14 @@
>   *
>   */
>
> -enum {                                 /**** Backend exit codes ****/
> -       CUPS_BACKEND_OK = 0,            /* Job completed successfully */
> -       CUPS_BACKEND_FAILED = 1,        /* Job failed, use error-policy */
> -       CUPS_BACKEND_AUTH_REQUIRED = 2, /* Job failed, authentication required */
> -       CUPS_BACKEND_HOLD = 3,          /* Job failed, hold job */
> -       CUPS_BACKEND_STOP = 4,          /* Job failed, stop queue */
> -       CUPS_BACKEND_CANCEL = 5,        /* Job failed, cancel job */
> -       CUPS_BACKEND_RETRY = 6,         /* Failure requires us to retry (BlueZ specific) */
> +enum {                                         /**** Backend exit codes ****/
> +       CUPS_BACKEND_OK =               0,      /* Job completed successfully */
> +       CUPS_BACKEND_FAILED =           1,      /* Job failed, use error-policy */
> +       CUPS_BACKEND_AUTH_REQUIRED =    2,      /* Job failed, authentication required */
> +       CUPS_BACKEND_HOLD =             3,      /* Job failed, hold job */
> +       CUPS_BACKEND_STOP =             4,      /* Job failed, stop queue */
> +       CUPS_BACKEND_CANCEL =           5,      /* Job failed, cancel job */
> +       CUPS_BACKEND_RETRY =            6,      /* Failure requires us to retry (BlueZ specific) */
>  };
>
>  int sdp_search_spp(sdp_session_t *sdp, uint8_t *channel);
> diff --git a/profiles/health/hdp_types.h b/profiles/health/hdp_types.h
> index b34b5e0..92f461a 100644
> --- a/profiles/health/hdp_types.h
> +++ b/profiles/health/hdp_types.h
> @@ -49,8 +49,8 @@
>  #define HDP_SOURCE_ROLE_AS_STRING      "source"
>
>  typedef enum {
> -       HDP_SOURCE = 0x00,
> -       HDP_SINK = 0x01
> +       HDP_SOURCE =    0x00,
> +       HDP_SINK =      0x01
>  } HdpRole;
>
>  typedef enum {
> diff --git a/profiles/proximity/reporter.h b/profiles/proximity/reporter.h
> index a8e1aac..243db26 100644
> --- a/profiles/proximity/reporter.h
> +++ b/profiles/proximity/reporter.h
> @@ -31,9 +31,9 @@
>  #define POWER_LEVEL_CHR_UUID           0x2A07
>
>  enum {
> -       NO_ALERT = 0x00,
> -       MILD_ALERT = 0x01,
> -       HIGH_ALERT = 0x02,
> +       NO_ALERT =      0x00,
> +       MILD_ALERT =    0x01,
> +       HIGH_ALERT =    0x02,
>  };
>
>  void reporter_device_remove(struct btd_service *service);
> diff --git a/profiles/time/server.c b/profiles/time/server.c
> index 1716a5e..0b6f70b 100644
> --- a/profiles/time/server.c
> +++ b/profiles/time/server.c
> @@ -55,22 +55,22 @@
>  #define CT_TIME_CHR_UUID               0x2A2B
>
>  enum {
> -       UPDATE_RESULT_SUCCESSFUL = 0,
> -       UPDATE_RESULT_CANCELED = 1,
> -       UPDATE_RESULT_NO_CONN = 2,
> -       UPDATE_RESULT_ERROR = 3,
> -       UPDATE_RESULT_TIMEOUT = 4,
> -       UPDATE_RESULT_NOT_ATTEMPTED = 5,
> +       UPDATE_RESULT_SUCCESSFUL =      0,
> +       UPDATE_RESULT_CANCELED =        1,
> +       UPDATE_RESULT_NO_CONN =         2,
> +       UPDATE_RESULT_ERROR =           3,
> +       UPDATE_RESULT_TIMEOUT =         4,
> +       UPDATE_RESULT_NOT_ATTEMPTED =   5,
>  };
>
>  enum {
> -       UPDATE_STATE_IDLE = 0,
> -       UPDATE_STATE_PENDING = 1,
> +       UPDATE_STATE_IDLE =     0,
> +       UPDATE_STATE_PENDING =  1,
>  };
>
>  enum {
> -       GET_REFERENCE_UPDATE = 1,
> -       CANCEL_REFERENCE_UPDATE = 2,
> +       GET_REFERENCE_UPDATE =          1,
> +       CANCEL_REFERENCE_UPDATE =       2,
>  };
>
>  static int encode_current_time(uint8_t value[10])
> --
> 1.9.1
>



-- 
Luiz Augusto von Dentz
