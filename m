Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Has anyone seen these problems with the CSR
	BlueCore and BlueZ before ?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4239C36B.1090203@csr.com>
References: <E1DBv62-0004qg-Ld@sc8-sf-mx1.sourceforge.net>
	 <4239B037.4020803@csr.com> <1111078208.9741.2.camel@pegasus>
	 <4239C36B.1090203@csr.com>
Content-Type: text/plain
Message-Id: <1111086419.9741.12.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 17 Mar 2005 20:06:59 +0100

Hi Steven,

> >                                            What document should I read
> > for more information about the panic/fault code meanings?
> 
> HQ Commands (bcore-sp-003Pc). They're in section 6.
> 
> In addition to the information in there, you can decode the following:
> 
>   0x0080-0x00ff: Debugging codes. These should be used only within CSR
>                  for testing purposes and, in theory, should not make it
>                  into released code, but you never know.
> 
>   0x0100-0xffff: No panic/fault since last power cycle. When the chip is
>                  powered on, the panic and fault codes usually end up
>                  somewhere in this area. In theory they could end up in
>                  the valid range, but it's unlikely. We don't use codes
>                  in this area for real panics or faults.
> 
> If you want to test them, then the BCCMD variables are writable so you
> should be able to write to them, read them back, and confirm that
> they're preserved across reset but not power cycle.
> 
> If you want to test them further, then writing to variables 0x4820 and
> 0x4822 will cause the chip to panic or fault respectively. Each takes a
> single 16 bit argument containg the code to use. In the case of panic,
> this means that the chip will reset (unless the watchdog is disabled).
> In the case of fault, an HCI Hardware_Error event and an HQ PDU should
> be emitted.
> 
> If you're writing the codes or provoking the actions via BCCMD then you
> can specify codes outside the normally valid range. This means you
> should be able to test the full range your decode.

the code for reading the value and displaying it if it is < 0x0100 is
now in the CVS. I leave it to someone else to add a {panic|fault}2str()
routine to the files utils/tools/csr.[ch].

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
