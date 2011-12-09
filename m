Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1323358075-27857-16-git-send-email-mikel.astiz@bmw-carit.de>
References: <1323358075-27857-1-git-send-email-mikel.astiz@bmw-carit.de>
	<1323358075-27857-16-git-send-email-mikel.astiz@bmw-carit.de>
Date: Fri, 9 Dec 2011 14:35:11 +0200
Message-ID: <CABBYNZJJLXaUVR=OkotNmFnsSz1+8ScPfpH4WRLXZbxKxt7Heg@mail.gmail.com>
Subject: Re: [RFC obexd v2 15/21] client: FileTransfer sessions return transports
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz@bmw-carit.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Thu, Dec 8, 2011 at 5:27 PM, Mikel Astiz <mikel.astiz@bmw-carit.de> wrote:
> ---
>  client/ftp.c    |   61 ++++++++----------
>  test/ftp-client |  188 ++++++++++++++++++++++++++-----------------------------
>  2 files changed, 117 insertions(+), 132 deletions(-)
>
> diff --git a/client/ftp.c b/client/ftp.c
> index 6630cc9..15b2b48 100644
> --- a/client/ftp.c
> +++ b/client/ftp.c
> @@ -192,29 +192,6 @@ static const GMarkupParser parser = {
>        NULL
>  };
>
> -static void get_file_callback(struct obc_session *session, GError *err,
> -                                       const struct obc_transfer *transfer,
> -                                       void *user_data)
> -{
> -       struct ftp_data *ftp = user_data;
> -       DBusMessage *reply;
> -
> -       if (!ftp->msg)
> -               return;
> -
> -       if (err)
> -               reply = g_dbus_create_error(ftp->msg,
> -                                       "org.openobex.Error.Failed",
> -                                       "%s", err->message);
> -       else
> -               reply = dbus_message_new_method_return(ftp->msg);
> -
> -       g_dbus_send_message(conn, reply);
> -
> -       dbus_message_unref(ftp->msg);
> -       ftp->msg = NULL;
> -}
> -
>  static void list_folder_callback(struct obc_session *session,
>                                        GError *err,
>                                        const struct obc_transfer *transfer,
> @@ -325,6 +302,9 @@ static DBusMessage *get_file(DBusConnection *connection,
>        struct ftp_data *ftp = user_data;
>        struct obc_session *session = ftp->session;
>        const char *target_file, *source_file;
> +       DBusMessage *reply;
> +       struct obc_transfer *transfer;
> +       const char *path;
>
>        if (dbus_message_get_args(message, NULL,
>                                DBUS_TYPE_STRING, &target_file,
> @@ -334,15 +314,21 @@ static DBusMessage *get_file(DBusConnection *connection,
>                                "org.openobex.Error.InvalidArguments", NULL);
>
>        if (obc_session_get(session, NULL, source_file,
> -                               target_file, NULL, 0, get_file_callback,
> -                               ftp, NULL) < 0)
> +                               target_file, NULL, 0, NULL,
> +                               NULL, &transfer) < 0)

Make obc_session_get to return the transfer and get an int *err as parameter.

>                return g_dbus_create_error(message,
>                                "org.openobex.Error.Failed",
>                                "Failed");
>
> -       ftp->msg = dbus_message_ref(message);
> +       path = obc_transfer_get_path(transfer);
>
> -       return NULL;
> +       reply = dbus_message_new_method_return(message);
> +
> +       dbus_message_append_args(reply,
> +                       DBUS_TYPE_OBJECT_PATH, &path,
> +                       DBUS_TYPE_INVALID);
> +
> +       return reply;
>  }
>
>  static DBusMessage *put_file(DBusConnection *connection,
> @@ -351,6 +337,9 @@ static DBusMessage *put_file(DBusConnection *connection,
>        struct ftp_data *ftp = user_data;
>        struct obc_session *session = ftp->session;
>        gchar *sourcefile, *targetfile;
> +       DBusMessage *reply;
> +       struct obc_transfer *transfer;
> +       const char *path;
>
>        if (dbus_message_get_args(message, NULL,
>                                        DBUS_TYPE_STRING, &sourcefile,
> @@ -360,12 +349,20 @@ static DBusMessage *put_file(DBusConnection *connection,
>                                "org.openobex.Error.InvalidArguments",
>                                "Invalid arguments in method call");
>
> -       if (obc_session_put(session, targetfile, sourcefile, NULL) < 0)
> +       if (obc_session_put(session, targetfile, sourcefile, &transfer) < 0)
>                return g_dbus_create_error(message,
>                                "org.openobex.Error.Failed",
>                                "Failed");

Same here.

> -       return dbus_message_new_method_return(message);
> +       path = obc_transfer_get_path(transfer);
> +
> +       reply = dbus_message_new_method_return(message);
> +
> +       dbus_message_append_args(reply,
> +                       DBUS_TYPE_OBJECT_PATH, &path,
> +                       DBUS_TYPE_INVALID);
> +
> +       return reply;
>  }
>
>  static DBusMessage *copy_file(DBusConnection *connection,
> @@ -503,10 +500,8 @@ static GDBusMethodTable ftp_methods[] = {
>                                                G_DBUS_METHOD_FLAG_ASYNC },
>        { "ListFolder",         "", "aa{sv}",   list_folder,
>                                                G_DBUS_METHOD_FLAG_ASYNC },
> -       { "GetFile",            "ss", "",       get_file,
> -                                               G_DBUS_METHOD_FLAG_ASYNC },
> -       { "PutFile",            "ss", "",       put_file,
> -                                               G_DBUS_METHOD_FLAG_ASYNC },
> +       { "GetFile",            "ss", "o",      get_file },
> +       { "PutFile",            "ss", "o",      put_file },
>        { "CopyFile",           "ss", "",       copy_file,
>                                                G_DBUS_METHOD_FLAG_ASYNC },
>        { "MoveFile",           "ss", "",       move_file,
> diff --git a/test/ftp-client b/test/ftp-client
> index 05f16ad..d48b44e 100755
> --- a/test/ftp-client
> +++ b/test/ftp-client
> @@ -9,42 +9,6 @@ import dbus.mainloop.glib
>  import os.path
>  from optparse import OptionParser
>
> -class Agent(dbus.service.Object):
> -    def __init__(self, conn=None, obj_path=None, verbose=False):
> -        dbus.service.Object.__init__(self, conn, obj_path)
> -        self.verbose = verbose
> -
> -    @dbus.service.method("org.openobex.Agent",
> -                    in_signature="o", out_signature="s")
> -    def Request(self, path):
> -        return ""
> -
> -    @dbus.service.method("org.openobex.Agent",
> -                    in_signature="ot", out_signature="")
> -    def Progress(self, path, transferred):
> -        if self.verbose:
> -            print "Transfer progress (%d bytes)" % (transferred)
> -        return
> -
> -    @dbus.service.method("org.openobex.Agent",
> -                    in_signature="o", out_signature="")
> -    def Complete(self, path):
> -        if self.verbose:
> -            print "Transfer finished"
> -        mainloop.quit()
> -
> -    @dbus.service.method("org.openobex.Agent",
> -                    in_signature="os", out_signature="")
> -    def Error(self, path, error):
> -        print "Transfer finished with an error: %s" % (error)
> -        mainloop.quit()
> -
> -    @dbus.service.method("org.openobex.Agent",
> -                    in_signature="", out_signature="")
> -    def Release(self):
> -        mainloop.quit()
> -
> -
>  def parse_options():
>     parser.add_option("-d", "--device", dest="device",
>                       help="Device to connect", metavar="DEVICE")
> @@ -64,55 +28,89 @@ def parse_options():
>                       help="Destination FILE", metavar="FILE")
>     parser.add_option("-r", "--remove", dest="remove_file",
>                       help="Remove FILE", metavar="FILE")
> -    parser.add_option("-v", "--verbose", action="store_true", dest="verbose")
>
>     return parser.parse_args()
>
> -def error(err):
> -    print err
> -
> -def void_reply():
> -    pass
> -
> -def change_folder(session, new_dir):
> -    for node in new_dir.split("/"):
> -        session.ChangeFolder(node)
> -
> -def list_folder(session):
> -    for i in session.ListFolder():
> -        if i["Type"] == "folder":
> -            print "%s/" % (i["Name"])
> -        else:
> -            print "%s" % (i["Name"])
> -
> -def put_file(session, filename):
> -    session.PutFile(os.path.abspath(filename),
> -                    os.path.basename(filename),
> -                    reply_handler=void_reply,
> -                    error_handler=error)
> -
> -def get_file(session, filename):
> -    session.GetFile(os.path.abspath(filename),
> -                    os.path.basename(filename),
> -                    reply_handler=void_reply,
> -                    error_handler=error)
> -
> -def remove_file(session, filename):
> -    session.Delete(filename,
> -                    reply_handler=void_reply,
> -                    error_handler=error)
> -
> -def move_file(session, filename, destname):
> -    session.MoveFile(filename,
> -                    destname,
> -                    reply_handler=void_reply,
> -                    error_handler=error)
> -
> -def copy_file(session, filename, destname):
> -    session.CopyFile(filename,
> -                    destname,
> -                    reply_handler=void_reply,
> -                    error_handler=error)
> +class FtpClient:
> +    def __init__(self, session_path):
> +        self.transfer_path = None
> +        bus = dbus.SessionBus()
> +        self.session = dbus.Interface(bus.get_object("org.openobex.client",
> +                                                     session_path),
> +                                      "org.openobex.Session")
> +        self.ftp = dbus.Interface(bus.get_object("org.openobex.client",
> +                                                 session_path),
> +                                  "org.openobex.FileTransfer")
> +        bus.add_signal_receiver(
> +            self.transfer_complete,
> +            dbus_interface="org.openobex.Transfer",
> +            signal_name="Complete",
> +            path_keyword="path")
> +        bus.add_signal_receiver(
> +            self.transfer_error,
> +            dbus_interface="org.openobex.Transfer",
> +            signal_name="Error",
> +            path_keyword="path")
> +
> +    def create_transfer_reply(self, path):
> +        self.transfer_path = path
> +        print "Transfer created: %s" % path
> +
> +    def error(self, err):
> +        print err
> +        mainloop.quit()
> +
> +    def transfer_complete(self, path):
> +        if path != self.transfer_path:
> +            return
> +        print "Transfer finished"
> +        mainloop.quit()
> +
> +    def transfer_error(self, error, path):
> +        if path != self.transfer_path:
> +            return
> +        print "Transfer finished with an error: %s" % (error)
> +        mainloop.quit()
> +
> +    def change_folder(self, new_dir):
> +        for node in new_dir.split("/"):
> +            self.ftp.ChangeFolder(node)
> +
> +    def list_folder(self):
> +        for i in self.ftp.ListFolder():
> +            if i["Type"] == "folder":
> +                print "%s/" % (i["Name"])
> +            else:
> +                print "%s" % (i["Name"])
> +
> +    def put_file(self, filename):
> +        self.ftp.PutFile(os.path.abspath(filename),
> +                         os.path.basename(filename),
> +                         reply_handler=self.create_transfer_reply,
> +                         error_handler=self.error)
> +
> +    def get_file(self, filename):
> +        self.ftp.GetFile(os.path.abspath(filename),
> +                         os.path.basename(filename),
> +                         reply_handler=self.create_transfer_reply,
> +                         error_handler=self.error)
> +
> +    def remove_file(self, filename):
> +        self.ftp.Delete(filename,
> +                        reply_handler=self.create_transfer_reply,
> +                        error_handler=self.error)
> +
> +    def move_file(self, filename, destname):
> +        self.ftp.MoveFile(filename,
> +                          destname,
> +                          reply_handler=self.create_transfer_reply,
> +                          error_handler=self.error)
> +
> +    def copy_file(self, filename, destname):
> +        self.ftp.CopyFile(filename,
> +                          destname,
> +                          reply_handler=self.create_transfer_reply,
> +                          error_handler=self.error)
>
>  if  __name__ == '__main__':
>
> @@ -129,41 +127,33 @@ if  __name__ == '__main__':
>     bus = dbus.SessionBus()
>     mainloop = gobject.MainLoop()
>
> -    path = "/test/agent"
> -    agent = Agent(bus, path, options.verbose)
> -
>     client = dbus.Interface(bus.get_object("org.openobex.client", "/"),
>                             "org.openobex.Client")
>
> +    print "Creating Session"
>     session_path = client.CreateSession("", options.device, "ftp", dict())
>
> -    session = dbus.Interface(bus.get_object("org.openobex.client", session_path),
> -                 "org.openobex.Session")
> -
> -    session.AssignAgent(path)
> -
> -    ftp = dbus.Interface(bus.get_object("org.openobex.client", session_path),
> -                 "org.openobex.FileTransfer")
> +    ftp_client = FtpClient(session_path)
>
>     if options.new_dir:
> -        change_folder(ftp, options.new_dir)
> +        ftp_client.change_folder(options.new_dir)
>
>     if options.list_dir:
> -        list_folder(ftp)
> +        ftp_client.list_folder()
>
>     if options.get_file:
> -        get_file(ftp, options.get_file)
> +        ftp_client.get_file(options.get_file)
>
>     if options.put_file:
> -        put_file(ftp, options.put_file)
> +        ftp_client.put_file(options.put_file)
>
>     if options.move_file:
> -        move_file(ftp, options.move_file, options.dest_file)
> +        ftp_client.move_file(options.move_file, options.dest_file)
>
>     if options.copy_file:
> -        copy_file(ftp, options.copy_file, options.dest_file)
> +        ftp_client.copy_file(options.copy_file, options.dest_file)
>
>     if options.remove_file:
> -       remove_file(ftp, options.remove_file)
> +       ftp_client.remove_file(options.remove_file)
>
>     mainloop.run()
> --
> 1.7.6.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
