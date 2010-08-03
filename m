Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTinxeqy3KMu0WLo7q-6yD2NbJU104BB4krSOo8gX@mail.gmail.com>
References: <35c90d960911121639o8b0b0bfxde880af69adc9f95@mail.gmail.com>
	<1258082098.7715.7.camel@violet> <35c90d960911121931n687a2cd4ie8130f919041ee70@mail.gmail.com>
	<1258084357.7715.26.camel@violet> <35c90d960911131445w16076c70sa0473e9b459d7d15@mail.gmail.com>
	<35c90d961001122046o733c7e10nf28bfed9e7f5465@mail.gmail.com>
	<1263366291.922.5.camel@localhost.localdomain> <AANLkTil8Hloz5I7Gpnp9M-y2W3jkLKeca4wz7dgFKA0V@mail.gmail.com>
	<AANLkTinIhVG_4CpxLR1p1OqVeNqOzXojY3stnkJJdQAp@mail.gmail.com>
	<AANLkTinxeqy3KMu0WLo7q-6yD2NbJU104BB4krSOo8gX@mail.gmail.com>
From: Nick Pelly <npelly@google.com>
Date: Tue, 3 Aug 2010 09:16:17 -0700
Message-ID: <AANLkTi=wLHf30og8TwkH0-0w2no97Pzk3X2pPmDvqf1p@mail.gmail.com>
Subject: Re: What is the motivation for conn->power_save
To: Liang Bao <tim.bao@gmail.com>
Cc: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: multipart/alternative; boundary=000e0cd30800629c56048ceda555
List-ID: <linux-bluetooth.vger.kernel.org>

--000e0cd30800629c56048ceda555
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 3, 2010 at 2:31 AM, Liang Bao <tim.bao@gmail.com> wrote:

>
>
> 2010/7/9 Nick Pelly <npelly@google.com>
>
> On Thu, Jul 8, 2010 at 8:07 AM, Andrei Emeltchenko
>> <andrei.emeltchenko.news@gmail.com> wrote:
>> > Hi,
>> >
>> > On Wed, Jan 13, 2010 at 10:04 AM, Marcel Holtmann <marcel@holtmann.org=
>
>> wrote:
>> >> Hi Nick,
>> >>
>> >>> >>> >> If I understand correctly, conn->power_save prevents the host
>> stack
>> >>> >>> >> from requesting active mode if it was not the host stack that
>> >>> >>> >> requested sniff mode.
>> >>> >>> >>
>> >>> >>> >> I don't understand the motivation for this. If we have ACL da=
ta
>> to
>> >>> >>> >> send, then it seems like a good idea for the host stack to
>> explicitly
>> >>> >>> >> request active mode, regardless of the reason that we entered
>> sniff
>> >>> >>> >> mode.
>> >>> >>> >>
>> >>> >>> >> We want to enter active mode more aggressively when setting u=
p
>> SCO
>> >>> >>> >> connections, to avoid a 5 second delay with certain sniff
>> modes. But
>> >>> >>> >> the conn->power_save code is getting in the way and doesn't
>> appear to
>> >>> >>> >> be useful in the first place.
>> >>> >>> >
>> >>> >>> > we have discussed this a few times. And if you lock through th=
e
>> code
>> >>> >>> > history then you see that initially we just took devices out o=
f
>> sniff
>> >>> >>> > mode if we had to send data. However with HID devices this fal=
ls
>> flat on
>> >>> >>> > its face. They need to stay in control of sniff mode if they
>> initiated
>> >>> >>> > it. Some of them crash and others just drain the battery. With
>> sniff
>> >>> >>> > mode you can send small amounts of data even while in sniff an=
d
>> for HID
>> >>> >>> > that is sometimes used. So the remote side better not interfer=
e.
>> >>> >>> >
>> >>> >>> > What we really need is a socket option where we can control th=
is
>> on a
>> >>> >>> > per socket basis if we take devices out of sniff mode. And one
>> extra
>> >>> >>> > case might be when we try to establish a SCO channel, because
>> then it is
>> >>> >>> > clearly not an HID device. However even A2DP has this sort of
>> problems
>> >>> >>> > sometimes where the stream setup takes time.
>> >>> >>>
>> >>> >>> Makes sense. Thanks for the explanation.
>> >>> >>
>> >>> >> this means you will be working on a patch for this :)
>> >>>
>> >>> Actually, I want to put a patch together for a socket option to not
>> >>> use power_save (so that we *always* exit sniff mode when sending ACL
>> >>> data). We're seeing this problem with the Plantronics Voyager 855
>> >>> which enters sniff mode during A2DP.
>> >>>
>> >>> Given that power_save is just for HID devices, my preferred design i=
s
>> >>> to disable power_save by default, and have an L2CAP socket option to
>> >>> turn on power_save that would be used by HID L2CAP sockets.
>> >>> Unfortunately this would require userspace HID code to use the new
>> >>> socket option to keep current behavior. But it seems preferable to t=
he
>> >>> alternative of having every single other L2CAP socket use a new sock=
et
>> >>> option just to disable power_save for the sake of HID.
>> >>
>> >> actually you still mix up the meaning of the power_save option. From
>> the
>> >> stack side, the automatic sniff mode is off by default. You have to
>> >> enable via sysfs first. The power_save option is just to control when
>> >> sniff mode is activated and the remote enters sniff mode, that we are
>> >> not getting out of it if we have ACL data.
>> >>
>> >> In conclusion, I am fine with a socket option that allows to control
>> >> sniff mode (preferable with interval details) and sniff subrate detai=
ls
>> >> so that we can use them for that ACL link.
>> >>
>> >> So go ahead and work on this. We can fix userspace easily since a new
>> >> socket can be detected easily with newer kernels.
>> >
>> > We have found that some Nokia BT headsets stop working after idle
>> > period when they enter
>> > "power save" mode.
>> >
>> > Do we have any solution for this problem? So far I see good enough
>> > patch :-)) below:
>> >
>> >
>> http://android.git.kernel.org/?p=3Dkernel/common.git;a=3Dblobdiff;f=3Dne=
t/bluetooth/hci_conn.c;h=3Dfa8b412205cd89546b4a325c558c68040eeaf491;hp=3D0c=
f25114a3f576fc2788a549eb96d0087dd39b44;hb=3Dd8488237646920cd71ef43e5f3ae100=
1c6f4cf7b;hpb=3D3f68e5050c5ae559f56d5da9202cb88928d42b36
>> >
>> > -       if (conn->mode !=3D HCI_CM_SNIFF || !conn->power_save)
>> > +       if (conn->mode !=3D HCI_CM_SNIFF /* || !conn->power_save */)
>> >
>> > Nick have you done socket option for "power_save"?
>>
>> No. We'll do it once we need it for HID support.
>>
> Can we do this: try to do check against some existing fields in structure
> hci_conn, for example device_class and then determine if conn->power_save
> shall be used here? By doing this, applications in user space can be save=
d
> from having knowledge how sniff mode works for different devices.
>
>
The class bits cannot be trusted - many devices have the wrong class bits.
And even with the right class bits, what about a device that supports both
HID and A2DP? A socket option still seems like the best approach.
Nick

--000e0cd30800629c56048ceda555
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Tue, Aug 3, 2010 at 2:31 AM, Liang Ba=
o <span dir=3D"ltr">&lt;<a href=3D"mailto:tim.bao@gmail.com">tim.bao@gmail.=
com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">

<br><br><div class=3D"gmail_quote">2010/7/9 Nick Pelly <span dir=3D"ltr">&l=
t;<a href=3D"mailto:npelly@google.com" target=3D"_blank">npelly@google.com<=
/a>&gt;</span><div><div></div><div class=3D"h5"><br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,=
 204, 204);padding-left:1ex">


<div><div></div><div>On Thu, Jul 8, 2010 at 8:07 AM, Andrei Emeltchenko<br>
&lt;<a href=3D"mailto:andrei.emeltchenko.news@gmail.com" target=3D"_blank">=
andrei.emeltchenko.news@gmail.com</a>&gt; wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; On Wed, Jan 13, 2010 at 10:04 AM, Marcel Holtmann &lt;<a href=3D"mailt=
o:marcel@holtmann.org" target=3D"_blank">marcel@holtmann.org</a>&gt; wrote:=
<br>
&gt;&gt; Hi Nick,<br>
&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt; &gt;&gt; If I understand correctly, conn-&gt;powe=
r_save prevents the host stack<br>
&gt;&gt;&gt; &gt;&gt;&gt; &gt;&gt; from requesting active mode if it was no=
t the host stack that<br>
&gt;&gt;&gt; &gt;&gt;&gt; &gt;&gt; requested sniff mode.<br>
&gt;&gt;&gt; &gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt; &gt;&gt; I don&#39;t understand the motivation fo=
r this. If we have ACL data to<br>
&gt;&gt;&gt; &gt;&gt;&gt; &gt;&gt; send, then it seems like a good idea for=
 the host stack to explicitly<br>
&gt;&gt;&gt; &gt;&gt;&gt; &gt;&gt; request active mode, regardless of the r=
eason that we entered sniff<br>
&gt;&gt;&gt; &gt;&gt;&gt; &gt;&gt; mode.<br>
&gt;&gt;&gt; &gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt; &gt;&gt; We want to enter active mode more aggres=
sively when setting up SCO<br>
&gt;&gt;&gt; &gt;&gt;&gt; &gt;&gt; connections, to avoid a 5 second delay w=
ith certain sniff modes. But<br>
&gt;&gt;&gt; &gt;&gt;&gt; &gt;&gt; the conn-&gt;power_save code is getting =
in the way and doesn&#39;t appear to<br>
&gt;&gt;&gt; &gt;&gt;&gt; &gt;&gt; be useful in the first place.<br>
&gt;&gt;&gt; &gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt; &gt; we have discussed this a few times. And if y=
ou lock through the code<br>
&gt;&gt;&gt; &gt;&gt;&gt; &gt; history then you see that initially we just =
took devices out of sniff<br>
&gt;&gt;&gt; &gt;&gt;&gt; &gt; mode if we had to send data. However with HI=
D devices this falls flat on<br>
&gt;&gt;&gt; &gt;&gt;&gt; &gt; its face. They need to stay in control of sn=
iff mode if they initiated<br>
&gt;&gt;&gt; &gt;&gt;&gt; &gt; it. Some of them crash and others just drain=
 the battery. With sniff<br>
&gt;&gt;&gt; &gt;&gt;&gt; &gt; mode you can send small amounts of data even=
 while in sniff and for HID<br>
&gt;&gt;&gt; &gt;&gt;&gt; &gt; that is sometimes used. So the remote side b=
etter not interfere.<br>
&gt;&gt;&gt; &gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt; &gt; What we really need is a socket option where=
 we can control this on a<br>
&gt;&gt;&gt; &gt;&gt;&gt; &gt; per socket basis if we take devices out of s=
niff mode. And one extra<br>
&gt;&gt;&gt; &gt;&gt;&gt; &gt; case might be when we try to establish a SCO=
 channel, because then it is<br>
&gt;&gt;&gt; &gt;&gt;&gt; &gt; clearly not an HID device. However even A2DP=
 has this sort of problems<br>
&gt;&gt;&gt; &gt;&gt;&gt; &gt; sometimes where the stream setup takes time.=
<br>
&gt;&gt;&gt; &gt;&gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt;&gt; Makes sense. Thanks for the explanation.<br>
&gt;&gt;&gt; &gt;&gt;<br>
&gt;&gt;&gt; &gt;&gt; this means you will be working on a patch for this :)=
<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Actually, I want to put a patch together for a socket option t=
o not<br>
&gt;&gt;&gt; use power_save (so that we *always* exit sniff mode when sendi=
ng ACL<br>
&gt;&gt;&gt; data). We&#39;re seeing this problem with the Plantronics Voya=
ger 855<br>
&gt;&gt;&gt; which enters sniff mode during A2DP.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Given that power_save is just for HID devices, my preferred de=
sign is<br>
&gt;&gt;&gt; to disable power_save by default, and have an L2CAP socket opt=
ion to<br>
&gt;&gt;&gt; turn on power_save that would be used by HID L2CAP sockets.<br=
>
&gt;&gt;&gt; Unfortunately this would require userspace HID code to use the=
 new<br>
&gt;&gt;&gt; socket option to keep current behavior. But it seems preferabl=
e to the<br>
&gt;&gt;&gt; alternative of having every single other L2CAP socket use a ne=
w socket<br>
&gt;&gt;&gt; option just to disable power_save for the sake of HID.<br>
&gt;&gt;<br>
&gt;&gt; actually you still mix up the meaning of the power_save option. Fr=
om the<br>
&gt;&gt; stack side, the automatic sniff mode is off by default. You have t=
o<br>
&gt;&gt; enable via sysfs first. The power_save option is just to control w=
hen<br>
&gt;&gt; sniff mode is activated and the remote enters sniff mode, that we =
are<br>
&gt;&gt; not getting out of it if we have ACL data.<br>
&gt;&gt;<br>
&gt;&gt; In conclusion, I am fine with a socket option that allows to contr=
ol<br>
&gt;&gt; sniff mode (preferable with interval details) and sniff subrate de=
tails<br>
&gt;&gt; so that we can use them for that ACL link.<br>
&gt;&gt;<br>
&gt;&gt; So go ahead and work on this. We can fix userspace easily since a =
new<br>
&gt;&gt; socket can be detected easily with newer kernels.<br>
&gt;<br>
&gt; We have found that some Nokia BT headsets stop working after idle<br>
&gt; period when they enter<br>
&gt; &quot;power save&quot; mode.<br>
&gt;<br>
&gt; Do we have any solution for this problem? So far I see good enough<br>
&gt; patch :-)) below:<br>
&gt;<br>
&gt; <a href=3D"http://android.git.kernel.org/?p=3Dkernel/common.git;a=3Dbl=
obdiff;f=3Dnet/bluetooth/hci_conn.c;h=3Dfa8b412205cd89546b4a325c558c68040ee=
af491;hp=3D0cf25114a3f576fc2788a549eb96d0087dd39b44;hb=3Dd8488237646920cd71=
ef43e5f3ae1001c6f4cf7b;hpb=3D3f68e5050c5ae559f56d5da9202cb88928d42b36" targ=
et=3D"_blank">http://android.git.kernel.org/?p=3Dkernel/common.git;a=3Dblob=
diff;f=3Dnet/bluetooth/hci_conn.c;h=3Dfa8b412205cd89546b4a325c558c68040eeaf=
491;hp=3D0cf25114a3f576fc2788a549eb96d0087dd39b44;hb=3Dd8488237646920cd71ef=
43e5f3ae1001c6f4cf7b;hpb=3D3f68e5050c5ae559f56d5da9202cb88928d42b36</a><br>



&gt;<br>
&gt; - =A0 =A0 =A0 if (conn-&gt;mode !=3D HCI_CM_SNIFF || !conn-&gt;power_s=
ave)<br>
&gt; + =A0 =A0 =A0 if (conn-&gt;mode !=3D HCI_CM_SNIFF /* || !conn-&gt;powe=
r_save */)<br>
&gt;<br>
&gt; Nick have you done socket option for &quot;power_save&quot;?<br>
<br>
</div></div>No. We&#39;ll do it once we need it for HID support.<br></block=
quote></div></div><div>Can we do this: try to do check against some existin=
g fields in structure hci_conn, for example device_class and then determine=
 if conn-&gt;power_save shall be used here? By doing this, applications in =
user space can be saved from having knowledge how sniff mode works for diff=
erent devices.<br>

<br></div></div></blockquote><div><br></div><div>The class bits cannot be t=
rusted - many devices have the wrong class bits. And even with the right cl=
ass bits, what about a device that supports both HID and A2DP? A socket opt=
ion still seems like the best approach.</div>

<div>Nick</div></div>

--000e0cd30800629c56048ceda555--
