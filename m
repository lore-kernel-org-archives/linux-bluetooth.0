Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] avrcp and dbus
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <438DD431.1090607@xmission.com>
References: <438DD431.1090607@xmission.com>
Content-Type: text/plain
Message-Id: <1133371554.18079.37.camel@blade>
Mime-Version: 1.0
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
Date: Wed, 30 Nov 2005 18:25:54 +0100

Hi Brad,

> I have my test app ("avrecv") accepting connections and ack'ing
> passthrough commands. Most or all headsets are going to be sending
> passthrough only, but we will nak other commands when I figure out how
> the nak looks.
> 
> If you have avrecv running when you start sending audio to the set, the
> headset will turn around and make the avrcp connection. I don't know how
> you use the play button to *initiate* the player however... :(

sounds promising. Keep up with it.

> I would like to make this app a multithreaded daemon and hook it up to
> dbus for both receiving events from headsets and relaying things back to
> the headset (eg volume changes). I will run one thread per connection
> and select() between data from the headset and dbus commands for the
> same l2cap connection...
> 
> Does the dbus approach sound reasonable? Any tips for where to start
> with dbus? (I've never written for it)

I think it is far to earlier to think about D-Bus integration.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
