Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1412654816-14971-6-git-send-email-gowtham.ab@samsung.com>
References: <1412654816-14971-1-git-send-email-gowtham.ab@samsung.com>
	<1412654816-14971-6-git-send-email-gowtham.ab@samsung.com>
Date: Wed, 8 Oct 2014 14:12:05 +0300
Message-ID: <CABBYNZK2TpB61PvCs9L8t_LxV50+mifKZo9C67-0U4JzLm6wBw@mail.gmail.com>
Subject: Re: [PATCH 5/6] obexd/messages: Add prototypes for MASInstance response
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Oct 7, 2014 at 7:06 AM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> ---
>  obexd/plugins/messages.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/obexd/plugins/messages.h b/obexd/plugins/messages.h
> index 00a16b1..3aaeec1 100644
> --- a/obexd/plugins/messages.h
> +++ b/obexd/plugins/messages.h
> @@ -307,3 +307,19 @@ int messages_set_delete(void *session, const char *handle, uint8_t value,
>   * session: Backend session.
>   */
>  void messages_abort(void *session);
> +
> +
> +
> +/* Retrieves MAS Instance Information for the given mas-instance id.
> + *
> + * session: Backend session.
> + * mas_id: MAS Instance id requested by the MCE.
> + *
> + * Callback shall be called for every mas_instance_id request received from MCE.
> + */
> +typedef void (*messages_mas_instance_info_cb)(void *session, int err,
> +               uint16_t size, const char *name, void *user_data);
> +
> +int messages_get_mas_instance_info(void *session, uint16_t mas_instance_id,
> +                               messages_mas_instance_info_cb callback,
> +                               void *user_data);
> --
> 1.9.1

You can drop using mas here since it is pretty obvious what it is for,
also Im not sure we need the size in the callback since we can use
strlen there.


-- 
Luiz Augusto von Dentz
