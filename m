Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43C66070.5010601@labri.fr>
From: Martin Raspaud <mraspaud@labri.fr>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] AVDTP in BlueZ
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
Date: Thu, 12 Jan 2006 14:58:08 +0100

Hi all,


According to the mailing archive (since september 2005) and the Todo
List there is no implementation of avdtp in BlueZ.
Is this right ?
I am planning to implement audio streaming (ogg) over bluetooth. If I
understand correctly (reading the mailing archive) there were attemps
to consider the bluetooth device as a soundcard using alsa. Is this
working ? Would this fit my purpose ? Would it replace avdtp in BlueZ ?

My idea was to implement an icecast plugin/patch to send the data over
bluetooth and then implement a reader on the phone/pda/some device.
Do you think it is doable ? Is someone already working on this ?

Do you any idea about that ?

Best regards

Martin



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
