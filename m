Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Dietmar Segbert <trebges@web.de>
To: <bluez-users@lists.sourceforge.net>
Message-ID: <9lZoapieSyB@trebges.web.de>
In-Reply-To: <43C1A0E4.1050102@xmission.com>
References: <43C1A0E4.1050102@xmission.com>
Subject: Re: [Bluez-users] a2play question
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Date: 09 Jan 2006 20:22:00 +0100

Hello List,
hello Brad,

thanks for your infos. I have downloaded the btsco-04.41 release
./configure --enable-alsaplugin
make

and the package will compile.

mpg123 --au - musik.mp3 | ./a2play 00:4F:62:05:53:8A -

starts the connection and after a double-beep i can hear the music. But it
is not a continous stream. it sounds as the music stops and begins.

If i use the -p parameter for a2play, it comes a errormessage:

/dev/rtc open: no such device

and i can not hear anything.

Regards.

Dietmar


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
