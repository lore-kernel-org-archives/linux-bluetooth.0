Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4239C36B.1090203@csr.com>
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Has anyone seen these problems with the CSR
    BlueCore and BlueZ before ?
References: <E1DBv62-0004qg-Ld@sc8-sf-mx1.sourceforge.net>
    <4239B037.4020803@csr.com> <1111078208.9741.2.camel@pegasus>
In-Reply-To: <1111078208.9741.2.camel@pegasus>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 17 Mar 2005 17:50:35 +0000

Marcel Holtmann wrote:
> Steven Singer wrote:
>> would it be a good idea to add reading of the panic and
>> fault codes to the CSR specific section of hcitool revision? Or,
>> get BlueZ to read the panic code when the inerface is brought up. If
>> it's non-zero and < 0x0100 write it to an event log and then zero it.
> 
> the kernel code should be complete vendor independent and thus adding
> this to "hciconfig hci0 revsion" is the only option.

That's OK. At least it will make it easy for users to find out this
information.

> Are both variables UINT16? If yes, then it will be quite easy to add
> this information to the hciconfig command.

Yes.

>                                            What document should I read
> for more information about the panic/fault code meanings?

HQ Commands (bcore-sp-003Pc). They're in section 6.

In addition to the information in there, you can decode the following:

  0x0080-0x00ff: Debugging codes. These should be used only within CSR
                 for testing purposes and, in theory, should not make it
                 into released code, but you never know.

  0x0100-0xffff: No panic/fault since last power cycle. When the chip is
                 powered on, the panic and fault codes usually end up
                 somewhere in this area. In theory they could end up in
                 the valid range, but it's unlikely. We don't use codes
                 in this area for real panics or faults.

If you want to test them, then the BCCMD variables are writable so you
should be able to write to them, read them back, and confirm that
they're preserved across reset but not power cycle.

If you want to test them further, then writing to variables 0x4820 and
0x4822 will cause the chip to panic or fault respectively. Each takes a
single 16 bit argument containg the code to use. In the case of panic,
this means that the chip will reset (unless the watchdog is disabled).
In the case of fault, an HCI Hardware_Error event and an HQ PDU should
be emitted.

If you're writing the codes or provoking the actions via BCCMD then you
can specify codes outside the normally valid range. This means you
should be able to test the full range your decode.

	- Steven
-- 


**********************************************************************
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom they
are addressed. If you have received this email in error please notify
the system manager.

**********************************************************************



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
