Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
In-Reply-To: <41749.212.58.233.129.1157115456.squirrel@samuri.demon.co.uk>
References: <44EC8877.8050200@palmsource.com> <44F5A472.30003@xmission.com>
	<44F7088F.6090606@palmsource.com>
	<41749.212.58.233.129.1157115456.squirrel@samuri.demon.co.uk>
Mime-Version: 1.0 (Apple Message framework v752.2)
Message-Id: <9D2AC8DE-2F8A-41B0-9B2A-05BC2D45C5E9@pepper.com>
From: Michael Frey <mfrey@pepper.com>
Date: Fri, 1 Sep 2006 14:25:40 -0400
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Big patch to a2dpd
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Is there a way to have a2dpd use the alsa dmixer?  And does anyone  =

know how to change the default alsa device on the fly.  I know you  =

can change .asoundrc but any running applications need to be  =

restarted in order to pick up the change.  Is there a better way?

Michael

On Sep 1, 2006, at 8:57 AM, andy@samuri.demon.co.uk wrote:

> Hi Fr=E9d=E9ric,
>
> Whoo some patch cant wait to give it a whirl..
>
> On the subject of your DOC nice work very concise
>
> You might like to add
> ------------------
> If you create an ~.asoundrc as follows
>
> pcm.a2dpd {
>        type a2dpd
> }
>
> Then you can directly add the headphone device (pcm.a2dpd) to any  =

> app that
> supports alsa plugins correctly, Without affecting the default  =

> Gnome/X/KDE
> sounds
>
> Known working Apps
>
> Xmms
> alsaplayer
> VLC (you have to manualy add it to the conf file as the gui wont allow
> adding non visible plugins (bug)).
>
> cheers Andy
> --------------------------------------
>  Hi Brad,
>>>
>>> I looked over Matthew's patches and applied them. I applied your  =

>>> "small
>>> patch" which turns out to be bigger than it sounds :)
>>>
>> This one is more than bigger!
>> Reindent,
>> Alsa output redirection,
>> New on-the-fly in-play switch from bt to alsa and reverse
>> Changing bdaddr in play too.
>> More options described in sample.a2dprc
>>
>> I removed the line LIBS=3D from Makefile.am as suggested. This line was
>> making tons of compilation problems. As a2dpd finally links to  =

>> alsa, it
>> is no longer needed.
>> Please give it a try before submitting (Matthew and RUI if you  =

>> read that).
>>
>> Wrote a doc : http://fdalleau.free.fr/a2dp_doc.pdf ideas welcome!
>>
>> Fr=E9d=E9ric
>>
>>
>
>
>
> ---------------------------------------------------------------------- =

> ---
> Using Tomcat but need to do more? Need to support web services,  =

> security?
> Get stuff done quickly with pre-integrated technology to make your  =

> job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache  =

> Geronimo
> http://sel.as-us.falkag.net/sel? =

> cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
