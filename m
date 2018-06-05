Return-Path: <attitokes@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMoM21G-HzSysjMoZ2gDQVAHi7M_cY7a6wpPx4zmMMXUY+Hc7Q@mail.gmail.com>
References: <CAMoM21GBuUJu=JDOyJc+dgNHccMw=ckwRYtMwJP-j0xuXE-pDQ@mail.gmail.com>
 <1516478795.11220.8.camel@iki.fi> <CAMoM21ExUmytoG8LOSmhhL5iubqLx02r3Cn0zmujisk9Et0ZJA@mail.gmail.com>
 <1516486000.11220.9.camel@iki.fi> <CAMoM21H84=3W03S2fotyEFFbMut95_=8q-NbwkGjzgdAUZe2NQ@mail.gmail.com>
 <6E3D045D-0353-4D65-BBA8-75C369620677@holtmann.org> <CAMoM21G-HzSysjMoZ2gDQVAHi7M_cY7a6wpPx4zmMMXUY+Hc7Q@mail.gmail.com>
From: =?UTF-8?B?QXR0aWxhIFTFkWvDqXM=?= <attitokes@gmail.com>
Date: Tue, 5 Jun 2018 22:28:50 +0300
Message-ID: <CAMoM21FwawKu=NsXzqc7-zLNhjWGUP8imrWRHYz6M6-n4MVCiA@mail.gmail.com>
Subject: Re: Raspberry Pi 3 / BCM43438 + HSP profile + PulseAudio
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Tanu Kaskinen <tanuk@iki.fi>, Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/alternative; boundary="000000000000584a8e056dea0f26"
List-ID: <linux-bluetooth.vger.kernel.org>

--000000000000584a8e056dea0f26
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

I just sent a patch with the changes for the SCO routing:
[PATCH] Bluetooth: hci_bcm: Configure SCO routing automatically

The patch applies to the bluetooth-next branch. I tested it with a 4.15.18
kernel (rpi build).

Thanks,
Attila

On Sun, Jan 21, 2018 at 9:22 PM, Attila T=C5=91k=C3=A9s <attitokes@gmail.co=
m> wrote:

> Hi Marcel,
>
>
> On Sun, Jan 21, 2018 at 2:21 PM, Marcel Holtmann <marcel@holtmann.org>
> wrote:
> > Hi Tokes,
> >
> >>>>>> I'm trying to use a Bluetooth speaker with Raspberry Pi 3 in HSP
> mode
> >>>>>> with PulseAudio.
> >>>>>>
> >>>>>> Based on the information I found on the web (blogs / forums /
> mailing
> >>>>>> list archives), apparently, HSP does not really works with the
> >>>>>> Rasberry Pi's built in BCM43438 chip. I didn't found the exact
> reason
> >>>>>> yet. Some people suggest it may be a problem with the BCM43438
> >>>>>> firmware or with the kernel driver. A2DP, and HSP with USB Bluetoo=
th
> >>>>>> dongles are reported to be working fine. (The most complete
> >>>>>> description I found about the problem is:
> >>>>>> http://youness.net/raspberry-pi/bluetooth-headset-
> raspberry-pi-3-ad2p-hsp)
> >>>>>>
> >>>>>> I think it would be useful to get clear picture about the problem.
> And
> >>>>>> maybe we could try to fix it.
> >>>>>>
> >>>>>> Does anyone managed to figure out what exactly the problem is?
> >>>>>>
> >>>>>> I started investigating the issue, but didn't got any result yet. =
I
> >>>>>> didn't had too much experience with the Linux's Bluetooth stack, s=
o
> >>>>>> some help with the further investigation would be useful.
> >>>>>>
> >>>>>> ----
> >>>>>>
> >>>>>> Bellow are some details of my investigation.
> >>>>>>
> >>>>>> Hardware: Raspberry Pi 3 + JBL GO! Bluetooth speaker
> >>>>>>
> >>>>>> Kernel: raspberrypi 4.14.14-v7
> >>>>>> BlueZ: 5.43
> >>>>>> PulseAudio: 11.1
> >>>>>>
> >>>>>> Summary:
> >>>>>> - BCM43438's driver is sucessfuly loaded, it's firmware is uploade=
d
> successfully
> >>>>>> - the Bluetooth speaker gets detected and the pairing / connection
> works fine
> >>>>>> - PulseAudio detects the speaker as a card
> >>>>>> - both the headset_head_unit and a2dp_sink profiles are shown by
> >>>>>> `pacmd list-cards` and can be set with `pacmd set-card-profile`
> >>>>>> - with the a2dp_sink profile, the audio playback works fine (teste=
d
> >>>>>> with `paplay`)
> >>>>>> - with the headset_head_unit profile, `paplay` gets stuck at start=
 a
> >>>>>> no audio is played (`parecord` does the same)
> >>>>>>
> >>>>>> I started booth BlueZ and PulseAudio in debug mode, but found
> nothing
> >>>>>> obviuosly wrong (at least for me :P) in the logs. Also did a HCI
> dump.
> >>>>>>
> >>>>>> Linking the following logs (uploaded to PasteBin; they are too lon=
g
> >>>>>> inline them):
> >>>>>> - the Blootoothd's log - https://pastebin.com/WC17Ze0r
> >>>>>> - the PlulseAudio's log - https://pastebin.com/jUjqjuhC
> >>>>>> - the output of the PA commands - https://pastebin.com/wvRzdTEx
> >>>>>> - the output of some BL Tools (sdptool / bluetoothctl / hciconfig)=
 -
> >>>>>> https://pastebin.com/Ax7XYr94
> >>>>>> - the HCI dump -https://pastebin.com/zqhqKu57
> >>>>>>
> >>>>>> SCO dump did not managed to get.
> >>>>>>
> >>>>>> I executed the following steps:
> >>>>>> (the steps are marked in the log files too):
> >>>>>> - start Blootoothd
> >>>>>> - start PulseAudio
> >>>>>> - powered on the Bloothooth speaker
> >>>>>> - tried to play some audio
> >>>>>> $ pacmd list cards
> >>>>>> $ pacmd set-card-profile 1 headset_head_unit
> >>>>>> $ paplay -v -d bluez_sink.78_44_05_4B_4F_FF.headset_head_unit
> >>>>>> /tmp/h2g2.ogg (gets stuck)
> >>>>>> $ pacmd set-card-profile 1 a2dp_sink
> >>>>>> $ paplay -v -d bluez_sink.78_44_05_4B_4F_FF.a2dp_sink
> /tmp/h2g2.ogg (works)
> >>>>>
> >>>>> HSP playback getting stuck is a fairly common problem (affecting
> >>>>> multiple bluetooth adapters from different vendors). Solutions for
> the
> >>>>> problem are known for a few adapters, but not this one. The issue i=
s
> >>>>> documented here (the "HSP problem: the bluetooth sink and source ar=
e
> >>>>> created, but no audio is being transmitted" section):
> >>>>>
> >>>>> https://www.freedesktop.org/wiki/Software/PulseAudio/
> Documentation/User/Bluetooth/#index8h3
> >>>>>
> >>>>> As you can read there, the underlying problem in the known cases is
> >>>>> either that firmware is missing or the SCO audio routing is wrong i=
n
> >>>>> the adapter. Changing the routing requires (at least in the known
> >>>>> cases) a vendor-specific magic command. I don't know how to figure
> out
> >>>>> the correct command. On one Broadcom chip this does the trick:
> "hcitool
> >>>>> cmd 0x3F 0x01C 0x01 0x02 0x00 0x01 0x01", but I don't know how like=
ly
> >>>>> that is to work on a different chip.
> >>>>
> >>>> I just sent that HCI command right now and guess what, it worked :).
> >>>> Both paplay an parecord are working fine with the HSP profile now.
> >>>
> >>> Awesome! I'll update the wiki page.
> >>
> >> Ok, Thanks! I posted the solution to the two related GitHub issues +
> >> some forums / blog posts, so hope it will reach anyone interested in
> >> this.
> >
> > I would be more interested in someone adding this kind of PCM routing
> configuration to DT and also adopting the hci_bcm.c driver to use it and
> send the appropriate commands.
>
> I could take a look on adding the new functionality to hci_bcm.c. I'm
> not really familiar with the Linux kernel development, so be aware
> that this will take some time.
>
> >
> > Sending hcitool cmd is like injecting commands. That is a hack. It is
> not a solution. So commenting that you need some hcitool to hack the
> hardware setup, that is just wrong. Get this merged into the driver and
> have it configurable via DT.
>
> Yes, I know its not the best solution, but it fixes the problem and
> this is more important for most of the people, than having the "right"
> solution. That's why I posted it to GitHub, etc.
>
> >
> > Also if you have a recent enough btmon installed, then it might actuall=
y
> decode the Broadcom commands for you. Can you give it a try and see what =
it
> says.
> >
>
> Actually, I found a document today with the vendor specific HCI
> commands for the Cypress CYW4329/CYW4330 chip
> (http://www.cypress.com/file/298311/download). Its not the same chip,
> by I guess the commands will be similar for all the Cypress / Broadcom
> chips.
>
> According to this document the HCI command
> hcitool cmd 0x3F 0x01C 0x01 0x02 0x00 0x01 0x01
>
> translates to:
>
> command =3D 0x01C (Write_SCO_PCM_Int_Param)
>    SCO_Routing =3D 0x01 (Transport)
>    PCM_Interface_Rate =3D 0x02 (512 KBps)
>    Frame_Type =3D 0x00 (Short)
>    Sync_Mode =3D 0x01 (Master)
>    Clock_Mode =3D 0x01 (Master)
>
> btmon (5.43) does not seems to know to decode the command. It outputs thi=
s:
>
> $ sudo btmon -s /org/bluez/hci0
> ...
> @ RAW Open: hcitool (privileged) version 2.22            {0x0003} 16.5349=
66
> @ RAW Close: hcitool
> {0x0003} 16.534997
> @ RAW Open: hcitool (privileged) version 2.22            {0x0003}
> [hci0] 16.535043
> < HCI Command: Vendor (0x3f|0x001c) plen 5             [hci0] 16.535162
>         01 02 00 01 01                                   .....
> > HCI Event: Command Complete (0x0e) plen 4          [hci0] 16.535566
>       Vendor (0x3f|0x001c) ncmd 1
>         Status: Success (0x00)
> @ RAW Close: hcitool
>
> > Regards
> >
> > Marcel
> >
>
> Thanks,
> Attila
>

--000000000000584a8e056dea0f26
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Marcel,<br><br>I just sent a patch with the changes for=
 the SCO routing:<br>[PATCH] Bluetooth: hci_bcm: Configure SCO routing auto=
matically<br><br>The patch applies to the bluetooth-next branch. I tested i=
t with a 4.15.18 kernel (rpi build).<br><br>Thanks,<br>Attila</div><div cla=
ss=3D"gmail_extra"><br><div class=3D"gmail_quote">On Sun, Jan 21, 2018 at 9=
:22 PM, Attila T=C5=91k=C3=A9s <span dir=3D"ltr">&lt;<a href=3D"mailto:atti=
tokes@gmail.com" target=3D"_blank">attitokes@gmail.com</a>&gt;</span> wrote=
:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">Hi Marcel,<br>
<div><div class=3D"h5"><br>
<br>
On Sun, Jan 21, 2018 at 2:21 PM, Marcel Holtmann &lt;<a href=3D"mailto:marc=
el@holtmann.org">marcel@holtmann.org</a>&gt; wrote:<br>
&gt; Hi Tokes,<br>
&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; I&#39;m trying to use a Bluetooth speaker with Ras=
pberry Pi 3 in HSP mode<br>
&gt;&gt;&gt;&gt;&gt;&gt; with PulseAudio.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Based on the information I found on the web (blogs=
 / forums / mailing<br>
&gt;&gt;&gt;&gt;&gt;&gt; list archives), apparently, HSP does not really wo=
rks with the<br>
&gt;&gt;&gt;&gt;&gt;&gt; Rasberry Pi&#39;s built in BCM43438 chip. I didn&#=
39;t found the exact reason<br>
&gt;&gt;&gt;&gt;&gt;&gt; yet. Some people suggest it may be a problem with =
the BCM43438<br>
&gt;&gt;&gt;&gt;&gt;&gt; firmware or with the kernel driver. A2DP, and HSP =
with USB Bluetooth<br>
&gt;&gt;&gt;&gt;&gt;&gt; dongles are reported to be working fine. (The most=
 complete<br>
&gt;&gt;&gt;&gt;&gt;&gt; description I found about the problem is:<br>
&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"http://youness.net/raspberry-pi/bluetoo=
th-headset-raspberry-pi-3-ad2p-hsp" rel=3D"noreferrer" target=3D"_blank">ht=
tp://youness.net/raspberry-<wbr>pi/bluetooth-headset-<wbr>raspberry-pi-3-ad=
2p-hsp</a>)<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; I think it would be useful to get clear picture ab=
out the problem. And<br>
&gt;&gt;&gt;&gt;&gt;&gt; maybe we could try to fix it.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Does anyone managed to figure out what exactly the=
 problem is?<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; I started investigating the issue, but didn&#39;t =
got any result yet. I<br>
&gt;&gt;&gt;&gt;&gt;&gt; didn&#39;t had too much experience with the Linux&=
#39;s Bluetooth stack, so<br>
&gt;&gt;&gt;&gt;&gt;&gt; some help with the further investigation would be =
useful.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; ----<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Bellow are some details of my investigation.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Hardware: Raspberry Pi 3 + JBL GO! Bluetooth speak=
er<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Kernel: raspberrypi 4.14.14-v7<br>
&gt;&gt;&gt;&gt;&gt;&gt; BlueZ: 5.43<br>
&gt;&gt;&gt;&gt;&gt;&gt; PulseAudio: 11.1<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Summary:<br>
&gt;&gt;&gt;&gt;&gt;&gt; - BCM43438&#39;s driver is sucessfuly loaded, it&#=
39;s firmware is uploaded successfully<br>
&gt;&gt;&gt;&gt;&gt;&gt; - the Bluetooth speaker gets detected and the pair=
ing / connection works fine<br>
&gt;&gt;&gt;&gt;&gt;&gt; - PulseAudio detects the speaker as a card<br>
&gt;&gt;&gt;&gt;&gt;&gt; - both the headset_head_unit and a2dp_sink profile=
s are shown by<br>
&gt;&gt;&gt;&gt;&gt;&gt; `pacmd list-cards` and can be set with `pacmd set-=
card-profile`<br>
&gt;&gt;&gt;&gt;&gt;&gt; - with the a2dp_sink profile, the audio playback w=
orks fine (tested<br>
&gt;&gt;&gt;&gt;&gt;&gt; with `paplay`)<br>
&gt;&gt;&gt;&gt;&gt;&gt; - with the headset_head_unit profile, `paplay` get=
s stuck at start a<br>
&gt;&gt;&gt;&gt;&gt;&gt; no audio is played (`parecord` does the same)<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; I started booth BlueZ and PulseAudio in debug mode=
, but found nothing<br>
&gt;&gt;&gt;&gt;&gt;&gt; obviuosly wrong (at least for me :P) in the logs. =
Also did a HCI dump.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Linking the following logs (uploaded to PasteBin; =
they are too long<br>
&gt;&gt;&gt;&gt;&gt;&gt; inline them):<br>
&gt;&gt;&gt;&gt;&gt;&gt; - the Blootoothd&#39;s log - <a href=3D"https://pa=
stebin.com/WC17Ze0r" rel=3D"noreferrer" target=3D"_blank">https://pastebin.=
com/WC17Ze0r</a><br>
&gt;&gt;&gt;&gt;&gt;&gt; - the PlulseAudio&#39;s log - <a href=3D"https://p=
astebin.com/jUjqjuhC" rel=3D"noreferrer" target=3D"_blank">https://pastebin=
.com/jUjqjuhC</a><br>
&gt;&gt;&gt;&gt;&gt;&gt; - the output of the PA commands - <a href=3D"https=
://pastebin.com/wvRzdTEx" rel=3D"noreferrer" target=3D"_blank">https://past=
ebin.com/wvRzdTEx</a><br>
&gt;&gt;&gt;&gt;&gt;&gt; - the output of some BL Tools (sdptool / bluetooth=
ctl / hciconfig) -<br>
&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://pastebin.com/Ax7XYr94" rel=3D"n=
oreferrer" target=3D"_blank">https://pastebin.com/Ax7XYr94</a><br>
&gt;&gt;&gt;&gt;&gt;&gt; - the HCI dump -<a href=3D"https://pastebin.com/zq=
hqKu57" rel=3D"noreferrer" target=3D"_blank">https://pastebin.com/zqhqKu57<=
/a><br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; SCO dump did not managed to get.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; I executed the following steps:<br>
&gt;&gt;&gt;&gt;&gt;&gt; (the steps are marked in the log files too):<br>
&gt;&gt;&gt;&gt;&gt;&gt; - start Blootoothd<br>
&gt;&gt;&gt;&gt;&gt;&gt; - start PulseAudio<br>
&gt;&gt;&gt;&gt;&gt;&gt; - powered on the Bloothooth speaker<br>
&gt;&gt;&gt;&gt;&gt;&gt; - tried to play some audio<br>
&gt;&gt;&gt;&gt;&gt;&gt; $ pacmd list cards<br>
&gt;&gt;&gt;&gt;&gt;&gt; $ pacmd set-card-profile 1 headset_head_unit<br>
&gt;&gt;&gt;&gt;&gt;&gt; $ paplay -v -d bluez_sink.78_44_05_4B_4F_FF.<wbr>h=
eadset_head_unit<br>
&gt;&gt;&gt;&gt;&gt;&gt; /tmp/h2g2.ogg (gets stuck)<br>
&gt;&gt;&gt;&gt;&gt;&gt; $ pacmd set-card-profile 1 a2dp_sink<br>
&gt;&gt;&gt;&gt;&gt;&gt; $ paplay -v -d bluez_sink.78_44_05_4B_4F_FF.<wbr>a=
2dp_sink /tmp/h2g2.ogg (works)<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; HSP playback getting stuck is a fairly common problem =
(affecting<br>
&gt;&gt;&gt;&gt;&gt; multiple bluetooth adapters from different vendors). S=
olutions for the<br>
&gt;&gt;&gt;&gt;&gt; problem are known for a few adapters, but not this one=
. The issue is<br>
&gt;&gt;&gt;&gt;&gt; documented here (the &quot;HSP problem: the bluetooth =
sink and source are<br>
&gt;&gt;&gt;&gt;&gt; created, but no audio is being transmitted&quot; secti=
on):<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; <a href=3D"https://www.freedesktop.org/wiki/Software/P=
ulseAudio/Documentation/User/Bluetooth/#index8h3" rel=3D"noreferrer" target=
=3D"_blank">https://www.freedesktop.org/<wbr>wiki/Software/PulseAudio/<wbr>=
Documentation/User/Bluetooth/#<wbr>index8h3</a><br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; As you can read there, the underlying problem in the k=
nown cases is<br>
&gt;&gt;&gt;&gt;&gt; either that firmware is missing or the SCO audio routi=
ng is wrong in<br>
&gt;&gt;&gt;&gt;&gt; the adapter. Changing the routing requires (at least i=
n the known<br>
&gt;&gt;&gt;&gt;&gt; cases) a vendor-specific magic command. I don&#39;t kn=
ow how to figure out<br>
&gt;&gt;&gt;&gt;&gt; the correct command. On one Broadcom chip this does th=
e trick: &quot;hcitool<br>
&gt;&gt;&gt;&gt;&gt; cmd 0x3F 0x01C 0x01 0x02 0x00 0x01 0x01&quot;, but I d=
on&#39;t know how likely<br>
&gt;&gt;&gt;&gt;&gt; that is to work on a different chip.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; I just sent that HCI command right now and guess what, it =
worked :).<br>
&gt;&gt;&gt;&gt; Both paplay an parecord are working fine with the HSP prof=
ile now.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Awesome! I&#39;ll update the wiki page.<br>
&gt;&gt;<br>
&gt;&gt; Ok, Thanks! I posted the solution to the two related GitHub issues=
 +<br>
&gt;&gt; some forums / blog posts, so hope it will reach anyone interested =
in<br>
&gt;&gt; this.<br>
&gt;<br>
&gt; I would be more interested in someone adding this kind of PCM routing =
configuration to DT and also adopting the hci_bcm.c driver to use it and se=
nd the appropriate commands.<br>
<br>
</div></div>I could take a look on adding the new functionality to hci_bcm.=
c. I&#39;m<br>
not really familiar with the Linux kernel development, so be aware<br>
that this will take some time.<br>
<span class=3D""><br>
&gt;<br>
&gt; Sending hcitool cmd is like injecting commands. That is a hack. It is =
not a solution. So commenting that you need some hcitool to hack the hardwa=
re setup, that is just wrong. Get this merged into the driver and have it c=
onfigurable via DT.<br>
<br>
</span>Yes, I know its not the best solution, but it fixes the problem and<=
br>
this is more important for most of the people, than having the &quot;right&=
quot;<br>
solution. That&#39;s why I posted it to GitHub, etc.<br>
<span class=3D""><br>
&gt;<br>
&gt; Also if you have a recent enough btmon installed, then it might actual=
ly decode the Broadcom commands for you. Can you give it a try and see what=
 it says.<br>
&gt;<br>
<br>
</span>Actually, I found a document today with the vendor specific HCI<br>
commands for the Cypress CYW4329/CYW4330 chip<br>
(<a href=3D"http://www.cypress.com/file/298311/download" rel=3D"noreferrer"=
 target=3D"_blank">http://www.cypress.com/file/<wbr>298311/download</a>). I=
ts not the same chip,<br>
by I guess the commands will be similar for all the Cypress / Broadcom<br>
chips.<br>
<br>
According to this document the HCI command<br>
<span class=3D"">hcitool cmd 0x3F 0x01C 0x01 0x02 0x00 0x01 0x01<br>
<br>
</span>translates to:<br>
<br>
command =3D 0x01C (Write_SCO_PCM_Int_Param)<br>
=C2=A0 =C2=A0SCO_Routing =3D 0x01 (Transport)<br>
=C2=A0 =C2=A0PCM_Interface_Rate =3D 0x02 (512 KBps)<br>
=C2=A0 =C2=A0Frame_Type =3D 0x00 (Short)<br>
=C2=A0 =C2=A0Sync_Mode =3D 0x01 (Master)<br>
=C2=A0 =C2=A0Clock_Mode =3D 0x01 (Master)<br>
<br>
btmon (5.43) does not seems to know to decode the command. It outputs this:=
<br>
<br>
$ sudo btmon -s /org/bluez/hci0<br>
...<br>
@ RAW Open: hcitool (privileged) version 2.22=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 {0x0003} 16.534966<br>
@ RAW Close: hcitool<br>
{0x0003} 16.534997<br>
@ RAW Open: hcitool (privileged) version 2.22=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 {0x0003}<br>
[hci0] 16.535043<br>
&lt; HCI Command: Vendor (0x3f|0x001c) plen 5=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0[hci0] 16.535162<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 01 02 00 01 01=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0.....<br>
&gt; HCI Event: Command Complete (0x0e) plen 4=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 [hci0] 16.535566<br>
=C2=A0 =C2=A0 =C2=A0 Vendor (0x3f|0x001c) ncmd 1<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Status: Success (0x00)<br>
@ RAW Close: hcitool<br>
<br>
&gt; Regards<br>
&gt;<br>
&gt; Marcel<br>
&gt;<br>
<br>
Thanks,<br>
Attila<br>
</blockquote></div><br></div>

--000000000000584a8e056dea0f26--
