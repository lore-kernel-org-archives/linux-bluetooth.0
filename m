Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <66dc03c80601041139r7a44eb49w@mail.gmail.com>
From: =?ISO-8859-1?Q?Cezar_S=E1_Espinola?= <cezarsa@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] inquiry frequency
In-Reply-To: <20060104181733.60859.qmail@web53113.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20060104181733.60859.qmail@web53113.mail.yahoo.com>
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
Date: Wed, 4 Jan 2006 16:39:51 -0300

Hi Ermal.
Try to use the flag IREQ_CACHE_FLUSH with hci_inquiry().

regards,
-
Cezar

2006/1/4, ermal mino <ermalmino1004@yahoo.it>:
> Hi,
>
> I made a program wich searches for bluettooth devices continuously.
> I saw that until about 20-30 seconds from the first inquiry  the results
> that were given to me were the same as the first one.
>
> I don't know if i explained it well, in a few words it makes a real inqui=
ry
> every 20-30 seconds.
> How can i fix this or at least to make this delay smaller?
>
> regards,
> Ermal Mino.
>
>  ________________________________
> Yahoo! Messenger: chiamate gratuite in tutto il mondo
>
>


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
