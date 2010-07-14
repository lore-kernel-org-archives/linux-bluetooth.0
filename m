Return-Path: <cyrus@holtmann.org>
From: "Perelet, Oleg" <operelet@quicinc.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Ron Shaffer <rshaffer@codeaurora.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Wilson, Matt" <mtwilson@quicinc.com>
Date: Wed, 14 Jul 2010 12:20:33 -0700
Subject: RE: [PATCH 3/3] Bluetooth: Synchronize SCO/eSCO connection requests
 to ACL state
Message-ID: <BCDE476F204B134B8B235FB275BC3AD810407AA0CD@NALASEXMB01.na.qualcomm.com>
References: <1278625779.10421.80.camel@localhost.localdomain>
	 <1278968772-29446-1-git-send-email-rshaffer@codeaurora.org>
 <1278972477.6282.10.camel@localhost.localdomain>
In-Reply-To: <1278972477.6282.10.camel@localhost.localdomain>
Content-Type: multipart/mixed;
	boundary="_002_BCDE476F204B134B8B235FB275BC3AD810407AA0CDNALASEXMB01na_"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--_002_BCDE476F204B134B8B235FB275BC3AD810407AA0CDNALASEXMB01na_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>I find your patch actually highly complicated. So I tried to capture
>your intend the in the attached patch (only compiled test) and it would
>be good if you can try that.

Marcel, your fix is mode delicate compared to original and has same functio=
nality.=20

There's small problem with both yours & Rons - there's no error handling fo=
r case when other device will never ACK's unsniff - you pretty much DOS ses=
sion if there's no reply. No real HS will do that but it may present securi=
ty flaw. I do not know how severe is that

I attached original conversation when we 1st time seen the problem.
Oleg.
=20

-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@v=
ger.kernel.org] On Behalf Of Marcel Holtmann
Sent: Monday, July 12, 2010 5:08 PM
To: Ron Shaffer
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3] Bluetooth: Synchronize SCO/eSCO connection request=
s to ACL state

Hi Ron,

> Certain headsets such as the Motorola H350 will reject SCO and eSCO
> connection requests while the ACL is transitioning from sniff mode
> to active mode. Add synchronization so that SCO and eSCO connection
> requests will wait until the ACL has fully transitioned to active mode.

I find your patch actually highly complicated. So I tried to capture
your intend the in the attached patch (only compiled test) and it would
be good if you can try that.

So in general it makes no difference which mode we are in. If a mode
change is pending, then we have to delay the SCO setup. And once we are
done we the mode change we just setup the SCO link. So in theory that
should be enough. Not sure if that is true. I could have overlooked
something since I don't really have tested the patch at all ;)

Regards

Marcel


--_002_BCDE476F204B134B8B235FB275BC3AD810407AA0CDNALASEXMB01na_
Content-Type: message/rfc822

From: "Perelet, Oleg" <operelet@quicinc.com>
To: Nick Pelly <npelly@google.com>, "Shaffer, Ron" <rshaffer@quicinc.com>
Date: Fri, 19 Mar 2010 10:00:16 -0700
Subject: RE: mot hs850
Thread-Topic: mot hs850
Thread-Index: AcrFUi8TRN3Ib70QQg2++ol4Lq93IQCMnhLQ
References: <BCDE476F204B134B8B235FB275BC3AD802E8E10ABA@NALASEXMB01.na.qualcomm.com>
 	<35c90d960912021009l5e269107wffbdad76fc8eab15@mail.gmail.com>
 	<BCDE476F204B134B8B235FB275BC3AD8034BBAAA0A@NALASEXMB01.na.qualcomm.com>
 	<35c90d961002231458r45f2b255k86759900e4821ad2@mail.gmail.com>
 	<BCDE476F204B134B8B235FB275BC3AD8034BCE0648@NALASEXMB01.na.qualcomm.com>
 	<54BAC5D5772B8649A612655AE317DB7D02BA11E076@NASANEXMB07.na.qualcomm.com>
 	<35c90d961002231842w2e8616aavc416ac40ed7edef@mail.gmail.com>
 	<BCDE476F204B134B8B235FB275BC3AD8034BEBB224@NALASEXMB01.na.qualcomm.com>
 	<35c90d961003161418x402a3bd5na7e23c111a69f55f@mail.gmail.com>
 	<54BAC5D5772B8649A612655AE317DB7D02BA2C5249@NASANEXMB07.na.qualcomm.com>
 <35c90d961003161444s424bfd14p4a660f4e035f90c5@mail.gmail.com>
In-Reply-To: <35c90d961003161444s424bfd14p4a660f4e035f90c5@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0

Nick, finally we understand what's wrong with HS830 (I think I called it 85=
0 before:)

It won't accept eSCO(or SCO for that matter, packet types do not apply in t=
his problem) until it ack's unsniff requests - dumb but reality.

This involved a bit more logic after doing:
+               acl->power_save =3D 1;
+               hci_conn_enter_active_mode(acl);
+
in

http://git.kernel.org/?p=3Dlinux/kernel/git/holtmann/bluetooth-2.6.git;a=3D=
blobdiff;f=3Dnet/bluetooth/hci_conn.c;h=3Db10e3cdb08f87358ca64d0db8cf83c27f=
5ad624a;hp=3Db7c4224f4e7dee01288dd31f4581f7a8821c7a21;hb=3Dc390216b3e868b16=
d8154939f4b6f8c16dbd9a9f;hpb=3D88d1a0cf659438a66135661538ae332b23f8635a

you actually need to wait for ack for it before doing hci_setup_sync. Ron e=
xtending kernel do to that and we'll mail you patch.

But honestly I think this sort of change should live in userland. Problem i=
s that you do not have libbuetooth up in Java to issue unsniff request and =
wait for ack for it. Maybe having raw hci going up from java? I do not know=
 - have you thought about this?


Oleg.


-----Original Message-----
From: Nick Pelly [mailto:npelly@google.com]
Sent: Tuesday, March 16, 2010 4:45 PM
To: Shaffer, Ron
Cc: Perelet, Oleg
Subject: Re: mot hs850

On Tue, Mar 16, 2010 at 2:35 PM, Shaffer, Ron <rshaffer@quicinc.com> wrote:
> Hey Nick:
>
>> -----Original Message-----
>> From: Nick Pelly [mailto:npelly@google.com]
>> Sent: Tuesday, March 16, 2010 4:19 PM
>> To: Perelet, Oleg
>> Cc: Shaffer, Ron
>> Subject: Re: mot hs850
>>
>> I haven't tested with that one....what happens?
>
> The issue the we've run into is an eSCO negotiation problem with mot h350=
.
> It fails to make eSCO or SCO connection after adding in the patch below t=
o
> handle the slow eSCO negotiation when in sniff.
>
> In particular, we request eSCO with 3-EV5, the headset says no let's do 2=
-EV3,
> then we say how about 3-EV3, and the headset says go pound sand.
>
> It really looks like a headset issue that we're trying to work around.
>
> I took a look at Bluetooth: Allow SCO/eSCO packet type selection for outg=
oing
> SCO connections,
> http://android.git.kernel.org/?p=3Dkernel/common.git;a=3Dcommit;
> h=3D3b077241e02041b1f03fee912896b8de1d7ac096
>
> and I was wondering if the above behavior is what you saw prior to this p=
atch.

The packet type selection patch was motivated by other headsets, but
can probably be used to resolve this issue as well. I think if you
experiment with disabling 3-EV3 and maybe 3-EV5 packet types with this
headset we might find packets that work. Please let me know if you
find the right packet mask so we can roll it in. With Froyo we are
introducing a config file to set packet type masks with known bad
headsets

I don't want to revert the exit sniff mode patch - it fixes a lot of
slow SCO problems and makes sense.

Nick

--_002_BCDE476F204B134B8B235FB275BC3AD810407AA0CDNALASEXMB01na_--
