Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <2de465760412062341e684f8b@mail.gmail.com>
From: Manjunath Prabhu <manjunath.mp@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Test Mode
Cc: steven.singer@csr.com, pws@csr.com
In-Reply-To: <41B47D96.2060304@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <2de4657604113010234e4e3a3f@mail.gmail.com>
	 <1101882666.18840.23.camel@pegasus>
	 <200412011028.iB1ASZIk030820@news01.csr.com> <manjunath.mp@gmail.com>
	 <2de4657604120606361751793a@mail.gmail.com> <25262.1102344714@csr.com>
	 <2de4657604120607051de3580b@mail.gmail.com> <41B47D96.2060304@csr.com>
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
Date: Tue, 7 Dec 2004 13:11:08 +0530

Hi,
I was able to conduct the local loopback test on DBT-120...so i can
state that anycom usb-120 does not support the HCI_Write_Loopback_Mode
command.
I tried the remote loopback test as per Peter's instructions and the
spec ....it doesn't seem to work.
I first have set my remote device(B) for Remote_loopback (Becoz
estabhlising a connection and then setting for loopback doesn't work).
I use then the Write command and verify that its set using the Read
command. I now establish a HCI connection from my local device(A) to
B. The connection is established. From A, i send a command packet to
B, expecting a loopback event, instead i get a regular reply for the
command packet (as though the  remote device is not set for loopback).
"hcitool con" on A  shows the connection.
 < ACL 00:11:35:00:22:B9 handle 41 state 1 lm MASTER

"hcitool con" on B doesn't show anything.
I also tried the switch role for B to be the master....but it remains
as the slave.
Hope you can help me out.

Thanks,
regards,
manjunath



On Mon, 06 Dec 2004 15:41:10 +0000, Steven Singer <steven.singer@csr.com> wrote:
> Manjunath Prabhu wrote:
> > Status shows 11 which is "HCI unsupported feature". I am using  a
> > version 1.1 anycom-120 usb dongle.
> 
> Maybe the device doesn't support loopback.
> 
> It's not mandatory (in fact, nothing at HCI is mandatory - it's not a
> qualifiable stack layer). There's no features bit to tell you if it's
> supported as it's a test command.
> 
> The Anycom-120 dongle is a Silicon Wave dongle. I don't know if they put
> loopback support in all (any?) of their dongles. It's not really that
> useful for anything other than host code testing (which most people
> don't want to do).
> 
> CSR devices support loopback (but we don't test it that thoroughly since
> hardly anybody ever uses it, and even when they do it's as a test so
> they don't care if it's not that robust).
> 
> Use hciconfig -a to see if it's a 1.2 device. If it is, it might
> support the HCI_Read_Local_Supported_Commands command, which will give
> you a list of all the commands the dongle supports. Use the BT 1.2 spec
> to find out the OCF and OGF and to decode the result.
> 
> Having said that, even it it's a 1.2 device it might not support the
> HCI_Read_Local_Supported_Commands command (in which case it should
> return error code 0x01).
> 
> Even then, it might claim to support the loopback command as it may
> understand the command but be unable to enter loopback mode for some
> other reason (like, for example, the loopback command must be the first
> command after a reset for some manufacturer specific reasons, or the
> device must not be scanning).
> 
> If you really need the feature then contact the manufacturer directly.
> However, most people have no use for the command, so don't be too
> surprised if it's not supported.
> 
>         - Steven
> 
> **********************************************************************
> 
> 
> This email and any files transmitted with it are confidential and
> intended solely for the use of the individual or entity to whom they
> are addressed. If you have received this email in error please notify
> the system manager.
> 
> This footnote also confirms that this email message has been swept by
> MIMEsweeper for the presence of computer viruses.
> 
> www.mimesweeper.com
> **********************************************************************
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
