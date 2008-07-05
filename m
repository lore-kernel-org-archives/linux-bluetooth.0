Return-Path: <cyrus@holtmann.org>
Message-ID: <098d01c8def8$6cef31d0$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <062301c8de19$144dc990$6701a8c0@freqonedev>
	<1215278245.4349.16.camel@californication>
Date: Sat, 5 Jul 2008 18:39:52 -0500
MIME-Version: 1.0
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

> Hi David,

Hello, Marcel...
>
>> Over the last few days, I have developed an Agent to implement the
>> org.bluez.Agent interface, so that I can test the new 
>> BT2.1-compatible
>> Simple Secure Pairing (SSP).
>>
>> did this, however, the new agent was never found by my application,
>> calling the Adapter.CreatePairedDevice method.  When I tested with 
>> the
>> hcid/simple-agent, that Python-based agent worked well.  I would like 
>> to
>> share the reasons for this...
>
> this sounds like a bug in hcid. You can use CreateDevice on a 
> Bluetooth
> 2.1 device and it will do just-works pairing.

When I CreatePairedDevice, the devices pair, but end up using legacy 
pairing with a pin code.  This makes me suspicious.

At the same time, CreateDevice does not appear to attempt to pair at 
all.

I am investigating to see if somehow my remote device is not in SSP mode 
(s/b default at this level of CSR's BlueLab SDK).  Alternatively, I am 
checking to see if the BT USB dongle is not quite capable of supporting 
SSP, because of an older HCI stack.
>
> Or try to call CreatePairedDevice with a wrong agent path and it 
> should
> gently fallback to the default one.

Thanks, now that my in-process Agent is working, I have verified that 
this fallback works.
>
>> 1) When first testing the agent as a separate process, I figured I 
>> had
>> to tie that agent to the org.bluez well-known name.  The only way I
>> could find to do that was to connect to the Session bus (not the 
>> System
>> bus), and provide "org.bluez" as the name of the bus in the session. 
>> I
>> used this to test the functioning of the agent with dbus-send. 
>> However,
>> when I tried calling CreatePairedDevice from my application, it did 
>> not
>> find the agent; the error message in syslog indicated that Method
>> RequestPinCode with signature "o" was not found.
>
> This is total non-sense. Session bus and system are two separate 
> things
> and nothing to do with each other.

Agreed, I was documenting my learning process...it would have been 
better to post this to bluez-users, not to bluez-devel (after all, you 
all know this in excruciating detail, right?)
>
>> 2) Knowing that hcid uses the System bus, I then tried to connect 
>> with
>> the System bus, referencing the "org.bluez" well-known connection 
>> name.
>
> An agent has not to provide a well known name. Our whole design is 
> based
> on the fact that an agent can connect to the system with a unique 
> name.
> Meaning that we don't need a security config file for the agent.

Agree with the concern for a security config file, which should not be a 
bluez issue in any event, but for the provider of the Agent.  However, 
if using a unique connection name, there is no way to pass that unique 
name to RegisterAgent.  Plus the issue of telling the 
RegisterAgent-calling what that unique name is.
>
>> 3) I connected the agent with the System bus leaving the service name
>> NULL, so the agent object was assigned a "unique connection name",
>> something like :1.56 (changes each time).  I was able to introspect 
>> the
>> object, and to invoke some of the methods using dbus-send, so long as 
>> I
>> addressed the System bus (--system) and set the destination with that
>> unique connection name (--dest =:1.56).  I also went down a path of
>> calling RegisterAgent from within the external Agent; this worked
>> properly in the sense that DBus was happy with it, the Agent was 
>> still
>> reachable from dbus-send, etc.
>
> That is how it is suppose to be. The :1.56 is the unique and it is
> unique for the life time of the system. It will never get re-assigned.

Yes, I know: again, better to send to bluez-users.  Sorry.
>
>> 4) I attempted to connect with the registered Agent using
>> Adapter.CreatePairedDevice, the Agent was not connected to.  The 
>> reason
>> for this is that CreatePairedDevice explicitly uses its own "unique
>> connection name" to the System bus as the "bus name", and assumes 
>> that
>> the Object Path will be found on that bus name.  Which is only the 
>> case
>> if the Agent code is contained within the same process as the rest of
>> the application; the application calling CreatePairedDevice.
>
> The object paths are per connection to the bus. So application A has 
> its
> own namespace for the objects and application B has another one.

For CreatePairedDevice, a bad path (e.g., /x/y/zzy) is fine and causes 
fall-back to the Register(ed)Agent if any.  Maybe a little inelegant 
(imho), but fine.
>
>
>> BUG-> (actually, the same bug) As with CreatePairedDevice, if there 
>> is
>> no object with that path for the unique connection name, 
>> RegisterAgent
>> should throw an error.
>
> Not a bug. We don't care. If calling the Agent object fails, then we
> fail the pairing process. That is perfectly fine.

I agree that failing pairing is OK; I am more concerned about 
RegisterAgent not finding the Object Path and not telling anybody (even 
the syslog).
>
>
> You know that there is a simple-agent Python script inside the
> bluez-utils source code :)

Yes, it was the basis for my work.  Thanks.  For perhaps irrational 
reasons, I prefer to use C/C++ at this point, despite the extra work.

That said, except for the "bug" questions, this should have been posted 
to bluez-users; I am sure there are others who may be struggling with 
these interfaces (and what is coming down the pike), and my intent is to 
save them a bit of struggle.

Best regards, David
>
> Regards
>
> Marcel
>
>
>
>
> 


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
