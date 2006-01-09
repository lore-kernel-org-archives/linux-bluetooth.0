Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43C29D4B.9030608@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] a2play error...
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAmaUem1Nm8k+FVVBwbPkbkcKAAAAQAAAAwZyW1fiQXke0+pFdteryAwEAAAAA@gmail.com>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAmaUem1Nm8k+FVVBwbPkbkcKAAAAQAAAAwZyW1fiQXke0+pFdteryAwEAAAAA@gmail.com>
Content-Type: text/plain; charset=EUC-KR
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
Date: Mon, 09 Jan 2006 10:28:43 -0700

pdjj14

>  My environment is 'Redhat9(kernel 2.4.20-8) + bluez-utils,-libs-2.24 +
> bluez-hcidump-1.18 + alsa-libs-1.0.10 + btsco-0.41 + mpg123-0.59r-4'.

do you have to run 2.4.x? if you do, can you update it to 2.4.31 and
apply mh1 from http://www.bluez.org/patches.html ?

I don't believe a2play does anything that requires features in the new
kernels but bluez will work better if you track something current.

>  I am modifying the code 'a2play.c'.
> 
>  Is correct what I do?
> 
>  I want to know good methods.

I would try to update the kernel as much as you can first, then look at
modifying a2play.c

are you running on an x86 cpu?

>              write failed: Connection reset by peer

this may be an underlying problem in bluez.

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
