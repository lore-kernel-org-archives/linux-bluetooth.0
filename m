Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41B6E98F.8030603@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: Problems with anycom usb dongle
References: <20041206225609.GA1177@zeus.galaxy.org.uk>
    <cp3mkk$m7t$1@sea.gmane.org> <1102407664.8447.20.camel@pegasus>
    <cp3rr7$1vv$1@sea.gmane.org> <1102411047.8447.28.camel@pegasus>
    <cp4a8v$959$1@sea.gmane.org> <1102425729.8447.41.camel@pegasus>
    <cp4df4$i6l$1@sea.gmane.org> <1102439143.8447.47.camel@pegasus>
    <cp6fpq$167$1@sea.gmane.org> <1102496771.9988.35.camel@pegasus>
In-Reply-To: <1102496771.9988.35.camel@pegasus>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 08 Dec 2004 11:46:23 +0000

Marcel Holtmann wrote:
> Sebastian wrote:
>>                         "This command will cause the link manager to
>> create a SCO connection ...". Does this mean LMP?

The Link Manager or LM is the entity - the code that performs the tasks.
Two link managers communicate with each other over the air using the
Link Manager Protocol or LMP.

Strictly speaking the P in L2CAP means protocol so really you should
talk about the L2CA layer but no one ever does.

> the link manager runs on the chip and L2CAP is part of the host protocol
> stack. And in between we have the HCI.

Or, if you prefer, L2CAP issues the commands, the LM processes the
commands.

The host talks to the link manager on the local device using HCI.
The local link manager talks to the remote link manager using LMP.

>                                        As far as I know, the connection
> handle from the link manager must not be the same connection handle used

I think you mean 'need not' not 'must not'.

> on the HCI. Feel free to correct me, because I never really looked under
> the HCI layer in that detail.

Correct. The LMP SCO handle is an 8 bit number in the range 1 to 255.
The HCI SCO handle is a 12 bit number in the range 0 to 0x0eff.

LMP SCO handles are unique per piconet and are assigned by the master.
If a device is a participant in multiple piconets then it may see the
same LMP handle on different networks. The LM must distinguish SCO
links using the (piconet, handle) pair.

HCI SCO handles are unique per host<->controller link. However, the
same HCI SCO handle may be being used by different devices in a
piconet to refer to different SCO links.

The LMP SCO handle is shared between the two devices in a SCO link
(this allows the devices to distinguish multiple SCO links so that they
agree on which link is to disconnect, for example).

The HCI SCO handles are not shared between the two devices. The two
hosts may see different handles.

	- Steven



**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

This footnote also confirms that this email message has been swept by
MIMEsweeper for the presence of computer viruses.

www.mimesweeper.com
**********************************************************************



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
