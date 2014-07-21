Return-Path: <cyrus@holtmann.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: 'Johan Hedberg' <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, cpgs@samsung.com
References: <1405934433-29723-1-git-send-email-bharat.panda@samsung.com>
 <20140721094355.GA29317@t440s.lan>
In-reply-to: <20140721094355.GA29317@t440s.lan>
Subject: RE: [PATCH ] tools: Add unregister gatt service
Date: Mon, 21 Jul 2014 17:16:36 +0530
Message-id: <00c501cfa4d9$77fc36b0$67f4a410$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> On Mon, Jul 21, 2014, Bharat Panda wrote:
> > +static int id;
> > +
> >  struct characteristic {
> >  	char *uuid;
> >  	char *path;
> > @@ -332,10 +334,10 @@ static gboolean register_characteristic(const
> > char *chr_uuid,
> >
> >  static char *register_service(const char *uuid)  {
> > -	static int id = 1;
> 
> Making id public looks unnecessary to me since after the registration
you've
> got the path which you can pass to the unregistration procedure.

The id was made public, because service path was not public. We need to make
either id or service path as public to unregister interface path.
> 
> > +static void remove_services()
> > +{
> > +	char *service_path = g_strdup_printf("/service%d", id);;
> > +
> > +	services = g_slist_remove(services, service_path);
> 
> This makes even less sense to me. You allocate a new pointer
> (service_path) and expect it to magically exist in the services list?
> That's not how g_slist_remove works. It knows nothing about strings.
> Instead you'd want to get hold of the original path string and remove the
> right entry based on that.

Yes, this is not needed actually, it will be removed in following patch.
> 
> > +	if (dbus_error_is_set(&derr)) {
> > +		printf("UnRegisterService: %s\n", derr.message);
> 
> It's UnregisterService. Not UnRegisterService.
> 
> > +	printf("UnRegisterService: OK\n");
> 
> Same here.
> 
> > +static void unregister_external_service(gpointer a, gpointer b) {
> > +	DBusConnection *conn = b;
> > +	const char *path = a;
> > +	DBusMessage *msg;
> > +	DBusPendingCall *call;
> > +	DBusMessageIter iter;
> > +
> > +	msg = dbus_message_new_method_call("org.bluez", "/org/bluez",
> > +					GATT_MGR_IFACE,
> "UnregisterService");
> > +	if (!msg) {
> > +		printf("Couldn't allocate D-Bus message\n");
> > +		return;
> > +	}
> > +
> > +	dbus_message_iter_init_append(msg, &iter);
> > +
> > +	dbus_message_iter_append_basic(&iter,
> DBUS_TYPE_OBJECT_PATH, &path);
> > +
> > +	if (!g_dbus_send_message_with_reply(conn, msg, &call, -1)) {
> > +		dbus_message_unref(msg);
> > +		return;
> > +	}
> > +
> > +	dbus_message_unref(msg);
> > +
> > +	dbus_pending_call_set_notify(call,
> unregister_external_service_reply,
> > +								NULL, NULL);
> > +	dbus_pending_call_unref(call);
> > +}
> > +
> >  static void register_external_service(gpointer a, gpointer b)  {
> >  	DBusConnection *conn = b;
> > @@ -432,6 +499,11 @@ static void connect_handler(DBusConnection
> *conn, void *user_data)
> >  	g_slist_foreach(services, register_external_service, conn);  }
> >
> > +static void disconnect_handler(DBusConnection *conn, void *user_data)
> > +{
> > +	g_slist_foreach(services, unregister_external_service, conn); }
> > +
> >  static gboolean signal_handler(GIOChannel *channel, GIOCondition cond,
> >  							gpointer user_data)
> >  {
> > @@ -524,6 +596,7 @@ int main(int argc, char *argv[])
> >  	client = g_dbus_client_new(connection, "org.bluez", "/org/bluez");
> >
> >  	g_dbus_client_set_connect_watch(client, connect_handler, NULL);
> > +	g_dbus_client_set_disconnect_watch(client, disconnect_handler,
> > +NULL);
> 
> When exactly would disconnect_handler be called in practice? At least one
> case seems to be if bluetoothd exits in which case it seems quite wasteful
to
> try to make any method calls to a non-existing service.
> What other scenarios would disconnect_handler be called in?

On running the gatt-service, it registers the service and updates gatt db
with the service path.
On exiting the gatt-service, it should call "UnregisterService" and clear
the gatt service db. 
Otherwise, on next run of gatt-service, when it registers the same service
path, 
it gets an error, service already exists. 

Best Regards,
Bharat

