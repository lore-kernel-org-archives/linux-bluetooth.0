Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <d3462b2c55fcd4ce9a00826b15ad035c6119a665.camel@hadess.net>
Subject: Re: [PATCH 1/1] Client: Added support for the history file.
From: Bastien Nocera <hadess@hadess.net>
To: Maico Timmerman <maico.timmerman@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date: Thu, 12 Apr 2018 15:01:35 +0200
In-Reply-To: <20180412103432.9760-2-maico.timmerman@gmail.com>
References: <20180412103432.9760-1-maico.timmerman@gmail.com>
         <20180412103432.9760-2-maico.timmerman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2018-04-12 at 12:34 +0200, Maico Timmerman wrote:
> +       // First check HOME env variable, otherwise read homedir from
> /etc/passwd.
> +       if ((homedir = getenv("HOME")) == NULL) {
> +               homedir = getpwuid(getuid())->pw_dir;
> +       }
> +       data.bt_shell_history = strcat(strcat(homedir, "/"),
> string);;
> +
> +       // Read history file and set index of history beyond latest
> position.
> +       read_history(data.bt_shell_history);
> +       history_set_pos(history_length);

It's in the wrong location (should be under ~/.cache), that's awfully
low-level C (I'm pretty sure the bluez maintainers wouldn't mind if you
used existing glib code, or copy/pasted those), and I doubt that C++-
style comments are the accepted usage.

g_get_user_cache_dir() is what you want.

Cheers
