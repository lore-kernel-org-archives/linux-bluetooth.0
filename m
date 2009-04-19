Return-Path: <cyrus@holtmann.org>
Date: Sun, 19 Apr 2009 23:05:28 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Stuart Pook <linux-bluetooth4@pook.es>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez git + Linksys USBBT100 + 2.6.30-rc2 -> Segmentation fault
Message-ID: <20090419200528.GA18068@jh-x301>
References: <49D89DCD.7090808@pook.es> <49D8E48A.2060807@pook.es> <20090405172212.GB6612@jh-x301> <49EB7950.4000802@pook.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <49EB7950.4000802@pook.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stuart,

On Sun, Apr 19, 2009, Stuart Pook wrote:
> :; cat /var/lib/bluetooth/00:0C:41:E1:FF:30/config
> mode off
> class 0x080104
> onmode off
> discovto 60
<snip>
> I guess that if you have read this far then you have found the solution 
> as I did
> mv /var/lib/bluetooth/00:0C:41:E1:FF:30/config /var/lib/bluetooth/00:0C:41:E1:FF:30/config.old
>
> /var/lib/bluetooth/00:0C:41:E1:FF:30/config was recreated containing
>
> : root; cat /var/lib/bluetooth/00:0C:41:E1:FF:30/config
> class 0x480104
>
> I guess that this is why my USBBT100 never (?) worked with bluez.

Yep. The reason is that you have somehow managed to get "onmode off" to
your config file. There's just one place (in storage.c) where the value of
onmode gets written and it looks like
         if (strcmp(mode, "off") != 0)
                 textfile_put(filename, "onmode", mode);
so it should be impossible for the value "off" to be stored. Maybe some old
bluez version has been buggy and allowed it or then the file has been
modified manually.

Anyway, if you look at the adapter_up function (in src/adapter.c) you'll
see that it calls itself recursively in the case that the last mode was
"off", but copies "onmode" to the previously stored mode before that. So,
if the stored "onmode" is actually "off" the adapter_up function will keep
calling itself indefinitely (until the daemon crashes).

I've just pushed a fix to git which falls back to the default "connectable"
mode if the stored onmode if for some reason "off". This should prevent
the infinite recursion of adapter_up:
http://git.kernel.org/?p=bluetooth/bluez.git;a=commitdiff;h=e40a1ccc50d87981b20d3ab0f1bec4209fee4247

Johan
