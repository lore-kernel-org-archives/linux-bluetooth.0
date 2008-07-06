Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <098d01c8def8$6cef31d0$6701a8c0@freqonedev>
References: <062301c8de19$144dc990$6701a8c0@freqonedev>
	<1215278245.4349.16.camel@californication>
	<098d01c8def8$6cef31d0$6701a8c0@freqonedev>
Date: Sun, 06 Jul 2008 12:59:08 +0200
Message-Id: <1215341948.7112.8.camel@californication>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Creating a 4.x org.bluez.Agent (with BUG)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi David,

> >> Over the last few days, I have developed an Agent to implement the
> >> org.bluez.Agent interface, so that I can test the new 
> >> BT2.1-compatible
> >> Simple Secure Pairing (SSP).
> >>
> >> did this, however, the new agent was never found by my application,
> >> calling the Adapter.CreatePairedDevice method.  When I tested with 
> >> the
> >> hcid/simple-agent, that Python-based agent worked well.  I would like 
> >> to
> >> share the reasons for this...
> >
> > this sounds like a bug in hcid. You can use CreateDevice on a 
> > Bluetooth
> > 2.1 device and it will do just-works pairing.
> 
> When I CreatePairedDevice, the devices pair, but end up using legacy 
> pairing with a pin code.  This makes me suspicious.

you will need the kernel patches from my bluetooth-2.6 repository to
enable Simple Pairing.

> At the same time, CreateDevice does not appear to attempt to pair at 
> all.

With Simple Pairing it is just-works model. Otherwise no pairing.

> >> 2) Knowing that hcid uses the System bus, I then tried to connect 
> >> with
> >> the System bus, referencing the "org.bluez" well-known connection 
> >> name.
> >
> > An agent has not to provide a well known name. Our whole design is 
> > based
> > on the fact that an agent can connect to the system with a unique 
> > name.
> > Meaning that we don't need a security config file for the agent.
> 
> Agree with the concern for a security config file, which should not be a 
> bluez issue in any event, but for the provider of the Agent.  However, 
> if using a unique connection name, there is no way to pass that unique 
> name to RegisterAgent.  Plus the issue of telling the 
> RegisterAgent-calling what that unique name is.

The whole point is not to pass bus names around at all. We get the
unique name of the agent from the D-Bus message. This is all meant to be
this way so we can track the existence of an agent and if it dies
unexpectedly. Also you can only register yourself as an agent. You
should never mess around with other applications. It is on purpose
contained like this.

> >> 4) I attempted to connect with the registered Agent using
> >> Adapter.CreatePairedDevice, the Agent was not connected to.  The 
> >> reason
> >> for this is that CreatePairedDevice explicitly uses its own "unique
> >> connection name" to the System bus as the "bus name", and assumes 
> >> that
> >> the Object Path will be found on that bus name.  Which is only the 
> >> case
> >> if the Agent code is contained within the same process as the rest of
> >> the application; the application calling CreatePairedDevice.
> >
> > The object paths are per connection to the bus. So application A has 
> > its
> > own namespace for the objects and application B has another one.
> 
> For CreatePairedDevice, a bad path (e.g., /x/y/zzy) is fine and causes 
> fall-back to the Register(ed)Agent if any.  Maybe a little inelegant 
> (imho), but fine.

The right way is to actually implement an agent if you wanna use
CreatePairedDevice. This fallback happens to work. Use it if you must,
but we are not encouraging people to do so. Also when writing real UI
application you do want a specific agent in this case anyway.

> >> BUG-> (actually, the same bug) As with CreatePairedDevice, if there 
> >> is
> >> no object with that path for the unique connection name, 
> >> RegisterAgent
> >> should throw an error.
> >
> > Not a bug. We don't care. If calling the Agent object fails, then we
> > fail the pairing process. That is perfectly fine.
> 
> I agree that failing pairing is OK; I am more concerned about 
> RegisterAgent not finding the Object Path and not telling anybody (even 
> the syslog).

Again. That is up to the agent to implement this right. Doing any extra
checking for hcid side is wasted time. And we do syslog issues when
calling the agent fails.

> > You know that there is a simple-agent Python script inside the
> > bluez-utils source code :)
> 
> Yes, it was the basis for my work.  Thanks.  For perhaps irrational 
> reasons, I prefer to use C/C++ at this point, despite the extra work.

I have to fixup the passkey-agent.c example, but there was simply no
time.

> That said, except for the "bug" questions, this should have been posted 
> to bluez-users; I am sure there are others who may be struggling with 
> these interfaces (and what is coming down the pike), and my intent is to 
> save them a bit of struggle.

I don't care. In a few month I will merge the mailing lists anyway.

Regards

Marcel



-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
