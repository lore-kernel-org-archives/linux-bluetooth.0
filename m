Return-Path: <cyrus@holtmann.org>
Subject: Re: PBAP storage plugin API proposal
From: Marcel Holtmann <marcel@holtmann.org>
To: Zhao Forrest <forrest.zhao@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <ac8af0be0810080159h712b0f8drdffa49dc57d7afb5@mail.gmail.com>
References: <ac8af0be0810080159h712b0f8drdffa49dc57d7afb5@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 08 Oct 2008 11:17:36 +0200
Message-Id: <1223457456.11272.254.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Forrest,

> I'm implementing PBAP server based on obexd. In order to support
> various PBAP backend storage each type of PBAP backend storage should
> be implemented as a plugin of PBAP server. So we propose the initial
> PBAP storage plugin API as follows. Basically the bellows are defined
> in pbap_storage_plugin.h
> ====================================================================
> typedef void* pullphonebook_t;
> typedef void* pullvcardlisting_t;
> typedef void* pullvcardentry_t;
> 
> struct pbap_storage_operations {
>         pullphonebook_t* (*pullphonebook_init) (const gchar *object_name,
>                           guint64 filter, guint8 format,
>                           guint16 max_list_count, guint16 list_start_offset,
>                           guint16 *phonebook_size, guint8 *new_missed_calls);
>         gint32 (*pullphonebook) (pullphonebook_t *handle, guint8 *buf,
>                 guint16 buf_len);
>         void (*pullphonebook_free) (pullphonebook_t *handle);
> 
>         pullvcardlisting_t* (*pullvcardlisting_init) (const gchar *object_name,
>                              guint8 order, guint8 search_attr, gchar
> *search_val,
>                              guint16 max_list_count, guint16 list_start_offset,
>                              guint16 *phonebook_size, guint8 *new_missed_calls);
>         gint32 (*pullvcardlisting) (pullvcardlisting_t *handle, guint8 *buf,
>                 guint16 buf_len);
>         void (*pullvcardlisting_free) (pullvcardlisting_t *handle);
> 
>         pullvcardentry_t* (*pullvcardentry_init) (const gchar *object_name,
>                            guint64 filter, guint8 format);
>         gint32 (*pullvcardentry) (pullvcardentry_t *handle, guint8 *buf,
>                                   guint16 buf_len);
>         void (*pullvcardentry_free) (pullvcardentry_t *handle);
> };
> 
> guint8 pbap_storage_operations_register(struct pbap_storage_operations *ops);
> 
> struct obex_pbap_storage_plugin_desc {
>         const char *name;
>         int (*init) (void);
>         void (*exit) (void);
> };
> 
> #define OBEX_PBAP_STORAGE_PLUGIN_DEFINE(name,init,exit) \
>                 struct obex_pbap_storage_plugin_desc
> obex_pbap_storage_plugin_desc = { \
>                         name, init, exit \
>                 };
> ====================================================================
> The plugin framework is similar to the one used in bluez and obexd. A
> particular PBAP storage plugin program should define its own "struct
> pbap_storage_operations" and call pbap_storage_operations_register()
> in obex_pbap_storage_plugin_desc.init() to register these callback
> functions to PBAP server.

use the generic per plugin defines and its init and exit functions and
then provide methods to register and unregister the operations.

Please keep in mind that in theory we can load more than one of these
phonebook "drivers".

All (and I mean all) plugins in bluetoothd and obexd are treated the
same. It is up to their init and exit routines to do the job. This
allows us to have a generic plugin framework and not do invent it over
and over again.

Did anyone converted the picture from the whiteboard at the meeting into
some written details.

Regards

Marcel


