Return-Path: <keihachi@swissinfo.org>
Message-ID: <000c01c45d2c$ed2e5f80$0364a8c0@haruo>
From: "KeiHachi" <keihachi@swissinfo.org>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
References: <003401c45c2b$b6eab240$0364a8c0@haruo> <1088359746.3774.20.camel@pegasus>
Subject: Re: [Bluez-devel] Questions about BlueZ in  commercial use
Date: Tue, 29 Jun 2004 01:28:17 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
List-ID: <bluez-devel.lists.sourceforge.net>

Thanks for your reply, Marcel.

> about what kind of product are you talking?
 
I think it is a mobile device like a PDA.


> > Q1. development schedule in the future
> > I saw  "http://www.bluez.org/todo.html"
> > But there is no information I want to know.
> > Please tell me the following things.
> 
> This list only shows kernel related items that other people can start
> working on if they want to contribute anything to BlueZ. My personal
> todo list is much longer.

Oh, that sounds good.


> > - eSCO (enhanced SCO) in Bluetooth 1.2
> > Do you have any plan to develop these?
> 
> Define what kind of eSCO support do you need? Must the SCO packets go
> though the HCI layer or through an extra PCM interface?

I expect that the transparent data as well as the voice data go through the HCI layer.


> Do you own Bluetooth chips that supports eSCO? I only own two devboards
> and both don"t support SCO over HCI and they also don"t came with a PCM
> codec on it.

No, we don't have any eSCO enabled Bluetooth chips now, too.
In the current situation, I noticed it is not so easy to support eSCO,
because there are few chips Bluetooth chips that support eSCO.

 
> > - Audio/Video related profiles
> > Do you have any plan to develop these(A2DP, AVRCP)?
> 
> Audio/video is along with HID one of the two major things that will be
> supported in the future. However talking about A2DP the problem I see is
> that there is not free GPL code for the suband codec at the moment and I
> am not an audio expert. I haven"t spent any time with thinking about the
> remote control profiles.

I know it is difficult to develop the SBC.
Aren't there audio experts in BlueZ community?

Or, do you think about working together with other open-source communities
that have some audio experts?
I found some open-source projects related to a audio codec
as a result of searching on sourceforge.net.
They are audio experts, so I think A2DP can be developed if they cooperate with BlueZ community.
(Of course I also think it is not easy.)

> > Q2. maintenance/support
> > I found some examples about the support of open-source that
> > companies which want to use such a open-source software,
> > pay some maintenance fee to the community or some companies which
> > provide the service to maintain it, so that
> > the community or such companies ensure the quality of their software is a certain level.
> > For example, MySQL, JBoss, etc.
> > These open-sources are maintained to ensure the quality,
> > by some kind of organizations which get the maintenance fee.
> > 
> > Does BlueZ allow such a business model?
> 
> Many business models are possible, but you must be more specific about
> that what you had in mind. What kind of maintenance and support do you
> need?

Um-, I don't have an explicit ideal world of such a business model.

However, the most important thing we want is the guarantee of quality.
For example, we shipped our product using BlueZ, then,
if a bug is found after the shipment, we expect our product will be corrected immediately. 
Or else,
we expect new features that aren't supported by BlueZ currently will be supported timely.

These are the supports that we expect.

I also think these already are the current task of BlueZ community,
but the problem is that the service level agreement based on a contract doesn't exist now.

I definitely think BlueZ members are always collaborative and kindly and nice guys.
However, BlueZ members work without pay, as unpaid volunteers,
instead of the disclaimer of the quality guarantee.
This development model characterizes a open-source project,
but in commercial use this is the problem.
Even if we pay some maintenance fee,
we want to get a minimum of the service level agreement based on a contract at least.


> > Q3. version control
> > Many open-sources are composed of two versions,
> > one is a "testing version", and another is a "stable version". 
> > But I think BlueZ has only a "testing version".
> > 
> > Why doesn"t BlueZ have a "stable version"?
> > Do you have any plan to have a "stable version" of BlueZ?
> 
> That is wrong. BlueZ itself is stable. Speaking about the kernel part
> then every code in a stable kernel like 2.4 and 2.6 is stable. Bugs
> exists and later kernel releases are more stable than previous, but
> every BlueZ code in the kernel can be considered as stable.

Oh, I see. That is the answer I want.

My understanding is:
  The kernel part of BlueZ is always stable
    because it is included in a stable kernel version, like 2.4 kernel.
  And then, the utils2/libs2 are the current working or developing version,
   the others are always stable versions.

Is that corrent understanding?


Regards,
KeiHachi
