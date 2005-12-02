Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43906361.7060506@anymore.nl>
From: Arjan Schrijver <arjan@anymore.nl>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] hciattach patch: make the device string longer
References: <439060DA.4000401@anymore.nl> <1133535797.20834.78.camel@blade>
In-Reply-To: <1133535797.20834.78.camel@blade>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Fri, 02 Dec 2005 16:08:17 +0100

Marcel Holtmann wrote:
> I don't get why a device node name is longer than 20 characters, but I
> fixed it in the CVS. However I preferred to use PATH_MAX instead of only
> 30 bytes.
>   
In order to comply with some sort of guideline (I'm not the driver 
programmer), we had to switch to /dev/s3c2410_serial0 as device.
As you can see it makes exactly 20 characters, but 21 including the \0.
Anyway, thanks for fixing!
Arjan


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
