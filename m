Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] hcidump iconsistent byte ordering?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <ct30se$vsg$1@sea.gmane.org>
References: <ct30se$vsg$1@sea.gmane.org>
Content-Type: text/plain
Message-Id: <1106581698.8058.47.camel@pegasus>
Mime-Version: 1.0
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
Date: Mon, 24 Jan 2005 16:48:18 +0100

Hi Luis,

> let's say I want to decipher the first two HCI events from the "hcitool 
> inq" dump:
> < HCI Command: Inquiry (0x01|0x0001) plen 5
>    33 8B 9E 08 64
>  > HCI Event: Command Status (0x0f) plen 4
>    00 01 01 04
> 
> Easily, the first one is the Inquiry command. Its command parameters are 
> specified (Bluetooth Specification 1.1) in this order: LAP, 
> Inquiry_Length, Num_Responses; so from the hcidump output we have:
> 
> 	LAP: 0x9E8B33 (general inquiry LAP)
> 	Inquiry_Length: 0x08
> 	Num_Responses: 0x64
> 
> so far so good; it makes sense, but how about the command status event? 
> the order of its event parameters from the specification is: Status, 
> Num_HCI_Command_Packets, Command_Opcode. So following the same procedure 
>   as before I would get:
> 	
> 	Status: 0x00
> 	Num_HCI_Command_Packets: 0x01
> 	Command_Opcode: 0x0401
> 
> but this doesn't make sense because Command_Opcode should be 0x0001 
> (Inquiry command). These bytes are now located as the two first bytes of 
> the output, and the reading order is different from that of LAP's order 
> in the Inquiry Command.
> 
> So, I'm asking, how must I read hcidump output in order to agree with 
> the specification?

the command opcode consists of OGF and OCF. Look at the specification on
how to encode them into the command opcode.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
