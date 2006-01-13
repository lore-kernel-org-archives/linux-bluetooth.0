Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43C7DEF8.4050007@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Multiple headsets with one dongle
References: <43C6F96B.6080402@sonar-security.com>
In-Reply-To: <43C6F96B.6080402@sonar-security.com>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Fri, 13 Jan 2006 10:10:16 -0700

Michael

> number, but what I haven't been able to get working is one headset
> calling the other. Well, actually, it *does* work, but the audio is
> totally unusable.
> 
> From what I have been able to gather so far, the headsets are using
> RFCOMM channel 2 (sdptool search --bdaddr 0x111E), and so when both are
> communicating with the dongle at the same time, they most likely are
> interfering each other. My questions are:

The rfcomm channel communication is not where interference happens. It's
when both headsets try to build the sco connection at the same time.

> 3. The dongle, configured as master, *should* support up to three slaves
> using the handsfree profile?

I'm not totally sure how to do this anyway. Marcel has hinted at it and
apparently there's a boot-time parameter to set something to allow two
sco connections. I tried to capture everything in the btsco bug for
multiple headsets, but this is all I come up with there:

Marcel adds: "To get more than one SCO channel working the hci_usb
driver must be fixed to dynamicaly change the alternate settting."

I think he was working on the generic case but if you know how many
headsets you have paired with you could set the alternate setting once
and leave it alone I think.

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
