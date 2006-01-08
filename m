Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Jukka Laurila <jplauril@cc.hut.fi>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <Pine.GSO.4.61.0601082205170.8744@vipunen.hut.fi>
Message-ID: <Pine.GSO.4.61.0601082258480.8744@vipunen.hut.fi>
References: <Pine.GSO.4.61.0601082205170.8744@vipunen.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Bluez-users] Re: sdptool browse fails with ISSC dongle and Nokia 6630 in Ubuntu
 Breezy
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
Date: Sun, 8 Jan 2006 23:00:37 +0200 (EET)

On Sun, 8 Jan 2006, Jukka Laurila wrote:

> When I do "sdptool browse 00:11:9F:C8:D9:36" (that's the address of my Nokia 
> 6630) sdptool gives the error:
>
>  Service Search failed: Connection timed out

One more thing: I noticed that "sdptool records 
00:11:9F:C8:D9:36" works fine: It prints out the services 
and no error messages appear on the terminal or in syslog.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
