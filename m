Return-Path: <cyrus@holtmann.org>
Message-ID: <064f01c8de1d$9af192c0$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Date: Fri, 4 Jul 2008 16:33:29 -0500
MIME-Version: 1.0
Subject: [Bluez-devel] A thought about Adapter.CreatePairedDevice
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Currently CreatePairedDevice requires the remote device address, plus 
the Object Path of a pairing agent (interface org.bluez.Agent), plus a 
string listing the pairing capabilities.

If an agent for the Adapter is already registered, this is redundant at 
best, and confusing at worst.

In my mucking around with my Agent (see my other manifesto...), I tried 
an experiment to see if it was possible to make a method polymorphic, 
and I found that DBus has no objections.  It introspects well (although 
d-feet does not recognizes only the first definition), and when I send a 
message using dbus-send, dbus routes the incoming message to the version 
of the Method with a matching signature.  Sweet.

So, my suggestion is: in adapter.c in setting up the adapter_methods 
table, add an additional method definition sort of like the following:

+++++
/* starting at line 4257 */
static GDBusMethodTable adapter_methods[] = {
...
 { "CreatePairedDevice", "sos", "o", create_paired_device,
      G_DBUS_METHOD_FLAG_ASYNC},
 { "CreatePairedDevice", "s", "o", create_paired_device_noagnt,
      G_DBUS_METHOD_FLAG_ASYNC},
...
}

+++++

The second one is the version that does not require the object path for 
the Agent, nor the capabilities.

Then, add an additional function, right after create_paired_device, to 
handle the new version of the message:

+++++

/* starting at line 4011 */
static DBusMessage *create_paired_device(DBusConnection *conn,
     DBusMessage *msg, void *data)
{
 const gchar *address, *agent_path, *capability;
 uint8_t cap;

 if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &address,
     DBUS_TYPE_OBJECT_PATH, &agent_path,
     DBUS_TYPE_STRING, &capability,
      DBUS_TYPE_INVALID) == FALSE)
  return invalid_args(msg);

 if (check_address(address) < 0)
  return invalid_args(msg);

 cap = parse_io_capability(capability);
 if (cap == IO_CAPABILITY_INVALID)
  return invalid_args(msg);

 return create_bonding(conn, msg, address, agent_path, cap, data);
}

/* new function to support agent-less CreatePairedDevice */

static DBusMessage *create_paired_device_noagnt(DBusConnection *conn,
     DBusMessage *msg, void *data)
{
 const gchar *address, *agent_path, *capability;
 uint8_t cap;

 if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &address,
      DBUS_TYPE_INVALID) == FALSE)
  return invalid_args(msg);

 if (check_address(address) < 0)
  return invalid_args(msg);

 return create_bonding(conn, msg, address, NULL, NULL, data);
}

+++++

There would need to be a couple of additional changes in create_bonding 
to (a) just use the adapter-wide Agent when the agent_path parameter is 
NULL, and (b) throw an error when the agent_path is null, and 
adapter->agent is also null.

Any comments?  If no major objections, I'll submit a patch against 3.35

David Stockwell
Frequency One 


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
