Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 18 Oct 2006 17:03:52 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20061018140352.GA11008@localhost.localdomain>
References: <1155819360.4075.123.camel@aeonflux.holtmann.net>
	<20060817113538.GB5118@srcf.ucam.org>
	<1155823499.4075.157.camel@aeonflux.holtmann.net>
	<20060817122559.GA6422@srcf.ucam.org>
	<20060817124514.GA27427@localhost.localdomain>
	<1155819813.18545.36.camel@cookie.hadess.net>
	<1155839761.4075.165.camel@aeonflux.holtmann.net>
	<44E5B2A5.1070002@palmsource.com>
	<1155924372.4075.191.camel@aeonflux.holtmann.net>
	<45362E18.1040909@palmsource.com>
MIME-Version: 1.0
In-Reply-To: <45362E18.1040909@palmsource.com>
Subject: Re: [Bluez-devel]
	DBus	interface	-	determining	whether	a	device	exists
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Fred,

On Wed, Oct 18, 2006, Frederic Danis wrote:
> You can find attached a new patch implementing ListRemoteDevices and 
> ListRecentRemoteDevices.

Couple of notes about your patch:

> +static void list_remote_devices_do_append(char *key, char *value, void *data)
> +{
> +	struct remote_device_list_t *param = data;
> +	char *address;
> +	struct tm date;
> +
> +	if (slist_find(param->list, key, (cmp_func_t) bacmp))
> +		return;

bacmp takes bdaddr_t pointers not char pointers. You probably want to 
use strcasecmp.

> +	slist_append(param->list, address);

This should be:
param->list = slist_append(param->list, address);

> +	/* Add Bonded devices to the list */
> +	create_name(filename, PATH_MAX, STORAGEDIR, adapter->address, "linkkeys");
> +	textfile_foreach(filename, list_remote_devices_do_append, &param);
> +
> +	/* Add Last Used devices to the list */
> +	create_name(filename, PATH_MAX, STORAGEDIR, adapter->address, "lastused");
> +	textfile_foreach(filename, list_remote_devices_do_append, &param);
> +
> +	/* Add Last Seen devices to the list */
> +	create_name(filename, PATH_MAX, STORAGEDIR, adapter->address, "lastseen");
> +	textfile_foreach(filename, list_remote_devices_do_append, &param);
> +
> +	reply = dbus_message_new_method_return(msg);
> +
> +	dbus_message_iter_init_append(reply, &iter);
> +
> +	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> +				DBUS_TYPE_STRING_AS_STRING, &array_iter);
> +
> +	slist_foreach(param.list, remote_devices_do_append, &array_iter);
> +
> +	slist_free(param.list);

slist_free only frees the nodes in the list but not the data they point 
to (the strings which have been allocated with strdup). So you probably 
want to call slist_foreach(param.list, (slist_func_t) free, NULL) before 
slist_free or free the data in remote_devices_do_append.

> +	/* Add Bonded devices to the list */
> +	create_name(filename, PATH_MAX, STORAGEDIR, adapter->address, "linkkeys");
> +	textfile_foreach(filename, list_remote_devices_do_append, &param);
> +
> +	/* Add Last Used devices to the list */
> +	create_name(filename, PATH_MAX, STORAGEDIR, adapter->address, "lastused");
> +	textfile_foreach(filename, list_remote_devices_do_append, &param);
> +
> +	reply = dbus_message_new_method_return(msg);
> +
> +	dbus_message_iter_init_append(reply, &iter);
> +
> +	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> +				DBUS_TYPE_STRING_AS_STRING, &array_iter);
> +
> +	slist_foreach(param.list, remote_devices_do_append, &array_iter);
> +
> +	slist_free(param.list);

And same applies here.

Johan

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
