Return-Path: <cyrus@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <D964A4DB-60BA-4B95-A970-4D7E3E289670@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: "Liu, Raymond" <raymond.liu@intel.com>
In-Reply-To: <0463F45F3606F4428ED35AC8C709F92E0217AAF9@pdsmsx502.ccr.corp.intel.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Can we change org.openobex.Client's dbus node path?
Date: Mon, 24 Nov 2008 09:29:18 +0100
References: <0463F45F3606F4428ED35AC8C709F92E0217A981@pdsmsx502.ccr.corp.intel.com> <CD8AC205-7C97-4078-A211-871D62407247@holtmann.org> <0463F45F3606F4428ED35AC8C709F92E0217AA44@pdsmsx502.ccr.corp.intel.com> <C0D77808-B8E7-4BF3-81D8-52EE39667C6C@holtmann.org> <0463F45F3606F4428ED35AC8C709F92E0217AAF9@pdsmsx502.ccr.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Raymond,

>> this is a bug in gdbus then. The exactly same code is used in
>> bluetoothd and connmand so it seems weird. Did you try to debug it
>> where it actually fails to get this wrong? Are we missing some
>> "invalidate parent" calls?
>>
> 	I found the reason. During interface register object_path_unref did  
> call invalidate_parent_data. But for our case: we have path "/" at  
> first, and we register interface at "/org/openobex/Session0", there  
> are no data for "/org/openobex", so no any parent introspect data is  
> invalidated. But the whole /org/openobex path is created for the  
> first time. So actually the "/"'s introspect data need to be  
> invalidated.

I suspected that this might be the reason. I fixed a similar bug some  
time ago. Funny that BlueZ didn't run into this since it might suffer  
the same with the new modified adapter and device object paths.

> I modify the code as below to invalidate the parent data up to "/",  
> so that it will fix this problem.
>
> -------------------------------------------------------------------
> diff --git a/gdbus/object.c b/gdbus/object.c
> old mode 100644
> new mode 100755
> index a417ab9..074f40b
> --- a/gdbus/object.c
> +++ b/gdbus/object.c
> @@ -299,25 +299,28 @@ static void  
> invalidate_parent_data(DBusConnection *conn, const char *child_path)
>        char *parent_path, *slash;
>
>        parent_path = g_strdup(child_path);
> -       slash = strrchr(parent_path, '/');
> -       if (!slash)
> -               goto done;
> -
> -       *slash = '\0';
> -       if (!strlen(parent_path))
> -               goto done;
> +       do{
> +               slash = strrchr(parent_path, '/');
> +               if (!slash)
> +                       break;
>
> -       if (!dbus_connection_get_object_path_data(conn, parent_path,
> -                                                       (void *)  
> &data))
> -               goto done;
> +               if (slash == parent_path) {
> +                       *(slash+1) = '\0';
> +               } else {
> +                       *slash = '\0';
> +               }
>
> -       if (!data)
> -               goto done;
> +               if (!dbus_connection_get_object_path_data(conn,  
> parent_path,
> +                                                                
> (void *) &data))
> +                       continue;
>
> -       g_free(data->introspect);
> -       data->introspect = NULL;
> +               if (!data)
> +                       continue;
>
> -done:
> +               g_free(data->introspect);
> +               data->introspect = NULL;
> +       }while(slash != parent_path);
> +
>        g_free(parent_path);
> }
>
> -------------------------------------------------------------------------
>
> However, It got some drawback here: if part of the parent path did  
> exist before, and the parent's parents data do not need to change.  
> This fix will do much more thing then it should. I guess to found  
> out all the change up to the necessay level will need more code. So  
> I just make it simple here.

so first, please fix the coding style here. I can tell from just the  
pure email that you are mixing up tabs and spaces and also that you  
are missing whitespaces here and there. Check that your mail client  
doesn't mangle it. If in doubt send it as attachment.

Regards

Marcel

