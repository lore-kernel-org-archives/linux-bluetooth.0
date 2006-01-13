Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bluez-devel] Problems with smart phones when using a"silent"kernel
Message-ID: <C70061B183DE09419568AB2060C52A9501750DA0@arion.intra.local>
From: "Victor Shcherbatyuk" <Victor.Shcherbatyuk@tomtom.com>
To: <bluez-devel@lists.sourceforge.net>
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
Date: Fri, 13 Jan 2006 14:01:56 +0100

I've checked, it is running, so the only option it has some issues with
console redirected to /dev/null... Will check the logs...

Regards,
    Victor.=20

-----Original Message-----
From: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Friday, January 13, 2006 13:13 PM
To: bluez-devel@lists.sourceforge.net
Subject: RE: [Bluez-devel] Problems with smart phones when using
a"silent"kernel

Hi Victor,

> Small update. I've tried to connect with rfcomm tool - the same=20
> behaviour. With the silent kernel it does not connect to Windows=20
> Mobile phones. The logs show attempts to connect to the phone with
"normal"
> kernel (connection successful) and "silent" one (fails). PSM Not=20
> Supported is something that probably goes wrong...

these stupid Microsoft devices. Everytime they get a connection, they
connect back to the SDP server of that device and this fails. So it
seems to me that the SDP daemon is not running or have problems with the
console redirected to /dev/null. Check in the log files for errors from
sdpd. Or you might need to use strace to track it.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log
files for problems?  Stop!  Download the new AJAX search engine that
makes searching your log files as easy as surfing the  web.  DOWNLOAD
SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


This e-mail message contains information which is confidential and may be=
 privileged. It is intended for use by the addressee only. If you are not=
 the intended addressee, we request that you notify the sender immediatel=
y and delete or destroy this e-mail message and any attachment(s), withou=
t copying, saving, forwarding, disclosing or using its contents in any ot=
her way. TomTom N.V., TomTom International BV or any other company belong=
ing to the TomTom group of companies will not be liable for damage relati=
ng to the communication by e-mail of data, documents or any other informa=
tion.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
