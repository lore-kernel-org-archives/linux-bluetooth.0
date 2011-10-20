Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1319115184-16116-1-git-send-email-frederic.danis@linux.intel.com>
References: <1319115184-16116-1-git-send-email-frederic.danis@linux.intel.com>
Date: Thu, 20 Oct 2011 17:27:30 -0300
Message-ID: <CAJdJm_McykSKCoaGZ-9Yi71cciB6zrhKe0wHEyV4-qU9xzBzfQ@mail.gmail.com>
Subject: Re: [PATCH v3] Simplify eir_parse_uuid* functions
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Danis?=
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

2011/10/20 Frédéric Danis <frederic.danis@linux.intel.com>:
> +                       if (eir->name)
> +                               g_free(eir->name);

You don't need to check for NULL before passing a pointer to g_free().
IMHO just "g_free(eir->name)" is clearer.

> +
> +                       eir->name = g_strndup((char *) &eir_data[2],
>                                                                field_len - 1);
> -                       else
> -                               eir->name = g_strdup("");
>                        eir->name_complete = eir_data[1] == EIR_NAME_COMPLETE;
>                        break;

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
