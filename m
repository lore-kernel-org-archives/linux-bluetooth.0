Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <062301c8de19$144dc990$6701a8c0@freqonedev>
References: <062301c8de19$144dc990$6701a8c0@freqonedev>
Date: Sat, 05 Jul 2008 19:17:25 +0200
Message-Id: <1215278245.4349.16.camel@californication>
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

> Over the last few days, I have developed an Agent to implement the
> org.bluez.Agent interface, so that I can test the new BT2.1-compatible
> Simple Secure Pairing (SSP).
> 
> I am developing in C/C++ with Glib and libgdbus, which provides the
> functions and structures for method and signal definition and especially
> provides for DBus introspection.  Also, I expected to develop this as a
> separate process, much like the old passkey-agent.  I found that when I
> did this, however, the new agent was never found by my application,
> calling the Adapter.CreatePairedDevice method.  When I tested with the
> hcid/simple-agent, that Python-based agent worked well.  I would like to
> share the reasons for this...

this sounds like a bug in hcid. You can use CreateDevice on a Bluetooth
2.1 device and it will do just-works pairing.

Or try to call CreatePairedDevice with a wrong agent path and it should
gently fallback to the default one.

> 1) When first testing the agent as a separate process, I figured I had
> to tie that agent to the org.bluez well-known name.  The only way I
> could find to do that was to connect to the Session bus (not the System
> bus), and provide "org.bluez" as the name of the bus in the session.  I
> used this to test the functioning of the agent with dbus-send.  However,
> when I tried calling CreatePairedDevice from my application, it did not
> find the agent; the error message in syslog indicated that Method
> RequestPinCode with signature "o" was not found.

This is total non-sense. Session bus and system are two separate things
and nothing to do with each other.

> 2) Knowing that hcid uses the System bus, I then tried to connect with
> the System bus, referencing the "org.bluez" well-known connection name.
> However, the connection was rejected because (as we all know) hcid owns
> that name, and only one object can own a name at a time (and hcid was
> not going to give it up!).

An agent has not to provide a well known name. Our whole design is based
on the fact that an agent can connect to the system with a unique name.
Meaning that we don't need a security config file for the agent.

> 3) I connected the agent with the System bus leaving the service name
> NULL, so the agent object was assigned a "unique connection name",
> something like :1.56 (changes each time).  I was able to introspect the
> object, and to invoke some of the methods using dbus-send, so long as I
> addressed the System bus (--system) and set the destination with that
> unique connection name (--dest =:1.56).  I also went down a path of
> calling RegisterAgent from within the external Agent; this worked
> properly in the sense that DBus was happy with it, the Agent was still
> reachable from dbus-send, etc.

That is how it is suppose to be. The :1.56 is the unique and it is
unique for the life time of the system. It will never get re-assigned.

> 4) I attempted to connect with the registered Agent using
> Adapter.CreatePairedDevice, the Agent was not connected to.  The reason
> for this is that CreatePairedDevice explicitly uses its own "unique
> connection name" to the System bus as the "bus name", and assumes that
> the Object Path will be found on that bus name.  Which is only the case
> if the Agent code is contained within the same process as the rest of
> the application; the application calling CreatePairedDevice.

The object paths are per connection to the bus. So application A has its
own namespace for the objects and application B has another one.

> BUG-> If there is no object with that path for the unique connection
> name, the code at hcid/agent.c agent_create (line 190) should throw an
> error, perhaps .DoesNotExist...  What actually happens is that the code
> just creates that path and attempts to call it during pairing; throwing
> no error (except for the DBus error that shows up in the syslog).
> Authentication then fails with no accurate indication as to why.

The type DBUS_TYPE_OBJECT_PATH has to be at least "/".

> 5) I attempted to register the Agent within the application using
> Adapter.RegisterAgent.  However, again RegisterAgent assumes that the
> bus name to be used is its own unique connection name; it does not
> search for the object among other connections to the System bus, nor is
> there any way to pass in a well-known name or a unique connection name.
> 
> BUG-> (actually, the same bug) As with CreatePairedDevice, if there is
> no object with that path for the unique connection name, RegisterAgent
> should throw an error.

Not a bug. We don't care. If calling the Agent object fails, then we
fail the pairing process. That is perfectly fine.

> 6) Finally, I very slightly revamped my Agent code, changed the sub main
> to a callable subroutine from my main application and integrated it into
> the mainloop of the application.  All now works well, because the
> application and the Agent are in the same process and share the same
> connection to the System bus.

That is how it is meant to be :)

> YOU MAY ASK, why did I not integrate the Agent code into the main
> application in the first place?
> 
> The first reason is that it was not clear that this is what I needed to
> do.  Although I did receive a hint about this from Johan Hedburg
> (thanks!), I expected the agent should be a separate process, much like
> the 3.x passkey-agent and auth-agent.
> 
> Second, depending on the application requirements, the agent may require
> entry of a pincode or passkey (in my case, I am using SSP-JustWorks, so
> human entry should not be needed).  Depending on the requirements, the
> Agent should not hang up the main application waiting for human
> interaction.  (That said, you could non-block the IO and multi-thread
> the whole thing...).

Nothing is blocking anything. The agent is fully async. Fix your agent
implementation :)

> Third, I just felt that putting the Agent in another process is a
> somewhat more modular way to handle security, authorization and pairing.

For the default agent, yes, and that is still possible. For the pairing
specific agent, they are tightly coupled anyway. The use case is a
wizard like setup dialog.

> Fourth, because it was there (the challenge of figuring this out,
> learning more about DBus, GLib and the whole mess).
> 
> To that end, and in the interest of sharing, I am submitting my agent
> code as a skeleton...  To react to RequestPinCode and RequestPasskey, I
> have hardcoded values... I compile with C++ and use cout and string
> because I am lazy (in this experimental phase); converting to standard
> C, or to popping up a dialog, is trivial.  And I throw no errors (e.g.,
> .Reject), nor do I really do anything with respect to actual
> authorization, etc.  In other words,  it's just a start, designed to
> allow me to see the interaction with the Agent during pairing,
> especially with SSP.

You know that there is a simple-agent Python script inside the
bluez-utils source code :)

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
