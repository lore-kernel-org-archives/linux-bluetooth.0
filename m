Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1380291161-10232-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1380291161-10232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1380291161-10232-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Fri, 27 Sep 2013 13:17:26 -0400
Message-ID: <CAJdJm_O5Og9+3EfB3RgT1c2oF-B1rrQvRi3dGzpHZ3c0j=NXMg@mail.gmail.com>
Subject: Re: [RFC 12/16] android: Add cap to bind to port < 1024
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Sep 27, 2013 at 10:12 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> +/**
> + * Include <sys/capability.h> for host build and
> + * also for Android 4.3 when it is added to bionic
> + */
> +#if (defined(__ANDROID_API__) && (__ANDROID_API__ > 17)) || \
> +                                       !defined(__ANDROID_API__)

I think the line below is equivalent to the above but easier to read:

#if !defined(__ANDROID_API__) || (__ANDROID_API__ > 17)

> +static bool android_set_aid_and_cap()
> +{
> +       struct __user_cap_header_struct header;
> +       struct __user_cap_data_struct cap;
> +
> +       DBG("%s: pid %d uid %d gid %d", __func__, getpid(), getuid(), getgid());
> +
> +       header.version = _LINUX_CAPABILITY_VERSION;
> +       header.pid = getpid();
> +       if (capget(&header, &cap) < 0)
> +               error("%s: capget(): %s", __func__, strerror(errno));

It seems you need to "return false" above, otherwise "cap" may have
uninitialized data.

> +
> +       DBG("%s: Cap data 0x%x, 0x%x, 0x%x\n", __func__, cap.effective,
> +                                       cap.permitted, cap.inheritable);
> +
> +       prctl(PR_SET_KEEPCAPS, 1, 0, 0, 0);
> +
> +       header.version = _LINUX_CAPABILITY_VERSION;
> +       header.pid = 0;
> +
> +       cap.effective = cap.permitted = cap.inheritable =
> +               1 << CAP_NET_RAW |
> +               1 << CAP_NET_ADMIN |
> +               1 << CAP_NET_BIND_SERVICE |
> +               1 << CAP_SYS_RAWIO |
> +               1 << CAP_SYS_NICE |
> +               1 << CAP_SETGID;
> +
> +       if (capset(&header, &cap)) {
> +               error("%s: capset(): %s", __func__, strerror(errno));
> +               return false;
> +       }
> +
> +       DBG("%s: capset(): Success", __func__);
> +       return true;
> +}
> +
>  int main(int argc, char *argv[])
>  {
>         GOptionContext *context;
> @@ -357,6 +407,9 @@ int main(int argc, char *argv[])
>         /* no need to keep parsed option in memory */
>         free_options();
>
> +       if (android_set_aid_and_cap() == false)
> +               exit(1);

IIRC Marcel suggested using EXIT_FAILURE and EXIT_SUCCESS instead of "exit(1)".

> +
>         init_mgmt_interface();
>
>         DBG("Entering main loop");

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
