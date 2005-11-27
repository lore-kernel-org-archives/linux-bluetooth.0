Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43895560.3050801@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] multiple rfcomm listeners
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
Date: Sat, 26 Nov 2005 23:42:40 -0700

Hey

I have been playing around with gpsd, DGPS and repeating gps data over
bluetooth. I'm considering how feasible it would be to run two rfcomm SP
listeners on one computer. Essentially I want to repeat the
(dgps-corrected) data to more than one bluetooth gps client.

If I run rfcomm listeners on two channels, can I just remove and add the
SP service on the alternate channel when a client connects?

I've heard that bluetooth clients are supposed to check for the SP
channel via sdp on every connect, but bluez doesn't do that in its
rfcomm bindings, eh? Do other devices check the channel only when pairing?

Is there a daemon to help with firing up the listener as soon as the
connection is made? I saw a script on my gumstix that uses rfcomm to
poll the rfcomm state and fire up a getty when connected. But will an
app with an rfcomm device open get sighup'd when the connection is broken?

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
