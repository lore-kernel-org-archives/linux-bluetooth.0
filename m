Return-Path: <Linux@feline-soul.com>
From: "Bearcat M. Sandor" <Linux@feline-soul.com>
Reply-To: Linux@feline-soul.com
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] How do I reset a pairing?
Date: Wed, 30 Aug 2006 20:48:42 -0600
Cc: Marcel Holtmann <marcel@holtmann.org>
References: <e4f1f0110608230129y73240448ufc024c1c99810789@mail.gmail.com> <200608291908.52176.Linux@feline-soul.com> <1156931555.4026.79.camel@aeonflux.holtmann.net>
In-Reply-To: <1156931555.4026.79.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608302048.42931.Linux@feline-soul.com>
List-ID: <bluez-users.lists.sourceforge.net>

Alright, we're getting there. I added the line to the pincodes file and now 
the pin is accepted.

However, doing an btsco 00:0D:44:4F:37:72 i get

Error: Failed to connect to SDP server: Function not implemented
Assuming channel 2

Can't connect RFCOMM channel: Resource temporarily unavailable

hcidump gives me:

HCI sniffer - Bluetooth packet analyzer ver 1.31
device: hci0 snap_len: 1028 filter: 0xffffffffffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: PIN Code Request (0x16) plen 6
> HCI Event: Mode Change (0x14) plen 6
> HCI Event: Mode Change (0x14) plen 6
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: PIN Code Request (0x16) plen 6
> HCI Event: Connect Complete (0x03) plen 11



Does rfcomm have to be running? If so, how is it best started?

My rfcomm.conf is:
 #
# RFCOMM configuration file.
#

rfcomm0 {
        # Automatically bind the device at startup
        bind no;

        # Bluetooth address of the device
        device 00:0D:44:4F:37:72;

        # RFCOMM channel for the connection
        channel 1;

        # Description of the connection
        comment "Example Bluetooth device";
}
 

Thanks for the help folks. Slowly, but surely, i'm getting there.

Bearcat M. Sandor

On Wednesday 30 August 2006 03:52 in an email titled "Re: [Bluez-users] How do 
I reset a pairing?" Marcel Holtmann wrote:
>Hi Bearcat,
>
>> Ok, the passkey-agent runs. But i get errors. Here's what i'm doing:
>>
>> 1. Switch to root.
>> 1. put headset into paring mode.
>> 2. run "btsco 00:0D:44:4F:37:72"
>> 3. run "passkey-agent 0000 00:0D:44:4F:37:72"
>>
>> I get "Can't get on system bus" from passkey-agent.  Is dbus
>> misconfigured?
>
>might be. You can however use "passkey-agent --default 0000" to be on
>the safe side. There is a difference between the default passkey agent
>and the application specific passkey agent.
>
>> I know dbus is running.  The "00:0D:44:4F:37:72" is the address of my
>> headset.  "0:07:61:1C:9F:D3" is the address of my hub. I've tried that as
>> well. I've also tried encapsulating the 0000 with quotes in case it is a
>> string. I am running passkey-agent as root.
>
>Not needed to run it as root.
>
>> What am i doing wrong. Is there a way to create the file
>> in /var/lib/bluetooth\00:07:61:1C:9F:D3 by hand?  What should the file be
>> called and what should it contain.
>
>You can use /var/lib/bluetooth/00:07:61:1C:9F:D3/pincodes and add a line
>with "00:0D:44:4F:37:72 0000" this will make the need of a passkey agent
>for that specific remote device obsolete.
>
>> I am very confused by the configuration of all this. I have seen
>> documentation that states that i need:
>>
>> 1. passkey "0000" in my hcid.conf file
>
>No. This PIN code is only for incoming connections.
>
>> 2. a /etc/bluetooth/passkeys/default file.
>
>This is Debian specific crap and has to go away anyway.
>
>> 3. A script to be called in the config file
>
>No longer supported as of 3.x releases.
>
>> 4. and now a passkey agent.
>
>That is of course the preferred way and the distribution should make it
>work nicely for you. Especially since bluez-gnome now contains a really
>good example for a passkey agent.
>
>Regards
>
>Marcel
>
>
>
>-------------------------------------------------------------------------
>Using Tomcat but need to do more? Need to support web services, security?
>Get stuff done quickly with pre-integrated technology to make your job
> easier Download IBM WebSphere Application Server v.1.0.1 based on Apache
> Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users

-- 
Bearcat M. Sandor
Bearcat@feline-soul.com
Jabber: bearcat@jabber.feline-soul.net
ICQ: 6628727
MSN: bearcatsandor@hotmail.com
Yahoo: bearcatsandor
AIM: bearcatmsandor
