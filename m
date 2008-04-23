Return-Path: <cyrus@holtmann.org>
Message-Id: <2D804CC1-0304-47A8-B67F-00814B3BE516@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1208876324686@dmwebmail.dmwebmail.chezphil.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Wed, 23 Apr 2008 20:25:07 +0300
References: <1208876324686@dmwebmail.dmwebmail.chezphil.org>
Subject: Re: [Bluez-users] Apple wireless keyboard
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Phil,

Any further success with your issue? Below are some answers to your  
questions:

On Apr 22, 2008, at 17:58, Phil Endecott wrote:
> Is there a reliable way to
> obtain a USB dongle with a CSR chip with this feature?

Don't think so. Usually you can't even be sure that there's a CSR chip  
inside the dongle since sometimes manufacturers use different chipsets  
for the same dongle model. The only way to be completely sure is to  
take your laptop to the store and convince the sales clerk to let you  
plug-in the dongle to your laptop before buying it.

> And how does
> pairing work in this HID mode?  (Is it secure?)

No idea about this actually, sorry.

> - Installing a kernel with the bluetooth modules.
> - Installing bluez-utils.
> - Starting hidd and hcid (enabling them in /etc/default/bluetooth on
> this Debian box)

This might have been the first step that went wrong. hidd has been  
superseded by the input service already some time ago. You can check  
whether it's enabled e.g. with the bluetooth-properties app that comes  
with bluez-gnome (assuming you use Gnome). You will need to tell the  
input service about your keyboard using the CreateDevice D-Bus method  
call (maybe bluetooth-properties even supports doing this through its  
GUI). Some python examples can nevertheless be found in the BlueZ  
wiki: http://wiki.bluez.org/wiki/HOWTO/InputDevices

> - Running passkey-agent --default 1234 (Debian ships this source for  
> this)

This is fine, except that if you run a graphical environment it might  
already provide a passkey agent for you. In Gnome this is provided by  
the bluetooth-applet program that's part of bluez-gnome.

> - Running hcitool scan to get the keyboard address (which I've now
> written on the back)
> - Running hidd --connect <addr> and typing 1234RET on the keyboard

Both of these are fine but instead of using hidd you'd use the Connect  
method that the input service provides (I think there's an example of  
that too in the wiki).

> Now, if I understand things correctly, this PIN pairing should be a
> one-off thing; there is now a file in /var/lib/bluetooth/..../linkkeys
> which I presume is a key that can be used subsequently instead of the
> PIN procedure - right?

That's right.

> (BTW, the .... in the pathname above is not the
> keyboard's address; it has lots of 0s at the end.  What is it?)

It's the address of your local bluetooth adapter (so if you have  
multiple adapters their settings don't get mixed up).

> So
> after I reboot the keyboard should be able to connect without user
> interaction.  But so far I have failed to make this happen.

Probably because you don't have a HID server to accept the incoming  
connection request. hidd has a server mode which I don't right now  
remember, but the correct thing to do with recent bluez versions is to  
have the input service running (note that you can't run the input  
service and hidd at the same time, that would be like trying to run  
two webservers that both try to bind to tcp port 80).
Remember that you need to first tell the input service about your  
keyboard using the CreateDevice method call. IIRC it will reject  
connections by default from any unknown device.

> I have
> only been able to reconnect by deleting various things and starting
> from fresh.  What do I need to do?  Do I need to add it to a
> configuration file somewhere?  Do I need to arrange for hidd --connect
> to be run?

If possible don't touch hidd anymore since it's deprecated. The input  
service will permanently store info about the keyboard once you've  
configured it through CreateDevice and it should be able to connect to  
your PC after that. You'll also need an authorization agent running (I  
think both bluetooth-applet and passkey-agent implement one), or then  
you need to tell bluez that the device is trusted using the SetTrusted  
method call (e.g. bluetooth-properties provides a GUI to do this).

In general for debuging bluez issues the most helpful info is often a  
HCI trace which you can get by running the hcidump tool. "hcidump -X - 
V" will produce human-readable output and attaching it to a problem  
report on bluez-devel or bluez-users will often get developers to  
analyze your issue more quickly. E.g. if your problems persist after  
trying out the suggestions in this email I suggest you attach a  
hcidump log of the failure to your next email. Another good source of  
debug information is what the different bluez daemons print to the  
syslog.

Johan

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
