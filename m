Return-Path: <cyrus@holtmann.org>
Message-ID: <ac8af0be0810080159h712b0f8drdffa49dc57d7afb5@mail.gmail.com>
Date: Wed, 8 Oct 2008 16:59:54 +0800
From: "Zhao Forrest" <forrest.zhao@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: PBAP storage plugin API proposal
Cc: forrest.zhao@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi experts,

I'm implementing PBAP server based on obexd. In order to support
various PBAP backend storage each type of PBAP backend storage should
be implemented as a plugin of PBAP server. So we propose the initial
PBAP storage plugin API as follows. Basically the bellows are defined
in pbap_storage_plugin.h
====================================================================
typedef void* pullphonebook_t;
typedef void* pullvcardlisting_t;
typedef void* pullvcardentry_t;

struct pbap_storage_operations {
        pullphonebook_t* (*pullphonebook_init) (const gchar *object_name,
                          guint64 filter, guint8 format,
                          guint16 max_list_count, guint16 list_start_offset,
                          guint16 *phonebook_size, guint8 *new_missed_calls);
        gint32 (*pullphonebook) (pullphonebook_t *handle, guint8 *buf,
                guint16 buf_len);
        void (*pullphonebook_free) (pullphonebook_t *handle);

        pullvcardlisting_t* (*pullvcardlisting_init) (const gchar *object_name,
                             guint8 order, guint8 search_attr, gchar
*search_val,
                             guint16 max_list_count, guint16 list_start_offset,
                             guint16 *phonebook_size, guint8 *new_missed_calls);
        gint32 (*pullvcardlisting) (pullvcardlisting_t *handle, guint8 *buf,
                guint16 buf_len);
        void (*pullvcardlisting_free) (pullvcardlisting_t *handle);

        pullvcardentry_t* (*pullvcardentry_init) (const gchar *object_name,
                           guint64 filter, guint8 format);
        gint32 (*pullvcardentry) (pullvcardentry_t *handle, guint8 *buf,
                                  guint16 buf_len);
        void (*pullvcardentry_free) (pullvcardentry_t *handle);
};

guint8 pbap_storage_operations_register(struct pbap_storage_operations *ops);

struct obex_pbap_storage_plugin_desc {
        const char *name;
        int (*init) (void);
        void (*exit) (void);
};

#define OBEX_PBAP_STORAGE_PLUGIN_DEFINE(name,init,exit) \
                struct obex_pbap_storage_plugin_desc
obex_pbap_storage_plugin_desc = { \
                        name, init, exit \
                };
====================================================================
The plugin framework is similar to the one used in bluez and obexd. A
particular PBAP storage plugin program should define its own "struct
pbap_storage_operations" and call pbap_storage_operations_register()
in obex_pbap_storage_plugin_desc.init() to register these callback
functions to PBAP server.

Here we use "pullphonebook" as an example to explain the PBAP storage
plugin API usage.
For example when OBEX PBAP server receives a "PullPhoneBook" request
from PBAP client, it first calls
pbap_storage_ops->pullphonebook_init() to get a handle, phonebook_size
and new_missed_calls as returned value; then it calls
pbap_storage_ops-> pullphonebook() to get the phonebook object until
the return value is 0; lastly it calls pbap_storage_ops->
pullphonebook_free() to release the handle.

The PBAP spec is at
http://www.bluetooth.com/NR/rdonlyres/58FC38BF-9ED6-49FF-81CF-E0B95B130D72/7761/PBAP_SPEC_V10r00.pdf.

Your comments are welcome!

Thanks,
Forrest
