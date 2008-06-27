Return-Path: <cyrus@holtmann.org>
Message-Id: <A4049608-9C65-47B6-9207-59A94B346A47@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <025201c8d891$75c10260$6701a8c0@freqonedev>
Mime-Version: 1.0 (Apple Message framework v924)
Date: Sat, 28 Jun 2008 00:10:39 +0300
References: <025201c8d891$75c10260$6701a8c0@freqonedev>
Subject: Re: [Bluez-devel] org.bluez.Agent interface vs.
	org.bluez.PasskeyAgent and org.bluez.AuthorizationAgent
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

On Jun 27, 2008, at 23:07, David Stockwell wrote:
> So, what is the future of these; is it the org.bluez.Agent, as  
> described in bluez-utils-3.34/doc/agent-api.txt?  Or is it the old  
> PasskeyAgent and AuthorizationAgent described in hcid/dbus-api.txt?

org.bluez.Agent is the "future" as you put it. It gets enabled through  
the -x switch in 3.x versions. For 4.x the old PasskeyAgent and  
AuthorizationAgent will go away.

> Also, the daemon/ directory used to contain sample code for a  
> passkey agent and an authorization agent.  If as I assume these need  
> to move over to the .Agent interface, are there plans to provide a  
> design example for these (or a combined agent daemon)?

There already is one. Take a look at hcid/simple-agent

> Has the gnome agent been modified to the "experimental" interface?

This one I'll have to let Marcel answer since he's responsible for it.

> When starting the sample passkey agent, it is possible to provide a  
> path that the agent uses as its object path (in function  
> register_agent, with the call to  
> dbus_connection_register_object_path).  I assume that this path is  
> what we would pass to "Adapter.CreatePairedDevice" as the object  
> path of the agent, with the capabilities string.  Am I correct?

Yes. However in the CreatePairedDevice case the agent can't be  
implemented by anyone else except the caller (since hcid identifies  
the location of the agent by the unique name of the sender of  
CreatePairedDevice) so typically it would be a different  
implementation that the generic agent registered through RegisterAgent.

> Any constraints on what this object path contains (for example: "/ 
> com/frequency-one")?  I assume it must be unique and must not clash  
> with the other paths under org.bluez.

There are no constraints as long as it's a valid object path. The  
agent's path resides in the agents object path hierarchy which is  
totally independent from hcid's object path hierarchy (since they  
reside withing two different processes).

Johan

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
