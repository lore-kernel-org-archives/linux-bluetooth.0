Return-Path: <cyrus@holtmann.org>
Message-ID: <066701c8de28$51a90a70$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Date: Fri, 4 Jul 2008 17:50:11 -0500
MIME-Version: 1.0
Subject: [Bluez-devel] One more suggestion regarding Agent
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

This is also based on my previous experimentation.

There may be a valid use-case to allow for the Agent to be a separate 
process.  However, there needs to be a way to designate the BusName of 
the connection from the other Agent process to the System bus.

For RegisterAgent and CreatePairedDevice, the syntax of the Object Path 
is simply "/net/frequencyone/authorize", which defaults to an object in 
the same process and using the process'es connection to the system bus.

I thought that one might incorporate the Bus Name/connection name into 
the Object Path.  For example, one might say:

"net.frequencyone:/net/frequencyone/authorize", which would point the 
bus name to "net.frequencyone", and the object would be attached to that 
"well-known name" (i.e., "net.frequencyone").

Alternatively, one might enter:

":1.57:/net/frequencyone/authorize", which would reference the unique 
connection name and the object path.  This would raise a problem with 
passing the current unique connection name from the agent to the 
application.  Unless there was some way to search the System bus for 
connections providing a given Object Path, or the unique name was shared 
via a pipe or shared memory, this would probably not be a great 
approach, but would still be within the realm of possibility.

However, in either case, the fact remains that the alternative formats 
do not confirm to the standard for a DBUS_TYPE_OBJECT_PATH, or its Glib 
binding version: DBUS_TYPE_G_OBJECT_PATH.

If it appears that this is a desirable added functionality (providing 
for the Agent as an external process), we might provide for it by 
additional definitions for the RegisterAgent and CreatePairedDevice 
methods of Adapter.  For example:

static GDBusMethodTable adapter_methods[] = {
...
 { "CreatePairedDevice", "sos", "o", create_paired_device,
      G_DBUS_METHOD_FLAG_ASYNC},
 { "CreatePairedDevice", "soss", "o", create_paired_device_ext,
      G_DBUS_METHOD_FLAG_ASYNC},
...
 { "RegisterAgent", "os", "", register_agent        },
 { "RegisterAgent", "oss", "o", register_agent_ext},
...
}

A proxy call to call the RegisterAgent method might look like the 
following:

dbus_g_proxy_call(dHciObj, "RegisterAgent", &gError,
    DBUS_TYPE_G_OBJECT_PATH, "/net/frequencyone/authorize,
    G_TYPE_STRING, "NoInputOutput",
    G_TYPE_STRING, "net.frequencyone",
    G_TYPE_INVALID,
    G_TYPE_INVALID)

In the unique connection name case, it might be:

dbus_g_proxy_call(dHciObj, "RegisterAgent", &gError,
    DBUS_TYPE_G_OBJECT_PATH, "/net/frequencyone/authorize,
    G_TYPE_STRING, "NoInputOutput",
    G_TYPE_STRING, ":1.57",
    G_TYPE_INVALID,
    G_TYPE_INVALID)

Of course, if the Agent code is registered and contained within the 
current process, the call would remain:

dbus_g_proxy_call(dHciObj, "RegisterAgent", &gError,
    DBUS_TYPE_G_OBJECT_PATH, "/net/frequencyone/authorize,
    G_TYPE_STRING, "NoInputOutput",
    G_TYPE_INVALID,
    G_TYPE_INVALID)

Any comments, including the basic questions around whether this should 
be done at all?

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
