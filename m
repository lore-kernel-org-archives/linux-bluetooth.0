Return-Path: <cyrus@holtmann.org>
Date: Tue, 26 Jul 2011 11:11:21 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Add SetRemoteProperty method for OOB mechanism
Message-ID: <20110726081121.GD9775@dell>
References: <1309790985-32143-1-git-send-email-bulislaw@linux.com>
 <CABBYNZ+B_dDGRnoic6xyn4N1kRpOPTGrMJ7xBkmB7M=ZBsZzDQ@mail.gmail.com>
 <CAPGrrxVT-xugggk_CcNn_Zd+ZSJjuVPrMn64XVnNoUqK2sm60Q@mail.gmail.com>
 <CABBYNZJHkqk5dQZrYzNiVTs4Fdx8WUk70CfAzLbVHhUHWuos+Q@mail.gmail.com>
 <CAPGrrxV_hpVhsp2pkkSgy+oSgeRNSxz3WP4hk8AzjjjZZH+j6g@mail.gmail.com>
 <CAPGrrxUwYsRXkaYomM5FS+OJLt7fL4u-DKKASNx76Of3wg6fcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAPGrrxUwYsRXkaYomM5FS+OJLt7fL4u-DKKASNx76Of3wg6fcQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Wed, Jul 06, 2011, Bartosz Szatkowski wrote:
> On Tue, Jul 5, 2011 at 11:59 AM, Bartosz Szatkowski <bulislaw@linux.com> wrote:
> > On Tue, Jul 5, 2011 at 11:51 AM, Luiz Augusto von Dentz
> >> On Tue, Jul 5, 2011 at 11:55 AM, Bartosz Szatkowski <bulislaw@linux.com> wrote:
> >>> Right, i'v discussed this approach with Johan and Szymon on freenode
> >>> -- i'v changed few things after that (mostly because implementing it
> >>> in AddRemoteData would break api, so i moved it to separate method) --
> >>> maybe it would be a good idea to have this functionality now in this
> >>> form and change it when the api break would be possible (5.0?)?
> >>
> >> Apparently the idea is to use this interface is to emulate a
> >> DeviceFound result, which I guess would make sense if the user pairs
> >> using the bt application/agent, but in the other hand this can be
> >> misused by application and they actually start overwriting device
> >> properties e.g. restore tool. So the question is how much do we trust
> >> application to provide this information without properly creating a
> >> device? To me it sounds that we either need the agent to actually
> >> accept this information as valid, which btw normally requires an
> >> object path to identify the device to query its properties, or we do
> >> it all together as I suggested in CreateDevice so we validate the
> >> information by pairing/connecting to the device.
> >>
> >> Btw, there is also the problem that D-Bus round trips are expensive
> >> and with such API one have to set one by one the properties to finally
> >> do a CreateDevice in the end, so at least the current design should
> >> make sure that an application can set all its known properties in one
> >> call e.g. SetRemoteProperties(string address, dict properties).
> >
> > Yeah it sound good, but are we sure that there is need for setting
> > other parameters via OOB? The idea that was cleared on irc wast to add
> > CoD parameter to OOB.AddRemoteData(address, hash, randomizer, CoD)
> 
> Is there any conclusion ? :)
> Are we leaving it that way or changing it as Luiz suggested (array)?
> Or maybe something else?

For things like name and class (I suppose a list of UUIDs can also come
through the OOB data?). I think a single method call taking a dictionary
would be best. For the hash and randomizer, we could either keep the
existing method, or just define new "Hash" and "Rand" dictionary
entries. Since it's likely that all of this data comes in the same
instant over OOB I'm leaning towards the later solution.

Johan
