Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1380291161-10232-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1380291161-10232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1380291161-10232-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Fri, 27 Sep 2013 12:04:54 -0400
Message-ID: <CAJdJm_NB0qsJrVxqpXPrt3TKKOOzvVRYzkbgX6Ha6naEjHS-ZA@mail.gmail.com>
Subject: Re: [RFC 03/16] android: Enable Socket interface
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Sep 27, 2013 at 10:12 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> +static bool is_profile(const char *profile, const char *str)
> +{
> +       return (strlen(str) == strlen(profile)) &&
> +               (strncmp(profile, str, strlen(str)) == 0);
> +}

If you are using strlen() (which requires both strings have the '\0'
terminator) anyway, why not use just:

return strcmp(profile, str) == 0;

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
