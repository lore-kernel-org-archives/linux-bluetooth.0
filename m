Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bluez-devel] Problems with smart phones when using a "silent"kernel
Message-ID: <C70061B183DE09419568AB2060C52A9501750326@arion.intra.local>
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
Date: Thu, 12 Jan 2006 14:35:29 +0100

Marcel,

Well, there are some PSM not supported packets in the failing dump. But
I still can not figure out what is wrong there... Thanks.

Regards,
    Victor.=20

-----Original Message-----
From: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Thursday, January 12, 2006 14:27 PM
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Problems with smart phones when using a
"silent"kernel

Hi Victor,

> I have a very strange problem here. When using a "silent" kernel=20
> (CONFIG_CMDLINE=3D"console=3D/dev/null quiet" instead of
> CONFIG_CMDLINE=3D"console=3DttySAC0,115200") It is no longer possible t=
o=20
> pair with Microsoft smartphones. A phone reports "the connection=20
> failed or pass key is incorrect". If a phone was already paired=20
> everything works fine. Other phones work fine too. Any clue what can=20
> go wrong. All this doesn't make much sence, but it is reality :) I've=20
> attached the dumps for the same phone for both of the kernels (silent=20
> and not). We use 2.6.13 with bluez 2.15 and there is no option to=20
> switch to something more recent. Just wonder what can cause the=20
> problem.... From the log I see that pairing actually went ok, cause it

> switched on encryption mode and exchanged some AT's, might be=20
> something with our application as well, but does not seem to be
likelly...

I don't see any strange inside the dump and I doubt that it really has
something to do with the console option. Maybe your application can live
if the console is /dev/null.

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
