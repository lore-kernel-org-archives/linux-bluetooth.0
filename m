Return-Path: <cyrus@holtmann.org>
Message-ID: <1384017476.3880.40.camel@nuvo>
Subject: Re: obexd broken for absolute paths
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Sat, 09 Nov 2013 18:17:56 +0100
In-Reply-To: <1383938500.3880.23.camel@nuvo>
References: <1383938500.3880.23.camel@nuvo>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2013-11-08 at 20:21 +0100, Bastien Nocera wrote:
> Heya,
> 
> I was trying to test gnome-user-share's Bluetooth support for BlueZ 5,
> and was quite surprised it didn't work one bit, with transfers failing
> as soon as they were created.
> 
> I made this simple change to test/simple-obex-agent so you could
> replicate the failure. Obviously, change the download path to exist on
> your system:
> -               return properties['Name']
> +               return ("%s/%s" % ("/home/hadess/Downloads/", properties['Name']))
> 
> This will see OBEX Push transfers fail as soon as accepted.

Turns out this is a feature of filesystem plugin in obexd, and a bit of
a problem as well:
- There's no way to change the folder without changing the service file
- It doesn't default to use the XDG_RUNTIME_DIR 

> I must also mention the dreadful code in agent_reply() in obexd/src/manager.c:
>                 const char *slash = strrchr(name, '/');
>                 DBG("Agent replied with %s", name);
>                 if (!slash) {
>                         agent->new_name = g_strdup(name);
>                         agent->new_folder = NULL;
>                 } else {
>                         agent->new_name = g_strdup(slash + 1); 
>                         agent->new_folder = g_strndup(name, slash - name);
>                 }
> 
> Please use g_path_get_basename() and g_path_get_dirname(). This is even
> a security issue because I could pass relative paths and expect some
> system file to get overwritten.

I've sent a patch for this.

Cheers

