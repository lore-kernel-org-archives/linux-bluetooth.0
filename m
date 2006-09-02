Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Sat, 2 Sep 2006 14:04:58 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD1012FED7C@pdsmsx411.ccr.corp.intel.com>
From: "Li, Lea" <lea.li@intel.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
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
Content-Type: multipart/mixed; boundary="===============0858981583=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0858981583==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Hi Michael,=20

's "Big patch to a2dpd" is just the right thing you are looking for. To =
switch to default alsa device, one way is to change ".asoundrc", the =
other way is to enable "audio routing" (see enablerereadconfig & =
enableredirectalsa) in ".a2dprc" which can do that on the fly. :)


Thanks,
Lea
=20

-----Original Message-----
From: bluez-devel-bounces@lists.sourceforge.net =
[mailto:bluez-devel-bounces@lists.sourceforge.net] On Behalf Of Michael =
Frey
Sent: 2006=C4=EA9=D4=C22=C8=D5 2:26
To: BlueZ development
Subject: Re: [Bluez-devel] Big patch to a2dpd

Is there a way to have a2dpd use the alsa dmixer?  And does anyone =20
know how to change the default alsa device on the fly.  I know you =20
can change .asoundrc but any running applications need to be =20
restarted in order to pick up the change.  Is there a better way?

Michael

On Sep 1, 2006, at 8:57 AM, andy@samuri.demon.co.uk wrote:

> Hi Fr=A8=A6d=A8=A6ric,
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
> Then you can directly add the headphone device (pcm.a2dpd) to any =20
> app that
> supports alsa plugins correctly, Without affecting the default =20
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
>>> I looked over Matthew's patches and applied them. I applied your =20
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
>> I removed the line LIBS=3D from Makefile.am as suggested. This line =
was
>> making tons of compilation problems. As a2dpd finally links to =20
>> alsa, it
>> is no longer needed.
>> Please give it a try before submitting (Matthew and RUI if you =20
>> read that).
>>
>> Wrote a doc : http://fdalleau.free.fr/a2dp_doc.pdf ideas welcome!
>>
>> Fr=A8=A6d=A8=A6ric
>>
>>
>
>
>
> ---------------------------------------------------------------------- =

> ---
> Using Tomcat but need to do more? Need to support web services, =20
> security?
> Get stuff done quickly with pre-integrated technology to make your =20
> job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache =20
> Geronimo
> http://sel.as-us.falkag.net/sel?=20
> cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D121642
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------------------------=

Using Tomcat but need to do more? Need to support web services, =
security?
Get stuff done quickly with pre-integrated technology to make your job =
easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache =
Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D=
121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


--===============0858981583==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0858981583==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0858981583==--
