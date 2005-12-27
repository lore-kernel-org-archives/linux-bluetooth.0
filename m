Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43B17C78.9050003@tootai.net>
From: Administrator TOOTAI <admin@tootai.net>
MIME-Version: 1.0
To: Bluetooth <bluez-users@lists.sourceforge.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Subject: [Bluez-users] Btsco CVS failed on bootstrap
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
Date: Tue, 27 Dec 2005 18:40:08 +0100

Hi list,

merry christmas and happy new year to all of you.

I compiled 9 monthes ago the alsa bluetooth module and it went fine. I 
uploaded the today CVS and ./bootstrap give me following errors:

configure.in:9: warning: do not use m4_patsubst: use patsubst or 
m4_bpatsubst
aclocal.m4:610: AM_CONFIG_HEADER is expanded from...
configure.in:9: the top level
configure.in:46: warning: do not use m4_regexp: use regexp or m4_bregexp
aclocal.m4:623: _AM_DIRNAME is expanded from...
configure.in:46: the top level
configure.in:9: warning: do not use m4_patsubst: use patsubst or 
m4_bpatsubst
aclocal.m4:610: AM_CONFIG_HEADER is expanded from...
configure.in:9: the top level
configure.in:46: warning: do not use m4_regexp: use regexp or m4_bregexp
aclocal.m4:623: _AM_DIRNAME is expanded from...
configure.in:46: the top level
configure.in:8: your implementation of AM_INIT_AUTOMAKE comes from an
configure.in:8: old Automake version.  You should recreate aclocal.m4
configure.in:8: with aclocal and run automake again.
/usr/share/automake-1.7/am/depend2.am: am__fastdepCC does not appear in 
AM_CONDITIONAL
/usr/share/automake-1.7/am/depend2.am: am__fastdepCC does not appear in 
AM_CONDITIONAL
/usr/share/automake-1.7/am/depend2.am: am__fastdepCC does not appear in 
AM_CONDITIONAL
/usr/share/automake-1.7/am/depend2.am: am__fastdepCC does not appear in 
AM_CONDITIONAL

The configure file is *not* created. I'm running Debian SID 2.6.14, 
automake 1.7.9, autoconf 2.59

Does someone know what's the problem? Thanks for any hint.

-- 
Daniel


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
