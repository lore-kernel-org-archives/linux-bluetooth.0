Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <0EA633E6-A0F5-4F67-B421-9857466C1175@holtmann.org>
References: <CAD0=r8yozB8eMdJOuffUeQZVFVf5xEXnP5tCt+k3m0e9wzMxiA@mail.gmail.com>
	<735FD32E-BD15-4CE1-8D9C-44B8EC56DF7A@holtmann.org>
	<CAHrH25Q6XqsLjGyfoXwimrap9=kKHOQn-G=k4Fz6HXmEPJ7EtQ@mail.gmail.com>
	<20140917051457.GA4671@t440s.P-661HNU-F1>
	<CAD0=r8x-=O7XAqQF_wBHQEqSkfifzgWW2AagW2EvsDUtM-E_ow@mail.gmail.com>
	<20140917065252.GA5554@t440s.lan>
	<CAD0=r8z9g+F7Z9X_8PE4jk3JbA+oLj9Of33RSqxiRd0dn9AnXQ@mail.gmail.com>
	<8868B74C-0DDD-43C1-BCBF-2578A700EF72@holtmann.org>
	<CAD0=r8xQzhizXo4umQ_mG_WMH7Akp4bji-9PNRGzqj-7HWnyNA@mail.gmail.com>
	<0EA633E6-A0F5-4F67-B421-9857466C1175@holtmann.org>
Date: Fri, 19 Sep 2014 09:39:16 -0700
Message-ID: <CAD0=r8w035mLnWTKtEfxZ7agzwTFRO9dsv+6qdafcBG7RYzYDQ@mail.gmail.com>
Subject: Re: [RFC] need for new scan api for bluetooth low energy.
From: Jakub Pawlowski <jpawlowski@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Arman Uguray <armansito@chromium.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>, Scott James Remnant <keybuk@google.com>
Content-Type: multipart/alternative; boundary=001a113a22aceee07a05036dbd6e
List-ID: <linux-bluetooth.vger.kernel.org>

--001a113a22aceee07a05036dbd6e
Content-Type: text/plain; charset=UTF-8

On Thu, Sep 18, 2014 at 8:37 AM, Marcel Holtmann <marcel@holtmann.org>
wrote:

> Hi Jakub,
>
> >>>>>>>> have you looked at the the Add Device management command with the
> >>>>>>>> 0x00 Action. That will just send out Device Found events for
> devices
> >>>>>>>> in range and uses passive scanning.
> >>>>>>>>
> >>>>>>>> In addition if you are paired with a device and actually want to
> >>>>>>>> connect to it, you can use Action 0x02 to allow for background
> >>>>>>>> connection. This is currently in use for LE HID devices.
> >>>>>>>
> >>>>>>> This still only sends one Device Found event though right? In
> Jakub's
> >>>>>>> case, a mgmt event is desired to let the userspace know every time
> a
> >>>>>>> new advertisement packet is received, with the updated RSSI and
> >>>>>>> TxPower and so on.
> >>>>>>
> >>>>>> It should send as many Device Found events as there are advertising
> >>>>>> reports from the controller. We're enabling duplicate filtering in
> the
> >>>>>> hci_req_add_le_passive_scan() function in hci_core.c so maybe that's
> >>>>>> your issue? Some HW (like Broadcom) tend to be more conservative in
> how
> >>>>>> many events they send when filtering is enabled whereas others (like
> >>>>>> CSR) will give you many more of them (at least one whenever RSSI
> >>>>>> changes).
> >>>>>
> >>>>> Why is duplicate filtering being enabled ? Does it filter packets
> that
> >>>>> have different advertisement content ? Can I turn it off ?
> >>>>
> >>>> At least in the HCI section of the core spec this parameter is quite
> >>>> vaguely defined. We've enabled it to save power by avoiding the
> >>>> controller waking up the host too often. With auto-connections it
> makes
> >>>> sense to have it enabled since we're really only interested in the
> first
> >>>> event which acts as a trigger to connect. Same goes for device
> discovery
> >>>> when you're interested in setting up a new device for use.
> >>>>
> >>>> Right now the filtering is hard-coded but we could consider making it
> >>>> conditional to whether there are any entries with action 0x00 ("scan
> but
> >>>> don't connect") and disable the filtering in that case.
> >>>>
> >>>>>>> I think this ties in with some of the previous conversations on the
> >>>>>>> list about adding a device scan API that is geared towards
> >>>>>>> applications (rather than OS UI). That is, not only a mgmt API that
> >>>>>>> enables these kinds of use cases but also (probably) a high-level
> API
> >>>>>>> exposed from bluetoothd that allows applications to scan for
> devices
> >>>>>>> filtered by service UUIDs, contents of the manufacturer data field,
> >>>>>>> and so on.
> >>>>>>>
> >>>>>>> As for the Add Device command, does bluetoothd currently use this
> somehow?
> >>>>>>
> >>>>>> Yes, this feature (action 0x02 for Add Device) takes over the
> entire LE
> >>>>>> background scanning and auto-connection mechanism from 3.17 kernel
> >>>>>> onwards since BlueZ 5.22 (which was mentioned in our release notes
> btw).
> >>>>>> This is much better than the active scanning based auto-connections
> that
> >>>>>> have until now been done using Start/Stop Discovery.
> >>>>>
> >>>>> Thanks for pointing that!
> >>>>> The release note says that:
> >>>>> "The kernel will even use the controller-side whitelist during
> >>>>> scanning (if no Resolvable Private Addresses are present), saving
> even
> >>>>> more power."
> >>>>> If I understand well, that mean that my peripheral device need to be
> >>>>> whitelisted in order for me to get advertisements ?
> >>>>
> >>>> The controller-side whitelist just means that the controller only
> wakes
> >>>> us up and gives us advertisements for entries in the whitelist. When
> not
> >>>> using the whitelist the kernel gets woken up and needs to do itself
> the
> >>>> filtering out of unknown devices. The kernel uses the controller-side
> >>>> whitelist whenever possible, but e.g. when we have resolvable private
> >>>> addresses in the list we can't use it as we can't know the address the
> >>>> remote device will use in advance.
> >>>>
> >>>>> My use case include scanning for non-paired, non-connected devices,
> >>>>> checking RSSI value and deciding about connection based on
> >>>>> advertisement content, so that won't work. Am I right ?
> >>>>
> >>>> If you know the bdaddr that you're interested in in advance we should
> be
> >>>> able to tweak the Add Device command to do what you want (e.g. disable
> >>>> duplicate filtering in the case of Action=0x00 entries). However, if
> >>>> what you need is general scanning for any devices (also previously
> >>>> unknown ones) then Add Device doesn't really fit in (since it takes a
> >>>> known bdaddr). For that we'd either need to consider allowing
> BDADDR_ANY
> >>>> as an accepted parameter or then we'd need to define a new mgmt
> command.
> >>>>
> >>>
> >>> Unfortunately my case include previously unknown devices. I decide
> >>> wether I should connect (without pairing) based on advertised service
> >>> and RSSI power only. BDADDR_ANY seems good solution. Or maybe we can
> >>> add some parameter that will force not using controller-side whitelist
> >>> for scan?
> >>
> >> actually BDADDR_ANY does not really look like a good solution. What we
> really want is to be able to define a list of UUIDs and maybe an RSSI range
> or threshold for this.
> >
> > I think there should be option in mgmt api to capture all
> > advertisement packets, and later on application level decide what
> > property to filter on. I understand that this might be not energy
> > efficient, and that's why there is whitelisting and controller level
> > filtering.
> > Specifying list of UUIDs or RSSI value as parameter will be nice, but
> > controllers doesn't support this kind of complex filtering right now
> > anyway.
> > If you decide to allow UUID and RSSI filtering, maybe in a while
> > someone will come up with need to filter by something in advertisement
> > ? Maybe it would be good to have this 'look for advertisements' API
> > very general.
>
> we can always extend the mgmt API with a new command for filtering
> something new. And yes, the Bluetooth SIG will define a new AD element type
> and then it is not supported. There are also many new Bluetooth
> specifications in progress and also planned (which I will not iterate here
> since they are Buetooth SIG confidential) which extend LE advertising in
> various form and shapes.
>
> For me it is important that we can do certain things in the kernel so that
> userspace can keep sleeping. And we really can just add extra mgmt commands
> to allow for this. Remember that kernel will have to disable certain
> "background" behavior anymore. An active discovery always comes first. An
> active connection establishment from a socket comes first. Pairing a device
> comes first. So all these major events that are driven by an user action
> will be prioritized. We have to do that since otherwise you end up with bad
> user experience. But then again, draining the battery is also bad user
> experience. So we need to find a balance here.
>

I will be very happy with mgmt api method that will filter by serice uuid
and RSSI value, and that's enough for me. From my use case it looks like
the user is going to be in this scan state for short time - few seconds,
maximum minute.

If it would be possible to also add general le scan method that would
return all advertisements, marked as "only for development", and "not for
use in production", and "behaves differently for different controllers" and
maybe somehow disabled by default and you need to set some special flag to
enable it on your developer machine then it would be awsome for developers
that want to play with it, but it's not my requirement.


>
> >>
> >> The real problem is that controllers behave so different when you talk
> about advertising event report. So even if you have duplicate filtering on
> or off they have different behaviors. And that is where the real challenge
> comes into play here. What works on one controller just fine, might turn
> into a huge battery drain on the other.
> >>
> >
> > Thanks for pointing that out, I've already heard that argument from
> > Scott before, and it'll require more investigation.
> >
> >> Get a few different controllers, Marvell, Intel, CSR and Broadcom and
> play with hcitool lescan to see the different behavior they provide. You
> can also write your own small little HCI program using the HCI User Channel
> feature we added in 3.13 and use src/shared/hci.c as helper for handling
> HCI commands. You really need to understand what you are getting yourself
> into here.
> >
> > I've already implemented my functionality first using BLED112 dongle,
> > and then on linux using HCI api and tested it on two controllers, but
> > from what I understood MGMT is the  API of future. Also I want to make
> > it work for all controllers, not only those three.
>
> This is not for an official API. You can not use HCI User Channel and mgmt
> at the time. They are mutually exclusive. Actually when opening a HCI User
> Channel you will see that the controller index disappears from the mgmt
> interface.
>

I was forced to use HCI, because mgmt didn't exposed required functionality
(the scan I want to add). And I want my code to work in the future without
causing the controller to disapear from mgmt.


>
> What I am saying is that you need to get yourself some understanding on
> how certain controllers from certain manufactures behave if you for example
> turn on/off the duplicate filtering. And then also have a rather busy LE
> environment with a bunch of devices advertising. Get a few beacons that are
> constant advertising and get a feel on what is going on on HCI. You will
> quickly see that we have to be smarter than just keep scanning. And for
> kicks, try to use BR/EDR for say A2DP at the same time. See how that goes.
>


>
> >>
> >> My main concern is battery drain. Once we figured out on how to avoid
> that, we can easily design a new mgmt command that allows you to do exactly
> what you want to do.
> >
> > From what I understand as long as controllers don't support
> > sophisticated filtering, that would be energy conuming. I would also
> > preffer to find a energy-friendly way, but is it better not to have
> > this functionality rather than have it in non-energy consuming way ?
>
> Even if we consume extra energy on older Bluetooth chips or certain
> manufactures, we want to try to not waste it. If it drains your battery,
> people will just disable Bluetooth and then you have not won anything.
>
> Maybe what this really needs is that we go into the Bluetooth SIG and
> propose controller based filtering with standard HCI commands.
>

Controller based filtering would be awsome, but it would probably take 2-3
years to get first controller that do it, and I hope to be able to ship my
functionality in maybe 2-3 months.

>From current discussion it seems that it's achievable to implement it in
kernel right now, and eventually talk with manufacturers to make it
standard in future.


> Regards
>
> Marcel
>
>

--001a113a22aceee07a05036dbd6e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Thu, Sep 18, 2014 at 8:37 AM, Marcel Holtmann <span dir=3D"ltr">&lt;=
<a href=3D"mailto:marcel@holtmann.org" target=3D"_blank">marcel@holtmann.or=
g</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204=
);border-left-style:solid;padding-left:1ex"><div><div>Hi Jakub,<br>
<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; have you looked at the the Add Device mana=
gement command with the<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; 0x00 Action. That will just send out Devic=
e Found events for devices<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; in range and uses passive scanning.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; In addition if you are paired with a devic=
e and actually want to<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; connect to it, you can use Action 0x02 to =
allow for background<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; connection. This is currently in use for L=
E HID devices.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; This still only sends one Device Found event t=
hough right? In Jakub&#39;s<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; case, a mgmt event is desired to let the users=
pace know every time a<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; new advertisement packet is received, with the=
 updated RSSI and<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; TxPower and so on.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; It should send as many Device Found events as ther=
e are advertising<br>
&gt;&gt;&gt;&gt;&gt;&gt; reports from the controller. We&#39;re enabling du=
plicate filtering in the<br>
&gt;&gt;&gt;&gt;&gt;&gt; hci_req_add_le_passive_scan() function in hci_core=
.c so maybe that&#39;s<br>
&gt;&gt;&gt;&gt;&gt;&gt; your issue? Some HW (like Broadcom) tend to be mor=
e conservative in how<br>
&gt;&gt;&gt;&gt;&gt;&gt; many events they send when filtering is enabled wh=
ereas others (like<br>
&gt;&gt;&gt;&gt;&gt;&gt; CSR) will give you many more of them (at least one=
 whenever RSSI<br>
&gt;&gt;&gt;&gt;&gt;&gt; changes).<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Why is duplicate filtering being enabled ? Does it fil=
ter packets that<br>
&gt;&gt;&gt;&gt;&gt; have different advertisement content ? Can I turn it o=
ff ?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; At least in the HCI section of the core spec this paramete=
r is quite<br>
&gt;&gt;&gt;&gt; vaguely defined. We&#39;ve enabled it to save power by avo=
iding the<br>
&gt;&gt;&gt;&gt; controller waking up the host too often. With auto-connect=
ions it makes<br>
&gt;&gt;&gt;&gt; sense to have it enabled since we&#39;re really only inter=
ested in the first<br>
&gt;&gt;&gt;&gt; event which acts as a trigger to connect. Same goes for de=
vice discovery<br>
&gt;&gt;&gt;&gt; when you&#39;re interested in setting up a new device for =
use.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Right now the filtering is hard-coded but we could conside=
r making it<br>
&gt;&gt;&gt;&gt; conditional to whether there are any entries with action 0=
x00 (&quot;scan but<br>
&gt;&gt;&gt;&gt; don&#39;t connect&quot;) and disable the filtering in that=
 case.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; I think this ties in with some of the previous=
 conversations on the<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; list about adding a device scan API that is ge=
ared towards<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; applications (rather than OS UI). That is, not=
 only a mgmt API that<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; enables these kinds of use cases but also (pro=
bably) a high-level API<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; exposed from bluetoothd that allows applicatio=
ns to scan for devices<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; filtered by service UUIDs, contents of the man=
ufacturer data field,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; and so on.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; As for the Add Device command, does bluetoothd=
 currently use this somehow?<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Yes, this feature (action 0x02 for Add Device) tak=
es over the entire LE<br>
&gt;&gt;&gt;&gt;&gt;&gt; background scanning and auto-connection mechanism =
from 3.17 kernel<br>
&gt;&gt;&gt;&gt;&gt;&gt; onwards since BlueZ 5.22 (which was mentioned in o=
ur release notes btw).<br>
&gt;&gt;&gt;&gt;&gt;&gt; This is much better than the active scanning based=
 auto-connections that<br>
&gt;&gt;&gt;&gt;&gt;&gt; have until now been done using Start/Stop Discover=
y.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Thanks for pointing that!<br>
&gt;&gt;&gt;&gt;&gt; The release note says that:<br>
&gt;&gt;&gt;&gt;&gt; &quot;The kernel will even use the controller-side whi=
telist during<br>
&gt;&gt;&gt;&gt;&gt; scanning (if no Resolvable Private Addresses are prese=
nt), saving even<br>
&gt;&gt;&gt;&gt;&gt; more power.&quot;<br>
&gt;&gt;&gt;&gt;&gt; If I understand well, that mean that my peripheral dev=
ice need to be<br>
&gt;&gt;&gt;&gt;&gt; whitelisted in order for me to get advertisements ?<br=
>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; The controller-side whitelist just means that the controll=
er only wakes<br>
&gt;&gt;&gt;&gt; us up and gives us advertisements for entries in the white=
list. When not<br>
&gt;&gt;&gt;&gt; using the whitelist the kernel gets woken up and needs to =
do itself the<br>
&gt;&gt;&gt;&gt; filtering out of unknown devices. The kernel uses the cont=
roller-side<br>
&gt;&gt;&gt;&gt; whitelist whenever possible, but e.g. when we have resolva=
ble private<br>
&gt;&gt;&gt;&gt; addresses in the list we can&#39;t use it as we can&#39;t =
know the address the<br>
&gt;&gt;&gt;&gt; remote device will use in advance.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; My use case include scanning for non-paired, non-conne=
cted devices,<br>
&gt;&gt;&gt;&gt;&gt; checking RSSI value and deciding about connection base=
d on<br>
&gt;&gt;&gt;&gt;&gt; advertisement content, so that won&#39;t work. Am I ri=
ght ?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; If you know the bdaddr that you&#39;re interested in in ad=
vance we should be<br>
&gt;&gt;&gt;&gt; able to tweak the Add Device command to do what you want (=
e.g. disable<br>
&gt;&gt;&gt;&gt; duplicate filtering in the case of Action=3D0x00 entries).=
 However, if<br>
&gt;&gt;&gt;&gt; what you need is general scanning for any devices (also pr=
eviously<br>
&gt;&gt;&gt;&gt; unknown ones) then Add Device doesn&#39;t really fit in (s=
ince it takes a<br>
&gt;&gt;&gt;&gt; known bdaddr). For that we&#39;d either need to consider a=
llowing BDADDR_ANY<br>
&gt;&gt;&gt;&gt; as an accepted parameter or then we&#39;d need to define a=
 new mgmt command.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Unfortunately my case include previously unknown devices. I de=
cide<br>
&gt;&gt;&gt; wether I should connect (without pairing) based on advertised =
service<br>
&gt;&gt;&gt; and RSSI power only. BDADDR_ANY seems good solution. Or maybe =
we can<br>
&gt;&gt;&gt; add some parameter that will force not using controller-side w=
hitelist<br>
&gt;&gt;&gt; for scan?<br>
&gt;&gt;<br>
&gt;&gt; actually BDADDR_ANY does not really look like a good solution. Wha=
t we really want is to be able to define a list of UUIDs and maybe an RSSI =
range or threshold for this.<br>
&gt;<br>
&gt; I think there should be option in mgmt api to capture all<br>
&gt; advertisement packets, and later on application level decide what<br>
&gt; property to filter on. I understand that this might be not energy<br>
&gt; efficient, and that&#39;s why there is whitelisting and controller lev=
el<br>
&gt; filtering.<br>
&gt; Specifying list of UUIDs or RSSI value as parameter will be nice, but<=
br>
&gt; controllers doesn&#39;t support this kind of complex filtering right n=
ow<br>
&gt; anyway.<br>
&gt; If you decide to allow UUID and RSSI filtering, maybe in a while<br>
&gt; someone will come up with need to filter by something in advertisement=
<br>
&gt; ? Maybe it would be good to have this &#39;look for advertisements&#39=
; API<br>
&gt; very general.<br>
<br>
</div></div>we can always extend the mgmt API with a new command for filter=
ing something new. And yes, the Bluetooth SIG will define a new AD element =
type and then it is not supported. There are also many new Bluetooth specif=
ications in progress and also planned (which I will not iterate here since =
they are Buetooth SIG confidential) which extend LE advertising in various =
form and shapes.<br>
<br>
For me it is important that we can do certain things in the kernel so that =
userspace can keep sleeping. And we really can just add extra mgmt commands=
 to allow for this. Remember that kernel will have to disable certain &quot=
;background&quot; behavior anymore. An active discovery always comes first.=
 An active connection establishment from a socket comes first. Pairing a de=
vice comes first. So all these major events that are driven by an user acti=
on will be prioritized. We have to do that since otherwise you end up with =
bad user experience. But then again, draining the battery is also bad user =
experience. So we need to find a balance here.<br></blockquote><div><br></d=
iv><div>I will be very happy with mgmt api method that will filter by seric=
e uuid and RSSI value, and that&#39;s enough for me. From my use case it lo=
oks like the user is going to be in this scan state for short time - few se=
conds, maximum minute.</div><div><br></div><div>If it would be possible to =
also add general le scan method that would return all advertisements, marke=
d as &quot;only for development&quot;, and &quot;not for use in production&=
quot;, and &quot;behaves differently for different controllers&quot; and ma=
ybe somehow disabled by default and you need to set some special flag to en=
able it on your developer machine then it would be awsome for developers th=
at want to play with it, but it&#39;s not my requirement.<br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-styl=
e:solid;padding-left:1ex">
<span><br>
&gt;&gt;<br>
&gt;&gt; The real problem is that controllers behave so different when you =
talk about advertising event report. So even if you have duplicate filterin=
g on or off they have different behaviors. And that is where the real chall=
enge comes into play here. What works on one controller just fine, might tu=
rn into a huge battery drain on the other.<br>
&gt;&gt;<br>
&gt;<br>
&gt; Thanks for pointing that out, I&#39;ve already heard that argument fro=
m<br>
&gt; Scott before, and it&#39;ll require more investigation.<br>
&gt;<br>
&gt;&gt; Get a few different controllers, Marvell, Intel, CSR and Broadcom =
and play with hcitool lescan to see the different behavior they provide. Yo=
u can also write your own small little HCI program using the HCI User Chann=
el feature we added in 3.13 and use src/shared/hci.c as helper for handling=
 HCI commands. You really need to understand what you are getting yourself =
into here.<br>
&gt;<br>
&gt; I&#39;ve already implemented my functionality first using BLED112 dong=
le,<br>
&gt; and then on linux using HCI api and tested it on two controllers, but<=
br>
&gt; from what I understood MGMT is the=C2=A0 API of future. Also I want to=
 make<br>
&gt; it work for all controllers, not only those three.<br>
<br>
</span>This is not for an official API. You can not use HCI User Channel an=
d mgmt at the time. They are mutually exclusive. Actually when opening a HC=
I User Channel you will see that the controller index disappears from the m=
gmt interface.<br></blockquote><div><br></div><div>I was forced to use HCI,=
 because mgmt didn&#39;t exposed required functionality (the scan I want to=
 add). And I want my code to work in the future without causing the control=
ler to disapear from mgmt.</div><div>=C2=A0<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-=
left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">
<br>
What I am saying is that you need to get yourself some understanding on how=
 certain controllers from certain manufactures behave if you for example tu=
rn on/off the duplicate filtering. And then also have a rather busy LE envi=
ronment with a bunch of devices advertising. Get a few beacons that are con=
stant advertising and get a feel on what is going on on HCI. You will quick=
ly see that we have to be smarter than just keep scanning. And for kicks, t=
ry to use BR/EDR for say A2DP at the same time. See how that goes.<br></blo=
ckquote><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,2=
04);border-left-style:solid;padding-left:1ex">
<span><br>
&gt;&gt;<br>
&gt;&gt; My main concern is battery drain. Once we figured out on how to av=
oid that, we can easily design a new mgmt command that allows you to do exa=
ctly what you want to do.<br>
&gt;<br>
&gt; From what I understand as long as controllers don&#39;t support<br>
&gt; sophisticated filtering, that would be energy conuming. I would also<b=
r>
&gt; preffer to find a energy-friendly way, but is it better not to have<br=
>
&gt; this functionality rather than have it in non-energy consuming way ?<b=
r>
<br>
</span>Even if we consume extra energy on older Bluetooth chips or certain =
manufactures, we want to try to not waste it. If it drains your battery, pe=
ople will just disable Bluetooth and then you have not won anything.<br>
<br>
Maybe what this really needs is that we go into the Bluetooth SIG and propo=
se controller based filtering with standard HCI commands.<br></blockquote><=
div><br></div><div>Controller based filtering would be awsome, but it would=
 probably take 2-3 years to get first controller that do it, and I hope to =
be able to ship my functionality in maybe 2-3 months.</div><div><br></div><=
div>From current discussion it seems that it&#39;s achievable to implement =
it in kernel right now, and eventually talk with manufacturers to make it s=
tandard in future.</div><div><br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb=
(204,204,204);border-left-style:solid;padding-left:1ex">
<br>
Regards<br>
<span><font color=3D"#888888"><br>
Marcel<br>
<br>
</font></span></blockquote></div><br></div></div>

--001a113a22aceee07a05036dbd6e--
