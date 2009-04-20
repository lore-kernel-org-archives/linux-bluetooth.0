Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1240244938.5260.5.camel@localhost.localdomain>
References: <8b5debfa0904200819sbcb6b08q5f33782381dcb229@mail.gmail.com>
	 <1240241475.5260.4.camel@localhost.localdomain>
	 <8b5debfa0904200852o7ba92880u15e950bf655eb81d@mail.gmail.com>
	 <1240244938.5260.5.camel@localhost.localdomain>
Date: Tue, 21 Apr 2009 00:48:07 +0530
Message-ID: <8b5debfa0904201218s3695bc01l39842aad26afcc4e@mail.gmail.com>
Subject: Re: [PATCH] Adding priority check for plugins.
From: alok barsode <alokbarsode@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Mon, Apr 20, 2009 at 9:58 PM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Alok,
>
>> modified patch attached.
>
> please to the line-break with BLUETOOTH_PLUGIN_DEFINE a little bit more
> like what ConnMan does so it looks nicer.
>
Infact i copied the syntax for BLUETOOTH_PLUGIN_DEFINE from the one in
connman. :D


#define CONNMAN_PLUGIN_DEFINE(name, description, version, priority,
init, exit) \
                extern struct connman_plugin_desc connman_plugin_desc
\
                                __attribute__
((visibility("default"))); \
                struct connman_plugin_desc connman_plugin_desc = { \
                        #name, description, version, priority, init,
exit \
                };

#define BLUETOOTH_PLUGIN_DEFINE(name, version, priority, init, exit) \
                extern struct bluetooth_plugin_desc
bluetooth_plugin_desc \
                                __attribute__
((visibility("default"))); \
                struct bluetooth_plugin_desc bluetooth_plugin_desc = {
\
                        name, version, priority, init, exit \
                };


> Regards
>
> Marcel
>
>
>

Cheers,
Alok.
