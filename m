Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <2de4657604112905095c31f953@mail.gmail.com>
From: Manjunath Prabhu <manjunath.mp@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] HCI connection_handle
In-Reply-To: <1101585529.27074.18.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <2de46576041127045238dc2264@mail.gmail.com>
	 <1101585529.27074.18.camel@pegasus>
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
Date: Mon, 29 Nov 2004 18:39:44 +0530

Hi Marcel,
I still have a lot of doubts on my previous question 2.

On Sat, 27 Nov 2004 20:58:49 +0100, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Manjunath,
> 
> 
> 
> > I am trying to use the "hcitool cmd" options and i have to pass the
> > connection_handle as a command parameter.
> > root:]#hcitool  con
> > < ACL 00:0B:0D:31:D1:BA handle 7 state 1 lm MASTER
> >
> > Assuming the connection_handle to be 7, i tried to read the rssi value
> >
> > root:]#hcitool cmd 0x05 0x0005 0x0007
> > I get the following
> >
> > < HCI Command: ogf 0x05, ocf 0x0005, plen 1
> >   07
> > > HCI Event: 0x0e plen 4
> >   01 05 14 12
> >
> > This means there is some error as i have got 12 instead of 00......
> >
> > Can you tell me what the problem is??
> 
> the problem is that you should read the HCI specification if you wanna
> play with the "hcitool cmd ..." call. The handle is a 16 bit value. And
> btw error code 0x12 means invalid parameters.
> 
> However the RSSI can be read with "hcitool rssi ..." and this code also
> does the handle lookup for you.
> 
> > 2) I tried using the test mode commands and I am simulatameously
> > running the hcidump, which prints a unknown command type. I am just
> > presuming that the commands might be working alright , only that
> > hcidump doesn't decipher the test commands. Am i right??
> 
> What version of hcidump do you use? Show the undecoded output to us.
> 

I am using hcidump ver 1.15.

I am trying to set my dongle for  a local loopback test. I try with a
"Enable device  under test command"
root]# hcitool cmd 0x06 0x0003 

Hci dump output is 

< HCI Command: Unknown (0x06|0x0003) plen 0
> HCI Event: Command Complete (0x0e) plen 4
  01 03 18 00

I am not getting an error.  I try to write the "write loopback method
command" and enable local loopback.

root]# hcitool cmd 0x06 0x0002 0x01

Hci dump output is 
< HCI Command: Unknown (0x06|0x0002) plen 1
  01
> HCI Event: Command Complete (0x0e) plen 4
  01 02 18 11

Status shows 11 which is "HCI unsupported feature". I am using  a
version 1.1 anycom-120 usb dongle.
hciconfig -a gives the features as 

Features: 0xff 0xff 0x05 0x00 0x00 0x00 0x00 0x00

 Is this a problem with the firmware. Do i have to upgrade the
firmware and Can i do it??

I also have another doubt......how can i generate the LMP commands
required for the test mode....as in LMP_test_activate PDU and several
other LMP commands. The test methodology only speaks about the LMP
PDU's. How can i generate these LMP commands for the test scenarios.

Thanks,
Best Regards,
Manjunath.
 
> Regards
> 
> Marcel
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
