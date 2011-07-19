Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110718205614.GA16958@dell.ger.corp.intel.com>
References: <1310995152-24121-1-git-send-email-luiz.dentz@gmail.com>
	<20110718205614.GA16958@dell.ger.corp.intel.com>
Date: Tue, 19 Jul 2011 12:04:57 +0300
Message-ID: <CABBYNZKcj1WA8j5VZYy1F=ettBh7gbPDe3xEX+_+HGfrdntQOQ@mail.gmail.com>
Subject: Re: [PATCH obexd 1/6 v2] Make use of g_slist_free_full when elements
 are dynamically-allocated
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Jul 18, 2011 at 11:56 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Luiz,
>
> On Mon, Jul 18, 2011, Luiz Augusto von Dentz wrote:
>> This avoid having to iterate twice in the list to free its elements.
>> ---
>>  configure.ac                |    3 +++
>>  plugins/bluetooth.c         |    8 +++-----
>>  plugins/pbap.c              |    7 ++++---
>>  plugins/phonebook-dummy.c   |    3 +--
>>  plugins/phonebook-tracker.c |    5 ++---
>>  plugins/vcard.c             |   18 ++++++------------
>>  src/obex.h                  |    8 ++++++++
>>  7 files changed, 27 insertions(+), 25 deletions(-)
>
> Doesn't compile:
>
>  CC     plugins/vcard.o
> In file included from plugins/vcard.c:33:0:
> ./src/obex.h:66:51: error: unknown type name ‘obex_object_t’
> ./src/obex.h:68:48: error: unknown type name ‘obex_object_t’
> make[1]: *** [plugins/vcard.o] Error 1

How about handling this as a macro directly on AC_DEFINE e.g:

diff --git a/configure.ac b/configure.ac
index e02f218..40f4d9b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -72,8 +72,11 @@ AC_CHECK_LIB(dl, dlopen, dummy=yes,
 PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.16, dummy=yes,
                                AC_MSG_ERROR(libglib 2.16 or later is required))
 AC_CHECK_LIB(glib-2.0, g_slist_free_full, dummy=yes,
-               AC_DEFINE(NEED_G_SLIST_FREE_FULL, 1,
-                       [Define to 1 if you need g_slist_free_full()
function.]))
+               AC_DEFINE(g_slist_free_full(list, destroy),
+               { \
+                       g_slist_foreach((GSList *) list, (GFunc)
destroy, NULL); \
+                       g_slist_free((GSList *) list); \
+               }, [Define if you need g_slist_free_full() function.]))
 AC_SUBST(GLIB_CFLAGS)
 AC_SUBST(GLIB_LIBS)


This would work for whatever file that includes config.h which seems
to be the perfect place for wrappers like this, but it doesn't seems
common to have this type of macros inside configure.ac/config.h so
perhaps it is a bad idea.

-- 
Luiz Augusto von Dentz
