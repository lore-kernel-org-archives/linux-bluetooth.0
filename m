Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <002101d0a501$df117d00$9d347700$@samsung.com>
References: <1433918216-19017-1-git-send-email-gowtham.ab@samsung.com>
	<002101d0a501$df117d00$9d347700$@samsung.com>
Date: Mon, 15 Jun 2015 13:34:09 +0300
Message-ID: <CABBYNZ+sN_io5bx_zOW-1wY61OU6=Wr5CgFxxSQnj-=VV6iROw@mail.gmail.com>
Subject: Re: [PATCH ] tools/obexctl: Add support for pull Vobjects
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bharat Panda <bharat.panda@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Fri, Jun 12, 2015 at 2:20 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Ping.
>
>> -----Original Message-----
>> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
>> owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
>> Sent: Wednesday, June 10, 2015 12:07 PM
>> To: linux-bluetooth@vger.kernel.org
>> Cc: bharat.panda@samsung.com; Gowtham Anandha Babu
>> Subject: [PATCH ] tools/obexctl: Add support for pull Vobjects
>>
>> PullBusinessCard from remote push server.
>>
>> [obex]# connect 00:1B:DC:07:33:4E 00001105-0000-1000-8000-00805f9b34fb
>> Attempting to connect to 00:1B:DC:07:33:4E [NEW] Session
>> /org/bluez/obex/client/session0 [default] [NEW] ObjectPush
>> /org/bluez/obex/client/session0 Connection successful [00:1B:DC:07:33:4E]#
>> pull /home/vcard.vcf Attempting to pull /home/vcard.vcf from
>> /org/bluez/obex/client/session0 [NEW] Transfer
>> /org/bluez/obex/client/session0/transfer0
>> Transfer /org/bluez/obex/client/session0/transfer0
>>       Status: queued
>>       Size: 0
>>       Filename: /home/vcard.vcf
>>       Session: /org/bluez/obex/client/session0 [CHG] Transfer
>> /org/bluez/obex/client/session0/transfer0 Status: complete [DEL] Transfer
>> /org/bluez/obex/client/session0/transfer0
>> [DEL] Session /org/bluez/obex/client/session0 [default] [DEL] ObjectPush
>> /org/bluez/obex/client/session0
>> ---
>>  tools/obexctl.c | 36 +++++++++++++++++++++++++++++++++++-
>>  1 file changed, 35 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/obexctl.c b/tools/obexctl.c index 4faff6b..79c0821
> 100644
>> --- a/tools/obexctl.c
>> +++ b/tools/obexctl.c
>> @@ -758,7 +758,7 @@ static void send_reply(DBusMessage *message, void
>> *user_data)
>>       dbus_error_init(&error);
>>
>>       if (dbus_set_error_from_message(&error, message) == TRUE) {
>> -             rl_printf("Failed to send: %s\n", error.name);
>> +             rl_printf("Failed to send/pull: %s\n", error.name);
>>               dbus_error_free(&error);
>>               return;
>>       }
>> @@ -792,6 +792,23 @@ static void opp_send(GDBusProxy *proxy, int argc,
>> char *argv[])
>>
>>       g_dbus_proxy_get_path(proxy));
>>  }
>>
>> +static void opp_pull(GDBusProxy *proxy, int argc, char *argv[]) {
>> +     if (argc < 2) {
>> +             rl_printf("Missing file argument\n");
>> +             return;
>> +     }
>> +
>> +     if (g_dbus_proxy_method_call(proxy, "PullBusinessCard",
>> send_setup, send_reply,
>> +                                     g_strdup(argv[1]), g_free) == FALSE)
>> {
>> +             rl_printf("Failed to pull\n");
>> +             return;
>> +     }
>> +
>> +     rl_printf("Attempting to pull %s from %s\n", argv[1],
>> +
>>       g_dbus_proxy_get_path(proxy));
>> +}
>> +
>>  static void push_reply(DBusMessage *message, void *user_data)  {
>>       DBusMessageIter iter;
>> @@ -869,6 +886,22 @@ static void cmd_send(int argc, char *argv[])
>>       rl_printf("Command not supported\n");
>>  }
>>
>> +static void cmd_pull(int argc, char *argv[]) {
>> +     GDBusProxy *proxy;
>> +
>> +     if (!check_default_session())
>> +             return;
>> +
>> +     proxy = find_opp(g_dbus_proxy_get_path(default_session));
>> +     if (proxy) {
>> +             opp_pull(proxy, argc, argv);
>> +             return;
>> +     }
>> +
>> +     rl_printf("Command not supported\n");
>> +}
>> +
>>  static void change_folder_reply(DBusMessage *message, void *user_data)
>> {
>>       DBusError error;
>> @@ -1979,6 +2012,7 @@ static const struct {
>>       { "suspend",      "<transfer>", cmd_suspend, "Suspend transfer" },
>>       { "resume",       "<transfer>", cmd_resume, "Resume transfer" },
>>       { "send",         "<file>",   cmd_send, "Send file" },
>> +     { "pull",         "<file>",   cmd_pull, "Pull Vobject & store in
> file" },
>>       { "cd",           "<path>",   cmd_cd, "Change current folder" },
>>       { "ls",           "<options>", cmd_ls, "List current folder" },
>>       { "cp",          "<source file> <destination file>",   cmd_cp,
>> --
>> 1.9.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
> in
>> the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Applying: tools/obexctl: Add support for pull Vobjects
WARNING:LONG_LINE: line over 80 characters
#25: FILE: tools/obexctl.c:802:
+ if (g_dbus_proxy_method_call(proxy, "PullBusinessCard", send_setup,
send_reply,

WARNING:LONG_LINE: line over 80 characters
#65: FILE: tools/obexctl.c:2015:
+ { "pull",  "<file>",   cmd_pull, "Pull Vobject & store in file" },

total: 0 errors, 2 warnings, 60 lines checked

Please fix these.

-- 
Luiz Augusto von Dentz
