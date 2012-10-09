Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1349798318-12689-8-git-send-email-frederic.danis@linux.intel.com>
References: <1349798318-12689-1-git-send-email-frederic.danis@linux.intel.com>
	<1349798318-12689-8-git-send-email-frederic.danis@linux.intel.com>
Date: Tue, 9 Oct 2012 13:04:36 -0400
Message-ID: <CAJdJm_N5G+qpH8XLav0VA8t1h+PAROB4g9PaOnxSR+NPAjEhAw@mail.gmail.com>
Subject: Re: [PATCH 7/7] adapter: Move saved config to ini-file format
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric_Danis?=
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frédéric,

On Tue, Oct 9, 2012 at 11:58 AM, Frédéric Danis
<frederic.danis@linux.intel.com> wrote:
> +       if (read_pairable_timeout(address, &timeout) == 0)
> +               g_key_file_set_integer(key_file, "General",
> +                                               "PairableTimeout", timeout);
> +
> +       if (read_pairable_timeout(address, &timeout) == 0)
> +               g_key_file_set_integer(key_file, "General",
> +                                               "DiscoverableTimeout", timeout);
> +

This second if() should use read_discoverable_timeout().

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
