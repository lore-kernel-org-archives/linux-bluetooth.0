Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <523397950.738031454943754387.JavaMail.weblogic@epmlwas06a>
References: <523397950.738031454943754387.JavaMail.weblogic@epmlwas06a>
Date: Thu, 11 Feb 2016 16:14:06 +0200
Message-ID: <CABBYNZ+10QhEwqerBjre9Q6-35Vgd7tgPbV+GD4-Mus6SB5Kww@mail.gmail.com>
Subject: Re: [PATCH 1/1] adapter: Fix memory leak
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"syamsidhardh@gmail.com" <syamsidhardh@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

On Mon, Feb 8, 2016 at 5:02 PM, SYAM SIDHARDHAN <s.syam@samsung.com> wrote:
>
> Hi,
> ------- Original Message -------
> Sender : SYAM SIDHARDHAN<s.syam@samsung.com> ./Senior Chief Engineer/SRI-Bangalore-System & Connectivity/Samsung Electronics
> Date : Feb 03, 2016 20:28 (GMT+05:30)
> Title : [PATCH 1/1] adapter: Fix memory leak
>
> if strlen(str) < 32 then there is a memory leak.
> ---
> src/adapter.c |    5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index b184eed..f4fbf82 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -3091,12 +3091,12 @@ static GSList *get_ltk_info(GKeyFile *key_file, const char *peer,
> static struct irk_info *get_irk_info(GKeyFile *key_file, const char *peer,
> uint8_t bdaddr_type)
> {
> - struct irk_info *irk;
> + struct irk_info *irk = NULL;
> char *str;
>
> str = g_key_file_get_string(key_file, "IdentityResolvingKey", "Key", NULL);
> if (!str || strlen(str) < 32)
> - return NULL;
> + goto failed;
>
> irk = g_new0(struct irk_info, 1);
>
> @@ -3108,6 +3108,7 @@ static struct irk_info *get_irk_info(GKeyFile *key_file, const char *peer,
> else
> str2buf(&str[0], irk->val, sizeof(irk->val));
>
> +failed:
> g_free(str);
>
> return irk;
> --
> 1.7.9.5
>

Applied, thanks.


-- 
Luiz Augusto von Dentz
