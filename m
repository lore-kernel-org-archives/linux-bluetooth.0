Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Questions about BlueZ in  commercial use
From: Marcel Holtmann <marcel@holtmann.org>
To: KeiHachi <keihachi@swissinfo.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <000c01c45d2c$ed2e5f80$0364a8c0@haruo>
References: <003401c45c2b$b6eab240$0364a8c0@haruo>
	 <1088359746.3774.20.camel@pegasus>  <000c01c45d2c$ed2e5f80$0364a8c0@haruo>
Content-Type: text/plain
Message-Id: <1088442828.6030.27.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 28 Jun 2004 19:13:48 +0200

Hi KeiHachi,

> > about what kind of product are you talking?
>  
> I think it is a mobile device like a PDA.

so what profiles do you wanna support on your PDA?

> > This list only shows kernel related items that other people can start
> > working on if they want to contribute anything to BlueZ. My personal
> > todo list is much longer.
> 
> Oh, that sounds good.

Not from my point ;)

> > Define what kind of eSCO support do you need? Must the SCO packets go
> > though the HCI layer or through an extra PCM interface?
> 
> I expect that the transparent data as well as the voice data go through the HCI layer.

Mostly the PCM interface is easier to handle. What kind of host
transport layer are you planning to use? USB or UART?

> > Do you own Bluetooth chips that supports eSCO? I only own two devboards
> > and both don"t support SCO over HCI and they also don"t came with a PCM
> > codec on it.
> 
> No, we don't have any eSCO enabled Bluetooth chips now, too.
> In the current situation, I noticed it is not so easy to support eSCO,
> because there are few chips Bluetooth chips that support eSCO.

Right now you can use a BlueCore3 and a Zeevo ZV4002. There must be also
a Silicon Wave, but I lost my prototype dongle so I can't check if it
says eSCO support.

> > Audio/video is along with HID one of the two major things that will be
> > supported in the future. However talking about A2DP the problem I see is
> > that there is not free GPL code for the suband codec at the moment and I
> > am not an audio expert. I haven"t spent any time with thinking about the
> > remote control profiles.
> 
> I know it is difficult to develop the SBC.
> Aren't there audio experts in BlueZ community?
> 
> Or, do you think about working together with other open-source communities
> that have some audio experts?
> I found some open-source projects related to a audio codec
> as a result of searching on sourceforge.net.
> They are audio experts, so I think A2DP can be developed if they cooperate with BlueZ community.
> (Of course I also think it is not easy.)

I will ask the open source audio experts, but I only wanna do that after
the AVDTP support is ready and usable.

> > Many business models are possible, but you must be more specific about
> > that what you had in mind. What kind of maintenance and support do you
> > need?
> 
> Um-, I don't have an explicit ideal world of such a business model.
> 
> However, the most important thing we want is the guarantee of quality.
> For example, we shipped our product using BlueZ, then,
> if a bug is found after the shipment, we expect our product will be corrected immediately. 
> Or else,
> we expect new features that aren't supported by BlueZ currently will be supported timely.
> 
> These are the supports that we expect.
> 
> I also think these already are the current task of BlueZ community,
> but the problem is that the service level agreement based on a contract doesn't exist now.

Yes, we already do this. We don't name it explicit bugfix or new
feature, but you can assume it from the changeset text in the Bitkeeper
repositories and the CVS trees.

> I definitely think BlueZ members are always collaborative and kindly and nice guys.
> However, BlueZ members work without pay, as unpaid volunteers,
> instead of the disclaimer of the quality guarantee.
> This development model characterizes a open-source project,
> but in commercial use this is the problem.
> Even if we pay some maintenance fee,
> we want to get a minimum of the service level agreement based on a contract at least.

I can't offer you anything like that at the moment, but if you are
really need this and you wanna pay for it, we can talk about it.

> > That is wrong. BlueZ itself is stable. Speaking about the kernel part
> > then every code in a stable kernel like 2.4 and 2.6 is stable. Bugs
> > exists and later kernel releases are more stable than previous, but
> > every BlueZ code in the kernel can be considered as stable.
> 
> Oh, I see. That is the answer I want.
> 
> My understanding is:
>   The kernel part of BlueZ is always stable
>     because it is included in a stable kernel version, like 2.4 kernel.
>   And then, the utils2/libs2 are the current working or developing version,
>    the others are always stable versions.
> 
> Is that corrent understanding?

Sometimes I bend this rules a little bit, but yes, this is correct.

Regards

Marcel




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
