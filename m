Return-Path: <cyrus@holtmann.org>
Message-ID: <5c1c70820802061534q1d43f6b3n20e3e7e08c31632c@mail.gmail.com>
Date: Thu, 7 Feb 2008 10:04:33 +1030
From: "Pooyan McSporran" <duckfreezone@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1202289686.15090.209.camel@violet>
MIME-Version: 1.0
References: <5c1c70820802052329s7e1e0d62pa43aa5f94e578ed3@mail.gmail.com>
	<1202289686.15090.209.camel@violet>
Subject: Re: [Bluez-devel] SDP limiting connections?
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

On 06/02/2008, Marcel Holtmann <marcel@holtmann.org> wrote:
> >
> > [snip]
> > In short, it looks as if the BlueZ SDP server is not responding at all
> > whilst my application has two current SPP connections.  I don't know
> > if that's what's actually happening, but that's how the symptoms
> > appear.
>
> if you don't see anything in hcidump from the other devices, then it is
> not a SDP servers problem. Would would see connection attempts.
>
> My guess is that both connection are as slaves. Check with "hcitool con"
> and in that case the chip is pretty much busy keeping up. So you need to
> have them to role-switch (RFCOMM_LM_MASTER).

Initial investigations show that your theory is correct (unsurprisingly!).

If we have two connections, "hcitool con" shows:
Connections:
  > ACL 00:18:0F:B3:5B:4D handle 47 state 1 lm SLAVE
  > ACL 00:19:2D:E2:0A:AA handle 42 state 1 lm SLAVE

I can switch role using "hcitool sr <bdaddr>", a given connection, but
it seems that this fails for the first connection.  ie, if I try this
for the first connection it fails, but if I try it for the 2nd, 3rd,
etc it succeeds.  The failure looks like this:

< HCI Command: Switch Role (0x02|0x000b) plen 7
    bdaddr 00:17:B0:B2:5C:7B role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Switch Role (0x02|0x000b) status 0x0c ncmd 1
    Error: Command Disallowed

I'm guessing this is a function of the protocol, not an application
error, so I'm not too worried about it. Most importantly, your
suggestion worked :)  If I do a role switch for each connection as it
is made (with the exception of the first connection which fails to
switch), I can have more than two SPP connections.

One other question, I can't see a way of performing the role switch
via dbus.  Is there a way to do this?

Thanks for your help.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
