Return-Path: <cyrus@holtmann.org>
Date: Fri, 22 Oct 2010 11:12:07 -0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: ext-tommi.keisala@nokia.comt
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix crash when GetProperties req is received before
 any adapters are set up
Message-ID: <20101022131207.GA29655@jh-x301>
References: <1287743558-17002-1-git-send-email-ext-tommi.keisala@nokia.com>
 <1287743558-17002-2-git-send-email-ext-tommi.keisala@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1287743558-17002-2-git-send-email-ext-tommi.keisala@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tommi,

On Fri, Oct 22, 2010, ext-tommi.keisala@nokia.com wrote:
> This patch avoids a crash when org.bluez.Manager GetProperties request is
> received and there is not yet any adapters ready. Happens often for example
> when bluetoothd and ofonod is started next ot each other.
> 
> Signed-off-by: Tommi Keisala <ext-tommi.keisala@nokia.com>
> ---
>  src/manager.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)

Looks like a bugfix is definitely in order here, but why introduce a new
variable to the function? Wouldn't something like the folling be good
enough:

--- a/src/manager.c
+++ b/src/manager.c
@@ -197,13 +197,14 @@ static DBusMessage *get_properties(DBusConnection *conn,
                        DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
 
        array = g_new0(char *, g_slist_length(adapters) + 1);
-       for (i = 0, list = adapters; list; list = list->next, i++) {
+       for (i = 0, list = adapters; list; list = list->next) {
                struct btd_adapter *adapter = list->data;
 
                if (!adapter_is_ready(adapter))
                        continue;
 
                array[i] = (char *) adapter_get_path(adapter);
+               i++;
        }
        dict_append_array(&dict, "Adapters", DBUS_TYPE_OBJECT_PATH, &array, i);
        g_free(array);

Could you send a new patch which doesn't introduce a new variable? Also,
please leave out the signed-off-by from the commit message since it's
not used for userspace bluez patches. Thanks.

Johan
