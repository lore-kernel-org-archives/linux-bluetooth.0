Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1499357295-22470-1-git-send-email-s.syam@samsung.com>
References: <CGME20170706160048epcas5p2e073fb00c373bc8b9fe0413505b5f65b@epcas5p2.samsung.com>
 <1499357295-22470-1-git-send-email-s.syam@samsung.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 7 Jul 2017 10:43:51 +0300
Message-ID: <CABBYNZJ1pvf9aYhZ5Z7w=vdBT0D4y=wtj-5N3Mz_BoiYOWbLhA@mail.gmail.com>
Subject: Re: [PATCH 1/1] obexd: Fix memory leak in phonebook-dummy
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

On Thu, Jul 6, 2017 at 7:08 PM, Syam Sidhardhan <s.syam@samsung.com> wrote:
> g_build_filename() returns a newly-allocated string
> that must be freed with g_free().
> ---
>  obexd/plugins/phonebook-dummy.c |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/obexd/plugins/phonebook-dummy.c b/obexd/plugins/phonebook-dummy.c
> index 29ae889..b9e3a0d 100644
> --- a/obexd/plugins/phonebook-dummy.c
> +++ b/obexd/plugins/phonebook-dummy.c
> @@ -524,6 +524,9 @@ void *phonebook_get_entry(const char *folder, const char *id,
>         filename = g_build_filename(root_folder, folder, id, NULL);
>
>         fd = open(filename, O_RDONLY);
> +
> +       g_free(filename);
> +
>         if (fd < 0) {
>                 DBG("open(): %s(%d)", strerror(errno), errno);
>                 if (err)
> --
> 1.7.9.5

Applied, thanks.

-- 
Luiz Augusto von Dentz
