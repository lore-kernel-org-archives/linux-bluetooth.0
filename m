Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1439202265-24485-1-git-send-email-luiz.dentz@gmail.com>
References: <1439202265-24485-1-git-send-email-luiz.dentz@gmail.com>
Date: Tue, 11 Aug 2015 13:34:26 +0300
Message-ID: <CABBYNZLVag6UOGxrf8+SQGDwpXHs4nXYbrXAM6ma_0yvy1+d8A@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] audio/avdtp: Fix suspending only the first SEID
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Aug 10, 2015 at 1:24 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> AVDTP_Suspend can contain several Stream Endpoing IDs to be suspended.
> ---
>  android/avdtp.c        | 2 +-
>  profiles/audio/avdtp.c | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/android/avdtp.c b/android/avdtp.c
> index 7e61280..1f79e74 100644
> --- a/android/avdtp.c
> +++ b/android/avdtp.c
> @@ -1678,7 +1678,7 @@ static gboolean avdtp_suspend_cmd(struct avdtp *session, uint8_t transaction,
>         for (i = 0; i < seid_count; i++, seid++) {
>                 failed_seid = seid->seid;
>
> -               sep = find_local_sep_by_seid(session, req->first_seid.seid);
> +               sep = find_local_sep_by_seid(session, seid->seid);
>                 if (!sep || !sep->stream) {
>                         err = AVDTP_BAD_ACP_SEID;
>                         goto failed;
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index 37f7a59..9c33373 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -1822,8 +1822,7 @@ static gboolean avdtp_suspend_cmd(struct avdtp *session, uint8_t transaction,
>         for (i = 0; i < seid_count; i++, seid++) {
>                 failed_seid = seid->seid;
>
> -               sep = find_local_sep_by_seid(session,
> -                                       req->first_seid.seid);
> +               sep = find_local_sep_by_seid(session, seid->seid);
>                 if (!sep || !sep->stream) {
>                         err = AVDTP_BAD_ACP_SEID;
>                         goto failed;
> --
> 2.1.0

Applied.



-- 
Luiz Augusto von Dentz
