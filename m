Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43983410.5010701@rambler.ru>
From: Pavel Fedin <sonic_amiga@rambler.ru>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] ISSC IVT USB dongle
References: <43982224.6020208@rambler.ru> <1134044091.3752.87.camel@blade>	 <43982BAC.2030508@rambler.ru> <1134047622.3752.89.camel@blade>
In-Reply-To: <1134047622.3752.89.camel@blade>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 08 Dec 2005 16:24:32 +0300

Marcel Holtmann wrote:

> Check what "hciconfig -a" says and if hcid is running.

  It reported that hci0 is in DOWN state. After hciconfig hci0 up everything worked fine! Thank you 
very much!
  In fact you saved my work. Windoze implementation doesn't work with RFCOMM. Just doesn't, noone 
knows why. Of course i expect Linux to work pretty well.
  BTW, how to set up my system then to bring up hci0 automatically?

  Kind regards.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
