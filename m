Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <438DD431.1090607@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] avrcp and dbus
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 30 Nov 2005 09:32:49 -0700

Hi

I have my test app ("avrecv") accepting connections and ack'ing
passthrough commands. Most or all headsets are going to be sending
passthrough only, but we will nak other commands when I figure out how
the nak looks.

If you have avrecv running when you start sending audio to the set, the
headset will turn around and make the avrcp connection. I don't know how
you use the play button to *initiate* the player however... :(

I would like to make this app a multithreaded daemon and hook it up to
dbus for both receiving events from headsets and relaying things back to
the headset (eg volume changes). I will run one thread per connection
and select() between data from the headset and dbus commands for the
same l2cap connection...

Does the dbus approach sound reasonable? Any tips for where to start
with dbus? (I've never written for it)

Brad


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
