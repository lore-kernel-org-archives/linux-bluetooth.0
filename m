Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Andrew N. Balahonov" <sspp@cityline.ru>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hci.c:885: storage size of `iv' isn't known
In-Reply-To: <1136230278.24985.4.camel@localhost>
Message-ID: <Pine.LNX.4.63.0601030202140.23868@sundust>
References: <20051231185308.E3D14130C8@sc8-sf-spam2.sourceforge.net>
 <Pine.LNX.4.63.0512312154150.23868@sundust>  <1136201460.22810.10.camel@localhost>
  <Pine.LNX.4.63.0601022121160.23868@sundust> <1136230278.24985.4.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
Date: Tue, 3 Jan 2006 02:07:13 +0300 (MSK)

Yes, it helps.
Did you commit it for next release?!

-- 
Yours sincerely, Andrew N. Balahonov
1024D/3C340684 94B4 C3C5 8936 9DF5 A2B8  3E5C DB3A CC66 3C34 0684

On Mon, 2 Jan 2006, Marcel Holtmann wrote:

> Hi Andrew,
>
>> OS: Openwall GNU/*/Linux., http://www.openwall.com/Owl/
>>
>> ls -l /lib/libc[.-]*
>> -rwxr-xr-x    1 root     root         3.9M  20  2003 /lib/libc-2.1.3.so
>> lrwxrwxrwx    1 root     root           13  23  2004 /lib/libc.so.6 -> libc-2.1.3.so
>>
>> $ gcc -v
>> Reading specs from /usr/lib/gcc-lib/i386-unknown-linux/2.95.3/specs
>> gcc version 2.95.3 20010315 (release)
>
> check if the attached patch helps.
>
> Regards
>
> Marcel
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
