Return-Path: <cyrus@holtmann.org>
Message-ID: <37367b3a0811280747y1f29a698w8c8ad70bf8c50ff2@mail.gmail.com>
Date: Fri, 28 Nov 2008 15:47:39 +0000
From: "Alan Carvalho de Assis" <acassis@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Modification on agent.c in order to it support new API
In-Reply-To: <37367b3a0811280738t4fa4f39bv5f03eb51f8cdb27d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_43419_3331393.1227887259222"
References: <37367b3a0811280738t4fa4f39bv5f03eb51f8cdb27d@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

------=_Part_43419_3331393.1227887259222
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Sending it again attached, gmail messed my patch!

Regards,

Alan

On Fri, Nov 28, 2008 at 3:38 PM, Alan Carvalho de Assis
<acassis@gmail.com> wrote:
> This is my effort to adapt agent.c to new API.
>
> I started doing it as single agent, but jhe suggest me to separate it
> on two agents, but after doing that none agent Methods are called.
>
> As single agent I got it:
>
> # agent 00:0E:ED:29:4F:2D
> Pairing to 00:0E:ED:29:4F:2D
> Adapter path: /org/bluez/1780/hci0
> Agent_message was called!
> Agent called: RequestPinCode
> Device path = /org/bluez/1780/hci0/dev_00_0E_ED_29_4F_2D
> Agent has been released
> Agent_message was called!
> Agent called: Cancel
> Request canceled for device
> Agent_message was called!
> Agent called: Release
> Agent has been released
>
> To test it as double agent just remove C++ style comments on main
> scope, then execute:
>
> # agent &
>
> # agent 00:0E:ED:29:4F:2D
> Pairing to 00:0E:ED:29:4F:2D
> Adapter path: /org/bluez/1780/hci0
>
> As you can see it doesn't call any agent methods.
>
> Please, some idea about this problem?
>
> Best Regards,
>
> Alan
>
>
> Signed-off-by: Alan Carvalho <acassis@gmail.com>
> ---
>  test/agent.c |  194 ++++++++++++++++++++++++++++++++++++++++++----------------
>  1 files changed, 142 insertions(+), 52 deletions(-)
>
> diff --git a/test/agent.c b/test/agent.c
> index a8d880a..fdab641 100644
> --- a/test/agent.c
> +++ b/test/agent.c
> @@ -35,7 +35,7 @@
>
>  #include <dbus/dbus.h>
>
> -static char *passkey = NULL;
> +static char *devaddr = NULL, *pincode = "0000";
>
>  static int do_reject = 0;
>
> @@ -70,28 +70,19 @@ static DBusHandlerResult agent_filter(DBusConnection *conn,
>        return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
>  }
>
> -static DBusHandlerResult request_message(DBusConnection *conn,
> +
> +static DBusHandlerResult cancel_message(DBusConnection *conn,
>                                                DBusMessage *msg, void *data)
>  {
>        DBusMessage *reply;
>        const char *path, *address;
> -       dbus_bool_t numeric;
> -
> -       if (!passkey)
> -               return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
>
> -       if (!dbus_message_get_args(msg, NULL,
> -                       DBUS_TYPE_STRING, &path, DBUS_TYPE_STRING, &address,
> -                       DBUS_TYPE_BOOLEAN, &numeric, DBUS_TYPE_INVALID)) {
> -               fprintf(stderr, "Invalid arguments for passkey Request method");
> +       if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_INVALID)) {
> +               fprintf(stderr, "Invalid arguments for Cancel method");
>                return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
>        }
>
> -       if (do_reject) {
> -               reply = dbus_message_new_error(msg,
> -                                       "org.bluez.Error.Rejected", "");
> -               goto send;
> -       }
> +       printf("Request canceled for device %s\n", address);
>
>        reply = dbus_message_new_method_return(msg);
>        if (!reply) {
> @@ -99,12 +90,6 @@ static DBusHandlerResult
> request_message(DBusConnection *conn,
>                return DBUS_HANDLER_RESULT_NEED_MEMORY;
>        }
>
> -       printf("Passkey request for device %s\n", address);
> -
> -       dbus_message_append_args(reply, DBUS_TYPE_STRING, &passkey,
> -                                       DBUS_TYPE_INVALID);
> -
> -send:
>        dbus_connection_send(conn, reply, NULL);
>
>        dbus_connection_flush(conn);
> @@ -114,20 +99,23 @@ send:
>        return DBUS_HANDLER_RESULT_HANDLED;
>  }
>
> -static DBusHandlerResult cancel_message(DBusConnection *conn,
> +static DBusHandlerResult reqpincode_message(DBusConnection *conn,
>                                                DBusMessage *msg, void *data)
>  {
>        DBusMessage *reply;
> -       const char *path, *address;
> +       char *dev_path;
>
> -       if (!dbus_message_get_args(msg, NULL,
> -                       DBUS_TYPE_STRING, &path, DBUS_TYPE_STRING, &address,
> -                                                       DBUS_TYPE_INVALID)) {
> -               fprintf(stderr, "Invalid arguments for passkey Confirm method");
> +       if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH,
> &dev_path, DBUS_TYPE_INVALID)) {
> +               fprintf(stderr, "Invalid arguments for RequestPinCode method");
>                return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
>        }
>
> -       printf("Request canceled for device %s\n", address);
> +       printf("Device path = %s\n",dev_path);
> +
> +       if (!__io_canceled)
> +               fprintf(stderr, "Agent has been released\n");
> +
> +       //__io_terminated = 1;
>
>        reply = dbus_message_new_method_return(msg);
>        if (!reply) {
> @@ -135,6 +123,9 @@ static DBusHandlerResult
> cancel_message(DBusConnection *conn,
>                return DBUS_HANDLER_RESULT_NEED_MEMORY;
>        }
>
> +       dbus_message_append_args(reply, DBUS_TYPE_STRING, &pincode,
> +                                       DBUS_TYPE_INVALID);
> +
>        dbus_connection_send(conn, reply, NULL);
>
>        dbus_connection_flush(conn);
> @@ -177,14 +168,37 @@ static DBusHandlerResult
> release_message(DBusConnection *conn,
>  static DBusHandlerResult agent_message(DBusConnection *conn,
>                                                DBusMessage *msg, void *data)
>  {
> -       if (dbus_message_is_method_call(msg, "org.bluez.Agent", "Request"))
> -               return request_message(conn, msg, data);
> +       printf("Agent_message was called!\n");
>
> -       if (dbus_message_is_method_call(msg, "org.bluez.Agent", "Cancel"))
> -               return cancel_message(conn, msg, data);
> -
> -       if (dbus_message_is_method_call(msg, "org.bluez.Agent", "Release"))
> +       if (dbus_message_is_method_call(msg, "org.bluez.Agent", "Release")){
> +               printf("Agent called: Release\n");
>                return release_message(conn, msg, data);
> +       }
> +
> +       if (dbus_message_is_method_call(msg, "org.bluez.Agent", "RequestPinCode")){
> +               printf("Agent called: RequestPinCode\n");
> +               return reqpincode_message(conn, msg, data);
> +       }
> +
> +       if (dbus_message_is_method_call(msg, "org.bluez.Agent", "RequestPasskey"))
> +               printf("Agent called: RequestPasskey\n");
> +
> +       if (dbus_message_is_method_call(msg, "org.bluez.Agent", "DisplayPasskey"))
> +               printf("Agent called: DisplayPasskey\n");
> +
> +       if (dbus_message_is_method_call(msg, "org.bluez.Agent",
> "RequestConfirmation"))
> +               printf("Agent called: RequestConfirmation\n");
> +
> +       if (dbus_message_is_method_call(msg, "org.bluez.Agent", "Authorize"))
> +               printf("Agent called: Authorize\n");
> +
> +       if (dbus_message_is_method_call(msg, "org.bluez.Agent", "ConfirmModeChange"))
> +               printf("Agent called: ConfirmModeChange\n");
> +
> +       if (dbus_message_is_method_call(msg, "org.bluez.Agent", "Cancel")){
> +               printf("Agent called: Cancel\n");
> +               return cancel_message(conn, msg, data);
> +       }
>
>        return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
>  }
> @@ -279,21 +293,88 @@ static int unregister_agent(DBusConnection
> *conn, const char *device_path,
>        return 0;
>  }
>
> -static char *get_device(const char *device)
> +static char *get_device(DBusConnection *conn)
>  {
> -       char *path;
> +       char *path, *device_path = NULL;
> +       DBusMessage *msg, *reply;
> +       DBusError err;
>
> -       path = strdup("/org/bluez/hci0");
> +       msg = dbus_message_new_method_call("org.bluez", "/",
> +                                       "org.bluez.Manager", "DefaultAdapter");
> +       if (!msg) {
> +               fprintf(stderr, "Can't allocate new method call\n");
> +               return NULL;
> +       }
>
> -       return path;
> +       dbus_error_init(&err);
> +
> +       reply = dbus_connection_send_with_reply_and_block(conn, msg, -1, &err);
> +
> +       dbus_message_unref(msg);
> +
> +       if (!reply) {
> +               fprintf(stderr, "Can't get Adapter path\n");
> +               if (dbus_error_is_set(&err)) {
> +                       fprintf(stderr, "%s\n", err.message);
> +                       dbus_error_free(&err);
> +               }
> +               return NULL;
> +       }
> +
> +       dbus_message_get_args(reply, NULL, DBUS_TYPE_OBJECT_PATH,
> &device_path, DBUS_TYPE_INVALID);
> +
> +       dbus_message_unref(reply);
> +
> +       dbus_connection_flush(conn);
> +
> +       return device_path;
> +}
> +
> +static int pair_device(DBusConnection *conn, const char *device_path,
> +                                       const char *agent_path,
> +                                       const char *capabilities)
> +{
> +       DBusMessage *msg;
> +       DBusPendingCall *pending;
> +       int ret;
> +
> +
> +       printf("Adapter path: %s\n", device_path);
> +
> +       msg = dbus_message_new_method_call("org.bluez", device_path,
> +                                       "org.bluez.Adapter", "CreatePairedDevice");
> +       if (!msg) {
> +               fprintf(stderr, "Can't allocate new method call\n");
> +               return -1;
> +       }
> +
> +       dbus_message_append_args(msg, DBUS_TYPE_STRING, &devaddr,
> +                                       DBUS_TYPE_OBJECT_PATH, &agent_path,
> +                                       DBUS_TYPE_STRING, &capabilities,
> +                                                       DBUS_TYPE_INVALID);
> +
> +       ret = dbus_connection_send_with_reply(conn, msg, &pending, 100000);
> +
> +       if (!ret) {
> +               fprintf(stderr, "Can't pair to device\n");
> +               return -1;
> +       }
> +
> +       dbus_message_unref(msg);
> +
> +       dbus_connection_flush(conn);
> +
> +       dbus_pending_call_block(pending);
> +
> +       return 0;
>  }
>
>  static void usage(void)
>  {
> -       printf("Bluetooth agent ver %s\n\n", VERSION);
> +       printf("Bluetooth agent ver %s\n\n", "4.18");
>
>        printf("Usage:\n"
> -               "\tagent [--device interface] [--path agent-path] <passkey>\n"
> +               "\tagent <device address> [pincode]\n"
>                "\n");
>  }
>
> @@ -348,12 +429,10 @@ int main(int argc, char *argv[])
>        argv += optind;
>        optind = 0;
>
> -       if (argc < 1) {
> +       /*if (argc < 1) {
>                usage();
>                exit(1);
> -       }
> -
> -       passkey = strdup(argv[0]);
> +       }*/
>
>        if (!agent_path)
>                agent_path = strdup(default_path);
> @@ -365,12 +444,25 @@ int main(int argc, char *argv[])
>        }
>
>        if (!device_path)
> -               device_path = get_device(device_id);
> +               device_path = get_device(conn);
>
> -       if (register_agent(conn, device_path, agent_path, capabilities) < 0) {
> -               dbus_connection_unref(conn);
> -               exit(1);
> -       }
> +
> +       //if (argc >= 1){
> +               devaddr = strdup(argv[0]);
> +               printf("Pairing to %s\n",devaddr);
> +               if (pair_device(conn, device_path, agent_path, capabilities) < 0){
> +                               dbus_connection_unref(conn);
> +                               printf("Pairing failed\n");
> +                               exit(1);
> +               }
> +       //}
> +       //else {
> +               if (register_agent(conn, device_path, agent_path, capabilities) < 0) {
> +                       dbus_connection_unref(conn);
> +                       exit(1);
> +               }
> +
> +       //}
>
>        if (!dbus_connection_add_filter(conn, agent_filter, NULL, NULL))
>                fprintf(stderr, "Can't add signal filter");
> @@ -395,11 +487,9 @@ int main(int argc, char *argv[])
>        if (!__io_terminated)
>                unregister_agent(conn, device_path, agent_path);
>
> -       free(device_path);
> +       free(devaddr);
>        free(agent_path);
>
> -       free(passkey);
> -
>        dbus_connection_unref(conn);
>
>        return 0;
> --
> 1.5.6.3
>

------=_Part_43419_3331393.1227887259222
Content-Type: text/x-diff;
 name=0001-Modification-on-agent.c-in-order-to-it-support-new-A.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fo2w2fmz0
Content-Disposition: attachment;
 filename=0001-Modification-on-agent.c-in-order-to-it-support-new-A.patch

RnJvbSA3MzJhNWZiYmE3Y2QzZTgwM2U1OWQxODE2MWFmZDZiMDI1YjMxMzRjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGFuIENhcnZhbGhvIGRlIEFzc2lzIDxhY2Fzc2lzQGdtYWls
LmNvbT4KRGF0ZTogRnJpLCAyOCBOb3YgMjAwOCAxMzoyMDo0NCArMDAwMApTdWJqZWN0OiBbUEFU
Q0hdIE1vZGlmaWNhdGlvbiBvbiBhZ2VudC5jIGluIG9yZGVyIHRvIGl0IHN1cHBvcnQgbmV3IEFQ
SQoKLS0tCiB0ZXN0L2FnZW50LmMgfCAgMTk0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZXMgY2hhbmdlZCwgMTQyIGluc2Vy
dGlvbnMoKyksIDUyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rlc3QvYWdlbnQuYyBiL3Rl
c3QvYWdlbnQuYwppbmRleCBhOGQ4ODBhLi5mZGFiNjQxIDEwMDY0NAotLS0gYS90ZXN0L2FnZW50
LmMKKysrIGIvdGVzdC9hZ2VudC5jCkBAIC0zNSw3ICszNSw3IEBACiAKICNpbmNsdWRlIDxkYnVz
L2RidXMuaD4KIAotc3RhdGljIGNoYXIgKnBhc3NrZXkgPSBOVUxMOworc3RhdGljIGNoYXIgKmRl
dmFkZHIgPSBOVUxMLCAqcGluY29kZSA9ICIwMDAwIjsKIAogc3RhdGljIGludCBkb19yZWplY3Qg
PSAwOwogCkBAIC03MCwyOCArNzAsMTkgQEAgc3RhdGljIERCdXNIYW5kbGVyUmVzdWx0IGFnZW50
X2ZpbHRlcihEQnVzQ29ubmVjdGlvbiAqY29ubiwKIAlyZXR1cm4gREJVU19IQU5ETEVSX1JFU1VM
VF9OT1RfWUVUX0hBTkRMRUQ7CiB9CiAKLXN0YXRpYyBEQnVzSGFuZGxlclJlc3VsdCByZXF1ZXN0
X21lc3NhZ2UoREJ1c0Nvbm5lY3Rpb24gKmNvbm4sCisKK3N0YXRpYyBEQnVzSGFuZGxlclJlc3Vs
dCBjYW5jZWxfbWVzc2FnZShEQnVzQ29ubmVjdGlvbiAqY29ubiwKIAkJCQkJCURCdXNNZXNzYWdl
ICptc2csIHZvaWQgKmRhdGEpCiB7CiAJREJ1c01lc3NhZ2UgKnJlcGx5OwogCWNvbnN0IGNoYXIg
KnBhdGgsICphZGRyZXNzOwotCWRidXNfYm9vbF90IG51bWVyaWM7Ci0KLQlpZiAoIXBhc3NrZXkp
Ci0JCXJldHVybiBEQlVTX0hBTkRMRVJfUkVTVUxUX05PVF9ZRVRfSEFORExFRDsKIAotCWlmICgh
ZGJ1c19tZXNzYWdlX2dldF9hcmdzKG1zZywgTlVMTCwKLQkJCURCVVNfVFlQRV9TVFJJTkcsICZw
YXRoLCBEQlVTX1RZUEVfU1RSSU5HLCAmYWRkcmVzcywKLQkJCURCVVNfVFlQRV9CT09MRUFOLCAm
bnVtZXJpYywgREJVU19UWVBFX0lOVkFMSUQpKSB7Ci0JCWZwcmludGYoc3RkZXJyLCAiSW52YWxp
ZCBhcmd1bWVudHMgZm9yIHBhc3NrZXkgUmVxdWVzdCBtZXRob2QiKTsKKwlpZiAoIWRidXNfbWVz
c2FnZV9nZXRfYXJncyhtc2csIE5VTEwsIERCVVNfVFlQRV9JTlZBTElEKSkgeworCQlmcHJpbnRm
KHN0ZGVyciwgIkludmFsaWQgYXJndW1lbnRzIGZvciBDYW5jZWwgbWV0aG9kIik7CiAJCXJldHVy
biBEQlVTX0hBTkRMRVJfUkVTVUxUX05PVF9ZRVRfSEFORExFRDsKIAl9CiAKLQlpZiAoZG9fcmVq
ZWN0KSB7Ci0JCXJlcGx5ID0gZGJ1c19tZXNzYWdlX25ld19lcnJvcihtc2csCi0JCQkJCSJvcmcu
Ymx1ZXouRXJyb3IuUmVqZWN0ZWQiLCAiIik7Ci0JCWdvdG8gc2VuZDsKLQl9CisJcHJpbnRmKCJS
ZXF1ZXN0IGNhbmNlbGVkIGZvciBkZXZpY2UgJXNcbiIsIGFkZHJlc3MpOwogCiAJcmVwbHkgPSBk
YnVzX21lc3NhZ2VfbmV3X21ldGhvZF9yZXR1cm4obXNnKTsKIAlpZiAoIXJlcGx5KSB7CkBAIC05
OSwxMiArOTAsNiBAQCBzdGF0aWMgREJ1c0hhbmRsZXJSZXN1bHQgcmVxdWVzdF9tZXNzYWdlKERC
dXNDb25uZWN0aW9uICpjb25uLAogCQlyZXR1cm4gREJVU19IQU5ETEVSX1JFU1VMVF9ORUVEX01F
TU9SWTsKIAl9CiAKLQlwcmludGYoIlBhc3NrZXkgcmVxdWVzdCBmb3IgZGV2aWNlICVzXG4iLCBh
ZGRyZXNzKTsKLQotCWRidXNfbWVzc2FnZV9hcHBlbmRfYXJncyhyZXBseSwgREJVU19UWVBFX1NU
UklORywgJnBhc3NrZXksCi0JCQkJCURCVVNfVFlQRV9JTlZBTElEKTsKLQotc2VuZDoKIAlkYnVz
X2Nvbm5lY3Rpb25fc2VuZChjb25uLCByZXBseSwgTlVMTCk7CiAKIAlkYnVzX2Nvbm5lY3Rpb25f
Zmx1c2goY29ubik7CkBAIC0xMTQsMjAgKzk5LDIzIEBAIHNlbmQ6CiAJcmV0dXJuIERCVVNfSEFO
RExFUl9SRVNVTFRfSEFORExFRDsKIH0KIAotc3RhdGljIERCdXNIYW5kbGVyUmVzdWx0IGNhbmNl
bF9tZXNzYWdlKERCdXNDb25uZWN0aW9uICpjb25uLAorc3RhdGljIERCdXNIYW5kbGVyUmVzdWx0
IHJlcXBpbmNvZGVfbWVzc2FnZShEQnVzQ29ubmVjdGlvbiAqY29ubiwKIAkJCQkJCURCdXNNZXNz
YWdlICptc2csIHZvaWQgKmRhdGEpCiB7CiAJREJ1c01lc3NhZ2UgKnJlcGx5OwotCWNvbnN0IGNo
YXIgKnBhdGgsICphZGRyZXNzOworCWNoYXIgKmRldl9wYXRoOwogCi0JaWYgKCFkYnVzX21lc3Nh
Z2VfZ2V0X2FyZ3MobXNnLCBOVUxMLAotCQkJREJVU19UWVBFX1NUUklORywgJnBhdGgsIERCVVNf
VFlQRV9TVFJJTkcsICZhZGRyZXNzLAotCQkJCQkJCURCVVNfVFlQRV9JTlZBTElEKSkgewotCQlm
cHJpbnRmKHN0ZGVyciwgIkludmFsaWQgYXJndW1lbnRzIGZvciBwYXNza2V5IENvbmZpcm0gbWV0
aG9kIik7CisJaWYgKCFkYnVzX21lc3NhZ2VfZ2V0X2FyZ3MobXNnLCBOVUxMLCBEQlVTX1RZUEVf
T0JKRUNUX1BBVEgsICZkZXZfcGF0aCwgREJVU19UWVBFX0lOVkFMSUQpKSB7CisJCWZwcmludGYo
c3RkZXJyLCAiSW52YWxpZCBhcmd1bWVudHMgZm9yIFJlcXVlc3RQaW5Db2RlIG1ldGhvZCIpOwog
CQlyZXR1cm4gREJVU19IQU5ETEVSX1JFU1VMVF9OT1RfWUVUX0hBTkRMRUQ7CiAJfQogCi0JcHJp
bnRmKCJSZXF1ZXN0IGNhbmNlbGVkIGZvciBkZXZpY2UgJXNcbiIsIGFkZHJlc3MpOworCXByaW50
ZigiRGV2aWNlIHBhdGggPSAlc1xuIixkZXZfcGF0aCk7CisKKwlpZiAoIV9faW9fY2FuY2VsZWQp
CisJCWZwcmludGYoc3RkZXJyLCAiQWdlbnQgaGFzIGJlZW4gcmVsZWFzZWRcbiIpOworCisJLy9f
X2lvX3Rlcm1pbmF0ZWQgPSAxOwogCiAJcmVwbHkgPSBkYnVzX21lc3NhZ2VfbmV3X21ldGhvZF9y
ZXR1cm4obXNnKTsKIAlpZiAoIXJlcGx5KSB7CkBAIC0xMzUsNiArMTIzLDkgQEAgc3RhdGljIERC
dXNIYW5kbGVyUmVzdWx0IGNhbmNlbF9tZXNzYWdlKERCdXNDb25uZWN0aW9uICpjb25uLAogCQly
ZXR1cm4gREJVU19IQU5ETEVSX1JFU1VMVF9ORUVEX01FTU9SWTsKIAl9CiAKKwlkYnVzX21lc3Nh
Z2VfYXBwZW5kX2FyZ3MocmVwbHksIERCVVNfVFlQRV9TVFJJTkcsICZwaW5jb2RlLAorCQkJCQlE
QlVTX1RZUEVfSU5WQUxJRCk7CisKIAlkYnVzX2Nvbm5lY3Rpb25fc2VuZChjb25uLCByZXBseSwg
TlVMTCk7CiAKIAlkYnVzX2Nvbm5lY3Rpb25fZmx1c2goY29ubik7CkBAIC0xNzcsMTQgKzE2OCwz
NyBAQCBzdGF0aWMgREJ1c0hhbmRsZXJSZXN1bHQgcmVsZWFzZV9tZXNzYWdlKERCdXNDb25uZWN0
aW9uICpjb25uLAogc3RhdGljIERCdXNIYW5kbGVyUmVzdWx0IGFnZW50X21lc3NhZ2UoREJ1c0Nv
bm5lY3Rpb24gKmNvbm4sCiAJCQkJCQlEQnVzTWVzc2FnZSAqbXNnLCB2b2lkICpkYXRhKQogewot
CWlmIChkYnVzX21lc3NhZ2VfaXNfbWV0aG9kX2NhbGwobXNnLCAib3JnLmJsdWV6LkFnZW50Iiwg
IlJlcXVlc3QiKSkKLQkJcmV0dXJuIHJlcXVlc3RfbWVzc2FnZShjb25uLCBtc2csIGRhdGEpOwor
CXByaW50ZigiQWdlbnRfbWVzc2FnZSB3YXMgY2FsbGVkIVxuIik7CiAKLQlpZiAoZGJ1c19tZXNz
YWdlX2lzX21ldGhvZF9jYWxsKG1zZywgIm9yZy5ibHVlei5BZ2VudCIsICJDYW5jZWwiKSkKLQkJ
cmV0dXJuIGNhbmNlbF9tZXNzYWdlKGNvbm4sIG1zZywgZGF0YSk7Ci0KLQlpZiAoZGJ1c19tZXNz
YWdlX2lzX21ldGhvZF9jYWxsKG1zZywgIm9yZy5ibHVlei5BZ2VudCIsICJSZWxlYXNlIikpCisJ
aWYgKGRidXNfbWVzc2FnZV9pc19tZXRob2RfY2FsbChtc2csICJvcmcuYmx1ZXouQWdlbnQiLCAi
UmVsZWFzZSIpKXsKKwkJcHJpbnRmKCJBZ2VudCBjYWxsZWQ6IFJlbGVhc2VcbiIpOwogCQlyZXR1
cm4gcmVsZWFzZV9tZXNzYWdlKGNvbm4sIG1zZywgZGF0YSk7CisJfQorCisJaWYgKGRidXNfbWVz
c2FnZV9pc19tZXRob2RfY2FsbChtc2csICJvcmcuYmx1ZXouQWdlbnQiLCAiUmVxdWVzdFBpbkNv
ZGUiKSl7CisJCXByaW50ZigiQWdlbnQgY2FsbGVkOiBSZXF1ZXN0UGluQ29kZVxuIik7CisJCXJl
dHVybiByZXFwaW5jb2RlX21lc3NhZ2UoY29ubiwgbXNnLCBkYXRhKTsKKwl9CisKKwlpZiAoZGJ1
c19tZXNzYWdlX2lzX21ldGhvZF9jYWxsKG1zZywgIm9yZy5ibHVlei5BZ2VudCIsICJSZXF1ZXN0
UGFzc2tleSIpKQorCQlwcmludGYoIkFnZW50IGNhbGxlZDogUmVxdWVzdFBhc3NrZXlcbiIpOwor
CisJaWYgKGRidXNfbWVzc2FnZV9pc19tZXRob2RfY2FsbChtc2csICJvcmcuYmx1ZXouQWdlbnQi
LCAiRGlzcGxheVBhc3NrZXkiKSkKKwkJcHJpbnRmKCJBZ2VudCBjYWxsZWQ6IERpc3BsYXlQYXNz
a2V5XG4iKTsKKworCWlmIChkYnVzX21lc3NhZ2VfaXNfbWV0aG9kX2NhbGwobXNnLCAib3JnLmJs
dWV6LkFnZW50IiwgIlJlcXVlc3RDb25maXJtYXRpb24iKSkKKwkJcHJpbnRmKCJBZ2VudCBjYWxs
ZWQ6IFJlcXVlc3RDb25maXJtYXRpb25cbiIpOworCisJaWYgKGRidXNfbWVzc2FnZV9pc19tZXRo
b2RfY2FsbChtc2csICJvcmcuYmx1ZXouQWdlbnQiLCAiQXV0aG9yaXplIikpCisJCXByaW50Zigi
QWdlbnQgY2FsbGVkOiBBdXRob3JpemVcbiIpOworCisJaWYgKGRidXNfbWVzc2FnZV9pc19tZXRo
b2RfY2FsbChtc2csICJvcmcuYmx1ZXouQWdlbnQiLCAiQ29uZmlybU1vZGVDaGFuZ2UiKSkKKwkJ
cHJpbnRmKCJBZ2VudCBjYWxsZWQ6IENvbmZpcm1Nb2RlQ2hhbmdlXG4iKTsKKworCWlmIChkYnVz
X21lc3NhZ2VfaXNfbWV0aG9kX2NhbGwobXNnLCAib3JnLmJsdWV6LkFnZW50IiwgIkNhbmNlbCIp
KXsKKwkJcHJpbnRmKCJBZ2VudCBjYWxsZWQ6IENhbmNlbFxuIik7CisJCXJldHVybiBjYW5jZWxf
bWVzc2FnZShjb25uLCBtc2csIGRhdGEpOworCX0KIAogCXJldHVybiBEQlVTX0hBTkRMRVJfUkVT
VUxUX05PVF9ZRVRfSEFORExFRDsKIH0KQEAgLTI3OSwyMSArMjkzLDg4IEBAIHN0YXRpYyBpbnQg
dW5yZWdpc3Rlcl9hZ2VudChEQnVzQ29ubmVjdGlvbiAqY29ubiwgY29uc3QgY2hhciAqZGV2aWNl
X3BhdGgsCiAJcmV0dXJuIDA7CiB9CiAKLXN0YXRpYyBjaGFyICpnZXRfZGV2aWNlKGNvbnN0IGNo
YXIgKmRldmljZSkKK3N0YXRpYyBjaGFyICpnZXRfZGV2aWNlKERCdXNDb25uZWN0aW9uICpjb25u
KQogewotCWNoYXIgKnBhdGg7CisJY2hhciAqcGF0aCwgKmRldmljZV9wYXRoID0gTlVMTDsKKwlE
QnVzTWVzc2FnZSAqbXNnLCAqcmVwbHk7CisJREJ1c0Vycm9yIGVycjsKIAotCXBhdGggPSBzdHJk
dXAoIi9vcmcvYmx1ZXovaGNpMCIpOworCW1zZyA9IGRidXNfbWVzc2FnZV9uZXdfbWV0aG9kX2Nh
bGwoIm9yZy5ibHVleiIsICIvIiwKKwkJCQkJIm9yZy5ibHVlei5NYW5hZ2VyIiwgIkRlZmF1bHRB
ZGFwdGVyIik7CisJaWYgKCFtc2cpIHsKKwkJZnByaW50ZihzdGRlcnIsICJDYW4ndCBhbGxvY2F0
ZSBuZXcgbWV0aG9kIGNhbGxcbiIpOworCQlyZXR1cm4gTlVMTDsKKwl9CiAKLQlyZXR1cm4gcGF0
aDsKKwlkYnVzX2Vycm9yX2luaXQoJmVycik7CisKKwlyZXBseSA9IGRidXNfY29ubmVjdGlvbl9z
ZW5kX3dpdGhfcmVwbHlfYW5kX2Jsb2NrKGNvbm4sIG1zZywgLTEsICZlcnIpOworCisJZGJ1c19t
ZXNzYWdlX3VucmVmKG1zZyk7CisKKwlpZiAoIXJlcGx5KSB7CisJCWZwcmludGYoc3RkZXJyLCAi
Q2FuJ3QgZ2V0IEFkYXB0ZXIgcGF0aFxuIik7CisJCWlmIChkYnVzX2Vycm9yX2lzX3NldCgmZXJy
KSkgeworCQkJZnByaW50ZihzdGRlcnIsICIlc1xuIiwgZXJyLm1lc3NhZ2UpOworCQkJZGJ1c19l
cnJvcl9mcmVlKCZlcnIpOworCQl9CisJCXJldHVybiBOVUxMOworCX0KKworCWRidXNfbWVzc2Fn
ZV9nZXRfYXJncyhyZXBseSwgTlVMTCwgREJVU19UWVBFX09CSkVDVF9QQVRILCAmZGV2aWNlX3Bh
dGgsIERCVVNfVFlQRV9JTlZBTElEKTsKKworCWRidXNfbWVzc2FnZV91bnJlZihyZXBseSk7CisK
KwlkYnVzX2Nvbm5lY3Rpb25fZmx1c2goY29ubik7CisKKwlyZXR1cm4gZGV2aWNlX3BhdGg7Cit9
CisKK3N0YXRpYyBpbnQgcGFpcl9kZXZpY2UoREJ1c0Nvbm5lY3Rpb24gKmNvbm4sIGNvbnN0IGNo
YXIgKmRldmljZV9wYXRoLAorCQkJCQljb25zdCBjaGFyICphZ2VudF9wYXRoLAorCQkJCQljb25z
dCBjaGFyICpjYXBhYmlsaXRpZXMpCit7CisJREJ1c01lc3NhZ2UgKm1zZzsKKwlEQnVzUGVuZGlu
Z0NhbGwgKnBlbmRpbmc7CisJaW50IHJldDsKKworCisJcHJpbnRmKCJBZGFwdGVyIHBhdGg6ICVz
XG4iLCBkZXZpY2VfcGF0aCk7CisKKwltc2cgPSBkYnVzX21lc3NhZ2VfbmV3X21ldGhvZF9jYWxs
KCJvcmcuYmx1ZXoiLCBkZXZpY2VfcGF0aCwKKwkJCQkJIm9yZy5ibHVlei5BZGFwdGVyIiwgIkNy
ZWF0ZVBhaXJlZERldmljZSIpOworCWlmICghbXNnKSB7CisJCWZwcmludGYoc3RkZXJyLCAiQ2Fu
J3QgYWxsb2NhdGUgbmV3IG1ldGhvZCBjYWxsXG4iKTsKKwkJcmV0dXJuIC0xOworCX0KKworCWRi
dXNfbWVzc2FnZV9hcHBlbmRfYXJncyhtc2csIERCVVNfVFlQRV9TVFJJTkcsICZkZXZhZGRyLAor
CQkJCQlEQlVTX1RZUEVfT0JKRUNUX1BBVEgsICZhZ2VudF9wYXRoLAorCQkJCQlEQlVTX1RZUEVf
U1RSSU5HLCAmY2FwYWJpbGl0aWVzLAorCQkJCQkJCURCVVNfVFlQRV9JTlZBTElEKTsKKworCXJl
dCA9IGRidXNfY29ubmVjdGlvbl9zZW5kX3dpdGhfcmVwbHkoY29ubiwgbXNnLCAmcGVuZGluZywg
MTAwMDAwKTsKKworCWlmICghcmV0KSB7CisJCWZwcmludGYoc3RkZXJyLCAiQ2FuJ3QgcGFpciB0
byBkZXZpY2VcbiIpOworCQlyZXR1cm4gLTE7CisJfQorCisJZGJ1c19tZXNzYWdlX3VucmVmKG1z
Zyk7CisKKwlkYnVzX2Nvbm5lY3Rpb25fZmx1c2goY29ubik7CisKKwlkYnVzX3BlbmRpbmdfY2Fs
bF9ibG9jayhwZW5kaW5nKTsKKworCXJldHVybiAwOwogfQogCiBzdGF0aWMgdm9pZCB1c2FnZSh2
b2lkKQogewotCXByaW50ZigiQmx1ZXRvb3RoIGFnZW50IHZlciAlc1xuXG4iLCBWRVJTSU9OKTsK
KwlwcmludGYoIkJsdWV0b290aCBhZ2VudCB2ZXIgJXNcblxuIiwgIjQuMTgiKTsKIAogCXByaW50
ZigiVXNhZ2U6XG4iCi0JCSJcdGFnZW50IFstLWRldmljZSBpbnRlcmZhY2VdIFstLXBhdGggYWdl
bnQtcGF0aF0gPHBhc3NrZXk+XG4iCisJCSJcdGFnZW50IDxkZXZpY2UgYWRkcmVzcz4gW3BpbmNv
ZGVdXG4iCiAJCSJcbiIpOwogfQogCkBAIC0zNDgsMTIgKzQyOSwxMCBAQCBpbnQgbWFpbihpbnQg
YXJnYywgY2hhciAqYXJndltdKQogCWFyZ3YgKz0gb3B0aW5kOwogCW9wdGluZCA9IDA7CiAKLQlp
ZiAoYXJnYyA8IDEpIHsKKwkvKmlmIChhcmdjIDwgMSkgewogCQl1c2FnZSgpOwogCQlleGl0KDEp
OwotCX0KLQotCXBhc3NrZXkgPSBzdHJkdXAoYXJndlswXSk7CisJfSovCiAKIAlpZiAoIWFnZW50
X3BhdGgpCiAJCWFnZW50X3BhdGggPSBzdHJkdXAoZGVmYXVsdF9wYXRoKTsKQEAgLTM2NSwxMiAr
NDQ0LDI1IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCiAJfQogCiAJaWYgKCFk
ZXZpY2VfcGF0aCkKLQkJZGV2aWNlX3BhdGggPSBnZXRfZGV2aWNlKGRldmljZV9pZCk7CisJCWRl
dmljZV9wYXRoID0gZ2V0X2RldmljZShjb25uKTsKIAotCWlmIChyZWdpc3Rlcl9hZ2VudChjb25u
LCBkZXZpY2VfcGF0aCwgYWdlbnRfcGF0aCwgY2FwYWJpbGl0aWVzKSA8IDApIHsKLQkJZGJ1c19j
b25uZWN0aW9uX3VucmVmKGNvbm4pOwotCQlleGl0KDEpOwotCX0KKworCS8vaWYgKGFyZ2MgPj0g
MSl7CisJCWRldmFkZHIgPSBzdHJkdXAoYXJndlswXSk7CisJCXByaW50ZigiUGFpcmluZyB0byAl
c1xuIixkZXZhZGRyKTsKKwkJaWYgKHBhaXJfZGV2aWNlKGNvbm4sIGRldmljZV9wYXRoLCBhZ2Vu
dF9wYXRoLCBjYXBhYmlsaXRpZXMpIDwgMCl7CisJCQkJZGJ1c19jb25uZWN0aW9uX3VucmVmKGNv
bm4pOworCQkJCXByaW50ZigiUGFpcmluZyBmYWlsZWRcbiIpOworCQkJCWV4aXQoMSk7CisJCX0K
KwkvL30KKwkvL2Vsc2UgeworCQlpZiAocmVnaXN0ZXJfYWdlbnQoY29ubiwgZGV2aWNlX3BhdGgs
IGFnZW50X3BhdGgsIGNhcGFiaWxpdGllcykgPCAwKSB7CisJCQlkYnVzX2Nvbm5lY3Rpb25fdW5y
ZWYoY29ubik7CisJCQlleGl0KDEpOworCQl9CisKKwkvL30KIAogCWlmICghZGJ1c19jb25uZWN0
aW9uX2FkZF9maWx0ZXIoY29ubiwgYWdlbnRfZmlsdGVyLCBOVUxMLCBOVUxMKSkKIAkJZnByaW50
ZihzdGRlcnIsICJDYW4ndCBhZGQgc2lnbmFsIGZpbHRlciIpOwpAQCAtMzk1LDExICs0ODcsOSBA
QCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQogCWlmICghX19pb190ZXJtaW5hdGVk
KQogCQl1bnJlZ2lzdGVyX2FnZW50KGNvbm4sIGRldmljZV9wYXRoLCBhZ2VudF9wYXRoKTsKIAot
CWZyZWUoZGV2aWNlX3BhdGgpOworCWZyZWUoZGV2YWRkcik7CiAJZnJlZShhZ2VudF9wYXRoKTsK
IAotCWZyZWUocGFzc2tleSk7Ci0KIAlkYnVzX2Nvbm5lY3Rpb25fdW5yZWYoY29ubik7CiAKIAly
ZXR1cm4gMDsKLS0gCjEuNS42LjMKCg==
------=_Part_43419_3331393.1227887259222--
