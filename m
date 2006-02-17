Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43F5D2F3.7010502@apexar.com>
From: =?ISO-8859-1?Q?Agust=EDn_Jos=E9_Fusaro?= <afusaro@apexar.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Cannot compile bluez-utils-2.25
References: <20051202220703.C04EF953BA@sc8-sf-spam1.sourceforge.net>	 <200512021834.19314.mgorbach@yahoo.com>	 <1140037472.3336.5.camel@localhost.localdomain> <e1effdeb0602170332g410fcf6bn1f4e00ec2c0d6710@mail.gmail.com>
In-Reply-To: <e1effdeb0602170332g410fcf6bn1f4e00ec2c0d6710@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Fri, 17 Feb 2006 10:43:15 -0300

Claudio, thx very much for your response. I've changed the name to=20
dbus_connection_disconnect, and now compiles perfectly
Thx again
Agustin Fusaro

Claudio Takahasi escribi=F3:

>Hi Augustin,
>
>On 2/15/06, Agustin Jose Fusaro <afusaro@apexar.com> wrote:
> =20
>
>>Hi everybody,
>>
>>I'm having trouble installing the bluez-utils-2.25 package. I've alread=
y
>>installed the bluez-libs-2.25 package without any problem, but now, whe=
n
>>I try to ' make ' the new utils I get an undefined reference to
>>`dbus_connection_close' error in file dbus.c. It seems not to be define=
d
>>in this file.
>>
>>Has anybody had this problem?
>>   =20
>>
>[Claudio Takahasi]
>The function dbus_connection_disconnect was deprecated. It was renamed
>to dbus_connection_close. Try update your D-Bus or rename the
>function.
>
>--
>---------------------------------------------------------
>Claudio Takahasi
>Instituto Nokia de Tecnologia - INdT
>
> =20
>
>>By the way, I've been working with the bluez library and utils (2.22)
>>for a while and had some strange problems (rfcomm mostly)... so I just
>>wanted to make sure that I have the latest version before making furthe=
r
>>questions.
>>
>>Thanks a lot!
>>
>>Agustin Fusaro
>>
>>
>>
>>-------------------------------------------------------
>>This SF.net email is sponsored by: Splunk Inc. Do you grep through log =
files
>>for problems?  Stop!  Download the new AJAX search engine that makes
>>searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
>>http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D103432&bid=3D230486&dat=
=3D121642
>>_______________________________________________
>>Bluez-users mailing list
>>Bluez-users@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/bluez-users
>>
>>   =20
>>
>
>
>-------------------------------------------------------
>This SF.net email is sponsored by: Splunk Inc. Do you grep through log f=
iles
>for problems?  Stop!  Download the new AJAX search engine that makes
>searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
>http://sel.as-us.falkag.net/sel?cmd_____________________________________=
__________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users
>
> =20
>



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
