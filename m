Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <001701c6e7e9$0a0f2a00$78b44856@claudia>
References: <001701c6e7e9$0a0f2a00$78b44856@claudia>
Date: Wed, 04 Oct 2006 22:29:33 +0200
Message-Id: <1159993773.8692.11.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] Use an ACL link when an SCO link  is established
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Michel,

> 
> my goal is to use an ACL link when an SCO link is established.
> 
> I work with two bluetooth development kits from Semtech-Xemics
> (SE1441). 
> 
> They are compliant Bluetooth v1.2. For the following explanations, one
> kit is noted "A" and the other "B".
> 
> 1) First, I create an ACL link between "A" and "B" with : hcitool cc
> BD_ADDR of "B",

first of all, don't do this. The "hcitool cc ..." is for testing only
and doesn't honor the kernel internal reference counting. You will see
side effects and I am not going to help you with it.
> 
> 2) Once the ACL link is done, "A" execute an
> "HCI_Setup_Synchronous_Connection" command to "B",
> 
> 3) At the event of an SCO request connection, "B" respond with an
> "HCI_Accept_Synchronous_Connection_Request" command.
> 
> 4) When the SCO link is established, a "Synchronous Connection
> Complete" HCI event is visible from the hci layer of each kit.
> 
> the "hcitool con" gives :
> 
> > SCO AA:AA:AA:AA:AA:04 handle 0 state 5 lm SLAVE
> 
> > ACL AA:AA:AA:AA:AA:04 handle 0 state 1 lm SLAVE

The eSCO support inside the kernel has never been adapted. You need to
change the kernel to open and accept eSCO connections.
> 
> 5) I try to use the ACL link with a l2ping command from B to A
> 
> the l2ping command gives :
> 
> l2ping AA:AA:AA:AA:AA:04 (BD_ADDR of A)
> 
> Ping: AA:AA:AA:AA:AA:04 from AA:AA:AA:AA:AA:05 (data size 44) ...
> 
> no response from AA:AA:AA:AA:AA:04: id 0
> 
> no response from AA:AA:AA:AA:AA:04: id 1

l2ping will create the ACL link if needed.

> ---------------------------------------------------------------------------------------------------------------------
> 
> Question 1 : With this configuration (SCO and ACL links between A and
> B), why l2ping doesn't work ? 
> 
> The ACL link can be used isn't it ?

Sure. But let the kernel create it. As I said, l2ping will create its
needed ACL link by itself.
> 
> Question 2 : From the hci dump of each side, I notice that there is a
> difference between the information
> 
> of the command and the OGF and OCF between the parenthesises. See
> below the hcidump results, the 
> 
>  red lines are those which give me a problem. At the "A" side, I send
> an "HCI_Setup_Asynchronous_Connection" and hcidump indicates an
> "HCI_Accept_Synchronous_Connection". I get a similar problem in "B"
> side an "HCI_Reject_Synchronous_Connection " instead of an "
> HCI_Accept_Synchronous_Connection ".

This might be an off-by-one bug in hcidump. Check the hcidump source
code and send in a patch for it.
> 
> When you see the bluetooth spec :
> 
> HCI_Setup_Asynchronous_Connection is OGF=0x01 and OCF=0x28 
> 
> HCI_Accept_Synchronous_Connection is OGF=0x01 and OCF=0x29 
> 
> HCI_Reject_Synchronous_Connection is OGF=0x01 and OCF=0x2A 
> 
>  
> 
> Do these differences are benign for the bluez stack or they can be the
> origine
> 
> of my problem ??

The hcidump is stupid and has nothing to do with actual data send to the
chip. This looks like a decoding bug. Or you simply sent the wrong
command. I haven't checked the specification.

> Question 3 : The event "Synchronous Connect Complete" gives the handle
> of the SCO link
> 
> in my case the handle value is 256. But when you see upside the
> hcitool
> 
> con result gives a handle 0 ? Is it normal ? 

Depends on the hardware you use. The handle is 16 bit value and the chip
implementation can at least pick the first 12 bits as it wishes.
> 
> Question 4 : Here's my software configurations : hcidump 1.30
> bluez-libs-2.25 bluez-utils-2.25 linux-debian 2.6.12.2 with an ARM
> target 
> 
>  
> 
> As I have to keep the kernel 2.6.12.2, with wich higher version of
> bluez-libs, bluez-utils and hcidump can I use to be compliant with my
> kernel ? 

The 3.x userspace packages will work with that kernel.

Regards

Marcel




-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
