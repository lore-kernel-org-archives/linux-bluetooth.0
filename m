Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Sat, 27 Oct 2007 23:37:03 -0700 (PDT)
From: Chris Dragga <chris_dragga@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <578209.61831.qm@web52103.mail.re2.yahoo.com>
Subject: [Bluez-users] Creating connections with the network DBUS API
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,

I'm back with another question about the network features of DBUS.  Specifically, I'm trying to create a connection using NAP as described on the wiki, albeit in C, rather than Python, and when I execute the Connect method on the connection object, I get the error:  "Operation now in progresss."  In addition, I never get a Connected signal (though I do have it handled correctly, I'm pretty sure), and hcitool shows no connections active once I've done this.  Note that the same error also occurs with GN.  Is there some sort of setting for Bluetooth itself that I'm missing, or do I need to introduce a delay somewhere in the code?  For what it's worth, the relevant sections of code are as follows:

/*Connects the signal properly*/
        dbus_g_object_register_marshaller(
                        g_cclosure_marshal_VOID__VOID,
                        G_TYPE_NONE, G_TYPE_NONE,
                        G_TYPE_INVALID);
        dbus_g_proxy_add_signal(network_conn, "Connected",
                        G_TYPE_INVALID);
        dbus_g_proxy_connect_signal(network_conn, "Connected",
                        G_CALLBACK(connected_handler), network_iface, NULL);
/*The actual connection method call*/
        if (!dbus_g_proxy_call(network_conn, "Connect", &error,
                        G_TYPE_INVALID, G_TYPE_STRING, &network_iface,
                        G_TYPE_INVALID)){
                handle_error(error);
                g_print("The network interface might be: %s\n", network_iface);
/*              return NULL;*/
        }

Also, when the documentation says that the Connect method returns the network interface, would this be something along the lines of bnep0?  Finally, correct me if I'm wrong, but since there is no "CreateServer" method in the network manager object (despite what the wiki says), the servers that ListServers lists are the only ones available.  Any help would be appreciated.

Thanks,
Chris Dragga



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
