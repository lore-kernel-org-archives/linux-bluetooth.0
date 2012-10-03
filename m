Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1349274401-32012-1-git-send-email-frederic.danis@linux.intel.com>
References: <1349274401-32012-1-git-send-email-frederic.danis@linux.intel.com>
Date: Wed, 3 Oct 2012 16:14:16 -0400
Message-ID: <CAJdJm_Oq2QoSJ-1xQSssL0+Tku4WAqb6nppbe1eAvc1LWoRMKg@mail.gmail.com>
Subject: Re: [PATCH] storage: Move adapter info to adapter.conf
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Danis?=
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Wed, Oct 3, 2012 at 10:26 AM, Frédéric Danis
<frederic.danis@linux.intel.com> wrote:
> +int keyfile_put_string(const char *pathname, const char *group,
> +                               const char *key, const char *value);
> +int keyfile_put_boolean(const char *pathname, const char *group,
> +                               const char *key, gboolean value);
> +int keyfile_put_integer(const char *pathname, const char *group,
> +                               const char *key, int value);
> +
> +char *keyfile_get_string(const char *pathname, const char *group,
> +                               const char *key);

One suggestion (which may or may not be acked by core devs), what
about being consistent here and use:

int keyfile_get_string(const char *pathname, const char *group, const
char *key, char **value);

(i.e. use return value for error and value pointer on last parameter).

> +int keyfile_get_boolean(const char *pathname, const char *group,
> +                               const char *key, gboolean *value);
> +int keyfile_get_integer(const char *pathname, const char *group,
> +                               const char *key, int *value);
> +
> +int keyfile_del(const char *pathname, const char *group, const char *key);
> +
> +typedef void (*keyfile_key_cb) (char *key, char *value, void *data);
> +typedef void (*keyfile_group_cb) (char *group, void *data);
> +
> +int keyfile_foreach_key(const char *pathname, const char *group,
> +                               keyfile_key_cb func, void *data);
> +int keyfile_foreach_group(const char *pathname,
> +                               keyfile_group_cb func, void *data);
> +
> +#endif /* __KEYFILE_H */

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
