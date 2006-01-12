Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43C68EEF.4070801@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] btsco.41 and config.log does not give a ko file
References: <43C675A7.1040308@pagestation.com>
In-Reply-To: <43C675A7.1040308@pagestation.com>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Thu, 12 Jan 2006 10:16:31 -0700

Jerry

> I just downloaded btsco.41 did the ./configure; make; make install
> I have no ko file in the the btsco.41 directory.
> 
> I had a problem where it could not find ao.h. I fixed that with "up2date
> libao-devel".
> I am using centos 4.2 which is compatible with RHEL 4.2.

the libao thing shouldn't have caused problems. I guess --disable-aotest
should have been specified when you didn't have the package

cd to the directory "kernel" and run make there to get the kernel
modules (just checked the docs; it's build step #4 on
http://bluetooth-alsa.sourceforge.net/ )

brad




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
