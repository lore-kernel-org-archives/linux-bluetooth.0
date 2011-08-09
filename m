Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAN_we7Mu76-iFWpphd+Hxnq314-xOURLomDRHGfXrsc2k5+qNA@mail.gmail.com>
References: <CAN_we7Mu76-iFWpphd+Hxnq314-xOURLomDRHGfXrsc2k5+qNA@mail.gmail.com>
Date: Tue, 9 Aug 2011 10:50:38 +0300
Message-ID: <CABBYNZK8J8zPz4bagc1VUdPab8jZdu_Xxgxu_izHN4QEEPWHtw@mail.gmail.com>
Subject: Re: Memory leak in obexd/plugins/opp.c
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Daniele Forsi <dforsi@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Daniele,

On Sat, Aug 6, 2011 at 1:40 PM, Daniele Forsi <dforsi@gmail.com> wrote:
> cppcheck shows this:
> [./plugins/opp.c:146]: (error) Memory leak: folder
>
> I'm not sending a patch because I can't test it and it seems that the
> g_strdup()'s can be removed because the folder and name variables are
> only used as arguments to g_build_filename()

Thanks for reporting this, in fact both folder and name ('\0') seems
to be leaking, they are always allocated because of
manager_request_authorization can return new strings. I think the
following should fix the problem:

diff --git a/plugins/opp.c b/plugins/opp.c
index 644a2c6..fd78af4 100644
--- a/plugins/opp.c
+++ b/plugins/opp.c
@@ -142,8 +142,10 @@ static int opp_chkput(struct obex_session *os,
void *user_data)
                name = g_strdup(obex_get_name(os));

 skip_auth:
-       if (name == NULL || strlen(name) == 0)
-               return -EBADR;
+       if (name == NULL || strlen(name) == 0) {
+               ret = -EBADR;
+               goto failed;
+       }

        if (g_strcmp0(name, obex_get_name(os)) != 0)
                obex_set_name(os, name);
@@ -155,6 +157,8 @@ skip_auth:
        ret = obex_put_stream_start(os, path);

        g_free(path);
+
+failed:
        g_free(folder);
        g_free(name);


-- 
Luiz Augusto von Dentz
